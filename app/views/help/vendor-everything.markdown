# Vendor everything #

Monk applications use the Dependencies gem to specify which libraries they depend on.
It's a simple text file called `./dependencies`:

    sinatra 0.9.4
    haml    2.2.2
    # ...

By using version numbers, you make Dependencies look for your libraries using RubyGems.

However, a practice many developers follow is to bundle all the dependencies inside your project.
Dependencies make it easy to do this:

    $ dep vendor --all

After that, your dependencies will be extracted to `./vendor`:

    $ tree vendor -L 1
    vendor
    |-- sinatra-0.9.4
    `-- haml-2.2.2

The good thing about this practice is that it allows you to deploy your application more easily by not relying on the environment. Also, it's easier for the development process, because your project's dependencies are updated as soon as your code is.

## Specifying dependencies from source ##

Dependencies allows you to specify a URL, rather than a version, so you can live "on the edge":

    # ./dependencies

    sinatra        git://github.com/sinatra/sinatra.git
    contest (test) git://github.com/citrusbyte/contest.git

If you run `dep vendor sinatra`, you'll be cloning the Git repository directly, rather than using a gem. The resulting directory is also `./vendor/sinatra`.
