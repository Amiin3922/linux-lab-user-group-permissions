# Linux Lab: User, Group, and Permissions

This lab demonstrates how to:
- create a user
- create a group named `marketing`
- add a user to that group
- set shared directory permissions
- test read/write access

## Files
- `scripts/linux_lab_permissions.sh` — script that sets up the lab
- `README.md` — usage instructions

## Prerequisites
- Linux system with `sudo` access
- Root privileges required to create users and groups

## Setup

Run the script as root:

```bash
sudo bash scripts/linux_lab_permissions.sh
```

## What the script does

1. Creates a group named `marketing` if it does not already exist
2. Creates a user named `marketing_user` if it does not already exist
3. Adds the user to the `marketing` group
4. Creates a shared directory at `/opt/marketing_shared`
5. Sets group ownership and permissions so members of the group can write
6. Creates a sample file and verifies the user can append to it

## Expected result

The user `marketing_user` should be a member of the `marketing` group and should be able to write to the shared directory and file.

## Example verification commands

```bash
id marketing_user
groups marketing_user
ls -ld /opt/marketing_shared
su - marketing_user -c "echo 'hello from marketing' >> /opt/marketing_shared/notes.txt"
cat /opt/marketing_shared/notes.txt
```

## Permission notes

- `chmod 2775 /opt/marketing_shared` gives group write access and keeps the group ownership on new files
- `chmod 664 /opt/marketing_shared/notes.txt` allows the group to edit the file
