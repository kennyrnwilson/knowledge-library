# Claude Code: Quick Start for Python Project Setup

**TL;DR - Get Claude Code instructions working in 3 minutes**

> **Based on:** [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md) in the AI Engineering Roadmap

---

## What This Enables

Once installed, you can ask Claude Code:

```
Create a new Python project called "my-project" at ~/projects
```

Claude Code will automatically:
- ✅ Create project directories (src/, tests/, docs/)
- ✅ Initialize git repository
- ✅ Create virtual environment
- ✅ Generate pyproject.toml
- ✅ Generate .vscode/settings.json (configured for your OS)
- ✅ Generate .vscode/launch.json
- ✅ Install pytest, ruff, and development tools
- ✅ Create initial test file
- ✅ Verify everything works

**Zero manual setup required.**

---

## Installation (Choose Your OS)

Claude Code uses a special `CLAUDE.md` file to load custom instructions. Place Python setup instructions in the global `~/.claude/` directory to apply across all your projects.

### Windows

1. Open PowerShell (as administrator recommended)

2. Create the directory:
   ```powershell
   mkdir -Path "$env:USERPROFILE\.claude" -Force
   ```

3. Create `CLAUDE.md` file in that directory:
   ```powershell
   Copy-Item "path\to\knowledge-library\04-guidance\professional\programming-language\python\claude-code-setup\02-instructions.md" `
     -Destination "$env:USERPROFILE\.claude\CLAUDE.md"
   ```
   Or manually copy the content of `02-instructions.md` into `C:\Users\YourName\.claude\CLAUDE.md`

4. Restart Claude Code

**Done!** Claude Code now knows how to set up Python projects.

### macOS or Linux

1. Open Terminal and run:
   ```bash
   mkdir -p ~/.claude
   ```

2. Copy the file:
   ```bash
   cp ~/path/to/knowledge-library/04-guidance/professional/programming-language/python/claude-code-setup/02-instructions.md \
      ~/.claude/CLAUDE.md
   ```

3. Restart Claude Code

**Done!** Claude Code now knows how to set up Python projects.

### WSL (Windows Subsystem for Linux)

1. Open WSL terminal and run:
   ```bash
   mkdir -p ~/.claude
   ```

2. Copy the file (adjust path if knowledge library is on Windows):
   ```bash
   cp /mnt/c/Users/YourName/projects/knowledge-library/04-guidance/professional/programming-language/python/claude-code-setup/02-instructions.md \
      ~/.claude/CLAUDE.md
   ```

3. Restart Claude Code

**Done!** Claude Code now knows how to set up Python projects.

---

## Testing It Works

1. Ask Claude Code:
   ```
   Create a new Python project called "test-project" at [your-path]
   I'm on [Windows/macOS/Linux/WSL]
   ```

2. Wait for Claude Code to complete

3. Check the folder was created with all files:
   ```
   test-project/
   ├── venv/
   ├── .vscode/
   ├── src/
   ├── tests/
   ├── pyproject.toml
   └── README.md
   ```

4. Open in VS Code:
   ```bash
   code test-project
   ```

5. Check status bar shows: `Python 3.11+ ('./venv': venv)`

**If all checks pass, you're good to go!**

---

## Files in This Guide

1. **`01-quick-start.md`** (this file)
   - Quick reference guide
   - Installation steps for all OSes
   - Quick testing checklist

2. **`02-instructions.md`**
   - The actual instructions Claude Code uses
   - Copy this to your instructions folder
   - Contains complete setup process and templates

3. **`03-detailed-setup-guide.md`**
   - Detailed installation guide for each OS
   - Troubleshooting tips
   - FAQ and keeping instructions updated

---

## Common Requests to Claude Code

Once installed, try these requests:

### Request 1: New Project
```
Create a new Python project called "calculator" at ~/projects
```

### Request 2: Specific Dependencies
```
Create a new Python project called "data-processor" that uses numpy and pandas.
I'm on Windows.
```

### Request 3: Add Setup to Existing Project
```
I have a Python project at ./my-existing-project
but it doesn't have venv, pyproject.toml, or VS Code configuration.
Set it up following best practices.
```

### Request 4: Configure VS Code Only
```
My Python project already has a venv at ./venv
Just set up the VS Code configuration files (.vscode/settings.json and launch.json)
I'm on macOS.
```

---

## File Locations

After installation, the CLAUDE.md file is located at:

| OS | Location |
|----|----------|
| **Windows** | `C:\Users\YourName\.claude\CLAUDE.md` |
| **macOS** | `~/.claude/CLAUDE.md` |
| **Linux** | `~/.claude/CLAUDE.md` |
| **WSL** | `~/.claude/CLAUDE.md` |

**Note:** This is the official Claude Code configuration directory as documented by Anthropic.

---

## What Gets Created

### Project Structure
```
my-project/
├── .git/                          # Git repository
├── .gitignore                     # Python ignores
├── .vscode/
│   ├── settings.json              # VS Code configuration (OS-specific!)
│   └── launch.json                # Debugging configuration
├── src/
│   └── my_project/
│       └── __init__.py
├── tests/
│   └── test_init.py
├── docs/
│   └── README.md
├── pyproject.toml                 # Project metadata
└── README.md
```

### Key Files Generated

**pyproject.toml:**
- Project metadata (name, version, description)
- Dependencies list
- pytest configuration
- ruff configuration (linting/formatting)

**`.vscode/settings.json`:**
- Points to `./venv/bin/python` (Unix) or `./venv/Scripts/python.exe` (Windows)
- Configures pytest, ruff, type checking
- Auto-formats on save
- Excludes `__pycache__` from file explorer

**`.vscode/launch.json`:**
- Debug current file
- Debug pytest tests
- Debug all tests with coverage

---

## Keeping Instructions Updated

### Option 1: Manual Update
Periodically copy the latest `02-instructions.md` content to your `~/.claude/CLAUDE.md` file.

### Option 2: Symbolic Link (Recommended)
Use a symlink so it's always up-to-date:

**macOS/Linux/WSL:**
```bash
# Remove old file
rm ~/.claude/CLAUDE.md

# Create symlink to repository file
ln -s ~/path/to/knowledge-library/04-guidance/professional/programming-language/python/claude-code-setup/02-instructions.md \
   ~/.claude/CLAUDE.md
```

Now when you update the repository, Claude Code automatically uses the new version.

**Windows (PowerShell as administrator):**
```powershell
# Remove old file
Remove-Item "$env:USERPROFILE\.claude\CLAUDE.md" -ErrorAction SilentlyContinue

# Create symlink to repository file
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\.claude\CLAUDE.md" `
  -Target "path\to\knowledge-library\04-guidance\professional\programming-language\python\claude-code-setup\02-instructions.md" -Force
```

---

## Troubleshooting

**Claude Code not using instructions?**
1. Check file exists at correct location
2. File must be named `python-project-setup.md` (not `02-instructions.md`)
3. Restart Claude Code completely
4. Try creating a test project

**Wrong Python path in settings?**
- Claude Code automatically detects your OS
- If wrong, file might be named incorrectly
- Delete file, check folder name, reinstall

**Virtual environment not creating?**
- Claude Code runs bash/PowerShell commands
- Ensure Python is in your PATH
- Check you have write permissions to target directory
- Try creating project in user's home directory first

---

## Related Documents

- [Detailed Setup Guide](./03-detailed-setup-guide.md) - Detailed instructions with troubleshooting
- [Instructions File](./02-instructions.md) - The actual instructions file (for reference)
- [VS Code Python Development](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md) - Debugging, testing, and workflows
- [Python Fundamentals Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/README.md) - All Python learning resources

---

## FAQ

**Q: Do I need to do this?**
A: No, but it saves ~10 minutes per project. Highly recommended.

**Q: Can I customize the setup?**
A: Yes, edit `02-instructions.md` before installing.

**Q: Does this work with existing projects?**
A: Yes, Claude Code can add setup to existing projects.

**Q: Can I share with my team?**
A: Yes, each team member installs the same file in their instructions folder.

**Q: What if I don't like it?**
A: Delete the file from your instructions folder. Claude Code goes back to normal.

**Q: Does this replace my system Python?**
A: No, it just creates a virtual environment. System Python is unchanged.

---

**Version:** 1.0
**Last Updated:** 2025-11-16
**Status:** ✅ Production Ready
