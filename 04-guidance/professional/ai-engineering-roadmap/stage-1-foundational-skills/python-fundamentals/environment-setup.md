# Environment Setup

Get Python installed and configured properly on your system.

## 📚 What You'll Learn

- Installing Python on Windows (with PATH configuration)
- Installing Python using Windows Subsystem for Linux (WSL)
- Installing Python on Mac using Homebrew
- Installing Python on Linux (Ubuntu/Debian)
- Verifying Python and pip installations
- Creating and activating virtual environments using venv
- Understanding why virtual environments are important
- Using Poetry for dependency management (recommended)
- Using Pipenv as an alternative to Poetry
- Installing and configuring VS Code for Python development
- Essential VS Code extensions for Python
- Selecting Python interpreter in VS Code
- Setting up pytest for testing
- Verifying your Python environment setup

## 🔗 Learning Resources

*Add relevant tutorials, documentation links, and other learning materials here.*

## ✅ Learning Checklist

### Installation
- [ ] Install Python on your operating system
- [ ] Verify Python installation with `python --version` or `python3 --version`
- [ ] Verify pip installation with `pip --version`
- [ ] (Windows users) Ensure Python is added to PATH
- [ ] (Windows users) Consider installing WSL for Unix-like environment

### Virtual Environments
- [ ] Create a virtual environment using `python -m venv venv`
- [ ] Activate the virtual environment
- [ ] Verify activation (check for venv in prompt)
- [ ] Practice deactivating the environment
- [ ] Understand when and why to use virtual environments

### Dependency Management
- [ ] Choose between Poetry or Pipenv
- [ ] Install Poetry: `pip install poetry`
- [ ] Initialize a Poetry project: `poetry init`
- [ ] Install dependencies with Poetry
- [ ] Run Python scripts with Poetry: `poetry run python script.py`
- [ ] (Alternative) Install and use Pipenv

### IDE Setup
- [ ] Download and install VS Code
- [ ] Install Python extension (Microsoft)
- [ ] Install Pylance extension
- [ ] Install Black Formatter extension
- [ ] Install Pytest extension
- [ ] Select Python interpreter (Cmd+Shift+P → "Python: Select Interpreter")
- [ ] Configure linting (pylint or flake8)

### Testing Setup
- [ ] Install pytest: `pip install pytest`
- [ ] Create a `tests/` directory
- [ ] Run pytest to verify installation

### Verification
- [ ] Create a test script `hello.py`:
```python
print("Hello, Python!")
print(f"Python version: {__import__('sys').version}")
```
- [ ] Run the test script: `python hello.py`
- [ ] Verify output displays correctly

### Next Steps
- [ ] Create your first Python project
- [ ] Move to [Core Python Concepts](./core-concepts/index.md)

---

*Last updated: 2025-11-03*
