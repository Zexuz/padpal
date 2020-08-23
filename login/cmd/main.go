package main

import (
	"github.com/golang-migrate/migrate"
	"login/internal/sql"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/golang-migrate/migrate/source/file"
)

func main() {
	db, _ := sql.Open("padel_360")
	err := sql.MigrateUp(db)

	if err == migrate.ErrNoChange {
		print("No migration needed, everything is up to date")
	} else if err != nil {
		panic(err)
	}
}
