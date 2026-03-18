## 🧪 Exercise: Setting up MySQL and connecting from VS Code (UCloud)

### GOAL

In this exercise, you will:

    - create an empty folder for MySQL data
    - start a MySQL server
    - set a root password
    - create a new user (clientuser)
    - start a VS Code server
    - connect VS Code to MySQL
    - create and test a database

### Step 1 — Create folder structure  

On UCLOUD go to Drives (files) and create two folders:
    - SQL
    - VSCODE

### Step 2 - Start MySQL server

- Under applications search for "sql" and select MySQL app.
- Select the smallest engine for a few hours
- Select folder: SQL
- Under "Mandatory Parameters" select the same folder SQL
- SUBMIT request

### Step 3 — Get root password

- In logs, you will see temporary root password:
    **GENERATED ROOT PASSWORD: <temporary_password>**
- copy the password as we need it when we enter the engine

### Step 4 — Log into MySQL and change password
- Open the terminal for MySQL application

enter:

```bash
mysql -u root -p
```
- Paste the temporary password

- then run

```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'abc123!';
```
### Step 5 — Create application user

Still inside MySQL write:

```sql
CREATE DATABASE course_db;

CREATE USER 'clientuser'@'%' IDENTIFIED BY 'abc123!';
GRANT ALL PRIVILEGES ON course_db.* TO 'clientuser'@'%';

FLUSH PRIVILEGES;
```
This will create a new user (client) and set a password for it... I have the same password, which is very wrong in real world, however, I was not really creative when writing this script.

**Important concept:**

    - 'clientuser'@'%' allows connections from other services (like VS Code)
    - root@localhost is only for internal/admin use


### Step 6 — Start VS Code server

Create a new VS Code / Coder job:
    - Engine: smallest
    - Time: 1 hours

Mount your VSCODE folder

**🔗 Important:**

    Use “Connect to other jobs”
    Select your MySQL job
    Set hostname: sql-net


### Step 7 — Open terminal and install MySQL client

Inside VS Code terminal:   # we need to install dependancies we will use

```bash
sudo apt update
sudo apt install mysql-client -y
```


### Step 8 — Test connection to MySQL

```bash
ping sql-net -c 3
```

### Step 9 — Connect to MySQL from VS Code

```bash
mysql -h sql-net -u clientuser -p
```

Enter password:

```
abc123!
```

### Step 10 — Use the database

```sql
USE course_db;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

INSERT INTO users (name, age) VALUES
('Alice', 25),
('Bob', 30);

SELECT * FROM users;
```

**If we get desired output (table) everything works... now, lets stop both applications and start them in the same order as earlier**

### Step 11 — Start MySQL using the same folder "SQL"

This time we dont need to set passwords, as all configuration and database was saved in this folder.

### Step 12 — Start VSCODE using the same folder "VSCODE"

**don't forget connecting the jobs again with the same hostname (sql-net)**

The configuration of this server was not saved. So, we need to do everything again from step 7 - 9!

### Step 13 - Write shell script for VS Code, that will be used next time to start the server and save it in VSCODE folder


### Step 14 - print the table again

```sql
SELECT * FROM users;
```

### Step 15 - turn off the VSCode application and run it again

- This time, when selecting parameters, under **Optional Parameters** choose **Initalization** and select shell script to start server.

- Dont forget to connect jobs again... 

After server starts... What did you noticed?


