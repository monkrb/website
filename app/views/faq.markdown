# Infrequently Asked Questions #

## How is using Monk different than using plain Sinatra? ##

Sinatra is a tiny and flexible tool. It can be used to write super simple
web applications ­like an API­ or a fully-fledged, highly interactive website.

As you develop more applications using Sinatra, you will start to find some patterns:

- You apply a similar structure to all of your projects (where to put your routes, whether to use
[classic or modular style](http://www.sinatrarb.com/extensions.html#background), etc.)
You also find some other common bits ­ you need to set up a logger, configure reloading on development mode, and more.

- You need to hook up your persistence layer of choice.

- Wiring in your desired testing suite.

It's easy to see how time-consuming this can be when you want to start a new project
with the minimum amount of work. That's why we wrote a tool that could enable us to get
started on a new project in no time. The result is a command line tool that lets
you create a new project out of an existing skeleton. The default skeleton we ship does
all the work for you, and you can just dive into your code.

## How do Monk skeletons compare to generators? ##

The idea of having a skeleton versus a code generator is
that we wanted to evolve the structure of the skeleton separate from the binary, thus
the structures can always be up to date without the need to update the
monk binary.

This is good also because you can have many different monk skeletons
configured: say you have the default one with Ohm (our Redis layer), 
another one with ActiveRecord and yet another one with Sequel. You can be sure at any
point that starting a project will give you the best combination, not
what was best at the time you installed the monk gem. Having the
binary generate all those different structures would be overkill, and
would concentrate the power on the people that release the monk gem.
This way, anyone can maintain their own skeleton with their stack of choice.

Some benefits of having functioning skeletons (rather than a generator) are:

* Integration: it's easier to test that the base application works and
that there are no conflicts in the dependencies.
* Visibility: this could be a matter of taste, but it's much easier to
see what your application will look like, what dependencies it will
have, etc.
* Contribution: the process of making changes to a skeleton is the
same as with a regular project, and you don't need to release a new
gem for a skeleton to be updated. It's also very easy to fork a
skeleton and tweak it exactly the way you want.

Also the idea is to create a repository of well-maintained skeletons
on Monk's website. So it's also about building community around the
skeletons.

## Why yet another dependency management library? ##

The idea behind Dependencies is that RubyGems is only one way of
getting a sane `$LOAD_PATH`. So this library is aimed to solve a few
problems:

* Documentation: the `dependencies` file specifies everything your
project needs in order to run. This is great both for developers and
sysadmins.

* Vendoring: after trying the alternative, we found vendoring our
dependencies is best as the application is self-contained. Again, this
is good for developers because you update your dependencies together
with your code, and it's good for sysadmins as they don't need to
worry about installing new dependencies as the project evolves.
So Dependencies makes it very easy to simply vendor everything
while keeping a clean list of what's needed.

There are other alternatives to managing dependencies and we're looking
into ways of being compatible with them. At the moment we're focusing
on Rip and Heroku's `.gems` manifest, but don't hesitate to get in
touch if you want to collaborate.

If you're interested in dependency management, RubyGems (or not)
and the `$LOAD_PATH`, we recommend [Ryan Tomayko's write-up](http://gist.github.com/54177).
