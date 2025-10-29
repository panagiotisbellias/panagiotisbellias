# Gita Proof of Concept

This directory demonstrates how to use **[Gita](https://github.com/nosarthur/gita)** to manage multiple Git repositories from a single command line.

---

## Setup

1. Clone the repo:
   ```bash
   git clone <repo-url>
   cd gita-poc
   ```

2. Create a virtual environment:
   ```bash
   python3 -m venv gita-venv
   source gita-venv/bin/activate
   ```

3. Upgrade pip and install dependencies:
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   ```

---

## Example Repositories

You can create some dummy repositories for testing:

   ```bash
   mkdir repos
   cd repos
   git init repo-alpha
   git init repo-beta
   git init repo-gamma

   ```

Optionally, add an initial commit to each:

   ```bash
   for d in repo-*; do
     cd $d
     echo "# $d" > README.md
     git add README.md
     git commit -m "Initial commit in $d"
     cd ..
   done
   ```

---

## Gita Usage Examples

Add repositories to Gita:
`gita add repos/repo-alpha repos/repo-beta repos/repo-gamma`

List all repositories:
`gita ls`

Check status of all repos:
`gita ll`

Fetch latest commits:
`gita fetch`

Run any git command across all repos:
`gita super git log -1`

Group repositories:
   ```bash
   gita group new demo repos/repo-alpha repos/repo-beta
   gita group ll
   ```

---

## Notes
- Gita configurations are stored in `~/.config/gita/`.
- You can run `gita open` to open repositories in your editor.
- Use `gita rename` or `gita rm` to rename/remove repos from Gita’s tracking.

---

## Cleanup

To reset your setup:
`rm -rf repos ~/.config/gita gita-venv`
