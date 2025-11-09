# 🧰 Coding Python in VS Code (2025): A Practical Guide

VS Code has become the most popular Python IDE in 2025, offering powerful features for development, testing, and debugging. This guide covers setup, essential extensions, workflows, and professional practices.

**← Back to**: [Environment Setup](./environment-setup.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn

### Initial Setup and Extensions

**Install VS Code:**
- Download: [https://code.visualstudio.com/](https://code.visualstudio.com/)
- Available for Windows, macOS, Linux
- Lightweight, extensible, free and open-source

**Essential Python Extensions:**

| Extension | Purpose | Install |
|-----------|---------|---------|
| **Python** (Microsoft) | Core Python support | `ms-python.python` |
| **Pylance** | Fast IntelliSense & type checking | `ms-python.vscode-pylance` |
| **Ruff** | Ultra-fast linter & formatter | `charliermarsh.ruff` |
| **Jupyter** | Notebook support | `ms-toolsai.jupyter` |
| **autoDocstring** | Generate docstrings | `njpwerner.autodocstring` |

**Install Extensions:**

```bash
# From command line
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension charliermarsh.ruff
code --install-extension ms-toolsai.jupyter
code --install-extension njpwerner.autodocstring

# Or use Extensions panel (Ctrl+Shift+X)
```

---

### Python Environment Configuration

**Selecting Python Interpreter:**

VS Code needs to know which Python interpreter to use.

```bash
# View available interpreters
Ctrl+Shift+P (Cmd+Shift+P on Mac) → "Python: Select Interpreter"

# Or click the interpreter in status bar (bottom-right)
```

**Project-Specific Settings** (`.vscode/settings.json`):

```json
{
  // Point to project venv
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",

  // Or use global Python
  // "python.defaultInterpreterPath": "/usr/bin/python3",

  // Pylance type checking
  "python.analysis.typeCheckingMode": "basic",  // or "strict"

  // Auto-activate venv in terminal
  "python.terminal.activateEnvironment": true,

  // Include paths for imports
  "python.analysis.extraPaths": [
    "${workspaceFolder}/src"
  ]
}
```

**Environment Discovery:**

VS Code automatically detects:
- `venv` environments (`.venv/`, `venv/`)
- `conda` environments
- `pyenv` installations
- System Python

---

### Code Intelligence and Navigation

**Pylance Features:**

Pylance provides rich IntelliSense powered by Microsoft's type-checking engine.

**IntelliSense (Auto-completion):**
- Trigger: Type or press `Ctrl+Space`
- Shows function signatures, docstrings, parameter types
- Works better with type hints

```python
# With type hints, IntelliSense knows types
def add(a: int, b: int) -> int:
    return a + b

result = add(2, 3)  # IntelliSense knows result is int
```

**Navigation Shortcuts:**

| Action | Shortcut | Description |
|--------|----------|-------------|
| Go to Definition | `F12` | Jump to where function/class is defined |
| Peek Definition | `Alt+F12` | View definition inline |
| Go to References | `Shift+F12` | Find all usages |
| Go to Symbol | `Ctrl+Shift+O` | Navigate to function/class in file |
| Go to Symbol in Workspace | `Ctrl+T` | Search symbols across project |
| Go Back | `Alt+Left` | Return to previous location |
| Go Forward | `Alt+Right` | Go to next location |

**Type Checking:**

```json
{
  // settings.json
  "python.analysis.typeCheckingMode": "basic",  // off, basic, or strict
  "python.analysis.diagnosticSeverityOverrides": {
    "reportUnusedVariable": "warning",
    "reportGeneralTypeIssues": "error"
  }
}
```

---

### Linting and Formatting

**Ruff - Modern All-in-One Tool (Recommended 2025):**

Ruff combines linting and formatting in a single, blazingly fast tool.

**Configuration** (`.vscode/settings.json`):

```json
{
  // Enable Ruff
  "ruff.enable": true,

  // Set Ruff as default formatter
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit"
    }
  },

  // Ruff arguments
  "ruff.lint.args": [],
  "ruff.format.args": []
}
```

**Ruff Configuration** (`pyproject.toml`):

```toml
[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = [
    "E",   # pycodestyle errors
    "F",   # pyflakes
    "I",   # isort (import sorting)
    "N",   # pep8-naming
    "W",   # pycodestyle warnings
    "UP",  # pyupgrade
    "B",   # flake8-bugbear
    "A",   # flake8-builtins
    "C4",  # flake8-comprehensions
]
ignore = []

[tool.ruff.lint.isort]
known-first-party = ["your_package"]
```

**Alternative: Black + mypy:**

```json
{
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.formatOnSave": true
  },
  "python.formatting.provider": "black",
  "python.linting.mypyEnabled": true,
  "python.linting.mypyArgs": [
    "--strict"
  ]
}
```

**Format on Save:**

```json
{
  "editor.formatOnSave": true,
  "editor.formatOnPaste": false
}
```

---

### Testing Integration

**Configure pytest:**

```bash
# Install pytest
pip install pytest pytest-cov

# Configure in VS Code
Ctrl+Shift+P → "Python: Configure Tests"
→ Select "pytest"
→ Select "tests" directory
```

**Test Configuration** (`.vscode/settings.json`):

```json
{
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": [
    "tests",
    "-v",
    "--cov=src"
  ],
  "python.testing.autoTestDiscoverOnSaveEnabled": true
}
```

**pytest Configuration** (`pyproject.toml`):

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_functions = ["test_*"]
addopts = "--cov=src --cov-report=term-missing --cov-report=html"
```

**Using the Test Explorer:**
- Open Test Explorer: Click beaker icon in sidebar
- Run all tests: Click play button at top
- Run single test: Click play button next to test name
- Debug test: Click debug icon next to test
- View test output in Test Results panel

**Test Shortcuts:**
- Run tests at cursor: `Ctrl+; Ctrl+C` (Windows/Linux)
- Debug test at cursor: `Ctrl+; Ctrl+D`
- Run all tests: `Ctrl+; A`

---

### Debugging

**Quick Debugging:**

```python
# Add breakpoint: Click left of line number or press F9
# Run debugger: Press F5 or click "Run and Debug" in sidebar

def calculate(a, b):
    result = a + b  # Set breakpoint here
    return result

calculate(5, 3)
```

**Launch Configuration** (`.vscode/launch.json`):

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
      "justMyCode": true,
      "env": {
        "PYTHONPATH": "${workspaceFolder}/src"
      }
    },
    {
      "name": "Python: Module",
      "type": "python",
      "request": "launch",
      "module": "your_package.main",
      "console": "integratedTerminal"
    },
    {
      "name": "Python: FastAPI",
      "type": "python",
      "request": "launch",
      "module": "uvicorn",
      "args": [
        "your_package.main:app",
        "--reload"
      ],
      "jinja": true
    },
    {
      "name": "Python: Debug Tests",
      "type": "python",
      "request": "launch",
      "module": "pytest",
      "args": [
        "tests",
        "-v"
      ],
      "console": "integratedTerminal"
    }
  ]
}
```

**Debugging Features:**

| Feature | Shortcut | Description |
|---------|----------|-------------|
| Toggle Breakpoint | `F9` | Add/remove breakpoint |
| Start Debugging | `F5` | Run with debugger |
| Continue | `F5` | Resume execution |
| Step Over | `F10` | Execute current line |
| Step Into | `F11` | Step into function call |
| Step Out | `Shift+F11` | Exit current function |
| Stop Debugging | `Shift+F5` | End debug session |

**Advanced Breakpoints:**
- **Conditional**: Right-click breakpoint → Edit Breakpoint → Add condition
- **Hit Count**: Trigger after N hits
- **Logpoint**: Log message without stopping (add `{variable}` to log values)

---

### Jupyter Notebooks

**Using Notebooks in VS Code:**

```bash
# Install Jupyter extension
code --install-extension ms-toolsai.jupyter

# Install Jupyter in your environment
pip install jupyter ipykernel
```

**Create Notebook:**

```bash
# Create .ipynb file
Ctrl+Shift+P → "Create: New Jupyter Notebook"
```

**Select Kernel:**
- Click "Select Kernel" in top-right
- Choose your virtual environment Python interpreter
- Or create new kernel: `python -m ipykernel install --user --name=myenv`

**Interactive Python:**

Run Python files as notebooks using `# %%` cell markers:

```python
# %%
import pandas as pd
import numpy as np

# %%
data = pd.DataFrame({
    'x': np.random.randn(100),
    'y': np.random.randn(100)
})

# %%
data.plot(x='x', y='y', kind='scatter')
```

**Run Cell:**
- Click "Run Cell" above cell marker
- Or use `Ctrl+Enter` to run cell
- `Shift+Enter` to run and move to next cell

---

### Remote Development

**WSL (Windows Subsystem for Linux):**

```bash
# Install WSL extension
code --install-extension ms-vscode-remote.remote-wsl

# Open WSL project
# From WSL terminal:
code .

# Or from Windows:
Ctrl+Shift+P → "WSL: Open Folder in WSL"
```

VS Code runs in WSL, giving you Linux environment while using Windows VS Code UI.

**Dev Containers:**

Define entire development environment in a container.

**`.devcontainer/devcontainer.json`:**

```json
{
  "name": "Python 3.12",
  "image": "mcr.microsoft.com/devcontainers/python:3.12",
  "features": {
    "ghcr.io/devcontainers/features/git:1": {}
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ms-python.python",
        "ms-python.vscode-pylance",
        "charliermarsh.ruff"
      ]
    }
  },
  "forwardPorts": [8000, 8888]
}
```

**Open in Container:**

```bash
Ctrl+Shift+P → "Dev Containers: Open Folder in Container"
```

**Remote SSH:**

Develop on remote server:

```bash
# Install extension
code --install-extension ms-vscode-remote.remote-ssh

# Connect to server
Ctrl+Shift+P → "Remote-SSH: Connect to Host"
# Enter: user@hostname
```

---

### Git Integration

**Built-in Git Features:**
- **Source Control Panel**: View changes, stage files, commit
- **Diff View**: Click file to see changes
- **Inline Blame**: See who changed each line
- **Branch Management**: Switch branches, create new branches

**Common Operations:**

```bash
# Stage file: Click + in Source Control panel
# Unstage: Click -
# Commit: Type message and press Ctrl+Enter
# Push: Click "..." → Push
# Pull: Click "..." → Pull
# Create branch: Click branch name in status bar → "Create new branch"
```

**GitLens Extension (Highly Recommended):**

```bash
code --install-extension eamodio.gitlens
```

Features:
- Inline blame annotations
- Commit history for files and lines
- Side-by-side comparisons
- Visual file history

**GitHub Pull Requests Extension:**

```bash
code --install-extension GitHub.vscode-pull-request-github
```

Review PRs directly in VS Code:
- View PR description and comments
- Comment on code
- Approve or request changes
- Merge PRs

---

### Workspace Configuration

**Project Structure:**

```
your-project/
├── .vscode/
│   ├── settings.json       # Project settings
│   ├── launch.json         # Debug configs
│   ├── tasks.json          # Build tasks
│   └── extensions.json    # Recommended extensions
├── src/
├── tests/
├── .venv/
├── pyproject.toml
└── README.md
```

**Recommended Extensions** (`.vscode/extensions.json`):

```json
{
  "recommendations": [
    "ms-python.python",
    "ms-python.vscode-pylance",
    "charliermarsh.ruff",
    "ms-toolsai.jupyter",
    "eamodio.gitlens",
    "github.vscode-pull-request-github"
  ]
}
```

Team members will see prompt to install recommended extensions.

**Tasks Configuration** (`.vscode/tasks.json`):

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Tests",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/pytest",
      "args": ["-v"],
      "group": {
        "kind": "test",
        "isDefault": true
      }
    },
    {
      "label": "Lint Code",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/ruff",
      "args": ["check", "."]
    }
  ]
}
```

**Run Task:**

```bash
Ctrl+Shift+P → "Tasks: Run Task" → Select task
```

---

### Productivity Tips

**Multi-cursor Editing:**
- `Alt+Click`: Add cursor
- `Ctrl+Alt+Up/Down`: Add cursor above/below
- `Ctrl+D`: Select next occurrence of word
- `Ctrl+Shift+L`: Select all occurrences

**Command Palette:**

```bash
Ctrl+Shift+P (Cmd+Shift+P on Mac)
# Quick access to all commands
```

**Quick Open:**

```bash
Ctrl+P (Cmd+P on Mac)
# Quick open file by name
# Type "?" to see all quick open modes
```

**Keyboard Shortcuts:**

| Action | Shortcut |
|--------|----------|
| Toggle sidebar | `Ctrl+B` |
| Toggle terminal | `Ctrl+\`` |
| Open command palette | `Ctrl+Shift+P` |
| Quick open file | `Ctrl+P` |
| Go to line | `Ctrl+G` |
| Find in files | `Ctrl+Shift+F` |
| Replace in files | `Ctrl+Shift+H` |
| Toggle comment | `Ctrl+/` |
| Duplicate line | `Shift+Alt+Down` |
| Move line up/down | `Alt+Up/Down` |
| Format document | `Shift+Alt+F` |

**Snippets:**

```python
# Type trigger and press Tab
if<Tab>  # Expands to if statement
for<Tab> # Expands to for loop
def<Tab> # Expands to function definition
```

**Custom Snippets** (`python.json`):

```json
{
  "pytest test function": {
    "prefix": "test",
    "body": [
      "def test_${1:name}():",
      "    \"\"\"${2:Test description}.\"\"\"",
      "    ${3:# Arrange}",
      "    ${4:# Act}",
      "    ${5:# Assert}",
      "    assert ${6:True}"
    ]
  }
}
```

---

## 🔗 Learning Resources

### Official Documentation

- [VS Code Python Tutorial](https://code.visualstudio.com/docs/python/python-tutorial) - Getting started guide
- [Python in VS Code](https://code.visualstudio.com/docs/languages/python) - Comprehensive documentation
- [Pylance Documentation](https://code.visualstudio.com/docs/python/pylance) - Language server features
- [Python Environments](https://code.visualstudio.com/docs/python/environments) - Managing interpreters

### Development Features

- [Editing Python Code](https://code.visualstudio.com/docs/python/editing) - IntelliSense, refactoring, navigation
- [Linting Python](https://code.visualstudio.com/docs/python/linting) - Code quality tools
- [Formatting Python](https://code.visualstudio.com/docs/python/formatting) - Code formatting options
- [Testing Python](https://code.visualstudio.com/docs/python/testing) - pytest and unittest integration
- [Debugging Python](https://code.visualstudio.com/docs/python/debugging) - Debug configurations and features

### Advanced Features

- [Jupyter Notebooks in VS Code](https://code.visualstudio.com/docs/datascience/jupyter-notebooks) - Notebook support
- [Python Settings Reference](https://code.visualstudio.com/docs/python/settings-reference) - All Python settings
- [Tasks in VS Code](https://code.visualstudio.com/docs/editor/tasks) - Build task automation
- [User Defined Snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets) - Custom code snippets

### Remote Development

- [Remote Development with WSL](https://code.visualstudio.com/docs/remote/wsl) - WSL integration
- [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) - Container-based development
- [Remote SSH](https://code.visualstudio.com/docs/remote/ssh) - Develop on remote servers
- [Dev Container Features](https://containers.dev/features) - Container feature marketplace

### Extensions

- [Python Extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python) - Core Python support
- [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance) - Language server
- [Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) - Fast linter/formatter
- [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) - Enhanced Git features
- [GitHub Pull Requests](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github) - PR management
- [autoDocstring](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) - Docstring generation

### Tools Documentation

- [Ruff](https://docs.astral.sh/ruff/) - Linter and formatter
- [Black](https://black.readthedocs.io/) - Code formatter
- [mypy](https://mypy.readthedocs.io/) - Static type checker
- [pytest](https://docs.pytest.org/) - Testing framework
- [pre-commit](https://pre-commit.com/) - Git hook framework

---

## ✅ Learning Checklist

### Initial Setup

- [ ] Download and install VS Code from [https://code.visualstudio.com/](https://code.visualstudio.com/)
- [ ] Install Python extension: `ms-python.python`
- [ ] Install Pylance extension: `ms-python.vscode-pylance`
- [ ] Install Ruff extension: `charliermarsh.ruff`
- [ ] (Optional) Install Jupyter extension: `ms-toolsai.jupyter`

### Environment Configuration

- [ ] Create project with virtual environment: `python -m venv .venv`
- [ ] Open project in VS Code
- [ ] Select Python interpreter: Click status bar or `Ctrl+Shift+P` → "Python: Select Interpreter"
- [ ] Verify correct interpreter is selected (should show `.venv/bin/python`)
- [ ] Create `.vscode/settings.json` with interpreter path
- [ ] Test terminal auto-activation of venv

### Code Quality Setup

- [ ] Install Ruff in venv: `pip install ruff`
- [ ] Configure Ruff as default formatter in settings
- [ ] Enable format on save: `"editor.formatOnSave": true`
- [ ] Configure Ruff in `pyproject.toml`
- [ ] Test formatting: Edit file and save, verify auto-formatting
- [ ] Test linting: Write code with issue, see squiggly underline

### Type Checking

- [ ] Enable Pylance type checking: `"python.analysis.typeCheckingMode": "basic"`
- [ ] Add type hints to a function
- [ ] Verify IntelliSense shows parameter types
- [ ] Test "Go to Definition" (`F12`) on a function call

### Testing Configuration

- [ ] Install pytest: `pip install pytest pytest-cov`
- [ ] Configure tests: `Ctrl+Shift+P` → "Python: Configure Tests" → Select pytest
- [ ] Create `tests/` directory with `test_*.py` file
- [ ] Write a simple test function
- [ ] Open Test Explorer (beaker icon)
- [ ] Run tests from Test Explorer
- [ ] Debug a test (click debug icon next to test)

### Debugging

- [ ] Open a Python file
- [ ] Set breakpoint by clicking left of line number (or press `F9`)
- [ ] Start debugging (`F5`)
- [ ] Step through code (`F10` to step over, `F11` to step into)
- [ ] Inspect variables in Variables panel
- [ ] Try conditional breakpoint (right-click breakpoint → Edit)
- [ ] Create `.vscode/launch.json` with custom debug configuration

### Jupyter Notebooks

- [ ] Install Jupyter in venv: `pip install jupyter ipykernel`
- [ ] Create new notebook: `Ctrl+Shift+P` → "Create: New Jupyter Notebook"
- [ ] Select kernel (should be your venv Python)
- [ ] Write code in cell and run (`Ctrl+Enter`)
- [ ] Try Interactive Python: Add `# %%` in `.py` file and run cell

### Git Integration

- [ ] Initialize git repo: `git init`
- [ ] Open Source Control panel (`Ctrl+Shift+G`)
- [ ] Stage files, write commit message, commit
- [ ] Install GitLens extension for enhanced Git features
- [ ] View inline blame annotations
- [ ] View file history

### Workspace Organization

- [ ] Create `.vscode/settings.json` for project-specific settings
- [ ] Create `.vscode/extensions.json` to recommend extensions to team
- [ ] Create `.vscode/launch.json` for debug configurations
- [ ] Create `.vscode/tasks.json` for build tasks
- [ ] Test running task: `Ctrl+Shift+P` → "Tasks: Run Task"

### Productivity

- [ ] Learn Command Palette: `Ctrl+Shift+P`
- [ ] Learn Quick Open: `Ctrl+P`
- [ ] Practice multi-cursor editing: `Alt+Click` or `Ctrl+D`
- [ ] Learn "Go to Symbol": `Ctrl+Shift+O` (in file) or `Ctrl+T` (workspace)
- [ ] Customize keyboard shortcuts: `Ctrl+K Ctrl+S`
- [ ] Create custom snippet for common code pattern

### Remote Development (Optional)

- [ ] (WSL) Install Remote-WSL extension
- [ ] (WSL) Open WSL folder: `code .` from WSL terminal
- [ ] (Container) Install Dev Containers extension
- [ ] (Container) Create `.devcontainer/devcontainer.json`
- [ ] (Container) Open folder in container
- [ ] (SSH) Install Remote-SSH extension
- [ ] (SSH) Connect to remote host

### Validation

- [ ] **Test**: Create new project, set up venv, configure VS Code, write and run tests
- [ ] **Test**: Write code with type hints, verify IntelliSense completions
- [ ] **Test**: Format code on save and see changes
- [ ] **Test**: Set breakpoint, debug code, inspect variables
- [ ] **Test**: Create Jupyter notebook, run cells with plots

---

*Last updated: 2025-11-04*
