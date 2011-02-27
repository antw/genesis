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

    - genesis/
      - {recipes,roles,servers}/
        - my-component.sh

          This is main script for the component, and is called by
          Genesis.

        - my-component/

          An optional directory containing files (or directories) to
          be copied into the server root. This copy is not performed
          implictly by Genesis, but rather when you run
          genesis_copy_{recipe,role,server}_files with the name of the
          component.

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
