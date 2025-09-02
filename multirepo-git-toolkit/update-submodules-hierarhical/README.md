# update_submodules_hierarchical.sh

## Detailed Explanation

This [script](update_submodules_hierarchical.sh) automates the process of cloning parent repositories and adding/updating submodules in a hierarchical structure. It ensures each repository and submodule is on the specified branch, creates branches if missing, initializes empty repos, and pushes changes to GitHub.

## Usage

```bash
./update_submodules_hierarchical.sh USER BRANCH submodules.txt
```

**Arguments**

* USER (required)
    * GitHub username or organization under which repositories exist.
* BRANCH (required)
    * Branch name for committing changes in parent repos and submodules. Will be created if missing.
* submodules.txt (required)
    * A file defining the hierarchical structure:
        * Lines like [repo-name] denote parent repositories.
        * Lines following a parent are submodule repository names.
        * Comments or empty lines are ignored.

**Operations**

* Initialization
    * Exits on any errors and traps failed lines.
    * Reads the submodules file, trims whitespace, removes empty lines/comments.
* Parent Repository Handling
    For lines like [repo-name]:
    * Cleans repo name for safe folder creation.
    * Clones the repository if missing.
    * Checks out the specified branch:
        * Creates it locally or remotely if missing.
        * Handles empty repos by creating an initial commit with a README.
* Submodule Handling
    For lines under a parent repository:
    * Sanitizes submodule folder name.
    * Adds the submodule if missing.
    * Checks out the specified branch in the submodule:
        * Creates branch if missing or orphan branch for empty repos.
        * Pulls latest changes from remote.
    * Updates the parent repository to reference the new submodule commit.
    * Commits and pushes changes in the parent repo.
* Error Handling
    * Uses set -e and trap to stop on errors.
    * Logs warnings and continues when non-critical operations fail (e.g., push conflicts).
* Logging
    * Prints informative messages:
        * Which parent and submodule repo is being processed.
        * Branch operations.
        * Clone, commit, and push actions.
        * Final commit hashes for submodules.

**Example**

Input file: submodules.txt

```txt
# Parent repos
[core-service]
auth-lib
db-lib

[frontend-ui]
ui-components
```

Command
```bash
./update_submodules_hierarchical.sh panagiotisbellias development submodules.txt
```

Output snippet:
```log
---------------------------------------------
📜 [1/5] Processing line: '[core-service]'
📂 Found parent repo: 'core-service'
➡️  Cloning https://github.com/panagiotisbellias/core-service.git into folder core-service
🔀 Checking if branch 'development' exists locally...
🆕 Repository is empty, creating initial commit...

✅ [2/5] Adding submodule auth-lib
   URL:       https://github.com/panagiotisbellias/auth-lib.git
   Path:      core-service/auth-lib
⬇️  Pulling latest changes in submodule auth-lib...
💾 Updating parent to new submodule commit abc123
🚀 Pushing parent changes...
```

**Use Cases**

* Hierarchical Project Setup  
Clone a parent repo and automatically add all submodules in the correct structure.

* Branch Management Across Parent/Submodules  
Ensure all repos and submodules exist on a specified branch, creating it if missing.

* Initial Commit Automation  
Handle empty repositories automatically by creating orphan branches with a README.

* Bulk Updates in Multi-Repo Projects  
Update submodules to the latest commit and push changes in parent repos automatically.

* GitHub Organization Automation  
Work across multiple repositories in a GitHub org, automating cloning, branch creation, submodule additions, and pushes.
