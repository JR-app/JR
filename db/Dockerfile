FROM postgres:17-bookworm
ENV POSTGRES_PASSWORD=a
ENV	POSTGRES_DB=jr-db-dev
COPY dummy-data.sql /docker-entrypoint-initdb.d/
