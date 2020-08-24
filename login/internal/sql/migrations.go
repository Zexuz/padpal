package sql

import (
	"database/sql"
	"fmt"
	"github.com/golang-migrate/migrate"
	"github.com/golang-migrate/migrate/database/mysql"

	_ "github.com/golang-migrate/migrate/source/file" // Registers the file path migrations in its "init" func
)

const migrationsTableName = "migrations"
const migrationsPath = "file://./migrations"

func MigrateUp(db *sql.DB) error {
	driver, _ := mysql.WithInstance(db, &mysql.Config{
		MigrationsTable: migrationsTableName,
	})

	m, _ := migrate.NewWithDatabaseInstance(
		migrationsPath,
		"mysql",
		driver,
	)
	return m.Up()
}

func Open(database string) (*sql.DB, error) {
	return sql.Open("mysql", fmt.Sprintf("root:password@tcp(localhost:3306)/%s?multiStatements=true", database))
}
