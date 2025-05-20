---

## 🚀 Getting Started

### Prerequisites
- A Unix-like operating system (Linux, macOS, etc.).
- Basic familiarity with the terminal and shell commands.

### Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/pratyush618/scripts.git
   cd scripts
   ```

2. **Install a script**:
   - Use the automated installer (`install.sh`) for Bash scripts:
     ```bash
     sudo ./bash/install.sh <script_name> [alias_name] [target_dir]
     ```
     Example:
     ```bash
     sudo ./bash/install.sh my_script my_alias
     ```
   - For manual installation, refer to the [INSTALLATION.md](./bash/INSTALLATION.md) guide.

---

## 📜 Scripts Overview

| Script Name       | Description                                  | Usage Example                     |
|-------------------|----------------------------------------------|-----------------------------------|
| `install.sh`      | Installs other scripts with aliases.         | `sudo ./install.sh my_script`     |
| (More scripts...) | (Descriptions added as scripts are included) | (Examples added later)            |

---

## 🛠️ Usage
- After installation, run scripts directly or via their aliases (if configured).
- For detailed usage instructions, refer to the script's header or comments.

---

## 📝 Adding New Scripts
1. **Place the script** in the appropriate directory (e.g., `bash/` for Bash scripts).
2. **Update documentation**:
   - Add a row to the [Scripts Overview](#-scripts-overview) table in this file.
   - Include usage instructions in the script's header or a separate `README` if needed.

---

## ❓ Troubleshooting
- **Permission denied**: Run scripts with `sudo` or ensure they have execute permissions (`chmod +x`).
- **Command not found**: Verify the script is in your `PATH` or use the full path to run it.


---

## 🙌 Contributing
Contributions are welcome! If you have a useful script, feel free to:
1. Fork the repository.
2. Add your script to the appropriate directory.
3. Submit a pull request.

---

## 📬 Contact
For questions or suggestions, open an issue or contact [your-email@example.com](mailto:your-email@example.com).
