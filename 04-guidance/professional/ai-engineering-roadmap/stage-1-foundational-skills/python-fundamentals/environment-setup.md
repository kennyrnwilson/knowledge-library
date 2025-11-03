# Environment Setup

Get Python installed and configured properly on your system.

## Installation by Operating System

### Windows
- Download Python from python.org
- **Important**: Check "Add Python to PATH" during installation
- Verify: `python --version` in Command Prompt
- Install pip: Usually included, verify with `pip --version`

### Windows with WSL (Recommended for Windows)
- Install Windows Subsystem for Linux
- Ubuntu 22.04 LTS recommended
- `sudo apt update && sudo apt install python3 python3-pip`
- More Unix-like environment for development

### Mac
- Install Homebrew first: `/bin/bash -c "$(curl...)"`
- `brew install python@3.11`
- Verify: `python3 --version`

### Linux (Ubuntu/Debian)
- `sudo apt update`
- `sudo apt install python3 python3-pip python3-venv`
- Verify: `python3 --version`

## Virtual Environments

**Why**: Isolate project dependencies, avoid conflicts

**Creating a Virtual Environment**:
```bash
python -m venv venv
source venv/bin/activate  # On Mac/Linux
venv\Scripts\activate     # On Windows
```

**Verify activation**: Prompt should show (venv)

**Deactivate**: `deactivate` command

## Modern Python Tooling

### Poetry (Recommended)
- Install: `pip install poetry`
- Initialize project: `poetry init`
- Creates `pyproject.toml` and `poetry.lock`
- Install deps: `poetry install`
- Run commands: `poetry run python script.py`

### Pipenv (Alternative)
- Install: `pip install pipenv`
- Initialize: `pipenv --python 3.11`
- Install packages: `pipenv install requests`
- Run: `pipenv run python script.py`

## IDE Setup: VS Code

### Installation
- Download VS Code from code.visualstudio.com
- Install Python extension (Microsoft)

### Configuration
- Select Python interpreter (Cmd+Shift+P → "Python: Select Interpreter")
- Choose your virtual environment
- Install pylint or flake8 for linting

### Extensions to Install
- Python (Microsoft)
- Pylance (code intelligence)
- Black Formatter (code formatting)
- Pytest (testing)

## Testing Setup

- Install pytest: `pip install pytest`
- Create `tests/` directory
- Run tests: `pytest`

## Verification

Create a test script `hello.py`:
```python
print("Hello, Python!")
print(f"Python version: {__import__('sys').version}")
```

Run: `python hello.py`

## Next Steps

- Choose Poetry or Pipenv
- Set up VS Code
- Create your first project
- Move to [Core Python Concepts](./core-concepts/index.md)

---

*Last updated: 2025-11-03*
