#!/bin/bash
# Linux Lab: User, Group, and Permissions Demo
# Run as root or with sudo

set -e

USERNAME="marketing_user"
GROUPNAME="marketing"
SHARED_DIR="/opt/marketing_shared"
FILE_TO_TEST="$SHARED_DIR/notes.txt"

echo "[1/6] Ensuring group exists..."
if ! getent group "$GROUPNAME" >/dev/null; then
    groupadd "$GROUPNAME"
    echo "Created group: $GROUPNAME"
else
    echo "Group already exists: $GROUPNAME"
fi

echo "[2/6] Ensuring user exists..."
if ! id "$USERNAME" >/dev/null 2>&1; then
    useradd -m -s /bin/bash -G "$GROUPNAME" "$USERNAME"
    echo "Created user: $USERNAME"
else
    echo "User already exists: $USERNAME"
fi

echo "[3/6] Creating shared directory..."
mkdir -p "$SHARED_DIR"
chown root:"$GROUPNAME" "$SHARED_DIR"
chmod 2775 "$SHARED_DIR"
ls -ld "$SHARED_DIR"

echo "[4/6] Creating sample file..."
echo "Marketing team shared notes" > "$FILE_TO_TEST"
chown root:"$GROUPNAME" "$FILE_TO_TEST"
chmod 664 "$FILE_TO_TEST"
ls -l "$FILE_TO_TEST"

echo "[5/6] Testing permissions as the created user..."
# Switch to user and attempt write to shared file
su - "$USERNAME" -c "echo 'New content from $USERNAME' >> '$FILE_TO_TEST'; ls -l '$FILE_TO_TEST'; cat '$FILE_TO_TEST'" 

echo "[6/6] Summary"
id "$USERNAME"
getent group "$GROUPNAME"
ls -ld "$SHARED_DIR"
ls -l "$FILE_TO_TEST"

echo "Lab complete."
