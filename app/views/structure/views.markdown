Views
=====

You will find them within

    /app/views

The default [skeleton](/skeletons) comes with [Haml](http://haml-lang.com), and we highly recommend it.

Nevertheless you can check the [Sinatra documentation](http://www.sinatrarb.com/book.html#views) for a list of all the available templates.


Partials
--------

Just specify the name of the partial you want to render and pass the local variables:

    = partial :games, :players => @players

This will look for `app/views/games.haml` and the template will have access to the `players` local variable.
