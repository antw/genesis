GENESIS
=======

A collection of scripts for setting up new servers.

COMPONENTS
----------

Genesis allows splitting set-up scripts into three categories: recipes,
roles, and servers.

Recipes are the smallest possible scripts, intended to set up single
pieces of software (and no more) such as Apache, Nginx, RVM, etc.
Recipies are then combined into "roles" which such as "rails-stack",
"mysql-stack", etc.

Finally, servers permit you to set up individual machines using the
roles which have been defined. You might for example, wish to combine
"rails-stack" and "mysql-stack" roles into a single "standalone" server,
or perhaps a "redis" recipie with a "resque-stack" to create a
dedicated job server. Server components are also an ideal place to
specify machine-specific configuration.

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

So long as you use the provided `install_package` and `run_recipe`
helpers, Genesis will keep track of the packages and recipes you have
run, so you can safely mix-and-match recipes and roles without worrying
about installing the same software multiple times.

USAGE
-----

Genesis should be copied to the new server thusly:

    $ rsync -avz --delete -e ssh genesis/ user@machine:genesis

Then run the command with the name of the server to be set up (the -t
flag tells OpenSSH to use a pseudo-tty in order to allow you to enter
sudo passwords):

    $ ssh -t user@machine "sudo -s ./genesis/genesis.sh server-component-name"

... and you're done!

Prior to running the server set-up, Genesis automatically runs the
bootstrap and openssh recipies. bootstrap is responsible for updating
the system, and openssh will adjust the OpenSSH configuration to
**disable root login**. Do not run `genesis.sh` until you have added
your SSH user to the sudoers file.

DETAILS
-------

* Source: [http://github.com/antw/genesis][genesis]
* Author: Anthony Williams
* Copyright: 2011
* License: None presently

[genesis]: http://github.com/antw/genesis
