Ohm ॐ
===========================

Description
-----------

[Ohm](http://ohm.keyvalue.org) is a library for storing objects in Redis, a persistent key-value database. It includes an extensible list of validations and has very good performance.

Example
-------

Here is a short example to show some basic features

    class Event < Ohm::Model
      attribute :name
      set :participants
      list :comments
      counter :votes

      index :name

      def validate
        assert_present :name
      end
    end

Please take a look at the [documentation](http://ohm.keyvalue.org) to see what you can do with it.
