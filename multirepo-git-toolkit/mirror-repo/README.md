# mirror_repo.sh

## Detailed Explanation

This [script](mirror_repo.sh) automates the process of mirroring a Git repository from a source URL to your GitHub account. It handles cloning, remote setup, branch creation/checkouts, and pushes all references. It also logs every operation to a file.

## Usage

```bash
./mirror_repo.sh SOURCE_URL [TARGET_REPO] [CHECKOUT_BRANCH] [OUTPUT_FILE]
```

**Arguments**

* SOURCE_URL (required)
    * The Git repository URL you want to mirror (e.g., https://github.com/user/library.git).
* TARGET_REPO (optional)
    * Name for the mirrored repository on your GitHub account. Defaults to the source repo name.
* CHECKOUT_BRANCH (optional)
    * Branch to check out after mirroring. If it doesn’t exist, it will be created from main, master, or the first commit.
* OUTPUT_FILE (optional, default: mirror.log)
    * File where all log output will be written.

**Operations**

* Initialization & Logging
    * Clears or creates the log file.
    * Defines a helper function log() for printing messages to both console and log file.
    * Determines target repository name and GitHub username.
    * Prints repository info, local directory, and timestamp.
* Repository Cloning
    * Clones the source repository as a mirror if it doesn’t exist locally.
    * If the repo exists locally, fetches all latest refs.
* GitHub Repository Creation
    * Checks if the target repo exists on GitHub.
        * If not → creates a new public repository.
        * If yes → logs that the repo already exists.
* Remote Configuration
    * Sets the origin remote to your GitHub repository URL (git@github.com:<user>/<repo>.git).
    * Pushes all refs using git push --mirror.
* Branch Handling (Optional)
    * If CHECKOUT_BRANCH is provided:
        * If the branch exists locally → checks it out.
        * If the branch exists remotely → checks it out tracking the remote.
        * If the branch does not exist → creates it from:
            * origin/main if it exists, otherwise
            * origin/master, otherwise
            * First commit in the repository.
    * Pushes the new branch to the GitHub mirror.
* Completion Logging
    * Logs successful mirroring.
    * Logs branch checkout if specified.

**Example**

```bash
./mirror_repo.sh https://github.com/someuser/somelib.git myforkedlib development mirror.log
```

```log
==============================================
🔍 Source: https://github.com/someuser/somelib.git
🎯 Target: myusername/myforkedlib
📂 Local : myforkedlib
📝 Log   : mirror.log
📅 Time  : 2025-09-02
----------------------------------------------
⬇️ Cloning https://github.com/someuser/somelib.git ...
🚀 Pushing repo to myusername/myforkedlib ...
🔎 Preparing to checkout branch 'development'...
   ✅ Branch 'development' exists locally, checking out...
✅ Repo successfully mirrored to https://github.com/myusername/myforkedlib
✅ Checked out branch: development
```

**Use Cases**

* Fork Mirroring  
Keep a mirror of upstream repositories in your own GitHub account for development or backup.

* Branch Management  
Automatically create or check out branches after mirroring.

* Project Migration  
Move repositories from one GitHub account to another without losing commit history.

* Backup Repositories  
Maintain local mirrors of remote repositories for safety or archival purposes.

* Automation Pipelines  
Integrate into CI/CD scripts to clone, mirror, and prepare repos for deployment or testing.
