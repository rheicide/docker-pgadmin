# docker-pgadmin
[![](https://images.microbadger.com/badges/image/nphung/pgadmin.svg)]() [![Docker Pulls](https://img.shields.io/docker/pulls/nphung/pgadmin.svg)]()

pgAdmin 4 has no prebuilt packages for Debian and its derivatives, so I have created this Alpine-based Docker image (~161 MB uncompressed) to get it up and running easily on my Linux Mint 18 box.

Note that pgAdmin will run in desktop mode (no multi-user and authentication).

## How to use it

Run:
```
docker run -d -p 5050:5050 --name pgadmin nphung/pgadmin
```

Then you can access pgAdmin at <http://localhost:5050>.

If you have a PostgreSQL instance running on the host and you want to connect the pgAdmin container to it, remember that you cannot use `localhost` in the Host field of pgAdmin's "Create server" dialog, because `localhost` there means *the container itself*. Use the host's IP instead, e.g. what you get from `` echo `ip -4 addr show scope global dev eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1` ``.

pgAdmin's log, sessions and SQLite configuration database will be lost if you remove the container. To persist them, create a named volume and mount it to `/home/pgadmin` in the container, e.g.:
```
docker run -d -p 5050:5050 -v data:/home/pgadmin --name pgadmin nphung/pgadmin
```
Now you can remove the container when you are done with it, and next time you need pgAdmin, you can start a new one with the same volume option (`-v data:/home/pgadmin`) and everything will still be there (the servers you added etc.), assuming you did not remove the named volume.
