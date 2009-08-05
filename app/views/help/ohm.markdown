Ohm ॐ
===========================

Description
-----------

[Ohm](http://www.github.com/soveran/ohm/tree/master) is a library that allows to store an object in Redis, a persistent key-value database. It includes an extensible list of validations and has very good performance.

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

*Please take a look at the [documentation](http://www.github.com/soveran/ohm/tree/master) to find more about this amazing library.*
