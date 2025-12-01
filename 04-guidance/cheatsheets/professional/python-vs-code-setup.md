# Python VS Code Setup - Quick Reference

Linux-focused prescriptive guide for setting up and working with Python projects in VS Code.

---

## Initial Setup

### Install Extensions

```bash
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension charliermarsh.ruff
code --install-extension ms-python.pytest
code --install-extension njpwerner.autodocstring
code --install-extension mhutchie.git-graph
```

### Create Virtual Environment

```bash
cd /path/to/project
python3 -m venv venv
source venv/bin/activate
pip install -e ".[dev]"
```

### Select Interpreter

1. `Ctrl+Shift+P` → `Python: Select Interpreter`
2. Choose: `./venv/bin/python`
3. Verify status bar shows: `Python 3.x.x ('./venv': venv)`

---

## Project Configuration

### Create `.vscode/settings.json`

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/venv/bin/python",
  "python.pythonPath": "${workspaceFolder}/venv/bin/python",
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
  "python.testing.pytestArgs": ["tests", "-v"],

  "editor.rulers": [100],
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    "**/.pytest_cache": true
  }
}
```

### Create `.vscode/launch.json`

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Current File",
      "type": "python",
      "request": "launch",
      "program": "${file}",
      "console": "integratedTerminal"
    },
    {
      "name": "pytest: Current File",
      "type": "python",
      "request": "launch",
      "module": "pytest",
      "args": ["${file}", "-v"],
      "console": "integratedTerminal"
    },
    {
      "name": "pytest: All Tests",
      "type": "python",
      "request": "launch",
      "module": "pytest",
      "args": ["tests", "-v", "--cov"],
      "console": "integratedTerminal"
    }
  ]
}
```

### Update `.gitignore`

```
# Virtual environments
venv/
env/
ENV/
.venv/

# Python
__pycache__/
*.pyc
*.pyo
*.egg-info/
.pytest_cache/

# IDE
.vscode/settings.local.json
```

---

## Debugging

### Breakpoint Operations

| Action | Method |
|--------|--------|
| Set/remove breakpoint | Click line number margin |
| Conditional breakpoint | Right-click breakpoint → Edit Breakpoint |
| Logpoint | Right-click line → Add Logpoint |

### Debug Controls

| Action | Shortcut |
|--------|----------|
| Start/Continue | `F5` |
| Stop | `Shift+F5` |
| Step Over | `F10` |
| Step Into | `F11` |
| Step Out | `Shift+F11` |
| Toggle Breakpoint | `Ctrl+F8` |

### Debug Workflow

```bash
# 1. Set breakpoint (click line margin)
# 2. Start debug: F5
# 3. Inspect variables in Debug panel
# 4. Use Debug Console: Ctrl+Shift+Y
# 5. Step through: F10/F11
# 6. Continue: F5
```

### Debug Test

1. Open Test Explorer (Testing icon)
2. Right-click test → "Debug Test"
3. Set breakpoints as needed
4. Inspect variables during execution

---

## Testing

### Run Tests

| Action | Method |
|--------|--------|
| Run all tests | Click play icon in Test Explorer |
| Run single test | Click play next to test name |
| Run file tests | Click play next to filename |
| Debug test | Right-click test → Debug Test |

### Command Line

```bash
# Run all tests
pytest tests/

# Run with coverage
pytest tests/ --cov=src --cov-report=term-missing

# Run specific test
pytest tests/test_file.py::test_function

# Run with verbose output
pytest -v
```

---

## Code Quality

### Ruff (Linting/Formatting)

```bash
# Lint check
ruff check .

# Format code
ruff format .

# Auto-fix issues
ruff check --fix .
```

VS Code runs these automatically on save.

### Type Checking

Pylance shows type errors inline. No manual action needed.

---

## Navigation

### Go To

| Action | Shortcut |
|--------|----------|
| Go to Definition | `F12` |
| Peek Definition | `Alt+F12` |
| Find References | `Shift+F12` |
| Go to Symbol (file) | `Ctrl+Shift+O` |
| Go to Symbol (workspace) | `Ctrl+T` |
| Quick File Open | `Ctrl+P` |

### Search

| Action | Shortcut |
|--------|----------|
| Find in File | `Ctrl+F` |
| Find in Workspace | `Ctrl+Shift+F` |
| Replace in File | `Ctrl+H` |
| Go to Line | `Ctrl+G` |

---

## Terminal

### Open Terminal

`Ctrl+` ` (backtick)

### Verify Virtual Environment

```bash
# Check venv is active (should see (venv) in prompt)
which python
# Should show: /path/to/project/venv/bin/python

# Verify packages
pip list | grep pytest
```

---

## Troubleshooting

### Module Not Found During Debug

```bash
# Ensure venv activated
source venv/bin/activate

# Reinstall in editable mode
pip install -e ".[dev]"

# Verify interpreter selection
# Ctrl+Shift+P → Python: Select Interpreter → ./venv/bin/python
```

### Tests Not Discovering

```bash
# Verify pytest installed in venv
pip show pytest

# Check settings.json has correct pytest path
# "python.testing.pytestPath": "${workspaceFolder}/venv/bin/pytest"

# Reload window: Ctrl+Shift+P → Reload Window
```

### Linting Not Working

```bash
# Install ruff in venv
pip install ruff

# Verify ruff path in settings.json
# "ruff.path": ["${workspaceFolder}/venv/bin/ruff"]

# Check output: View → Output → Select "Ruff"
```

### Debug Using Wrong Python

```bash
# Set breakpoint, start debug (F5)
# Open Debug Console (Ctrl+Shift+Y), type:
import sys
print(sys.executable)
# Should show venv path, not system Python

# If wrong, reselect interpreter:
# Ctrl+Shift+P → Python: Select Interpreter
```

---

## Essential Shortcuts

### Editor

| Action | Shortcut |
|--------|----------|
| Command Palette | `Ctrl+Shift+P` |
| Save | `Ctrl+S` |
| Format Document | `Shift+Alt+F` |
| Multi-cursor (next) | `Ctrl+D` |
| Multi-cursor (all) | `Ctrl+Shift+L` |
| Comment/Uncomment | `Ctrl+/` |

### Panel Management

| Action | Shortcut |
|--------|----------|
| Toggle Sidebar | `Ctrl+B` |
| Toggle Terminal | `Ctrl+` ` |
| Debug Panel | `Ctrl+Shift+D` |
| Extensions | `Ctrl+Shift+X` |
| Source Control | `Ctrl+Shift+G` |

---

## Quick Start Checklist

New project setup:

```bash
# 1. Create project and venv
mkdir myproject && cd myproject
python3 -m venv venv
source venv/bin/activate

# 2. Install tools
pip install pytest pytest-cov ruff

# 3. Open in VS Code
code .

# 4. Install extensions (if not already)
# Ctrl+Shift+P → Extensions: Show Recommended Extensions

# 5. Select interpreter
# Ctrl+Shift+P → Python: Select Interpreter → ./venv/bin/python

# 6. Create .vscode/settings.json
# Copy from configuration section above

# 7. Verify setup
which python  # Should show venv path
pytest --version
ruff --version

# 8. Start developing
# - Create src/ and tests/ directories
# - Write code
# - Run tests with Test Explorer
# - Debug with F5
```

---

## File Structure

```
myproject/
├── venv/                          # Virtual environment (not in git)
│   ├── bin/
│   │   ├── python
│   │   ├── pytest
│   │   └── ruff
│   └── lib/python3.x/site-packages/
├── src/
│   └── myproject/
│       ├── __init__.py
│       └── module.py
├── tests/
│   ├── __init__.py
│   └── test_module.py
├── .vscode/
│   ├── settings.json              # In git
│   └── launch.json                # In git
├── .gitignore
├── pyproject.toml
└── README.md
```

---

## Common Commands

### Project Setup

```bash
# Create and activate venv
python3 -m venv venv
source venv/bin/activate

# Install package in dev mode
pip install -e ".[dev]"

# Freeze dependencies
pip freeze > requirements.txt
```

### Testing

```bash
# Run tests
pytest

# With coverage
pytest --cov=src --cov-report=html

# Watch mode (requires pytest-watch)
ptw
```

### Code Quality

```bash
# Check code
ruff check .

# Format code
ruff format .

# Fix auto-fixable issues
ruff check --fix .
```

### Git

```bash
# Stage and commit from VS Code
# Ctrl+Shift+G → Stage files → Enter message → Ctrl+Enter

# Or from terminal
git add .
git commit -m "message"
git push
```

---

## Advanced: Remote Debugging

### On Remote Machine

```bash
# Install debugpy
pip install debugpy

# Add to script
import debugpy
debugpy.listen(("0.0.0.0", 5678))
print("Waiting for debugger...")
debugpy.wait_for_client()

# Run script
python script.py
```

### On Local VS Code

Add to `.vscode/launch.json`:

```json
{
  "name": "Remote Attach",
  "type": "python",
  "request": "attach",
  "connect": {
    "host": "remote-host-ip",
    "port": 5678
  },
  "pathMappings": [
    {
      "localRoot": "${workspaceFolder}",
      "remoteRoot": "/remote/project/path"
    }
  ]
}
```

Select "Remote Attach" from debug dropdown and press F5.

---

*Quick reference for Python development in VS Code on Linux*
