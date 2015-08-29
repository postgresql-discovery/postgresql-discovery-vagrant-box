/home/vagrant/workspace/postgresql.org/build:
    file.directory:
        - user: vagrant
        - group: vagrant
        - mode: 755
        - makedirs: True
        - recurse:
            - user
            - group
            - mode
