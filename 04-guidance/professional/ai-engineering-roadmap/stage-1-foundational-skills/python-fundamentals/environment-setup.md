# Environment Setup

Get Python installed and configured properly on your system. Choose the guide that matches your operating system.

---

## 📚 What You'll Learn

**Platform-Specific Guides:**
- Setting up Python on Windows with PATH configuration
- Setting up Python using Windows Subsystem for Linux (WSL)
- Installing Python on Mac using Homebrew
- Installing Python on Linux (Ubuntu/Debian)

**Common to All Platforms:**
- Creating and activating virtual environments using venv
- Understanding why virtual environments are important
- Using Poetry for dependency management
- Installing and configuring VS Code for Python development
- Selecting Python interpreter in VS Code
- Verifying your Python environment setup

## 🔗 Learning Resources

### Operating System Guides

**Windows Users:**
- [🪟 Windows Installation](./windows-installation.md) - Official installer, PATH configuration, PowerShell setup
- [🐧 WSL Installation](./wsl-installation.md) - Linux environment on Windows, best for Linux-focused development

**Mac Users:**
- Use Homebrew: `brew install python@3.12`
- [Official Python on Mac Guide](https://docs.python.org/3/using/mac/index.html)
- [Real Python: macOS Setup](https://realpython.com/installing-python/#how-to-install-python-on-macos)

**Linux Users (Ubuntu/Debian):**
- Use apt: `sudo apt install python3 python3-pip python3-venv`
- [Official Python on Linux Guide](https://docs.python.org/3/using/unix/index.html)
- [Real Python: Linux Setup](https://realpython.com/installing-python/#how-to-install-python-on-linux)

### Official Documentation

- [Python Official Documentation](https://docs.python.org/3/) - Authoritative Python reference
- [venv Documentation](https://docs.python.org/3/library/venv.html) - Virtual environment module
- [Poetry Documentation](https://python-poetry.org/) - Dependency management tool

### IDE Setup

- [VS Code](https://code.visualstudio.com/) - Code editor
- [VS Code Python Extension](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [PyCharm](https://www.jetbrains.com/pycharm/) - Alternative Python IDE

### Related Topics

- [Python Fundamentals Overview](./index.md)
- [Core Python Concepts](./core-concepts/index.md)
- [Stage 1: Foundational Skills](../index.md)

---

## ✅ Learning Checklist

### Choose Your Platform

- [ ] Identify your operating system (Windows, Mac, or Linux)
- [ ] Decide between native Python (Windows/Mac/Linux) or WSL (Windows users only)
- [ ] Understand the trade-offs of your choice

### Installation

- [ ] Complete the installation guide for your operating system
- [ ] Verify Python installation: `python --version` or `python3 --version`
- [ ] Verify pip installation: `pip --version` or `pip3 --version`
- [ ] Locate your Python installation directory
- [ ] Understand the Scripts/bin folder location

### Virtual Environments

- [ ] Create a virtual environment: `python -m venv venv`
- [ ] Activate the virtual environment
  - Windows: `venv\Scripts\activate.bat` or `venv\Scripts\Activate.ps1`
  - Mac/Linux: `source venv/bin/activate`
- [ ] Verify activation (check prompt shows `(venv)`)
- [ ] Install a test package: `pip install requests`
- [ ] Create requirements.txt: `pip freeze > requirements.txt`
- [ ] Deactivate virtual environment: `deactivate`
- [ ] Recreate from requirements: `pip install -r requirements.txt`

### IDE Setup

- [ ] Download and install VS Code (or your preferred IDE)
- [ ] Install Python extension for VS Code
- [ ] Select Python interpreter from your venv
- [ ] Test with a simple script

### Verification

- [ ] Create a test script that uses a package from your venv
- [ ] Run the script and verify it works
- [ ] Verify the package is from venv, not global Python
- [ ] Document your environment for future reference

### Key Concepts to Understand

- [ ] Why virtual environments are important (isolation)
- [ ] How PATH/environment variables work on your OS
- [ ] Difference between system Python and project Python
- [ ] When to use venv vs Poetry vs other tools
- [ ] How to troubleshoot installation issues

---

**Next Step:** Go to your operating system-specific guide:
- [🪟 Windows Installation](./windows-installation.md)
- [🐧 WSL Installation](./wsl-installation.md)

Or move to [Core Python Concepts](./core-concepts/index.md) once you've completed your setup.

---

*Last updated: 2025-11-04*
