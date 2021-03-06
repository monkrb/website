require "base64"
require File.join(File.dirname(__FILE__), "ohm", "redis")
require File.join(File.dirname(__FILE__), "ohm", "validations")

module Ohm

  # Provides access to the redis database. This is shared accross all models and instances.
  def redis
    @redis
  end

  # Connect to a redis database.
  #
  # @param options [Hash] options to create a message with.
  # @option options [#to_s] :host ('127.0.0.1') Host of the redis database.
  # @option options [#to_s] :port (6379) Port number.
  # @option options [#to_s] :db (0) Database number.
  # @option options [#to_s] :timeout (0) Database timeout in seconds.
  # @example Connect to a database in port 6380.
  #   Ohm.connect(:port => 6380)
  def connect(*options)
    @redis = Ohm::Redis.new(*options)
  end

  # Clear the database.
  def flush
    @redis.flushdb
  end

  # Join the parameters with ":" to create a key.
  def key(*args)
    args.join(":")
  end

  module_function :key, :connect, :flush, :redis

  module Attributes
    class Collection
      include Enumerable

      attr_accessor :key, :db

      def initialize(db, key)
        self.db = db
        self.key = key
      end

      def each(&block)
        all.each(&block)
      end

      def all(model = nil)
        model ? raw.collect { |id| model[id] } : raw
      end
    end

    # Represents a Redis list.
    #
    # @example Use a list attribute.
    #
    #   class Event < Ohm::Model
    #     attribute :name
    #     list :participants
    #   end
    #
    #   event = Event.create :name => "Redis Meeting"
    #   event.participants << "Albert"
    #   event.participants << "Benoit"
    #   event.participants.all #=> ["Albert", "Benoit"]
    class List < Collection

      # @param value [#to_s] Pushes value to the list.
      def << value
        db.rpush(key, value)
      end

    private

      def raw
        db.list(key)
      end
    end

    # Represents a Redis set.
    #
    # @example Use a set attribute.
    #
    #   class Company < Ohm::Model
    #     attribute :name
    #     set :employees
    #   end
    #
    #   company = Company.create :name => "Redis Co."
    #   company.employees << "Albert"
    #   company.employees << "Benoit"
    #   company.employees.all #=> ["Albert", "Benoit"]
    #   company.include?("Albert") #=> true
    class Set < Collection

      # @param value [#to_s] Adds value to the list.
      def << value
        db.sadd(key, value)
      end

      # @param value [Ohm::Model#id] Adds the id of the object if it's an Ohm::Model.
      def add model
        raise ArgumentError unless model.kind_of?(Ohm::Model)
        raise ArgumentError unless model.id
        self << model.id
      end

      def delete(value)
        db.srem(key, value)
      end

      def include?(value)
        db.sismember(key, value)
      end

    private

      def raw
        db.smembers(key).sort
      end
    end
  end

  class Model
    module Validations
      include Ohm::Validations

      # Validates that the attribute or array of attributes are unique. For this,
      # an index of the same kind must exist.
      #
      # @overload assert_unique :name
      #   Validates that the name attribute is unique.
      # @overload assert_unique [:street, :city]
      #   Validates that the :street and :city pair is unique.
      def assert_unique(attrs)
        index_key = index_key_for(Array(attrs), read_locals(Array(attrs)))
        assert(db.scard(index_key).zero? || db.sismember(index_key, id), [Array(attrs), :not_unique])
      end
    end

    include Validations

    ModelIsNew = Class.new(StandardError)

    @@attributes = Hash.new { |hash, key| hash[key] = [] }
    @@collections = Hash.new { |hash, key| hash[key] = [] }
    @@counters = Hash.new { |hash, key| hash[key] = [] }
    @@indices = Hash.new { |hash, key| hash[key] = [] }

    attr_accessor :id

    # Defines a string attribute for the model. This attribute will be persisted by Redis
    # as a string. Any value stored here will be retrieved in its string representation.
    #
    # @param name [Symbol] Name of the attribute.
    def self.attribute(name)
      define_method(name) do
        read_local(name)
      end

      define_method(:"#{name}=") do |value|
        write_local(name, value)
      end

      attributes << name
    end

    # Defines a counter attribute for the model. This attribute can't be assigned, only incremented
    # or decremented. It will be zero by default.
    #
    # @param name [Symbol] Name of the counter.
    def self.counter(name)
      define_method(name) do
        read_local(name).to_i
      end

      counters << name
    end

    # Defines a list attribute for the model. It can be accessed only after the model instance
    # is created.
    #
    # @param name [Symbol] Name of the list.
    def self.list(name)
      attr_list_reader(name)
      collections << name
    end

    # Defines a set attribute for the model. It can be accessed only after the model instance
    # is created. Sets are recommended when insertion and retrival order is irrelevant, and
    # operations like union, join, and membership checks are important.
    #
    # @param name [Symbol] Name of the set.
    def self.set(name)
      attr_set_reader(name)
      collections << name
    end

    # Creates an index (a set) that will be used for finding instances.
    #
    # If you want to find a model instance by some attribute value, then an index for that
    # attribute must exist.
    #
    # Each index declaration creates an index. It can be either an index on one particular attribute,
    # or an index accross many attributes.
    #
    # @example
    #   class User < Ohm::Model
    #     attribute :email
    #     index :email
    #   end
    #
    #   # Now this is possible:
    #   User.find :email, "ohm@example.com"
    #
    # @overload index :name
    #   Creates an index for the name attribute.
    # @overload index [:street, :city]
    #   Creates a composite index for street and city.
    def self.index(attrs)
      indices << Array(attrs)
    end

    def self.attr_list_reader(name)
      class_eval <<-EOS
        def #{name}
          @#{name} ||= Attributes::List.new(db, key("#{name}"))
        end
      EOS
    end

    def self.attr_set_reader(name)
      class_eval <<-EOS
        def #{name}
          @#{name} ||= Attributes::Set.new(db, key("#{name}"))
        end
      EOS
    end

    def self.[](id)
      new(:id => id) if exists?(id)
    end

    def self.all
      filter(:all)
    end

    def self.attributes
      @@attributes[self]
    end

    def self.counters
      @@counters[self]
    end

    def self.collections
      @@collections[self]
    end

    def self.indices
      @@indices[self]
    end

    def self.create(*args)
      model = new(*args)
      model.create
      model
    end

    def self.find(attribute, value)
      filter(Ohm.key(attribute, encode(value)))
    end

    def self.encode(value)
      Base64.encode64(value.to_s).chomp
    end

    def self.encode_each(values)
      values.collect do |value|
        encode(value)
      end
    end

    def initialize(attrs = {})
      @_attributes = Hash.new {|hash,key| hash[key] = read_remote(key) }

      attrs.each do |key, value|
        send(:"#{key}=", value)
      end
    end

    def new?
      !id
    end

    def create
      return unless valid?
      initialize_id
      create_model_membership
      add_to_indices
      save!
    end

    def save
      create if new?
      return unless valid?
      update_indices
      save!
    end

    def delete
      delete_from_indices
      delete_attributes(attributes)
      delete_attributes(counters)
      delete_attributes(collections)
      delete_model_membership
      self
    end

    # Increment the attribute denoted by :att.
    #
    # @param att [Symbol] Attribute to increment.
    def incr(att)
      raise ArgumentError unless counters.include?(att)
      write_local(att, db.incr(key(att)))
    end

    # Decrement the attribute denoted by :att.
    #
    # @param att [Symbol] Attribute to decrement.
    def decr(att)
      raise ArgumentError unless counters.include?(att)
      write_local(att, db.decr(key(att)))
    end

    def attributes
      self.class.attributes
    end

    def counters
      self.class.counters
    end

    def collections
      self.class.collections
    end

    def indices
      self.class.indices
    end

    def ==(other)
      other.key == key
    rescue ModelIsNew
      false
    end

  protected

    def key(*args)
      raise ModelIsNew if new?
      self.class.key(id, *args)
    end

  private

    def self.db
      Ohm.redis
    end

    def self.key(*args)
      Ohm.key(*args.unshift(self))
    end

    def self.filter(name)
      db.smembers(key(name)).map do |id|
        new(:id => id)
      end
    end

    def self.exists?(id)
      db.sismember(key(:all), id)
    end

    def initialize_id
      self.id = db.incr(self.class.key("id"))
    end

    def db
      Ohm.redis
    end

    def delete_attributes(atts)
      atts.each do |att|
        db.del(key(att))
      end
    end

    def create_model_membership
      db.sadd(self.class.key(:all), id)
    end

    def delete_model_membership
      db.srem(self.class.key(:all), id)
    end

    def save!
      attributes.each { |att| write_remote(att, send(att)) }
      self
    end

    def update_indices
      delete_from_indices
      add_to_indices
    end

    def add_to_indices
      indices.each do |attrs|
        db.sadd(index_key_for(attrs, read_locals(attrs)), id)
      end
    end

    def delete_from_indices
      indices.each do |attrs|
        db.srem(index_key_for(attrs, read_remotes(attrs)), id)
      end
    end

    def read_local(att)
      @_attributes[att]
    end

    def write_local(att, value)
      @_attributes[att] = value
    end

    def read_remote(att)
      id && db.get(key(att))
    end

    def write_remote(att, value)
      db.set(key(att), value)
    end

    def read_locals(attrs)
      attrs.map do |att|
        read_local(att)
      end
    end

    def read_remotes(attrs)
      attrs.map do |att|
        read_remote(att)
      end
    end

    def index_key_for(attrs, values)
      self.class.key *(attrs + self.class.encode_each(values))
    end
  end
end
