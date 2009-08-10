Monk, the glue framework
========================

Monk is a glue framework for web development in Ruby.
It's truly modular by relying on the best tool for each job.
It's also pretty fast thanks to
[Rack](http://chneukirchen.org/blog/archive/2007/02/introducing-rack.html)
and [Sinatra](http://www.sinatrarb.com/intro.html).

What's in the package?
----------------------

The default skeleton will give you a Sinatra
application with a structure, which can be tested
using [Contest](http://github.com/citrusbyte/contest),
[Rack::Test](http://www.brynary.com/2009/3/5/rack-test-released-a-simple-testing-api-for-rack-based-frameworks-and-apps) and
[Webrat](http://wiki.github.com/brynary/webrat). To store things you'll
have [Ohm](http://ohm.keyvalue.org), a persistence layer that talks
to [Redis](http://code.google.com/p/redis). Other niceties included,
like a logger, a settings hash and proper reloading for easier
development.

But Monk also respects your tastes, and you are encouraged to create your
own skeletons (and maybe share them with us). More on [Skeletons](/skeletons).

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
> one. [More](/skeletons).

Next: [Project structure](/structure)
-------------------------------------
