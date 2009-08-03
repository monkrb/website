# Monk plays with Sinatra #

Sinatra is a minimal framework for Ruby web applications. Unlike other frameworks, Sinatra only gives you a nice DSL for defining and handling routes. It makes very few assumptions and thus is very versatile. Make sure you read through the [README](http://www.sinatrarb.com/intro.html), a great walktrough of its features.

Monk skeletons are encouraged to [vendor everything](/help/vendor-everything), so you won't need to install Sinatra in order to start your first Monk application. However, if you would like to try it outside of Monk:

    $ sudo gem install sinatra

Create a file named `init.rb`:

    require "rubygems"
    require "sinatra"

    get "/" do
      "Hello, world!"
    end

Simply run it:

    $ ruby init.rb

You should be able to browse your app at `http://localhost:4567`.
