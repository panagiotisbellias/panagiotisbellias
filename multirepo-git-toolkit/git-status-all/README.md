# git_status_all.sh

## Detailed Explanation

This [script](git_status_all.sh) recursively scans all Git repositories under the current directory (including submodules), collects their git status, and logs the results. It highlights repositories that have uncommitted changes.

## Usage

```bash
./git_status_all.sh [OUTPUT_FILE]
```

**Arguments**

* OUTPUT_FILE (optional, default: git-status.log)
    * File where the status reports will be saved.

**Operations**

* Setup & Logging
    * Clears the output file.
    * Prints a header showing where the log will be written.
* Repository Discovery
    * Recursively finds all .git directories or .git files (the latter for submodules).
    * Iterates through each discovered repository.
* Per-Repository Processing
    For each repository:
    * Logs repository path and timestamp.
    * Enters the repository.
    * Runs:
        * git status --ignore-submodules=none → human-readable status.
        * git status --porcelain=2 --untracked-files=all --ignore-submodules=none → machine-readable check.
    * If porcelain output is non-empty → marks the repository as DIRTY (uncommitted/untracked changes).
    * Appends results to both the console and the output file.
* Dirty Repo Tracking
    * Keeps track of all repos that were dirty in a dirty_repos array (currently logged inline).

**Example**

```bash
./git_status_all.sh my-status-report.log
```

Output snippet:
```log
📝 Collecting git status for all repos (including submodules)...
Output will be written to my-status-report.log
---------------------------------------
📂 Checking ./project-a ...
On branch development
Your branch is up to date with 'origin/development'.
nothing to commit, working tree clean

📂 Checking ./project-b ...
On branch feature-x
Your branch is behind 'origin/feature-x' by 2 commits, and can be fast-forwarded.
  (use "git pull" to update your local branch)
Untracked files:
  (use "git add <file>..." to include in what will be committed)
    test.txt

⚠️ Repo is DIRTY: ./project-b
```

**Use Cases**

* Workspace Health Check  
Quickly review the state of all repositories in your development environment.

* Pre-Commit Audits  
Ensure no dirty repos remain before committing or pushing changes.

* Release Validation  
Verify that all repositories and submodules are clean before cutting a release.

* Team Collaboration  
Share a unified log (git_status.log) of repo states across a large project.

* Automation Pipelines  
Integrate into CI/CD to detect uncommitted changes before automated builds or deployments.
