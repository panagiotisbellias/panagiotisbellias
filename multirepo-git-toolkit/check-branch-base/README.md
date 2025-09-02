# check_branch_base.sh

## Detailed Explanation

This [script](check_branch_base.sh) automates the process of verifying whether a given branch in multiple Git repositories is based on main or master. It also handles missing main/master branches gracefully by creating one from the initial commit when needed.

## Usage

```bash
./check_branch_base.sh TARGET_BRANCH [OUTPUT_FILE] [START_DIR] [SKIP_REPOS_FILE]
```

**Arguments**

* TARGET_BRANCH (required)
    * The branch you want to verify (e.g., development, feature-x).
* OUTPUT_FILE (optional, default: branch-check.log)
    * File where the results will be logged.
* START_DIR (optional, default: .)
    * Root directory to search for Git repositories.
* SKIP_REPOS_FILE (optional)
    * Path to a text file containing repository names to skip (one per line).

**Operations**

* Setup & Logging
    * Clears the output file.
    * Prints script parameters (branch, start dir, skip list).
* Repository Discovery
    * Recursively finds all .git folders starting from START_DIR.
    * Optionally excludes repos listed in SKIP_REPOS_FILE.
* Per-Repository Processing
    For each repository:
    * Logs repo name and timestamp.
    * Skips if it’s in the skip list.
    * Detects whether origin/main or origin/master exists.
        * If neither exists:
            * Creates a main branch from the first commit.
            * Pushes it to origin.
    * Verifies if the target branch exists locally or remotely.
        * If not found → logs a warning.
    * Finds the common ancestor (git merge-base) between the target branch and origin main/origin/master.
        * If ancestor exists and is in branch history → ✅ branch is based on main/master.
        * Otherwise → ⚠️ branch exists but is not based on main/master.
    * Switches back to the target branch (if present).
* Logging
    * Results are written to both the console and the output file (tee).

**Example**

```bash
./check_branch_base.sh development check_branch_base.log ~/projects skip_repos.txt
```

* Checks if development is based on main/master in all repos under ~/projects.
* Logs results to check_branch_base.log.
* Skips repositories listed in skip_repos.txt.

**Use Cases**

* Codebase Audits  
Verify that all feature or development branches are properly based on main or master.

* Migration Checks  
Ensure that repositories migrated from older structures still follow main/master as their base.

* CI/CD Pipelines  
Integrate into automation to prevent merges from branches that are not properly branched off main.

* Team Governance  
Help enforce branching strategies across multiple repositories in a mono-repo or multi-repo setup.

* Cleanup & Standardization  
Automatically create a main branch when missing, ensuring consistency across repositories.
