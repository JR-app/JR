package utils

import (
	"context"
	"fmt"
	"os"

	"github.com/JR-app/JR/api/vars"
	"github.com/jackc/pgx/v5/pgxpool"
)

func GetConnection() {
	dbpool, err := pgxpool.New(context.Background(), vars.DATABASE_URL)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to create connection pool: %v\n", err)
		os.Exit(1)
	}
	defer dbpool.Close()

	var greeting string
	// TODO: change this
	err = dbpool.QueryRow(context.Background(), "select 'Hello, world!'").Scan(&greeting)
	if err != nil {
		fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
		os.Exit(1)
	}

	fmt.Println(greeting)
}
