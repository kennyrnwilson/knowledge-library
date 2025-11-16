# Installing Claude Code Global Instructions for Python Projects

This guide explains how to set up Claude Code's global instructions for automatic Python project setup on your system.

> **Source:** Based on [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md)
> **Part of:** [Claude Code Python Project Setup Guide](./README.md)

**← Back to**: [Claude Code Setup Guide Home](./README.md)

---

## Overview

Claude Code supports global instructions that apply automatically to all requests. By installing the Python project setup instructions file, Claude Code will automatically follow professional best practices whenever you ask it to create or set up a Python project.

## Files Involved

Two files work together:

1. **claude-code-setup-python-projects.md** - The actual instructions (this repository)
2. **Local instructions directory** - Where you place it on your system

## Installation by Operating System

### Windows

**Step 1: Locate the Instructions Directory**

Press `Win+R`, paste:
```
%APPDATA%\Claude\instructions
```

This opens the Claude configuration directory. If the `instructions` folder doesn't exist, create it.

**Step 2: Copy the Instructions File**

Download or copy `claude-code-setup-python-projects.md` from this repository:

From: `04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md`

To: `%APPDATA%\Claude\instructions\python-project-setup.md`

You can use:
```powershell
# PowerShell
$source = "C:\path\to\knowledge-library\04-guidance\professional\ai-engineering-roadmap\stage-1-foundational-skills\python-fundamentals\claude-code-setup-python-projects.md"
$dest = "$env:APPDATA\Claude\instructions\python-project-setup.md"
Copy-Item -Path $source -Destination $dest -Force
```

**Step 3: Restart Claude Code**

Close and reopen Claude Code for the instructions to take effect.

**Step 4: Verify Installation**

Ask Claude Code:
```
Create a new Python project called "test-project" at C:\Users\YourName\projects
```

Claude Code should follow the professional setup process automatically.

**File Location Reference:**
```
C:\Users\YourName\AppData\Roaming\Claude\instructions\python-project-setup.md
```

### macOS

**Step 1: Create Instructions Directory (if needed)**

Open Terminal and run:
```bash
mkdir -p ~/.config/Claude/instructions
```

**Step 2: Copy the Instructions File**

```bash
# Option 1: Direct copy
cp ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md

# Option 2: Create symlink (updates automatically from repository)
ln -s ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

**Step 3: Restart Claude Code**

Close and reopen Claude Code.

**Step 4: Verify Installation**

Ask Claude Code:
```
Create a new Python project called "test-project" in ~/projects
```

Claude Code should follow the professional setup process automatically.

**File Location Reference:**
```
~/.config/Claude/instructions/python-project-setup.md
```

### Linux

**Step 1: Create Instructions Directory (if needed)**

```bash
mkdir -p ~/.config/Claude/instructions
```

**Step 2: Copy the Instructions File**

```bash
# Option 1: Direct copy
cp ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md

# Option 2: Create symlink (updates automatically from repository)
ln -s ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

**Step 3: Restart Claude Code**

Close and reopen Claude Code.

**Step 4: Verify Installation**

Ask Claude Code:
```
Create a new Python project called "test-project" in ~/projects
```

Claude Code should follow the professional setup process automatically.

**File Location Reference:**
```
~/.config/Claude/instructions/python-project-setup.md
```

### WSL (Windows Subsystem for Linux)

When using Claude Code within WSL:

**Step 1: Create Instructions Directory**

```bash
mkdir -p ~/.config/Claude/instructions
```

**Step 2: Copy from Repository**

If your knowledge library is in WSL:
```bash
cp ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

If your knowledge library is on Windows (e.g., `/mnt/c/Users/...`):
```bash
cp /mnt/c/Users/YourName/projects/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

**Step 3: Restart Claude Code**

Close and reopen Claude Code.

**Step 4: Verify Installation**

Ask Claude Code:
```
Create a new Python project called "test-project" in ~/projects
```

Claude Code should follow the professional setup process automatically.

**File Location Reference:**
```
~/.config/Claude/instructions/python-project-setup.md
```

## Keeping Instructions Updated

### Option 1: Manual Updates

Periodically copy the latest version from the repository:

**Windows:**
```powershell
$source = "C:\path\to\knowledge-library\04-guidance\professional\ai-engineering-roadmap\stage-1-foundational-skills\python-fundamentals\claude-code-setup-python-projects.md"
$dest = "$env:APPDATA\Claude\instructions\python-project-setup.md"
Copy-Item -Path $source -Destination $dest -Force
```

**macOS/Linux/WSL:**
```bash
cp ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

### Option 2: Symbolic Link (Automatic Updates)

Create a symlink so the file updates automatically:

**macOS/Linux/WSL:**
```bash
# Remove old file if it exists
rm ~/.config/Claude/instructions/python-project-setup.md 2>/dev/null

# Create symlink
ln -s ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

Now whenever the repository file is updated, Claude Code will use the latest version.

### Option 3: Git Repository Management

If you manage your knowledge library with Git:

```bash
# Navigate to the instructions directory
cd ~/.config/Claude/instructions

# Create a symlink to the repository
ln -s /absolute/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md \
   python-project-setup.md

# Now whenever you `git pull` the knowledge library, the instructions are updated
```

## Verifying Installation

After installation, test that Claude Code is using your instructions:

### Test 1: New Project Creation

Ask Claude Code:
```
Create a new Python project called "test-project" at [your-path].
I'm using Windows/WSL/macOS.
```

**Expected behavior:**
- Claude Code creates all directories
- Creates pyproject.toml with proper structure
- Creates .vscode/settings.json with venv paths
- Creates virtual environment
- Installs pytest, ruff
- Shows setup completion

**If this happens:** ✅ Installation successful

### Test 2: Check Project Structure

After Claude Code finishes, verify the project has:
```
test-project/
├── .git/
├── .gitignore
├── .vscode/
│   ├── settings.json
│   └── launch.json
├── src/
│   └── test_project/
│       └── __init__.py
├── tests/
│   └── test_init.py
├── pyproject.toml
└── README.md
```

If all files are present: ✅ Setup working correctly

### Test 3: VS Code Integration

Open the project in VS Code:
```bash
code test-project
```

Check:
- Status bar shows: `Python 3.11+ ('./venv': venv)`
- Test Explorer shows 1 test
- No red squiggles in Python files

**If all checks pass:** ✅ Fully working

## Troubleshooting

### Issue: Instructions Not Being Used

**Problem:** Claude Code doesn't create projects using the instructions

**Solutions:**
1. Verify file location:
   - Windows: Check `%APPDATA%\Claude\instructions\python-project-setup.md` exists
   - macOS/Linux: Check `~/.config/Claude/instructions/python-project-setup.md` exists

2. Restart Claude Code completely:
   - Close all windows
   - Wait 5 seconds
   - Reopen

3. Check filename: File must be named `python-project-setup.md` (not `claude-code-setup-python-projects.md`)

4. Check file permissions:
   ```bash
   # macOS/Linux/WSL
   ls -la ~/.config/Claude/instructions/python-project-setup.md
   # Should show readable file
   ```

### Issue: File Not Found Error

**Problem:** When copying, you get "File not found"

**Solutions:**
1. Verify source path exists:
   ```bash
   ls ~/path/to/knowledge-library/04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/claude-code-setup-python-projects.md
   ```

2. Create instructions directory if missing:
   - Windows: `mkdir %APPDATA%\Claude\instructions`
   - macOS/Linux: `mkdir -p ~/.config/Claude/instructions`

### Issue: Permission Denied

**Problem:** Error when copying or creating file

**Solutions (macOS/Linux/WSL):**
```bash
# Make sure directory exists and is writable
mkdir -p ~/.config/Claude/instructions
chmod 755 ~/.config/Claude/instructions

# Copy file
cp source-file ~/.config/Claude/instructions/python-project-setup.md

# Make file readable
chmod 644 ~/.config/Claude/instructions/python-project-setup.md
```

### Issue: Changes Not Taking Effect

**Problem:** You updated the file, but Claude Code uses old version

**Solutions:**
1. If using direct copy: Re-copy the file to instructions directory
2. If using symlink: Symlink is automatic, just restart Claude Code
3. Restart Claude Code completely (close all windows)

## Integration with Knowledge Library

This instructions file is stored in your knowledge library at:

```
04-guidance/
└── professional/
    └── ai-engineering-roadmap/
        └── stage-1-foundational-skills/
            └── python-fundamentals/
                ├── claude-code-setup-python-projects.md (← Use this file)
                ├── claude-code-instructions-setup-guide.md (← This file)
                ├── vs-code-python-development.md
                ├── complete-modern-project-tutorial.md
                └── README.md
```

When you update your knowledge library (e.g., `git pull`), you can keep Claude Code's instructions in sync using a symlink.

## Related Documentation

- [VS Code Python Development](./vs-code-python-development.md) - Comprehensive guide on debugging, testing, and development workflows
- [Complete Modern Python Project Tutorial](./complete-modern-project-tutorial.md) - Full project structure and best practices
- [Python Fundamentals](./README.md) - All Python learning resources

## FAQ

**Q: Can I customize the instructions?**

A: Yes, edit `claude-code-setup-python-projects.md` to match your preferences, then copy to the instructions directory.

**Q: Does this work with other Python tools?**

A: These instructions are specific to Python projects. For other languages, create similar instruction files.

**Q: Can I have multiple instruction files?**

A: Yes, you can create separate files for different project types (e.g., `python-web-setup.md`, `python-data-setup.md`).

**Q: What if I don't want to use these instructions?**

A: Just remove the file from `~/.config/Claude/instructions/` or `%APPDATA%\Claude\instructions\`.

**Q: Are these instructions Windows-specific?**

A: No, the instructions include platform-specific steps for Windows, macOS, Linux, and WSL. Claude Code will use the appropriate steps for your system.

**Q: Can I share these instructions with my team?**

A: Yes, distribute the `claude-code-setup-python-projects.md` file. Each team member installs it in their own Claude configuration directory.

---

**Last Updated: 2025-11-16**

**← Back to**: [Python Fundamentals](./README.md)
