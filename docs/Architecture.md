# Architecture Overview – MariaDB Logging Server (Manual Setup)

This document outlines the architecture of a manually configured MariaDB-based logging server hosted on a resource-constrained Debian machine. The setup emphasizes production-style practices with full manual control, Git-based versioning, and cron-managed automation.

---

## Project Goal

To manually build a robust and transparent database logging system using:

- A self-hosted MariaDB server (no package manager)
- Shell scripts for startup and logging
- GitHub integration for daily log archival
- Cron-based automation for error handling and cleanup

---

##Server & Environment

| Component      | Detail                          |
|----------------|---------------------------------|
| OS             | Debian (No GUI)                 |
| RAM            | 4 GB                            |
| CPU            | AMD-based laptop                |
| Service Base   | `/location/`                    |
| Access         | Local terminal (no remote SSH)  |

---

## Directory Structure – `/location/`
myserver/
├── mariadb/ # Extracted MariaDB binaries
├── mysql/ # MariaDB data files
├── logs/ # Runtime logs (general, error, startup)
└── github/ # Git-tracked project folder
  ├── config/ # Configuration files (e.g., my.cnf)
  ├── cron/ # Cron scripts like auto-push-logs.sh
  ├── logs/ # Daily copied logs pushed to GitHub
  ├── scripts/ # Service control scripts
  └── docs/ # Architecture & system design docs

---

## Key Components

### 1. MariaDB (Manual Install)
- Installed from official tarball
- Custom `my.cnf` in `mariadb/`
- Bound to `127.0.0.1` to ensure local-only access
- Fixed port `XXXX` used for consistent server/client communication
- Socket-only communication enabled for efficient and secure local connection
- Logs enabled: `general.log`, `error.log`
- Runs as non-root user `harsh` for better privilege separation and system safety

### 2. Git Logging System
- Git repo lives under `/location/github/`
- Token-based GitHub sync
- Logs pushed daily at 2 AM via cron
- Repo structure:
  - `logs/`: `startup-YYYY-MM-DD.log`, `general-YYYY-MM-DD.log`, `error-YYYY-MM-DD.log`
  - `scripts/`: `start-mariadb.sh`, `auto-push-logs.sh`
  - `docs/`: `Architecture.md`, `System_Design.md`

### 3. Cron Jobs
| Time     | Task                                               |
|----------|----------------------------------------------------|
| 12:01 AM | Rotate error.log and Genereal.log at 12:01 AM      |
| 12:02 AM | Create new empty logs after rotation               |
| 12:03 AM | Flush logs so that mariadb can open the new files  |
| 12:03 AM | Keep only last 7 days of logs in MariaDB           |
| 12:04 AM | Move rotated logs to github folder                 |
| 12:05 AM | Push logs to githubv                               |
| 12:10 AM | Delete all logs in github after push at 12:10 AM   |

---

## Workflow Summary

1. You manually start the MariaDB server using `start-mariadb.sh`
2. The script writes a `startup-YYYY-MM-DD.log`
3. MariaDB itself writes `general.log` and `error.log`
4. At 2 AM the next day, cron:
   - Copies all logs from yesterday
   - Renames if needed
   - Commits and pushes to GitHub

---

## Why This Architecture?

- Full manual control (no hidden automation)
- Real production-style logging and rotation
- Version-controlled logs, scripts, and configs
- Optimized for minimal resources (ideal for old systems)
- Designed to scale into a multi-service platform

---

## Next Steps

- Create databases and scoped users in MariaDB
- Build DB dashboard on `/location2/`
- Host public/private services across `/location3/` partitions
- Build a media server from `/location4/`

---

This architecture is under continuous enhancement and follows a "build-it-yourself" philosophy for hands-on learning.

