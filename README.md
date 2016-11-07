# docker-pgadmin

Run:
```
docker run -d -it -p 5050:5050 -v $PWD:/home/pgadmin --name pgadmin nphung/docker-pgadmin
```

pgAdmin's log, sessions and SQLite configuration database will be persisted in `$PWD/.pgadmin`.
