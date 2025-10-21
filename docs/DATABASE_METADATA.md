# Database Metadata Feature

## Overview

The Database Metadata feature allows you to add rich contextual information to your database connections without affecting tool names. This solves the problem of tool names becoming too long while still providing AI assistants like Cursor with the context they need to select the right database.

## The Problem

When you have multiple databases for different projects and environments, you want descriptive names like `transaction-service-production-database`. However, these names create tool names like `query_transaction-service-production-database` which are:

1. **Too long** - Can hit character limits in some MCP clients
2. **Hard to read** - Difficult to scan quickly
3. **Redundant** - The tool type prefix adds extra length

## The Solution

Use **short IDs** for tool names but add **rich metadata** for context:

```json
{
  "id": "ts_prod",  // Short ID used in tool names
  "display_name": "Transaction Service Production",  // Full descriptive name
  "project": "transaction-service",  // Project identifier
  "environment": "production",  // Environment
  "description": "Main production database for transaction processing service",
  "tags": ["production", "critical", "transactions", "payments"]
}
```

This creates tools named:
- `query_ts_prod` ✅ Short and clean
- `schema_ts_prod` ✅ Easy to read

But with descriptions that provide full context:
- "Execute read-only SQL query (SELECT only) on Transaction Service Production database (Project: transaction-service, Environment: production, Main production database for transaction processing service)"

## Configuration

### Basic Configuration (Backward Compatible)

The simplest configuration still works:

```json
{
  "connections": [
    {
      "id": "my_db",
      "type": "postgres",
      "host": "localhost",
      "port": 5432,
      "name": "mydb",
      "user": "user",
      "password": "pass"
    }
  ]
}
```

### Enhanced Configuration with Metadata

Add optional metadata fields for better context:

```json
{
  "connections": [
    {
      "id": "ts_prod",
      "type": "postgres",
      "host": "transaction-db.prod.example.com",
      "port": 5432,
      "name": "transactions",
      "user": "app_user",
      "password": "your-password-here",
      
      // Metadata fields (all optional)
      "display_name": "Transaction Service Production",
      "project": "transaction-service",
      "environment": "production",
      "description": "Main production database for transaction processing service",
      "tags": ["production", "critical", "transactions", "payments"]
    }
  ]
}
```

## Metadata Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `id` | string (required) | Short identifier for tool names | `ts_prod`, `usr_stg` |
| `display_name` | string | Full descriptive name | `Transaction Service Production` |
| `project` | string | Project identifier | `transaction-service` |
| `environment` | string | Environment name | `production`, `staging`, `dev` |
| `description` | string | Detailed description | `Main production database for transaction processing` |
| `tags` | array[string] | Tags for categorization | `["production", "critical"]` |

## Naming Convention Recommendations

### Short IDs (for tool names)

Use concise, memorable abbreviations:

```
project_env
```

Examples:
- `ts_prod` - Transaction Service Production
- `ts_stage` - Transaction Service Staging
- `usr_prod` - User Service Production
- `ord_prod` - Order Service Production
- `inv_dev` - Inventory Service Development

### Display Names

Use full, human-readable names:

```
[Project Name] [Environment]
```

Examples:
- `Transaction Service Production`
- `User Authentication Staging`
- `Order Management Production`
- `Inventory Service Development`

## How MCP Clients See It

### Tool Name (Short)
```
query_ts_prod
```

### Tool Description (Rich Context)
```
Execute read-only SQL query (SELECT only) on Transaction Service Production database 
(Project: transaction-service, Environment: production, 
Main production database for transaction processing service)
```

### Benefits for AI Assistants

1. **Clear Context** - AI knows exactly which database to use
2. **Project Awareness** - Understands which service the database belongs to
3. **Environment Safety** - Knows if it's production, staging, or dev
4. **Purpose Understanding** - Description explains what the database contains

## Example: Multi-Project Setup

```json
{
  "connections": [
    {
      "id": "ts_prod",
      "display_name": "Transaction Service Production",
      "project": "transaction-service",
      "environment": "production",
      "description": "Production database for transaction processing",
      "tags": ["production", "transactions"],
      "type": "postgres",
      "host": "transaction-db.prod.example.com",
      "port": 5432,
      "name": "transactions",
      "user": "app_user",
      "password": "password"
    },
    {
      "id": "ts_stage",
      "display_name": "Transaction Service Staging",
      "project": "transaction-service",
      "environment": "staging",
      "description": "Staging environment for testing transaction features",
      "tags": ["staging", "transactions"],
      "type": "postgres",
      "host": "transaction-db.stage.example.com",
      "port": 5432,
      "name": "transactions",
      "user": "app_user",
      "password": "password"
    },
    {
      "id": "usr_prod",
      "display_name": "User Service Production",
      "project": "user-service",
      "environment": "production",
      "description": "User authentication and profile database",
      "tags": ["production", "users", "auth"],
      "type": "postgres",
      "host": "user-db.prod.example.com",
      "port": 5432,
      "name": "users",
      "user": "app_user",
      "password": "password"
    }
  ]
}
```

## Migration Guide

### Step 1: Keep Your Current IDs

If you already have long IDs in use, you can either:

1. **Keep them** (backward compatible) - Just add metadata fields
2. **Shorten them** - Update IDs and add display names with the full original name

### Step 2: Add Display Names

Add a `display_name` field with the full descriptive name:

```json
{
  "id": "existing_long_database_name",
  "display_name": "Existing Long Database Name",
  ...
}
```

### Step 3: Add Project and Environment

Add context for AI assistants:

```json
{
  "id": "existing_long_database_name",
  "display_name": "Existing Long Database Name",
  "project": "my-project",
  "environment": "production",
  ...
}
```

### Step 4: Add Descriptions and Tags

Complete the metadata:

```json
{
  "id": "existing_long_database_name",
  "display_name": "Existing Long Database Name",
  "project": "my-project",
  "environment": "production",
  "description": "Main application database",
  "tags": ["production", "critical"],
  ...
}
```

## Best Practices

### 1. Use Consistent ID Naming

Pick a pattern and stick with it:
- `{project}_{env}` - `ts_prod`, `usr_stage`
- `{abbrev}_{env}` - `trx_prod`, `usr_stage`

### 2. Make Display Names Descriptive

Include both the service and environment:
- ✅ `Transaction Service Production`
- ❌ `Database 1`

### 3. Add Helpful Descriptions

Explain what the database contains:
- ✅ `Main database for processing customer transactions and payment records`
- ❌ `Transaction database`

### 4. Use Tags for Organization

Tag databases by:
- **Criticality**: `critical`, `non-critical`
- **Environment**: `production`, `staging`, `dev`
- **Function**: `transactions`, `users`, `analytics`
- **Compliance**: `pii`, `financial`, `public`

## Testing Your Configuration

After updating your config, test the tool descriptions:

```bash
# Test the tools list
./test_list_tools.sh | jq '.result.tools[] | {name, description}'
```

You should see enhanced descriptions with your metadata.

## See Also

- [config.example-with-metadata.json](../config.example-with-metadata.json) - Full example configuration
- [README.md](../README.md) - Main project documentation

