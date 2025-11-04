# 🪟 Windows Installation

Setting up Python on Windows requires understanding Windows-specific paths, environment variables, and best practices. This guide covers everything from installation to professional development workflows on Windows.

---

## 📚 What You'll Learn

### Python Installation on Windows

Windows offers several ways to install Python. The recommended approach is the official installer from [python.org](http://python.org).

**Installation Methods:**

| Method | Best For | Pros | Cons |
|--------|----------|------|------|
| **[python.org](http://python.org) installer** | Most users | Official, stable, customizable | Manual updates |
| **Microsoft Store** | Beginners | Auto-updates, sandboxed | Limited customization |
| **Chocolatey/Winget** | Power users | Scriptable, version management | Requires package manager |
| **Anaconda** | Data science | Pre-bundled libraries | Large installation |

**Installation Directory Structure:**

```javascript
C:\Users\YourName\AppData\Local\Programs\Python\Python312\
├── python.exe              # Python interpreter
├── pythonw.exe            # GUI version (no console)
├── Scripts\               # Installed executables
│   ├── pip.exe           # Package installer
│   ├── activate.bat      # venv activation script
│   └── [other tools]
├── Lib\                  # Standard library
│   └── site-packages\   # Third-party packages
└── DLLs\                # Dynamic libraries
```

### Environment Variables

Windows uses environment variables to locate executables and configure Python behavior.

**Key Environment Variables:**

**PATH** - Tells Windows where to find executables:

```shell
# View PATH
echo %PATH%

# Python should be in PATH:
C:\Users\YourName\AppData\Local\Programs\Python\Python312\
C:\Users\YourName\AppData\Local\Programs\Python\Python312\Scripts\
```

**PYTHONPATH** (optional) - Additional module search paths:

```shell
# View PYTHONPATH
echo %PYTHONPATH%

# Set temporarily (current session)
set PYTHONPATH=C:\MyProjects\mypackage

# Set permanently (use System Properties > Environment Variables)
```

**PYTHONHOME** (rarely needed) - Override Python installation location.

### Virtual Environments on Windows

Virtual environments isolate project dependencies from the global Python installation.

**Creating and Using Virtual Environments:**

```shell
# Navigate to project directory
cd C:\Projects\myproject

# Create virtual environment
python -m venv venv

# Activate (Command Prompt)
venv\Scripts\activate.bat

# Activate (PowerShell)
venv\Scripts\Activate.ps1
```

**Virtual Environment Structure:**

```javascript
myproject\
├── venv\                    # Virtual environment
│   ├── Scripts\            # Windows executables
│   │   ├── python.exe
│   │   ├── pip.exe
│   │   ├── activate.bat   # CMD activation
│   │   └── Activate.ps1   # PowerShell activation
│   ├── Lib\               # Isolated packages
│   │   └── site-packages\
│   └── pyvenv.cfg         # Configuration
└── requirements.txt       # Dependencies
```

### PowerShell Execution Policy

By default, PowerShell may block activation scripts.

**Fix PowerShell Activation Issues:**

```powershell
# Check current policy
Get-ExecutionPolicy

# Set policy (run PowerShell as Administrator)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Now activation works
.\venv\Scripts\Activate.ps1
```

### Windows-Specific Best Practices

**1. Use Forward Slashes or Raw Strings**

```python
# Windows accepts forward slashes
path = "C:/Users/Name/Documents/file.txt"

# Or use raw strings for backslashes
path = r"C:\Users\Name\Documents\file.txt"

# Or use pathlib (recommended)
from pathlib import Path
path = Path("C:/Users/Name/Documents/file.txt")
```

**2. Handle Long Paths**

Windows has a 260-character path limit (MAX_PATH). Enable long paths:

```shell
# Enable long paths (Windows 10 1607+)
# Run as Administrator
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
```

**3. Use pyproject.toml with Editable Installs**

Instead of modifying PYTHONPATH:

```shell
# Install package in development mode
pip install -e .
```

**4. Avoid System Python**

Never modify the system Python installation. Always use virtual environments.

### Common Windows Issues

**Issue 1: "python not recognized"**

```shell
# Fix: Add Python to PATH
# System Properties > Environment Variables > Path > Edit
# Add: C:\Users\YourName\AppData\Local\Programs\Python\Python312
```

**Issue 2: pip installs to wrong location**

```shell
# Check which pip
where pip
# Should show virtual environment pip when activated

# Verify with:
pip --version
```

**Issue 3: Permission denied errors**

```shell
# Don't use administrator privileges
# Use virtual environments instead
# Install packages in venv, not globally
```

**Issue 4: DLL load failed errors**

```shell
# Install Visual C++ Redistributable
# Download from Microsoft Visual C++ website
```

---

## 🔗 Learning Resources

### Official Documentation

- [Python on Windows FAQ](https://docs.python.org/3/faq/windows.html) - Official Windows-specific guidance
- [venv Documentation](https://docs.python.org/3/library/venv.html) - Virtual environment module reference
- [Windows PATH Documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/path) - Understanding PATH variable

### Installation Guides

- [Python.org Windows Installer](https://www.python.org/downloads/windows/) - Official installer downloads
- [Real Python: Windows Setup](https://realpython.com/installing-python/#how-to-install-python-on-windows) - Comprehensive installation guide
- [VS Code Python on Windows](https://code.visualstudio.com/docs/python/python-tutorial#_install-python-and-the-python-extension) - IDE setup guide

### Best Practices

- [Python Packaging User Guide](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/) - Virtual environments and pip
- [Hitchhiker's Guide: Windows Dev](https://docs.python-guide.org/starting/install3/win/) - Development environment setup

### Tools & Utilities

- [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) - Modern terminal with tabs and customization
- [PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/) - Windows PowerShell reference
- [Chocolatey](https://chocolatey.org/) - Windows package manager
- [Winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) - Microsoft's package manager

### Troubleshooting

- [Python Windows Troubleshooting](https://docs.python.org/3/using/windows.html#troubleshooting) - Common issues and solutions
- [Stack Overflow: Python Windows](https://stackoverflow.com/questions/tagged/python+windows) - Community Q&A

---

## ✅ Learning Checklist

### Installation & Setup

- [ ] Install Python from [python.org](http://python.org) using the official installer
- [ ] Verify "Add Python to PATH" was checked during installation
- [ ] Confirm installation: run `python --version` in CMD/PowerShell
- [ ] Verify pip installation: run `pip --version`
- [ ] Locate Python installation directory (typically `C:\Users\YourName\AppData\Local\Programs\Python\Python3XX`)
- [ ] Understand Scripts folder location and purpose

### Environment Variables

- [ ] View PATH variable: `echo %PATH%` (CMD) or `$env:Path` (PowerShell)
- [ ] Verify Python directories are in PATH
- [ ] Understand difference between User and System environment variables
- [ ] Know when to use PYTHONPATH (rarely needed with proper package management)

### Virtual Environments

- [ ] Create a virtual environment: `python -m venv venv`
- [ ] Activate virtual environment (CMD): `venv\Scripts\activate.bat`
- [ ] Activate virtual environment (PowerShell): `venv\Scripts\Activate.ps1`
- [ ] Fix PowerShell execution policy if needed: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
- [ ] Verify activation: prompt shows `(venv)` and `where python` points to venv
- [ ] Install a package in venv: `pip install requests`
- [ ] Verify package is in venv, not global: check `venv\Lib\site-packages`
- [ ] Deactivate virtual environment: `deactivate`
- [ ] Create requirements.txt: `pip freeze > requirements.txt`
- [ ] Recreate environment from requirements: `pip install -r requirements.txt`

### Best Practices

- [ ] Always use virtual environments for projects (never install packages globally)
- [ ] Use `pathlib.Path` for cross-platform file paths
- [ ] Understand forward slash `/` works in Python on Windows
- [ ] Know how to use raw strings `r"C:\path"` for Windows paths
- [ ] Use editable installs `pip install -e .` instead of modifying PYTHONPATH

### Troubleshooting

- [ ] Fix "python not recognized" by checking PATH
- [ ] Verify correct pip with `where pip` when venv is activated
- [ ] Install Visual C++ Redistributable if encountering DLL errors
- [ ] Enable long paths on Windows 10+ if needed
- [ ] Avoid using administrator privileges for Python operations

### Validation

- [ ] **Test**: Create new project folder, create venv, activate it, install requests, write simple script that imports requests, run successfully
- [ ] **Test**: Open new CMD/PowerShell, navigate to project, activate venv, verify isolation from global Python
- [ ] **Test**: Deactivate venv, verify `where python` shows global Python, not venv Python

---

*Last updated: 2025-11-04*
