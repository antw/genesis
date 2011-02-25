Genesis
-------

A collection of scripts for setting up new servers.

* **lib/** helpers used internally by Genesis.

* **recipes/** re-usable scripts which can be bundled together into
  roles. Examples include "apache", "nginx", "mysql-client", etc.

* **roles/** Bundles recipies into larger roles. For example, the
  "rails-stack" role might include the "nginx", "ruby", and "rails"
  recipes.

* **servers/** Definitions for servers. Best organised by the host name
  of each server. Servers use one or more roles.
