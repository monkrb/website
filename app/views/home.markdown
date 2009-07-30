Monk, the glue framework
========================

Monk is a glue framework for web development. It means that instead of
installing all the tools you need for your projects, you can rely on a
git repository and a list of dependencies, and Monk takes care of the
rest. By default, it ships with a Sinatra application that includes
Contest, Stories, Webrat, Ohm and some other niceties, along with a
structure and helpful documentation to get your hands wet in no time.

But Monk also respects your tastes, and you are invited to create your
own versions of the skeleton app and your own list of dependencies. You
can add many different templates (different git repositories) and Monk
will help you manage them all.

Getting started
---------------

Monk makes the following assumptions:

- You know how to program in [Ruby](/help/ruby).
- You are familiar with [Sinatra](/help/sinatra).
- You are familiar with [RubyGems](/help/gems).
- You have [git](/help/git) installed.

If you are ready for the rest, we can install Monk:

    $ sudo gem install monk

This will install a tiny binary that will help you bootstrap your
applications. Now create your first Monk project:

    $ monk init myapp

This command fetches an application structure with git, along with a
list of dependencies.


Project structure
-----------------

The basic structure has some key elements:

    /app

This is where most of your code will go. Since Rails, most of the
[MVC](/help/model-view-controller) frameworks have adhered to this
convention. Inside you will find four directories:

    /app/helpers
    /app/models
    /app/routes
    /app/views

If you are familiar with Sinatra and Rails, you may know by
now what goes where. If you don't, you can read more about
[helpers](/app/helpers), [models](/app/models), [routes](/app/routes)
and [views](/app/views).

> Note that this is what you get from the default skeleton. You can add
> other skeletons to your monk configuration and even replace the default
> one. [More](more).