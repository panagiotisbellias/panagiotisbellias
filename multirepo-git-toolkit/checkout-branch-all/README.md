# checkout_branch_all.sh

## Detailed Explanation

This [script](checkout_branch_all.sh) automates checking out a specified branch across multiple Git repositories under a given parent directory. It also handles submodules and can skip specific repositories via a skip list file.

## Usage

```bash
./checkout_branch_all.sh PARENT_DIR BRANCH [OUTPUT_FILE] [SKIP_REPOS_FILE]
```

**Arguments**

* PARENT_DIR (required)
    * Root directory where Git repositories will be searched (recursively).
* BRANCH (required)
    * The branch to check out in each repository.
* OUTPUT_FILE (optional, default: checkout_branch_all.log)
    * File where the results will be logged.
* SKIP_REPOS_FILE (optional)
    * Path to a text file containing repo names or path fragments to skip (one per line).

**Operations**

* Setup & Logging
    * Clears the output file.
    * Prints script parameters (branch, skip list, output file).
* Repository Discovery
    * Finds all .git directories recursively under PARENT_DIR.
    * Optionally excludes repos listed in SKIP_REPOS_FILE.
* Per-Repository Processing
    For each repository:
    * Logs repo name and timestamp.
    * Fetches latest refs (git fetch origin).
    * Detects current branch:
        * If already on target branch → ✅ pulls the latest changes.
        * If the branch exists on remote → 🔄 switches to it, pulling updates, with stash applied before/after switch.
        * If no remote branch exists → ✨ creates a new local branch (not pushed).
    * Handles submodules:
        * Initializes and updates submodules recursively.
        * For each submodule:
            * If already on target branch → ✅ pulls updates.
            * If branch exists remotely → 🔄 switches and pulls.
            * Otherwise → ✨ creates a new local branch.
* Logging
    * All output is both printed to the console and appended to the output file via tee.

**Example**

```bash
./checkout_branch_all.sh ~/Projects development checkout_branch_all.log skip.txt
```

* Checks out (or creates) branch development in all repos under ~/Projects.
* Logs results to checkout_branch_all.log.
* Skips any repos listed in skip.txt.

**Use Cases**

* Consistent Branch Setup Across Many Repos  
Quickly ensure all repos in a mono-repo or multi-repo setup are on the same branch.

* Team Onboarding  
New team members can align their entire workspace with the correct branch in one step.

* Release Preparation  
Switch all repos to a release branch before tagging or deployment.

* Submodule Synchronization  
Keep submodules aligned with the same branch as their parent repository.

* Bulk Migration  
Create a new branch across all repositories without manually switching one by one.
