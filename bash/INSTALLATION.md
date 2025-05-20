# Bash Script Installation Guide

This guide provides generic instructions for installing and setting up any bash script on Unix-like systems (Linux, macOS, etc.). Follow these steps to make your script executable and easily accessible from the command line.

---

## Prerequisites
- A Unix-like operating system (Linux, macOS, etc.).
- Basic familiarity with the terminal and shell configuration files (e.g., `.bashrc`, `.zshrc`).

---

## Installation Steps

### 1. Save the Script
Save your bash script to a directory included in your system's `PATH`. Common locations include `/usr/local/bin` or `~/bin`. For example:

```bash
sudo nano /usr/local/bin/your_script_name
```

Paste your script's content into the editor and save the file.

### 2. Make the Script Executable
Run the following command to grant execute permissions to the script:

```bash
sudo chmod +x /usr/local/bin/your_script_name
```

### 3. Create an Alias (Optional)
To make the script easier to invoke, add an alias to your shell configuration file. For example:

- For `zsh` (default on newer macOS versions):
  ```bash
  echo "alias shortcut='your_script_name'" >> ~/.zshrc
  ```

- For `bash`:
  ```bash
  echo "alias shortcut='your_script_name'" >> ~/.bash_profile
  ```

Replace `shortcut` with your preferred command name.

### 4. Reload the Shell Configuration
Apply the changes by reloading your shell configuration:

- For `zsh`:
  ```bash
  source ~/.zshrc
  ```

- For `bash`:
  ```bash
  source ~/.bash_profile
  ```

---

## Usage
After installation, you can run the script directly by typing its name (or the alias you created) in the terminal. For example:

```bash
your_script_name [arguments]
```

Or, if you created an alias:
```bash
shortcut [arguments]
```

---

## Customization
- **Script Location**: If you prefer not to use `/usr/local/bin`, you can save the script to another directory in your `PATH` or add a custom directory to your `PATH`.
- **Permissions**: Ensure the script has the correct permissions (`chmod +x`) to be executed.
- **Alias**: The alias step is optional but recommended for frequently used scripts.

---

## Troubleshooting
- **Command Not Found**: If the script isn't found, verify that the directory containing it is in your `PATH`. You can check your `PATH` with:
  ```bash
  echo $PATH
  ```
- **Permission Denied**: Ensure the script has execute permissions (`chmod +x`).

---

## Example
For a script named `move_n` (as in the original example), the installation would follow the same steps, with `your_script_name` replaced by `move_n`.

---

## Notes
- Always review scripts from untrusted sources before installing them.
- For system-wide scripts, use `/usr/local/bin`. For user-specific scripts, `~/bin` is a good alternative (ensure it's in your `PATH`).

## Automated Installation Using `install.sh`

For convenience, you can use the `install.sh` script to automate the installation of any bash script. This script handles copying the script to `/usr/local/bin`, setting permissions, and optionally creating an alias.

### Steps:
1. **Download or create the `install.sh` script** (see below for the script content).
2. **Run the installer** (requires `sudo`):
   ```bash
   sudo ./install.sh <script_name> [alias_name] [target_dir]
   ```
   - `<script_name>`: The name of the script to install (must be in the current directory).
   - `[alias_name]` (optional): The alias to create for the script (defaults to the script name).
   - `[target_dir]` (optional): The target directory for installation (defaults to `/usr/local/bin`).

   Example:
   ```bash
   sudo ./install.sh my_script my_alias
   ```

3. **Reload your shell configuration** (if an alias was created):
   ```bash
   source ~/.bashrc  # or source ~/.zshrc
   ```

### Notes:
- The `install.sh` script must be run with `sudo` to copy files to system directories.
- Ensure the script you want to install is in the same directory as `install.sh`.

### Troubleshooting:
- **Permission Issues**: Run the installer with `sudo`.
- **Script Not Found**: Verify the script exists in the current directory.
- **Alias Not Working**: Reload your shell configuration or restart the terminal.

---

### Example Workflow:
1. Save your script (e.g., `my_script`) and `install.sh` in the same directory.
2. Run:
   ```bash
   sudo ./install.sh my_script my_alias
   ```
3. Use the script:
   ```bash
   my_alias  # or my_script
   ```
