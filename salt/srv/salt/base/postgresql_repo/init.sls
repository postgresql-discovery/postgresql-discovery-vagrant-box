git://git.postgresql.org/git/postgresql.git:
    git.latest:
        - rev: master
        - target: /home/vagrant/workspace/postgresql.org/postgresql
        - depth: 1
        - user: vagrant
        - require:
            - pkg: git
