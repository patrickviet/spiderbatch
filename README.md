# SpiderBatch
Run commands on multiple servers with various reliability options

Why?
====

Run any commands on multiple servers, with specific permissions, and variable levels of reliability.
Example usage: update local redis cache everywhere, as you write on master database.
Other example usage: trigger a rsync for a shared directory, on demand.

What?
=====

A small server daemon listens to http calls.
For the first level of reliability (default), it pushes messages to the Redis pub/sub
We can also not run a server and call it via CLI

A client daemon connects to the redis, and via its config, watches certain queues, and runs certain commands configured per queue
You can say that for queue X, it runs a command as user Y, and sends the payload in STDIN.

How?
====

Just use Redis pub/sub
Super basic Sinatra app

Configuration
=============


The configuration files for servers and clients don't interfere, they have their own section parts.
As such, we use the same file name. It's just easier.


Server
------


/etc/spiderbatch/spiderbatch.ini

```
# The server section is only necessary if you run the server. You can also choose to only run the CLI to publish.
[server]
port = 9000
bind = 127.0.0.1
lowrel_redis_host = 127.0.0.1
lowrel_redis_port = 6379

[some_queue_name]
reliability = (low/high). Default: low (only implemented low for now)

#TODO
#authentication for local clients, and for the nodes.
```

Node
----

/etc/spiderbatch/spiderbatch.ini
```
[some_queue_name]
server = <name>
reliability = (low/high). Default: low (only implemented low for now)
command = <some command>

#TODO
#user = <some user it will suid to>
#group = <some group it will suid to>
```
