Backup Script Documentation
===========================

Overview
--------

This PowerShell script is designed to automate the process of backing up files and directories from a source directory to an external storage device. It includes features such as progress bars, file comparison, and ledger management to track changes across backups. The script also provides an option to safely eject the storage device after the backup process is complete.

* * * * *

Features
--------

1.  **Interactive Device Selection**:

    -   Scans for connected external storage devices (e.g., USB drives).
    -   Allows the user to select a target device interactively.
2.  **Data Structure Creation**:

    -   Analyzes both the source and target directories.
    -   Creates data structures containing file metadata (e.g., file name, path, last modified date).
3.  **File Synchronization**:

    -   Compares files between the source and target directories.
    -   Copies new or modified files to the target while maintaining the directory structure.
    -   Deletes files from the target if they no longer exist in the source.
4.  **Ledger Management**:

    -   Logs details of each backup, including:
        -   Number of files changed, created, and deleted.
        -   Total size of data copied.
    -   Stores logs in a ledger file.
5.  **Progress Bars**:

    -   Provides real-time progress feedback during analysis and file copying.
6.  **Eject Option**:

    -   Offers the option to safely eject the external storage device after the backup.

* * * * *

Requirements
------------

-   **PowerShell Version**: PowerShell 5.1 or later.
-   **Permissions**: Administrator privileges may be required to access external storage devices.

* * * * *

Script Workflow
---------------

### 1\. Define Source and Ledger Paths

-   **Source Directory**: The directory containing files to be backed up.

    ```
    $SourceDir = "C:\Users\Pratyush\Documents\Personal"
    ```

-   **Ledger File**: The file used to log backup details.

    ```
    $LedgerFile = "C:\Users\Pratyush\Desktop\BackupLedger.txt"
    ```

### 2\. Detect External Storage Devices

-   The script scans for external devices using the `Get-Volume` cmdlet.
-   Example output:

    ```
    D: - USB Drive
    E: - Backup Drive
    ```

### 3\. Analyze Source and Target Directories

-   The `New-DataStructure` function creates a data structure with metadata for all files in a directory.
-   Real-time progress is displayed for the analysis.

### 4\. File Synchronization

-   Files in the source directory are compared with those in the target directory.
-   The script:
    -   Copies new or updated files to the target.
    -   Deletes files from the target that no longer exist in the source.

### 5\. Ledger Management

-   Logs the following details in the ledger file:
    -   Date and time of the backup.
    -   Number of files changed, created, and deleted.
    -   Total size of data copied.
-   Example ledger entry:

    ```
    Backup Report
    ===============
    Date and Time: 01/18/2025 02:30:45 PM
    Files Changed: 5
    Files Created: 10
    Files Deleted: 2
    Size Copied: 200.5 MB
    ---------------
    ```

* * * * *

Functions
---------

### 1\. `Get-ExternalStorage`

-   **Purpose**: Lists all connected external storage devices.
-   **Output**: Drive letter and file system label.

### 2\. `New-DataStructure`

-   **Purpose**: Creates a structured representation of files in a directory.
-   **Output**: A list of objects with the following properties:
    -   `Name`: File name.
    -   `Path`: Full path of the file.
    -   `LastModified`: Last modified date.

### 3\. `Write-Ledger`

-   **Purpose**: Logs backup details to a ledger file.
-   **Parameters**:
    -   `FilesChanged`: Number of files updated.
    -   `FilesCreated`: Number of files added.
    -   `FilesDeleted`: Number of files removed.
    -   `SizeCopied`: Total size of data copied.

* * * * *

Example Usage
-------------

1.  **Run the Script**:

    ```
    .\BackupScript.ps1
    ```

2.  **Follow the Prompts**:

    -   Select a drive for the target directory.
    -   View progress during analysis and file synchronization.
    -   Confirm whether to eject the storage device.
3.  **Check the Ledger**:

    -   Open the ledger file to view details of the backup.

* * * * *

Error Handling
--------------

-   **No Devices Found**:
    -   If no external devices are detected, the script exits with a message.
-   **File Not Found**:
    -   Skips files that cannot be located and logs a warning.
-   **Ejection Failure**:
    -   If the device cannot be ejected, the script prompts the user to eject it manually.

* * * * *

Notes
-----

-   Ensure the target device has sufficient storage space for the backup.
-   Run the script with appropriate permissions to access all files and devices.
-   Modify the `$SourceDir` and `$LedgerFile` paths as needed for your environment.

* * * * *

Future Improvements
-------------------

-   Add support for network drives as targets.
-   Implement logging to track script execution steps.
-   Add email notifications upon backup completion.