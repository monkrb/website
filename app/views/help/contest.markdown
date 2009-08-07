Contest
=======

Write declarative tests using nested contexts without performance penalties. [Contest](http://blog.citrusbyte.com/2009/05/19/introducing-contest/) is less than 100 lines of code and gets the job done.

Here's an example of what it looks like:

    require "rubygems"
    require "contest"

    class Array
      def rotate_left(n = 1)
        n.times { push(shift) }
        self
      end
    end

    class TestArray < Test::Unit::TestCase
      context "Array" do
        should "rotate elements to the left when sent rotate_left" do
          assert_equal [2, 3, 4, 5, 1], [1, 2, 3, 4, 5].rotate_left
        end

        should "rotate elements to the left 2 places when sent rotate_left(2)" do
          assert_equal [3, 4, 5, 1, 2], [1, 2, 3, 4, 5].rotate_left(2)
        end
      end
    end

*Check out the [documentation](http://github.com/citrusbyte/contest/tree/master) on github.*
