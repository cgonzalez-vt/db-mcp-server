package dbtools

import (
	"testing"
)

func TestValidateReadOnlyQuery(t *testing.T) {
	tests := []struct {
		name        string
		query       string
		expectError bool
	}{
		{
			name:        "Valid SELECT query",
			query:       "SELECT * FROM users",
			expectError: false,
		},
		{
			name:        "Valid SELECT with WHERE",
			query:       "SELECT id, name FROM users WHERE age > 18",
			expectError: false,
		},
		{
			name:        "Valid SELECT with JOIN",
			query:       "SELECT u.name, o.total FROM users u JOIN orders o ON u.id = o.user_id",
			expectError: false,
		},
		{
			name:        "Invalid INSERT query",
			query:       "INSERT INTO users (name, email) VALUES ('John', 'john@example.com')",
			expectError: true,
		},
		{
			name:        "Invalid UPDATE query",
			query:       "UPDATE users SET name = 'Jane' WHERE id = 1",
			expectError: true,
		},
		{
			name:        "Invalid DELETE query",
			query:       "DELETE FROM users WHERE id = 1",
			expectError: true,
		},
		{
			name:        "Invalid DROP query",
			query:       "DROP TABLE users",
			expectError: true,
		},
		{
			name:        "Invalid CREATE query",
			query:       "CREATE TABLE users (id INT, name VARCHAR(100))",
			expectError: true,
		},
		{
			name:        "Invalid ALTER query",
			query:       "ALTER TABLE users ADD COLUMN age INT",
			expectError: true,
		},
		{
			name:        "Invalid TRUNCATE query",
			query:       "TRUNCATE TABLE users",
			expectError: true,
		},
		{
			name:        "Invalid query with semicolon separator",
			query:       "SELECT * FROM users; DROP TABLE users",
			expectError: true,
		},
		{
			name:        "Invalid SELECT INTO query",
			query:       "SELECT * INTO new_table FROM users",
			expectError: true,
		},
		{
			name:        "Invalid SELECT INTO OUTFILE",
			query:       "SELECT * FROM users INTO OUTFILE '/tmp/users.csv'",
			expectError: true,
		},
		{
			name:        "Valid WITH CTE query",
			query:       "WITH cte AS (SELECT * FROM users) SELECT * FROM cte",
			expectError: false,
		},
		{
			name:        "Valid EXPLAIN query",
			query:       "EXPLAIN SELECT * FROM users",
			expectError: false,
		},
		{
			name:        "Valid SHOW query",
			query:       "SHOW TABLES",
			expectError: false,
		},
		{
			name:        "Valid DESCRIBE query",
			query:       "DESCRIBE users",
			expectError: false,
		},
		{
			name:        "Case insensitive INSERT",
			query:       "insert into users (name) values ('test')",
			expectError: true,
		},
		{
			name:        "Case insensitive UPDATE",
			query:       "update users set name='test'",
			expectError: true,
		},
		{
			name:        "Invalid EXEC query",
			query:       "EXEC sp_procedure",
			expectError: true,
		},
		{
			name:        "Invalid EXECUTE query",
			query:       "EXECUTE sp_procedure",
			expectError: true,
		},
		{
			name:        "Invalid CALL query",
			query:       "CALL my_procedure()",
			expectError: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			err := validateReadOnlyQuery(tt.query)
			if tt.expectError && err == nil {
				t.Errorf("Expected error for query: %s, but got none", tt.query)
			}
			if !tt.expectError && err != nil {
				t.Errorf("Did not expect error for query: %s, but got: %v", tt.query, err)
			}
		})
	}
}





