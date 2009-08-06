Project structure
=================

Unless you update your monk configuration, monk will grab the default
skeleton from git://github.com/monkrb/skeleton.git.

Requirements
------------

This skeleton has the following requirements:

- You must have [Redis](/help/redis) installed.
- You may be familiar with [TDD and User Stories](/help/stories).

Directory layout
----------------

The basic structure has some key elements:

    /app

This is where most of your code will go. Since Rails came out, most of the
[MVC](/help/model-view-controller) frameworks have adhered to this
convention. Inside you will find four directories:

    /app/helpers
    /app/models
    /app/routes
    /app/views

If you are familiar with Sinatra and Rails, you may know by
now what goes where. If you don't, you can read more about
[helpers](/structure/helpers), [models](/structure/models), [routes](/structure/routes)
and [views](/structure/views).

Another usual suspects:

    /lib
    /vendor

You can require everything you put in those two directories. Vendor is
special, though, thanks to the [dependencies](/help/vendor-everything) gem.

Next: [Dependencies](/dependencies)
-----------------------------------
