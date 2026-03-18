# Workshop Introduction: Shell Scripts and Cron in MLOps

## Why this matters in MLOps

In MLOps, models and data pipelines do not live only on our laptops.  
At some point, we want processes to run on servers in a more reliable and repeatable way.

Two very common building blocks are:

- **Shell scripts (`.sh`)**
- **Cron jobs**

These are simple but powerful tools that help automate ML-related work on a server.

---

## 1. What is a `.sh` script?

A `.sh` script is a **shell script**: a text file containing terminal commands that the server can execute step by step.

Instead of typing the same commands manually every time, we put them into one script.

Typical uses in MLOps:

- creating folders
- activating environments
- running Python scripts
- starting API servers
- launching training jobs
- making backups
- downloading data
- logging outputs

### Why use shell scripts?

Because they make work:

- **repeatable**
- **faster**
- **less error-prone**
- **easier to share with others**
- **easier to document**

So a shell script is often the first step from a manual workflow toward automation.

---

## 2. What is `cron`?

`cron` is a scheduler on Linux servers.

It allows the server to automatically run commands or scripts at specific times, for example:

- every day at 06:00
- every Monday at 08:00
- every hour
- every 5 minutes

In MLOps, cron can be used to:

- fetch fresh data regularly
- retrain models on a schedule
- generate predictions every morning
- clean logs or temporary files
- run monitoring scripts
- back up databases

### Cron vs GitHub Actions

Cron is a bit like **GitHub Actions for your own server**.

The difference is:

- **GitHub Actions** runs in GitHub's infrastructure
- **cron** runs directly on your own Linux machine or virtual server

So if you have your own Ubuntu server, cron is one of the simplest ways to automate workflows there.

---

## 3. Typical MLOps flow on a server

A very common simple setup looks like this:

1. A **shell script** contains the commands
2. A **Python script** does the actual ML/data task
3. **cron** runs the shell script automatically
4. Logs are saved so we can inspect what happened

Example:

- `run_pipeline.sh` activates environment and runs Python
- `news_pipeline.py` downloads data and stores results
- cron runs `run_pipeline.sh` every morning at 07:00
- output is written to a log file

This is a very small but real MLOps pattern.

---

## 4. Example: create and run a simple shell script

Below is a very small example.

### Step A: Create a folder

```bash
mkdir -p ~/mlops_demo
cd ~/mlops_demo
```

### Step B: Create a shell script

Create a file called `hello_server.sh`:

```bash
nano hello_server.sh
```

Paste this:

```bash
#!/bin/bash

echo "Hello from the server!"
echo "Current date and time:"
date
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
Hello from the server!
Current date and time:
Tue Mar 17 14:00:00 CET 2026
```

---

## 5. A more realistic MLOps example

Usually we want the shell script to run a Python script.

### Example Python script: `train_demo.py`

```python
from datetime import datetime

print("Running ML task...")
print("Timestamp:", datetime.now())

# Example placeholder for ML work
# - load data
# - train model
# - save output
```

### Example shell script: `run_training.sh`

```bash
#!/bin/bash

cd ~/mlops_demo

echo "Starting training job..."
date

python3 train_demo.py

echo "Training job finished."
date
```

Make it executable:

```bash
chmod +x run_training.sh
```

Run it:

```bash
./run_training.sh
```

---

## 6. Why `cd` is important inside scripts

A server does not always run scripts from the folder you expect.

That is why shell scripts often include:

```bash
cd /path/to/project
```

Without that, Python files, data files, or output paths may fail.

This is one of the most common beginner mistakes.

---

## 7. Using cron to run a script automatically

Open the cron editor:

```bash
crontab -e
```

Add a line like this:

```cron
0 7 * * * /home/your_username/mlops_demo/run_training.sh >> /home/your_username/mlops_demo/training.log 2>&1
```

### What this means

- `0 7 * * *` → run every day at 07:00
- `run_training.sh` → the script to execute
- `>> training.log` → append normal output to a log file
- `2>&1` → also append errors to the same log file

This is very important, because logs help us debug problems.

---

## 8. Cron time format

Cron uses five time fields:

```text
minute hour day_of_month month day_of_week
```

Examples:

```cron
0 7 * * *     # every day at 07:00
0 * * * *     # every hour
*/5 * * * *   # every 5 minutes
30 8 * * 1    # every Monday at 08:30
```

---

## 9. Good practices in MLOps server automation

When using shell scripts and cron, it is good to:

- use absolute paths
- log both output and errors
- test scripts manually before scheduling them
- keep scripts simple and readable
- separate shell logic from Python logic
- make folders for logs, data, and outputs
- document what the job does

---

## 10. Common problems students run into

### Script works manually but not in cron
Usually because:

- environment variables are missing
- paths are relative instead of absolute
- the wrong Python interpreter is used
- the script is not executable

### Permissions problems
Fix with:

```bash
chmod +x script_name.sh
```

### Nothing seems to happen
Check:

```bash
crontab -l
```

And inspect the log file:

```bash
cat training.log
```

---

## 11. A simple workshop exercise

### Task
Create a script that:

1. creates a folder called `outputs`
2. writes the current date into a file
3. runs automatically every minute for testing

### Example shell script

```bash
#!/bin/bash

cd ~/mlops_demo
mkdir -p outputs
echo "Run at: $(date)" >> outputs/runs.txt
```

Save it as:

```text
log_time.sh
```

Make it executable:

```bash
chmod +x log_time.sh
```

Run it manually once:

```bash
./log_time.sh
```

Now schedule it:

```bash
crontab -e
```

Add:

```cron
* * * * * /home/your_username/mlops_demo/log_time.sh
```

Wait a couple of minutes and inspect:

```bash
cat ~/mlops_demo/outputs/runs.txt
```

You should see multiple timestamps being added.

---

## 12. Summary

Shell scripts and cron are basic but very useful tools in MLOps.

- **Shell scripts** help us package commands into repeatable workflows
- **cron** helps us automate those workflows on a server
- together they form a simple foundation for data pipelines, model training, prediction jobs, and monitoring tasks

Before using bigger tools such as Airflow, Prefect, Kubernetes, or cloud schedulers, it is very useful to understand this simple server-based setup.

---

# Minimal End-to-End Example

## Files

### `train_demo.py`

```python
from datetime import datetime
from pathlib import Path

output_dir = Path.home() / "mlops_demo" / "outputs"
output_dir.mkdir(parents=True, exist_ok=True)

with open(output_dir / "train_log.txt", "a", encoding="utf-8") as f:
    f.write(f"Training ran at: {datetime.now()}\n")

print("Done.")
```

### `run_training.sh`

```bash
#!/bin/bash

cd /home/your_username/mlops_demo
python3 train_demo.py
```

## Commands to set it up

```bash
mkdir -p ~/mlops_demo
cd ~/mlops_demo
nano train_demo.py
nano run_training.sh
chmod +x run_training.sh
./run_training.sh
```

## Add to cron

```bash
crontab -e
```

```cron
*/5 * * * * /home/your_username/mlops_demo/run_training.sh >> /home/your_username/mlops_demo/cron.log 2>&1
```

This will run every 5 minutes.

---

# Suggested classroom message

This setup is not fancy, but it is very realistic.  
A lot of real MLOps automation starts exactly like this: a server, a script, a scheduler, and a log file.
