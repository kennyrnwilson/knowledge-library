# Claude Code Global Instructions: Professional Python Project Setup

> **Source:** Based on [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md)
> **Part of:** [Claude Code Python Project Setup Guide](./README.md)
> **Official Docs:** [Anthropic Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

**Installation Instructions:**

This file should be saved as `CLAUDE.md` in Claude Code's global configuration directory (`~/.claude/`) on your system so that Claude Code automatically uses these instructions for all new Python projects:

**Windows:**
```
Save this file to: C:\Users\YourName\.claude\CLAUDE.md
```

**macOS/Linux/WSL:**
```
Save this file to: ~/.claude/CLAUDE.md
```

After placing this file in the correct location, restart Claude Code and it will automatically load these instructions.

This uses the official Claude Code CLAUDE.md mechanism as documented by Anthropic at https://www.anthropic.com/engineering/claude-code-best-practices

For installation instructions, see: [Quick Start Guide](./01-quick-start.md)

---

# Python Professional Development Project Setup Guide

You are an expert Python developer helping users set up professional Python projects. When a user asks to create a new Python project or set up an existing one, follow this comprehensive setup process.

## Core Setup Principles

Always ensure the following when setting up Python projects:

1. **Virtual Environment**: Every project gets its own isolated virtual environment at `./venv`
2. **Project Structure**: Standard layout with `src/`, `tests/`, `docs/` directories
3. **Configuration**: `pyproject.toml` for all project metadata and dependencies
4. **Version Control**: Git initialized with proper `.gitignore`
5. **VS Code Integration**: Complete `.vscode/settings.json` with venv paths and tool configuration
6. **Code Quality**: Ruff for linting/formatting, pytest for testing
7. **Debugging**: Configured launch configurations for debugging and testing

## Project Structure Template

Always create this structure:

```
project-name/
├── .git/                          # Git repository
├── .gitignore                     # Python/IDE ignores
├── .vscode/
│   ├── settings.json              # VS Code workspace settings
│   └── launch.json                # Debug configurations
├── src/
│   └── project_name/
│       └── __init__.py            # Package initialization
├── tests/
│   └── test_*.py                  # Test files
├── docs/
│   └── README.md                  # Documentation
├── pyproject.toml                 # Project metadata and dependencies
└── README.md                      # Project readme
```

## Critical Configuration Files

### pyproject.toml Template

All new projects must include this `pyproject.toml`:

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "PROJECT_NAME"
version = "0.1.0"
description = "PROJECT_DESCRIPTION"
readme = "README.md"
requires-python = ">=3.11"
authors = [
    {name = "Author Name", email = "author@example.com"}
]
dependencies = []

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov>=4.0",
    "ruff>=0.1",
]

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"
python_classes = "Test*"
python_functions = "test_*"

[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "W"]
ignore = ["E501"]

[tool.ruff.format]
line-length = 100
```

### .gitignore Template

Every project must include:

```
# Virtual environments
venv/
env/
ENV/
.venv/

# Python artifacts
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Testing
.pytest_cache/
.coverage
htmlcov/
.tox/

# IDE
.vscode/settings.local.json
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Project specific
*.log
```

### .vscode/settings.json - Windows Template

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/venv/Scripts/python.exe",
  "python.pythonPath": "${workspaceFolder}/venv/Scripts/python.exe",
  "python.terminal.executeInFileDir": true,
  "python.terminal.activateEnvironment": true,

  "ruff.path": ["${workspaceFolder}/venv/Scripts/ruff.exe"],
  "ruff.lint.args": ["--line-length=100"],

  "python.analysis.typeCheckingMode": "basic",
  "python.analysis.pythonPath": "${workspaceFolder}/venv/Scripts/python.exe",

  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit"
    }
  },

  "python.testing.pytestEnabled": true,
  "python.testing.pytestPath": "${workspaceFolder}/venv/Scripts/pytest.exe",
  "python.testing.pytestArgs": [
    "tests",
    "-v"
  ],

  "python.debugging.logDir": "${workspaceFolder}/.vscode/debug_logs",

  "editor.rulers": [100],
  "editor.wordWrap": "on",
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    "**/.pytest_cache": true,
    "**/venv": false
  }
}
```

### .vscode/settings.json - WSL/Linux/macOS Template

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/venv/bin/python",
  "python.pythonPath": "${workspaceFolder}/venv/bin/python",
  "python.terminal.executeInFileDir": true,
  "python.terminal.activateEnvironment": true,

  "ruff.path": ["${workspaceFolder}/venv/bin/ruff"],
  "ruff.lint.args": ["--line-length=100"],

  "python.analysis.typeCheckingMode": "basic",
  "python.analysis.pythonPath": "${workspaceFolder}/venv/bin/python",

  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit"
    }
  },

  "python.testing.pytestEnabled": true,
  "python.testing.pytestPath": "${workspaceFolder}/venv/bin/pytest",
  "python.testing.pytestArgs": [
    "tests",
    "-v"
  ],

  "python.debugging.logDir": "${workspaceFolder}/.vscode/debug_logs",

  "editor.rulers": [100],
  "editor.wordWrap": "on",
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    "**/.pytest_cache": true,
    "**/venv": false
  }
}
```

### .vscode/launch.json Template

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal",
            "justMyCode": true
        },
        {
            "name": "pytest: Current File",
            "type": "python",
            "request": "launch",
            "module": "pytest",
            "args": ["${file}", "-v"],
            "console": "integratedTerminal",
            "justMyCode": true
        },
        {
            "name": "pytest: All Tests",
            "type": "python",
            "request": "launch",
            "module": "pytest",
            "args": ["tests", "-v"],
            "console": "integratedTerminal",
            "justMyCode": true
        }
    ]
}
```

## Setup Process Steps

When a user asks to set up a new Python project, execute these steps in order:

### 1. Gather Information

Ask the user for:
- **Project name** (e.g., "my-calculator", "data-processor")
- **Location** (e.g., "C:\Users\YourName\projects", "~/projects")
- **Operating system** (Windows, WSL, macOS, Linux)
- **Python version** (3.11 is default, ask if different)
- **Initial dependencies** (empty list is fine for now)

### 2. Create Project Structure

```bash
# Navigate to target directory
cd /path/to/projects

# Create project folder
mkdir project-name
cd project-name

# Create directories
mkdir src
mkdir src/project_name
mkdir tests
mkdir docs
mkdir -p .vscode

# Initialize git
git init
```

### 3. Create Configuration Files

Create the following files in the project root:

- `pyproject.toml` (use template above, substitute PROJECT_NAME, PROJECT_DESCRIPTION)
- `.gitignore` (use template above)
- `README.md` (basic content about the project)

### 4. Create VS Code Configuration

Create `.vscode/settings.json` (use appropriate template for Windows or WSL/Linux/macOS based on user's OS)

Create `.vscode/launch.json` (same for all platforms)

### 5. Create Virtual Environment

**Windows (PowerShell):**
```powershell
python -m venv venv
.\venv\Scripts\Activate.ps1
```

**WSL/Linux/macOS (bash):**
```bash
python3 -m venv venv
source venv/bin/activate
```

### 6. Install Dependencies

With venv activated:

```bash
# Upgrade pip
pip install --upgrade pip

# Install from pyproject.toml (this installs dev dependencies)
pip install -e ".[dev]"
```

### 7. Create Initial Package Files

```bash
# Create package init file
touch src/project_name/__init__.py
```

### 8. Create Initial Test

Create `tests/test_init.py`:

```python
"""Tests for package initialization."""

def test_import():
    """Test that package imports successfully."""
    import project_name
    assert project_name is not None
```

### 9. Verify Installation

```bash
# Test that venv is active
which python  # WSL/Linux/macOS
where python  # Windows

# List installed packages
pip list

# Run initial test
pytest tests/ -v
```

## Platform-Specific Considerations

### Windows with PowerShell

- Virtual environment scripts are in `venv\Scripts\`
- Use `.ps1` activation script: `.\venv\Scripts\Activate.ps1`
- VS Code settings use `venv\Scripts\python.exe`
- Path separators in settings: Use forward slashes (VS Code translates)

### WSL

- Virtual environment scripts are in `venv/bin/`
- Use bash activation: `source venv/bin/activate`
- VS Code settings use `venv/bin/python`
- Path separators: Use forward slashes
- Ensure Python 3.11+ installed: `apt install python3.11`

### macOS

- Use Homebrew for Python 3.11+: `brew install python@3.11`
- Virtual environment scripts are in `venv/bin/`
- Use bash activation: `source venv/bin/activate`
- VS Code settings use `venv/bin/python`

## Verification Checklist

After setup completes, verify with user:

- [ ] Virtual environment created at `./venv`
- [ ] `pyproject.toml` exists with project metadata
- [ ] `.vscode/settings.json` references venv paths correctly
- [ ] `.gitignore` includes Python artifacts
- [ ] Git initialized: `git status` shows no errors
- [ ] Packages installed: `pip list` shows pytest, ruff
- [ ] Can open project in VS Code
- [ ] Status bar shows: `Python 3.11+ ('./venv': venv)`
- [ ] Initial test passes: `pytest tests/` shows 1 passed
- [ ] Linting works: Create unused import, see red squiggly
- [ ] Formatting works: Save file, auto-removes unused import

## Post-Setup Instructions

After successful setup, provide user with:

1. **VS Code Opening:**
   ```bash
   code .
   ```

2. **Virtual Environment Activation (for terminal work):**
   ```bash
   # WSL/Linux/macOS
   source venv/bin/activate

   # Windows PowerShell
   .\venv\Scripts\Activate.ps1
   ```

3. **Running Tests:**
   - In VS Code: Click Test Explorer icon (flask), then run
   - In terminal: `pytest tests/`

4. **Debugging:**
   - Set breakpoint by clicking line number margin
   - Press F5 to start debugging
   - Use Debug Console (Ctrl+Shift+Y) to inspect variables

5. **Next Steps:**
   - Create modules in `src/project_name/`
   - Write tests in `tests/`
   - Commit to git regularly

## Common Issues and Solutions

### Issue: "ModuleNotFoundError" in VS Code

**Cause:** Wrong Python interpreter selected

**Solution:**
1. `Ctrl+Shift+P` → "Python: Select Interpreter"
2. Choose interpreter with `venv` in path
3. Restart debugging

### Issue: Tests won't run

**Cause:** pytest not installed or venv not activated

**Solution:**
```bash
source venv/bin/activate  # WSL/macOS
.\venv\Scripts\Activate.ps1  # Windows
pip install -e ".[dev]"
pytest tests/
```

### Issue: Ruff linting not working

**Cause:** Ruff not installed in venv

**Solution:**
```bash
pip install ruff
# Restart VS Code
```

### Issue: venv not activating in VS Code terminal

**Cause:** Terminal profile doesn't have venv activation

**Solution:**
- Settings already configured with `"python.terminal.activateEnvironment": true`
- Restart VS Code
- New terminals should show `(venv)` in prompt

## Customization Examples

### Add Project Dependencies

User asks: "Add requests and numpy to the project"

1. Edit `pyproject.toml`, add to `dependencies`:
```toml
dependencies = [
    "requests>=2.28.0",
    "numpy>=1.24.0",
]
```

2. Install:
```bash
pip install -e ".[dev]"
```

### Change Python Version Target

User asks: "Use Python 3.12"

1. Edit `pyproject.toml`:
```toml
requires-python = ">=3.12"

[tool.ruff]
target-version = "py312"
```

2. If needed, create new venv with Python 3.12

### Add Test Coverage

Edit `pyproject.toml`:

```toml
[tool.pytest.ini_options]
addopts = "-v --cov=src/project_name --cov-report=html"
```

Then: `pytest tests/`

## When to Use This Guide

Use this guide when:
- User says "Create a new Python project"
- User says "Set up Python project structure"
- User says "Initialize a Python project with best practices"
- User asks "How do I set up a professional Python project?"
- User has an existing project and wants to set it up properly

Do NOT use this guide for:
- Simple Python scripts (single .py file is fine without venv)
- Teaching Python basics (focus on language, not setup)
- Troubleshooting existing projects (unless setup is the issue)

## Reference

This guide is based on professional Python development practices and integrates with:
- VS Code Python development workflow
- Modern Python packaging (pyproject.toml)
- pytest testing framework
- ruff linting and formatting
- Virtual environment best practices

For detailed information on VS Code debugging, testing, and advanced features, refer to the VS Code Python Development Guide in the knowledge library.

---

**Last Updated: 2025-11-16**

**Version: 1.0**
