# RAM Usage Guard

`ram_usage_guard.sh` is a Bash script designed to monitor the RAM usage of a specified process and automatically terminate it if the usage exceeds a predefined limit. This script helps in ensuring efficient resource management and preventing potential system overloads caused by runaway processes.

## Features

- Monitor the RAM usage of a specific process by PID.
- Automatically kill the process if its RAM usage exceeds the specified limit.
- Check storage space left on the root filesystem.
- Easy-to-use command-line interface.

## Requirements

- Linux operating system
- Bash shell

## Usage

1. **Download the script:**
   
   Download the `ram_usage_guard.sh` script to your local machine.

2. **Make the script executable:**
   
   ```bash
   chmod +x ram_usage_guard.sh
   ```
2. **Run the scrip:**
   ```bash
   ./ram_usage_guard.sh -p <PID> -m <MAX_RAM_USAGE>
   ```
- Replace <PID> with the PID of the process you want to monitor.
- Replace <MAX_RAM_USAGE> with the maximum allowed RAM usage percentage.

