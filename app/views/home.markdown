Monk, the glue framework
========================

Monk is a glue framework for web development. It means that instead
of installing all the tools you need for your projects, you can
rely on a Git repository and a list of dependencies, and Monk takes
care of the rest. By default, it ships with a Sinatra application
that includes [Contest](http://github.com/citrusbyte/contest),
[Stories](http://github.com/citrusbyte/stories),
[Webrat](http://wiki.github.com/brynary/webrat),
[Ohm](http://github.com/soveran/ohm) and some other niceties, along with
a structure and helpful documentation to get your hands wet in no time.

But Monk also respects your tastes, and you are invited to create your
own versions of the skeleton app and your own list of dependencies. You
can add many different templates (different Git repositories) and Monk
will help you manage them all.

Getting started
---------------

Monk makes the following assumptions:

- You are familiar with [Sinatra](/help/sinatra).
- You have [Git](/help/git) installed.

If you are ready for the rest, start by installing Monk:

    $ sudo gem install monk

This will install a tiny binary that will help you bootstrap your
applications. Now create your first Monk project:

    $ monk init myapp

This command fetches an application structure with Git, along with a
list of dependencies.

> Note that this is what you get with the default skeleton. You can add
> other skeletons to your monk configuration and even replace the default
> one. [More](/help/skeletons).

Next: [Project structure](/app)
---------------------------------------------
