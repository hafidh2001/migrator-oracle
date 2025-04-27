# Database Connection Tool

A command-line tool to connect to Oracle Database and explore tables.

## Setup

1. Copy the environment file:

```bash
cp .env.example .env
```

## Usage

Test connection:

```bash
bun run index.ts
```

Show Help

```bash
bun run index.ts --help
```

Show Schema Diagram by Mermaid

```bash
bun run index.ts --show=schema [--output=file]
```

This command generate a mermaid script. The diagram is viewed if you visit a url such as https://mermaid.live/.

Show all tables:

```bash
bun run index.ts --show=tables
```

Show table structure:

```bash
bun run index.ts --show=structure --table=TABLE_NAME
```

Show all sequences:

```bash
bun run index.ts --show=sequences
```

Show all pk:

```bash
bun run index.ts --show=pk [--table=TABLE_NAME]
```

Show all uk:

```bash
bun run index.ts --show=uk [--table=TABLE_NAME]
```

Show all fk:

```bash
bun run index.ts --show=fk [--table=TABLE_NAME]
```

Compare files with database tables:

```bash
bun run index.ts --compare=csv --path=BACKUP_DIRECTORY
```

This command checks if each file in the specified directory has a corresponding table in the database. The comparison ignores file extensions and is case-insensitive (e.g., "users.csv", "USERS.json", or "Users.txt" would all match with a "USERS" table).

## Installation

1. Install dependencies:

```bash
bun i
```

## Security Note

- `.env` file containing your actual database credentials is ignored by git
- Never commit sensitive credentials to version control
