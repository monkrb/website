Views
=====

You will find them within

    /app/views

The default [skeleton](/help/skeleton) comes with [haml](http://haml-lang.com/), and we highly recommend it.

Nevertheless you can check the [Sinatra documentation](http://www.sinatrarb.com/book.html#views) for a list of all the available templates, just in case.

Partials
--------

If you do chose to use haml as your template, Monk has some helper methods that will help you unleash it's full potential.

To render a partial, just use the partial method inside any view

    = partial :games, :players => @players


Just specify the name of the partial you want to render and pass the local variables. This will look for app/views/games.haml
