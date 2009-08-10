Project structure
=================

Unless you update your monk configuration, monk will grab the default
skeleton from git://github.com/monkrb/skeleton.git.

Requirements
------------

This skeleton has the following requirements:

- You must have [Redis](/help/redis) installed.
- You may be familiar with TDD and User Stories.

Directory layout
----------------

The basic structure has some key elements:

    ./app

This is where most of your code will go. Since Rails came out, most of the
Model-View-Controller frameworks have adhered to this
convention. Inside you will find four directories:

    ./app/helpers
    ./app/models
    ./app/routes
    ./app/views

If you are familiar with Sinatra and Rails, you may know by
now what goes where. If you don't, you can read more about
[helpers](/structure/helpers), [models](/structure/models), [routes](/structure/routes)
and [views](/structure/views).

Other usual suspects:

    ./lib
    ./vendor

You can require everything you put in those two directories. Vendor is
special, though, thanks to the [dependencies](/dependencies) gem.

Next: [Dependencies](/dependencies)
-----------------------------------
