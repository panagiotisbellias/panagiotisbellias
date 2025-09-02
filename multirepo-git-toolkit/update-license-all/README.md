# update_license_all.sh

## Detailed Explanation

This [script](update_license_all.sh) automates the process of updating or adding the Apache 2.0 LICENSE to all Git repositories under a given directory, including submodules. It commits and pushes changes to a specified branch.

## Usage

```bash
./update_license_all.sh [PARENT_DIR]
```

**Arguments**

* PARENT_DIR (optional, default: current directory)
    * The root directory where repositories are located. If omitted, the script scans the current working directory.

**Operations**

* Configuration
    * USER → GitHub username for repository access.
    * BRANCH → branch where LICENSE should be updated (e.g., development or main).
    * LICENSE_TEXT → the content of the Apache 2.0 License, automatically inserting the current year and user.
* Repository License Update
    For each repository:
    * Verifies that .git exists.
    * Writes the LICENSE file with the defined Apache 2.0 text.
    * Checks out the target branch; creates it if missing.
    * If LICENSE has changes:
        * Adds and commits the LICENSE.
        * Sets GitHub default repo (via gh) and pushes the branch.
    * Logs success or notes if no changes were needed.
* Submodule Handling
    * Recursively initializes and updates submodules.
    * Calls the license update function for each submodule.
* Directory Traversal
    * Recursively finds all Git repositories under the specified directory.
    * Updates LICENSE in each repository and its submodules.

**Example**

```bash
./update_license_all.sh ~/Projects
```

Output snippet:
```log
📦 Updating LICENSE in ~/Projects/project-a
✅ LICENSE updated and pushed in ~/Projects/project-a

📦 Updating LICENSE in ~/Projects/project-b
⚠️ No changes in LICENSE for ~/Projects/project-b
🔍 Updating submodules for ~/Projects/project-b
➡️ Entering submodule1
✅ LICENSE updated and pushed in ~/Projects/project-b/submodule1
```

**Use Cases**
* Standardizing License Across Repos  
Quickly add or update the Apache 2.0 LICENSE for all projects under a directory.

* Open Source Compliance  
Ensure all repositories comply with licensing requirements.

* Team Repository Governance  
Automatically enforce license updates across multiple repositories in a team or organization.

* Mono-Repo / Multi-Repo Projects  
Update LICENSE files in all repositories and submodules recursively.

* Automated License Updates  
Integrate into CI/CD pipelines to refresh or enforce license information in all repositories.
