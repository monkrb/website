# Redis, a simple key-value store #

The default skeleton ships with [Ohm](/help/ohm), a persistence layer that uses [Redis](http://code.google.com/p/redis).

## Installing Redis ##

    $ cd /usr/src
    $ wget http://redis.googlecode.com/files/redis-0.900_2.tar.gz
    $ tar xzf redis-0.900_2.tar.gz 
    $ cd redis-0.900
    $ make
    $ mv redis-server /usr/bin/
    $ mv redis-cli /usr/bin/

## Running Redis during development ##

You'll need at least two instances of Redis – one for each of `development` and `test` environments.

The default skeleton includes sample configuration files:

    $ monk init foo
    $ cd foo
    $ cp config/redis/development.example.conf config/redis/development.conf
    $ cp config/redis/test.example.conf config/redis/test.conf
    $ redis-server config/redis/development.conf
    $ redis-server config/redis/test.conf

You should be able to connect to Redis now.
