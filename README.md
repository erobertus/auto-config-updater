# Update Config Script

This project contains a shell script, `update_config.sh`, that automates the modification of configuration files based on specified dates. The script updates a configuration variable within a specified file and executes a command if the value has changed.

## Features

- Modify any configuration file by specifying the file path, variable name, and values.
- Apply changes only within a specific date range.
- Execute a command (e.g., `csf -ra`) if the configuration variable's value has been changed.
- Error handling to ensure the configuration file exists before making changes.

## Prerequisites

- A Unix-like operating system (e.g., Ubuntu).
- Bash shell (typically available by default).
- Permissions to read and write the configuration file and execute the specified command.

## Installation

To install the script, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/erobertus/auto-config-updater.git
   cd auto-config-updater
   ```

2. **Edit `install.sh` and `uninstall.sh` if Cron Job setup is required:**

   - Open `install.sh` and locate the cron job section:

     ```bash
     # echo "Setting up a sample cron job to run the script daily at midnight..."
     # (sudo crontab -l ; echo "0 0 * * * /usr/local/bin/update_config.sh /etc/csf/csf.conf CC_ALLOW_FILTER 'CA,IT' 'CA' '2024-09-18' '2024-10-07' 'csf -ra'") | sudo crontab -
     ```

   - Edit the cron job line with your actual parameters and uncomment it if you want to automatically set up the cron job during installation:

     ```bash
     echo "Setting up a sample cron job to run the script daily at midnight..."
     (sudo crontab -l ; echo "0 0 * * * /usr/local/bin/update_config.sh /etc/csf/csf.conf CC_ALLOW_FILTER 'CA,IT' 'CA' '2024-09-18' '2024-10-07' 'csf -ra'") | sudo crontab -
     ```

   - Similarly, open `uninstall.sh` and locate the cron job removal section:

     ```bash
     # echo "Removing sample cron job..."
     # sudo crontab -l | grep -v "/usr/local/bin/update_config.sh" | sudo crontab -
     ```

   - Uncomment the lines if you want to automatically remove the cron job during uninstallation:

     ```bash
     echo "Removing sample cron job..."
     sudo crontab -l | grep -v "/usr/local/bin/update_config.sh" | sudo crontab -
     ```

3. **Run the install script:**

   The `install.sh` script will copy `update_config.sh` to `/usr/local/bin` and set the correct permissions.

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

   After installation, you can run `update_config.sh` from anywhere on your system.

## Usage

### Script Parameters

The script accepts the following parameters:

1. **config_file**: The path to the configuration file you want to modify (e.g., `/etc/csf/csf.conf`).
2. **config_variable**: The name of the configuration variable to change (e.g., `CC_ALLOW_FILTER`).
3. **start_value**: The value to assign when the current date is within the start and end dates (e.g., `CA,IT`).
4. **end_value**: The value to assign when the current date is outside the start and end dates (e.g., `CA`).
5. **start_date**: The date when the start value should be used (inclusive).
6. **end_date**: The date after which the end value should be used (exclusive).
7. **command**: The command to execute if the configuration value changes (e.g., `csf -ra`).

### Example

Run the script with the necessary parameters:

```bash
update_config.sh /etc/csf/csf.conf CC_ALLOW_FILTER 'CA,IT' 'CA' '2024-09-18' '2024-10-07' 'csf -ra'
```

### Automate with Cron

To automate the script execution, set up a cron job. For example, to run the script daily at midnight:

1. Open the cron job editor:

   ```bash
   sudo crontab -e
   ```

2. Add the following line:

   ```bash
   0 0 * * * /usr/local/bin/update_config.sh /etc/csf/csf.conf CC_ALLOW_FILTER 'CA,IT' 'CA' '2024-09-18' '2024-10-07' 'csf -ra'
   ```

## Uninstallation

To uninstall the script, run the `uninstall.sh` script:

1. **Run the uninstall script:**

   The `uninstall.sh` script will remove `update_config.sh` from `/usr/local/bin`.

   ```bash
   chmod +x uninstall.sh
   ./uninstall.sh
   ```

   This will remove the script from your system, and you will no longer be able to run `update_config.sh` from the command line.

## Error Handling

- The script will check if the specified configuration file exists. If the file is not found, it will display an error message and stop execution.
- The command specified as the seventh parameter will only be executed if the configuration variable's value has been changed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.

## Contact

For any questions or issues, please contact Eugene Robertus at [erobertus@indexdynamic.com](mailto:erobertus@indexdynamic.com).
