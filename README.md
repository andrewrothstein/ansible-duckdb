andrewrothstein.duckdb
=========

![Build Status](https://github.com/andrewrothstein/ansible-duckdb/actions/workflows/build.yml/badge.svg)

Installs the [duckdb](https://duckdb.org/) cli

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.duckdb
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
