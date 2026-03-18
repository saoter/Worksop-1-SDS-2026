# Workshop Introduction: Shell Scripts  in MLOps

## Why this matters in MLOps

In MLOps, models and data pipelines do not live only on our laptops.  
At some point, we want processes to run on servers in a more reliable and repeatable way.

  

-   **Shell scripts (`.sh`)**

These are simple but powerful tools that help automate ML-related work on a server.

---

## 1. What is a `.sh` script?

A `.sh` script is a **shell script**: a text file containing terminal commands that the server can execute step by step.

Instead of typing the same commands manually every time, we put them into one script.

Typical uses in MLOps:

-   creating folders
-   activating environments
-   running Python scripts
-   starting API servers
-   launching training jobs
-   making backups
-   downloading data
-   logging outputs

### Why use shell scripts?

Because they make work:

-   **repeatable**
-   **faster**
-   **less error-prone**
-   **easier to share with others**
-   **easier to document**

  

##   

---

## 3. Typical MLOps flow on a server

A very common simple setup looks like this:

1.  A **shell script** contains the commands
2.  A **Python script** does the actual ML/data task
3.  **cron** runs the shell script automatically
4.  Logs are saved so we can inspect what happened

Example:

-   `run_pipeline.sh` activates environment and runs Python
-   `news_pipeline.py` downloads data and stores results
-   cron runs `run_pipeline.sh` every morning at 07:00
-   output is written to a log file

This is a very small but real MLOps pattern.

---

## 4. Example: create and run a simple shell script

Below is a very small example.

### Step A: Create a folder

```bash
mkdir -p ~/mlops_democd ~/mlops_demo
```

### Step B: Create a shell script

Create a file called `hello_server.sh`:

```bash
nano hello_server.sh
```

Paste this:

```bash
#!/bin/bashecho "Hello from the server!"echo "Current date and time:"date
```

Save and exit.

### Step C: Make it executable

```bash
chmod +x hello_server.sh
```

### Step D: Run it

```bash
./hello_server.sh
```

You should see something like:

```text
Hello from the server!Current date and time:Tue Mar 17 14:00:00 CET 2026
```

---

##