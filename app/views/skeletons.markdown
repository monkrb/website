Skeletons
=========

When you run `monk init`, you are initializing a project with the default skeleton. Monk keeps an index of skeletons in the file `~/.monk`. You can add other skeletons to your collection:

    $ monk list
          default  git://github.com/monkrb/skeleton.git
    $ monk add myskeleton git://github.com/myaccount/foobar.git
    $ monk list
          default  git://github.com/monkrb/skeleton.git
       myskeleton  git://github.com/myaccount/foobar.git

Now you can specify which skeleton you want to use when creating a new project:

    $ monk init -s myskeleton

You can also replace the default skeleton:

    $ monk rm myskeleton
    $ monk add default git://github.com/myaccount/foobar.git

And now every time you run `monk init`, you will be using your custom project structure.
