Routes
======

You will find them within

    /app/routes

[Monk plays with Sinatra](/help/sinatra), so make sure you are familiar with Sinatra's [documentation](http://www.sinatrarb.com/book.html#routes).

In Monk, your routes must have this structure:


    class Main
      get "/" do
        haml :home
      end

      ...
    end

Actually, Monk ships with two sample routes located in `app/routes/home.rb` and `app/routes/css.rb`. The first one is like a hello world, something you can take a look at and modify at pleasure. The route for CSS is a convenient way to process your [SASS](http://sass-lang.com) files stored in `app/views/css`.
