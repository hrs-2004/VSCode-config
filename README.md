# Apply VSCode Global Settings

This script applies global VSCode settings on **macOS/Linux** and **Windows** systems by downloading the necessary config files directly into a local `.vscode` folder — no `git`, no platform-specific logic.

---

## 🛠 Local Install (All Platforms)

Run the following commands in any terminal (macOS, Linux, or Windows CMD/PowerShell):

```bash
# Create the .vscode folder locally
# Create .vscode directory if it doesn't exist
mkdir -p .vscode

# Download settings.json into the .vscode directory
curl -L -o .vscode/settings.json https://raw.githubusercontent.com/hrs-2004/VSCode-config/main/.vscode/settings.json

# Download keybindings.json into the .vscode directory
curl -L -o .vscode/keybindings.json https://raw.githubusercontent.com/hrs-2004/VSCode-config/main/.vscode/keybindings.json

# Download extensions.txt file
curl -L -o extensions.txt https://raw.githubusercontent.com/hrs-2004/VSCode-config/main/extensions.txt

# Install the extensions (Uncomment the lines below to enable this part)
# cat extensions.txt | xargs -n 1 code --install-extension

echo "VSCode settings applied successfully!"
```

# Apply VSCode Global Settings

This script applies global VSCode settings on **macOS/Linux** and **Windows** systems by detecting the platform and copying the appropriate settings.

---
This section detects whether your system is **macOS** or **Linux** and sets the appropriate path for VSCode settings.

```bash
#!/bin/bash

# Detect system and set the VSCode settings directory path
if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_DIR="$HOME/Library/Application Support/Code/User"  # macOS
else
    VSCODE_DIR="$HOME/.config/Code/User"  # Linux
fi

# Exit if VSCode settings directory is not found
if [ ! -d "$VSCODE_DIR" ]; then
    echo "VSCode settings directory not found! Exiting."
    exit 1
fi

# Clone the repository with the VSCode settings
git clone https://github.com/hrs-2004/VSCode-config.git

# Copy the settings to the VSCode settings directory
cp -r VSCode-config/.vscode/* "$VSCODE_DIR"

# Clean up by removing the cloned repository
rm -rf VSCode-config

echo "VSCode settings have been applied successfully."

```
This section sets the path for **VSCode settings** in **Windows** using Command Prompt (CMD).

```bash# Windows (Command Prompt) Script

:: Set the VSCode settings directory for Windows (Command Prompt)
set VSCODE_DIR=C:\Users\%USERNAME%\AppData\Roaming\Code\User

:: Exit if VSCode settings directory is not found
if not exist "%VSCODE_DIR%" exit /b 1

:: Clone the repository and copy the settings to the VSCode directory
git clone https://github.com/hrs-2004/VSCode-config.git
xcopy /E /I VSCode-config\.vscode\* "%VSCODE_DIR%"
rmdir /S /Q VSCode-config

