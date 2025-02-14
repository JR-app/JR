# JR

## Running
#### Frontend
```
npx expo start --tunnel #umich wifi requires --tunnel
```


#### Backend
```
go run main.go
```

#### Postgres
runs dev database on port 5432 with dummy data loaded from db/dummy-data.sql
```
# in repository root directory
docker build -t jr-db-img db/
docker run --name <container-name> -p 5432:5432 -v <volume-name>:/var/lib/postgresql/data jr-db-img
```
