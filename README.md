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
no dev instance yet, will create one soon
```
docker pull postgres
docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -d postgres
```
