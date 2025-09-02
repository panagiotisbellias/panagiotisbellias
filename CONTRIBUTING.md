# Contributing to Panagiotis Bellias' GitHub Toolkit & Profile Repo

🎉 First off, thanks for taking the time to contribute!  
This repository contains both my **GitHub profile README** and a **Multi-Repo Git Toolkit** with Bash/PowerShell scripts for managing repositories at scale.  
Contributions are welcome in the form of bug reports, feature requests, code improvements, or documentation updates.  

---

## 🐛 Reporting Issues

- Use the **Issues tab** to report bugs or suggest new features.  
- Include clear steps to reproduce the bug (if applicable).  
- If suggesting a feature, explain the use case and why it would be useful.  

---

## 🛠️ Contribution Workflow

1. **Fork** the repository.  
2. **Clone** your fork locally:  
   ```bash
   git clone https://github.com/<your-username>/panagiotisbellias.git
   cd panagiotisbellias
   ```
3. Create a **new branch** for your changes:  
   ```bash
   git checkout -b feature/my-new-feature
   ```
4. Make your changes and **commit** them with a descriptive message:  
   ```bash
   git add .
   git commit -m "Add: description of change"
   ```
5. Push your branch:  
   ```bash
   git push origin feature/my-new-feature
   ```
6. Open a **Pull Request** against `main` (or the appropriate branch).  

---

## 💻 Guidelines for Toolkit Contributions

When contributing to the **Multi-Repo Git Toolkit**:

- ✔️ Follow **Bash scripting best practices**:
  - Use `#!/bin/bash` or `#!/usr/bin/env bash` at the top.  
  - Use `set -euo pipefail` where appropriate.  
  - Add comments explaining non-obvious logic.  
  - Prefer functions for reusable code.  

- ✔️ Ensure **scripts are executable**:  
  ```bash
  chmod +x script.sh
  ```

- ✔️ Validate inputs and provide helpful usage messages.  

- ✔️ Keep output **readable** with emojis/symbols (consistent with current scripts).  

- ✔️ If adding a new script, provide a **separate README** inside the `toolkit/` folder explaining:
  - Purpose of the script  
  - Usage example  
  - Expected input/output  

---

## 🧪 Testing Contributions

Before submitting a pull request:

- Run your script locally on **Linux / WSL2** and ensure no syntax errors.  
- Test edge cases (empty inputs, invalid repo names, etc.).  
- If relevant, test GitHub CLI (`gh`) commands in a sandbox repo.  

---

## 📜 Documentation

- Keep the **main README** short with references to scripts.  
- Place detailed explanations in **per-script README files**.  
- Update the **Multi-Repo Git Toolkit section** in the main README if you add or remove scripts.  

---

## 🤝 Code of Conduct

Please keep discussions respectful and constructive. This project is meant to help developers manage GitHub repositories efficiently and to showcase my developer journey.  

---

💡 *Pro tip: Contributions to improve automation, error handling, or cross-platform support (Linux/Windows/WSL) are especially welcome!* 🚀
