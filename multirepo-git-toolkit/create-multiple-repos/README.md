# create_multiple_repos.sh

## Detailed Explanation

This [script](create_multiple_repos.sh) automates the creation of multiple GitHub repositories in one go. It reads from a configuration file containing repository names and descriptions, checks if each repository already exists, and creates it if missing.

## Usage

```bash
./create_multiple_repos.sh supermodule_repos.txt
```

**Arguments**

supermodule_repos.txt (required)
A text file where each line defines a repository in the format:

```txt
repo-name|Description of the repository
```

**Operations**

* Input Validation
    * Ensures a repos file is provided; otherwise, exits with usage instructions.
* File Parsing
    * Reads each line from the provided file.
    * Splits the line into:
        * repo → repository name (mandatory).
        * desc → repository description (optional).
    * Skips:
        * Empty lines.
        * Commented lines (starting with #).
* Repository Handling
    * For each repository:
        * Checks if it already exists on GitHub (gh repo view).
            * If it exists → ⚠️ logs a warning and skips creation.
            * If it does not exist → ✅ creates a new private repository with the provided description.
                * Cleans the description by stripping control characters and trimming spaces.

**Example**

### Input file: supermodule_repos.txt

```txt
# Core system repositories
core-service|Core backend microservice
frontend-ui|Frontend React application
devops-scripts|CI/CD automation scripts

# Experimental repos
ml-experiments|Machine learning research and experiments
```

### Command

```bash
./create_multiple_repos.sh supermodule_repos.txt
```

### Output (example)
```log
Processing repository: core-service
✅ Creating private repository: core-service

Processing repository: frontend-ui
⚠️ Repository 'frontend-ui' already exists, skipping...

Processing repository: devops-scripts
✅ Creating private repository: devops-scripts
```

**Use Cases**

* Bootstrapping New Projects  
Quickly spin up multiple repositories for a new product or system.

* Class/Workshop Setup  
Teachers or trainers can create repositories for multiple students or groups.

* Organization Migration  
Re-create repositories in bulk when moving to a new GitHub organization.

* Supermodule Setup  
Set up a suite of repos defined in a “supermodule” or umbrella project file.

* DevOps Automation  
Integrate with scripts or pipelines to provision repositories as part of infrastructure setup.
