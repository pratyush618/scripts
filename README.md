# Scripts Repository

This repository contains a collection of utility scripts for automating tasks, improving productivity, and simplifying workflows. The scripts are written in Bash, PowerShell, and CMD, with more languages added over time.

## 🚀 Getting Started

### Prerequisites
- **Bash Scripts**: Unix-like OS (Linux, macOS, WSL) or Windows (with Git Bash/Cygwin).
- **PowerShell**: Windows PowerShell 5.1+ or PowerShell Core (cross-platform).
- **CMD**: Windows Command Prompt (for `.bat`/`.cmd` scripts).

### Installation

#### Bash Scripts
1. **Clone the repository**:
   ```bash
   git clone https://github.com/pratyush618/scripts.git
   cd scripts
   ```

2. **Install a script**:
   - Use the automated installer (`install.sh`):
     ```bash
     sudo ./bash/install.sh <script_name> [alias_name] [target_dir]
     ```
   - For manual installation, refer to [INSTALLATION.md](./bash/INSTALLATION.md).

#### PowerShell Scripts
1. **Place scripts** in the `powershell/` directory.
2. **Run scripts**:
   - From PowerShell:
     ```powershell
     .\powershell\<script_name>.ps1
     ```
   - For system-wide access, add the `powershell/` directory to your `PATH`.

#### CMD Scripts
1. **Place scripts** in the `cmd/` directory (for `.bat` or `.cmd` files).
2. **Run scripts**:
   - From Command Prompt:
     ```cmd
     cmd\<script_name>.bat
     ```
   - For system-wide access, add the `cmd/` directory to your `PATH`.

## 📜 Scripts Overview

| Script Name       | Language  | Description                                  | Usage Example                     |
|-------------------|-----------|----------------------------------------------|-----------------------------------|
| `install.sh`      | Bash      | Installs other scripts with aliases.         | `sudo ./install.sh my_script`     |
| (More scripts...) | (Various) | (Descriptions added as scripts are included) | (Examples added later)            |

## 🛠️ Usage
- **Bash**: Run directly or via aliases (e.g., `my_script`).
- **PowerShell**: Execute with `.\<script_name>.ps1` or add to `PATH`.
- **CMD**: Run from Command Prompt or add to `PATH`.

## 📝 Adding New Scripts
1. **Place the script** in the appropriate directory:
   - Bash: `bash/`
   - PowerShell: `powershell/`
   - CMD: `cmd/`
2. **Update documentation**:
   - Add a row to the [Scripts Overview](#-scripts-overview) table.
   - Include usage instructions in the script's header or a separate `README`.

## ❓ Troubleshooting
- **Bash**:
  - `Permission denied`: Use `sudo` or `chmod +x`.
  - `Command not found`: Verify `PATH` or use full path.
- **PowerShell**:
  - Execution policy: Run `Set-ExecutionPolicy RemoteSigned` (admin mode).
- **CMD**:
  - `PATH` issues: Add script directory to `PATH` or use full path.

## 🙌 Contributing
1. Fork the repository.
2. Add scripts to the correct directory (`bash/`, `powershell/`, or `cmd/`).
3. Submit a pull request.
