# SQL Command Reference – MySQL/MariaDB

---

## SQL Login

- **If MySQL is installed on root system:**
  - `mysql -u root -p`

- **If MySQL is installed in a specific location:**
  - Login from any directory: `/location/mysql -u root -p`
  - Move to the directory where MySQL is present: `./mysql -u root -p`

- **If a personal configuration is set up:**
  - Login from any directory: `/location/mysql --defaults-file=/location/personal.cnf -u root -p`
  - Move to directory where MySQL is present: `./mysql --defaults-file=/location/personal.cnf -u root -p`

**Explanation:**
- `-u` specifies the user
- `-p` prompts for password
- `--defaults-file` loads a custom config (for ports, sockets, etc.)
- `./` tells terminal to run from the current directory

---

## Check User

- `select user from mysql.user;`

**Explanation:**
- `select` chooses the column
- `from mysql.user` reads from the internal user table

Fields in `mysql.user` include:
- `host`: where the user connects from
- `authentication_string`: hashed password
- privilege flags: control access rights (e.g., SELECT, CREATE)

---

## Create User

- **Method 1:** `create user user_name;`
- **Method 2:** `create user 'user_name'@'host' identified by 'password@123';`

**Explanation:**
- `create user`: defines a new user
- `'user_name'@'host'`: user allowed to connect from specified host
- `identified by`: sets a password (stored hashed in `authentication_string`)

---

## rant Privileges to User

- `grant all privileges on *.* to 'username'@'host' with grant option;`

**Explanation:**
- `grant`: start of permission statement
- `all privileges`: full rights (CREATE, INSERT, DELETE, etc.)
- `on *.*`: all databases and tables
- `with grant option`: lets user delegate privileges

---

## Delete User

- **Standard:** `drop user 'username'@'host';`
- **Safe method:** `drop user if exists 'username'@'host';`

**Explanation:**
- `drop user`: removes a user
- `if exists`: prevents error if user not found

---

## reate Database

- **Standard:** `create database db_name;`
- **Safe method:** `create database if not exists db_name;`

**Explanation:**
- `create database`: creates a new DB
- `if not exists`: avoids error if it already exists

---

## elete Database

- **Standard:** `drop database db_name;`
- **Safe method:** `drop database if exists db_name;`

**Explanation:**
- `drop database`: deletes a DB
- `if exists`: avoids error if DB not found

---

## Create Table

```sql
create table table_name (
    id int primary key,
    name varchar(50) not null,
    age int default 0
);
```

**Explanation:**
- `create table`: starts table definition
- Columns:
  - `id int primary key`: unique + not null
  - `name varchar(50) not null`: string max 50, required
  - `age int default 0`: integer with default value

---

## Alter Table

- **Add Column:**
  `alter table table_name add column address varchar(100);`

- **Delete Column:**
  `alter table table_name drop column address;`

- **Rename Column:**
  `alter table table_name change column old_name new_name datatype;`

- **Change Datatype:**
  `alter table table_name modify column column_name new_datatype;`

**Explanation:**
- `alter table`: modifies existing table
- `add column`: adds new field
- `drop column`: removes field
- `change column`: renames + changes type
- `modify column`: changes type only

---

## Delete Table

- **Standard:** `drop table table_name;`
- **Safe method:** `drop table if exists table_name;`

**Explanation:**
- `drop table`: deletes table and all data
- `if exists`: avoids error if table missing

---
