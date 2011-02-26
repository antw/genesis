GENESIS
=======

A collection of scripts for setting up new servers.

COMPONENTS
----------

Genesis allows splitting set-up scripts into three categories: recipes,
roles, and servers.

Recipes are the smallest possible scripts, intended to set up single
pieces of software (and no more) such as Apache, Nginx, RVM, etc.
Recipies are then combined into "roles" which combine recipes into
larger, reusuable units such as "rails-stack", "mysql-stack", etc.

Finally, servers permit roles to be combines on a server-by-server
basis. You might, for example, wish to combine "rails-stack" and
"mysql-stack" roles into a single "standalone" server, or perhaps a
"redis" recipie with a "resque-stack" to create a dedicated job server.
Server components are also an ideal place to specify machine-specific
configuration.

Recipes, roles, and servers should each have their own directory which
matches the name of the component, with the following directory
structure inside:

* **`run.sh`** This is the first script called and should perform
  initial installation, set variables, define functions, etc.

* **`files/`** An directory containing files (or directories) to be
  copied into the server root. This copy if performed after running
  `run.sh` but before...

* **`after.sh`** Effectively an after "filter", this is run after files
  are copied.

All three of the above files/directories are optional. Genesis will skip
any which aren't present.

Component directories may also contain a four sub-directory.

* **`contrib/`** A directory containing sources, .deb pages, etc, which
  are _not_ copied to the server root, but may be used by `run.sh` or
  `after.sh`.

USAGE
-----

Genesis should be copied to the new server thusly:

    $ scp -r genesis/ user@machine

Then run the command with the name of the server to be set up (the -t
flag tells OpenSSH to use a pseudo-tty in order to allow you to enter
sudo passwords):

    $ ssh -t user@machine "./genesis/genesis.sh server-component-name"

... and you're done!

DETAILS
-------

* Source: [http://github.com/antw/genesis][genesis]
* Author: Anthony Williams
* Copyright: 2011
* License: None presently

[genesis]: http://github.com/antw/genesis
