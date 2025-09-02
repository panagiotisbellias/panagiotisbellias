# Multi-Repo Git Toolkit

A collection of Bash scripts to manage, audit, and synchronize multiple Git repositories and submodules efficiently. Each script is self-contained, with a detailed README for usage and examples. This central README provides **quick references**, **use cases**, and guidance on which script to use for different tasks.

---

## Prerequisite

You’ll need GitHub CLI installed and authenticated (gh auth login).
https://cli.github.com/

## 👁 Scripts Included

| Script                              | Purpose                                                                     | README Reference                                     |
|-------------------------------------|-----------------------------------------------------------------------------|------------------------------------------------------|
| `check_branch_base.sh`              | Check if a branch in all repositories is based on `main` or `master`        | [README.md](check-branch-base/README.md)             |
| `checkout_branch.sh`                | Checkout or create a branch in multiple repositories (including submodules) | [README.md](checkout-branch-all/README.md)           |
| `create_multiple_repos.sh`          | Create multiple GitHub repositories from a list                             | [README.md](create-multiple-repos/README.md)         |
| `git_status_all.sh`                 | Collect `git status` from all repositories and submodules                   | [README.md](git-status-all/README.md)                |
| `mirror_repo.sh`                    | Mirror a repository to your GitHub account, optionally creating a branch    | [README.md](mirror-repo/README.md)                   |
| `update_license_all.sh`             | Add or update Apache 2.0 LICENSE in multiple repositories and submodules    | [README.md](update-license-all/README.md)            |
| `update_submodules_hierarchical.sh` | Clone parent repos, add/update hierarchical submodules, manage branches     | [README.md](update-submodules-hierarhical\README.md) |
|`rename_single_repo_steps.md`|Rename repositories to kebab-case|[README.md](rename-single-repo-steps\README.md)|

---

## ⚡ Common Use Cases and Scripts

### 1. **Repository Health & Status**

* **Use case:** Audit repos to see if branches are up-to-date, detect uncommitted changes, or check branch ancestry.
* **Scripts:**

  * `git_status_all.sh` → detect dirty repos
  * `check_branch_base.sh` → verify branch is based on main/master

---

### 2. **Branch Management**

* **Use case:** Checkout or create branches across multiple repositories consistently.
* **Scripts:**

  * `checkout_branch.sh` → checkout or create a branch in multiple repos and submodules
  * `check_branch_base.sh` → verify branch ancestry before further operations

---

### 3. **Repository Creation & Initialization**

* **Use case:** Bulk creation of new repositories on GitHub.
* **Scripts:**

  * `create_multiple_repos.sh` → create multiple private repos from a list

---

### 4. **Repository Mirroring / Migration**

* **Use case:** Mirror an upstream repository to your GitHub account, including branches and refs.
* **Scripts:**

  * `mirror_repo.sh` → clone, set remote, push all refs, checkout optional branch

---

### 5. **License Management**

* **Use case:** Standardize licensing across multiple repositories and submodules.
* **Scripts:**

  * `update_license_all.sh` → add/update Apache 2.0 LICENSE, commit, and push changes

---

### 6. **Submodule Management / Hierarchical Projects**

* **Use case:** Automate hierarchical repository setups with submodules, branches, and commits.
* **Scripts:**

  * `update_submodules_hierarchical.sh` → clone parent repos, add/update submodules, manage branches

---

### 7. **Automation Pipelines**

* **Use case:** Integrate repo management tasks into CI/CD pipelines.
* **Scripts:**

  * `git_status_all.sh` → pre-build checks for dirty repos
  * `checkout_branch.sh` → ensure branches exist before deployment
  * `update_license_all.sh` → enforce license compliance

---

### 8. **Team Collaboration / Repo Governance**

* **Use case:** Standardize multiple repositories and submodules across a team or organization.
* **Scripts:**

  * All scripts are applicable depending on the operation: status, branch, license, submodule hierarchy, or mirroring.

---

### 📚 Notes

* All scripts log their output; some support an optional output file.
* Scripts operate recursively for submodules where applicable.
* Scripts are designed to be **idempotent** where possible, so re-running them is generally safe.
* Each script has its own detailed README with examples, logging, and error handling instructions.

---

This central README acts as a **quick reference guide** for your multi-repo workflow, while the detailed READMEs maintain all the in-depth documentation for each script.
