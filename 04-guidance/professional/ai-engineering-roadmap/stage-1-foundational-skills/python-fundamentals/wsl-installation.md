# 🐧 WSL Installation

WSL (Windows Subsystem for Linux) provides a Linux environment on Windows, offering the best of both worlds for Python development. This guide covers WSL setup, Python installation, and professional development workflows.

---

## 📚 What You'll Learn

### What is WSL?

WSL allows you to run a Linux distribution directly on Windows without virtual machines or dual-booting.

**WSL Versions:**

| Feature | WSL 1 | WSL 2 (Recommended) |
|---------|-------|---------------------|
| **Performance** | Slower I/O | Native Linux kernel, faster |
| **File System** | Translates Windows FS | Actual Linux ext4 FS |
| **System Calls** | Translated | Native Linux syscalls |
| **Docker Support** | Limited | Full support |
| **Network** | Uses Windows network | Virtualized network |

**When to Use WSL:**

- Developing for Linux production environments
- Using Linux-specific tools (bash scripts, grep, sed, awk)
- Running Docker containers
- Learning Linux while on Windows
- Better performance for file-heavy operations

### Installing WSL

**Quick Install (Windows 11 / Windows 10 2004+):**

```powershell
# Open PowerShell as Administrator
wsl --install

# This installs WSL 2 + Ubuntu by default
# Restart computer when prompted
```

**List Available Distributions:**

```powershell
# See all available distros
wsl --list --online

# Install specific distro
wsl --install -d Ubuntu-24.04
```

**Verify Installation:**

```bash
# Check WSL version
wsl --status

# List installed distros
wsl --list --verbose

# Should show:
# NAME            STATE           VERSION
# Ubuntu-24.04    Running         2
```

### Python Installation on WSL

WSL Ubuntu comes with Python pre-installed, but you should install additional versions and tools.

**Check Pre-installed Python:**

```bash
# System Python (usually Python 3.11 or 3.12)
python3 --version

# pip might not be installed
pip3 --version  # May fail
```

**Install pip and venv:**

```bash
# Update package list
sudo apt update

# Install pip and venv
sudo apt install python3-pip python3-venv -y

# Verify
pip3 --version
python3 -m venv --help
```

**Install Additional Python Versions:**

```bash
# Using deadsnakes PPA (Ubuntu)
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update

# Install Python 3.13
sudo apt install python3.13 python3.13-venv python3.13-dev -y

# Verify
python3.13 --version
```

**Alternative: Using pyenv (Recommended for Multiple Versions):**

```bash
# Install dependencies
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
libffi-dev liblzma-dev

# Install pyenv
curl https://pyenv.run | bash

# Add to ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Install Python version
pyenv install 3.13.0
pyenv local 3.13.0
```

### WSL File System

Understanding WSL file systems is critical for performance and compatibility.

**File System Structure:**

```bash
# Linux filesystem (fast, native)
/home/username/projects/          # Your Linux home (RECOMMENDED)

# Windows filesystem (slower, accessible from Windows)
/mnt/c/Users/Username/Documents/  # Windows C: drive
/mnt/d/                           # Windows D: drive
```

**Performance Comparison:**

| Location | Read/Write Speed | Use Case |
|----------|------------------|----------|
| `/home/username/` | **Fast** (native ext4) | Development, git repos |
| `/mnt/c/Users/` | **Slow** (9P protocol) | Sharing files with Windows |

**Best Practice:**

```bash
# Store projects in Linux filesystem
cd ~                          # Linux home directory
mkdir -p ~/projects/myapp
cd ~/projects/myapp

# Access from Windows:
# \\wsl$\Ubuntu\home\username\projects\myapp
# Or in File Explorer: \\wsl.
```

### Virtual Environments on WSL

WSL uses standard Linux virtual environment workflows.

**Creating Virtual Environments:**

```bash
# Navigate to project (in Linux filesystem!)
cd ~/projects/myproject

# Create venv with system Python
python3 -m venv venv

# Or with specific version (pyenv)
pyenv local 3.13.0
python -m venv venv

# Activate
source venv/bin/activate

# Verify activation
(venv) username@hostname:~/projects/myproject$
which python
# Output: /home/username/projects/myproject/venv/bin/python

# Install packages
pip install requests numpy pandas

# Freeze dependencies
pip freeze > requirements.txt

# Deactivate
deactivate
```

**Virtual Environment Structure:**

```javascript
myproject/
├── venv/                    # Virtual environment
│   ├── bin/                # Executables (Linux)
│   │   ├── python
│   │   ├── pip
│   │   └── activate       # Activation script
│   ├── lib/               # Isolated packages
│   │   └── python3.13/
│   │       └── site-packages/
│   └── pyvenv.cfg         # Configuration
├── src/                    # Your code
└── requirements.txt       # Dependencies
```

### WSL-Specific Best Practices

**1. Always Use Linux Filesystem for Development**

```bash
# GOOD: Fast performance
~/projects/myapp/

# BAD: 10x slower
/mnt/c/Users/Name/Projects/myapp/
```

**2. Access WSL Files from Windows**

```javascript
# In Windows File Explorer, navigate to:
\\wsl$\Ubuntu\home\username\projects

# Or (newer Windows):
\\wsl.
```

**3. Use WSL-Specific VS Code**

```bash
# Install VS Code on Windows with WSL extension

# From WSL terminal, open project:
cd ~/projects/myapp
code .

# This opens VS Code on Windows but connected to WSL
# All operations run in Linux environment
```

**4. Manage Packages with apt (Don't Use sudo pip)**

```bash
# GOOD: System packages via apt
sudo apt install python3-numpy python3-pandas

# GOOD: Project packages in venv
source venv/bin/activate
pip install requests

# BAD: Never do this
sudo pip install requests  # Breaks system Python!
```

**5. Set Up Git with SSH Keys**

```bash
# Generate SSH key in WSL
ssh-keygen -t ed25519 -C "your.email@example.com"

# Start SSH agent
eval "$(ssh-agent -s)"

# Add key
ssh-add ~/.ssh/id_ed25519

# Copy public key (add to GitHub)
cat ~/.ssh/id_ed25519.pub
```

### Integration with Windows Tools

**Run Windows Executables from WSL:**

```bash
# Open file in Windows default app
explorer.exe .

# Copy to Windows clipboard
echo "Hello" | clip.exe

# Run Windows Python (not recommended for dev)
/mnt/c/Python312/python.exe script.py
```

**Environment Variables:**

```bash
# View WSL PATH
echo $PATH

# WSL automatically appends Windows PATH
# Can access Windows executables like code.exe, git.exe

# Set environment variables in ~/.bashrc
echo 'export MY_VAR="value"' >> ~/.bashrc
source ~/.bashrc
```

### Common WSL Issues

**Issue 1: Slow Git Operations**

```bash
# Cause: Project in /mnt/c/ (Windows filesystem)
# Solution: Move to ~/projects/
mv /mnt/c/Projects/myapp ~/projects/
```

**Issue 2: Permission Denied Errors**

```bash
# Fix WSL file permissions
chmod +x script.sh
```

**Issue 3: Can't Access WSL from Windows**

```bash
# Ensure WSL is running
wsl --list --running

# Restart WSL
wsl --shutdown
wsl  # Restarts on next command
```

**Issue 4: Python Not Found After pyenv Install**

```bash
# Add to ~/.bashrc if missing
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

---

## 🔗 Learning Resources

### Official Documentation

- [WSL Documentation](https://learn.microsoft.com/en-us/windows/wsl/) - Official Microsoft WSL guide
- [WSL Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install) - Setup instructions
- [Python on Linux (Ubuntu)](https://docs.python.org/3/using/unix.html) - Python on Unix systems
- [venv Documentation](https://docs.python.org/3/library/venv.html) - Virtual environment module

### WSL Setup & Configuration

- [WSL 2 Best Practices](https://learn.microsoft.com/en-us/windows/wsl/compare-versions) - WSL 1 vs WSL 2
- [File System Performance](https://learn.microsoft.com/en-us/windows/wsl/filesystems) - Understanding WSL filesystems
- [VS Code + WSL](https://code.visualstudio.com/docs/remote/wsl) - VS Code Remote WSL extension

### Python Version Management

- [pyenv GitHub](https://github.com/pyenv/pyenv) - Python version manager
- [deadsnakes PPA](https://launchpad.net/~deadsnakes/+archive/ubuntu/ppa) - Ubuntu Python versions
- [Python Build Dependencies](https://github.com/pyenv/pyenv/wiki#suggested-build-environment) - Required packages

### Best Practices

- [Real Python: WSL Setup](https://realpython.com/python-coding-setup-windows/#using-the-windows-subsystem-for-linux-wsl) - WSL Python development
- [Python Packaging Guide](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/) - Virtual environments and pip

### Tools & Utilities

- [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) - Modern terminal with WSL integration
- [WSL Utilities](https://github.com/wslutilities/wslu) - Helpful WSL tools
- [Docker Desktop for WSL 2](https://docs.docker.com/desktop/wsl/) - Container development

### Troubleshooting

- [WSL Troubleshooting](https://learn.microsoft.com/en-us/windows/wsl/troubleshooting) - Common issues and fixes
- [Stack Overflow: WSL](https://stackoverflow.com/questions/tagged/wsl) - Community Q&A

---

## ✅ Learning Checklist

### WSL Installation & Setup

- [ ] Install WSL 2: `wsl --install` (PowerShell as Admin)
- [ ] Restart computer after installation
- [ ] Verify WSL version: `wsl --status` shows WSL 2
- [ ] Launch Ubuntu (or your chosen distro) from Start Menu
- [ ] Create Linux username and password
- [ ] Update packages: `sudo apt update && sudo apt upgrade -y`

### Python Installation

- [ ] Check system Python: `python3 --version`
- [ ] Install pip and venv: `sudo apt install python3-pip python3-venv -y`
- [ ] Verify pip: `pip3 --version`
- [ ] (Optional) Install pyenv for multiple Python versions
- [ ] (Optional) Install Python 3.13: `sudo apt install python3.13 python3.13-venv -y`
- [ ] Understand difference between apt Python and pyenv Python

### File System Understanding

- [ ] Navigate to Linux home: `cd ~`
- [ ] Create projects directory: `mkdir -p ~/projects`
- [ ] Access Windows files: `cd /mnt/c/Users/YourName/`
- [ ] Access WSL files from Windows: `\\wsl$\Ubuntu\home\username` in File Explorer
- [ ] Understand performance difference: Linux FS (fast) vs Windows FS (slow)
- [ ] Store all development projects in `~/projects/` for best performance

### Virtual Environments

- [ ] Create project directory in Linux FS: `mkdir ~/projects/test-project`
- [ ] Create virtual environment: `python3 -m venv venv`
- [ ] Activate venv: `source venv/bin/activate`
- [ ] Verify activation: prompt shows `(venv)` and `which python` points to venv
- [ ] Install a package: `pip install requests`
- [ ] Verify package location: `pip show requests` (should be in venv)
- [ ] Create requirements.txt: `pip freeze > requirements.txt`
- [ ] Deactivate: `deactivate`
- [ ] Recreate environment from requirements: `pip install -r requirements.txt`

### WSL-Windows Integration

- [ ] Install VS Code on Windows with Remote WSL extension
- [ ] Open WSL project in VS Code: `code .` from WSL terminal
- [ ] Verify VS Code shows "WSL: Ubuntu" in bottom-left corner
- [ ] Open Windows File Explorer from WSL: `explorer.exe .`
- [ ] Copy text to Windows clipboard: `echo "test" | clip.exe`
- [ ] Pin WSL projects folder to Quick Access in Windows

### Git Configuration

- [ ] Install git: `sudo apt install git -y`
- [ ] Configure git: `git config --global user.name "Your Name"`
- [ ] Configure email: `git config --global user.email "you@example.com"`
- [ ] Generate SSH key: `ssh-keygen -t ed25519 -C "you@example.com"`
- [ ] Start SSH agent and add key
- [ ] Add public key to GitHub/GitLab

### Best Practices

- [ ] Always develop in Linux filesystem (`~/projects/`), never in `/mnt/c/`
- [ ] Never use `sudo pip install` (use venv instead)
- [ ] Use `apt` for system packages, `pip` in venv for project packages
- [ ] Keep WSL updated: `sudo apt update && sudo apt upgrade`
- [ ] Use Windows Terminal for better WSL experience

### Troubleshooting

- [ ] Know how to restart WSL: `wsl --shutdown` (from PowerShell)
- [ ] Fix permission issues with `chmod`
- [ ] Check which Python/pip is active: `which python` and `which pip`
- [ ] Verify venv activation before installing packages

### Validation

- [ ] **Test**: Create new project in `~/projects/`, create venv, activate it, install requests, write script that imports requests, run successfully
- [ ] **Test**: Open same project in VS Code from WSL, verify Python interpreter is from venv
- [ ] **Test**: Access project files from Windows File Explorer using `\\wsl$\Ubuntu\`
- [ ] **Test**: Clone a GitHub repo, create venv, install dependencies, run code

---

*Last updated: 2025-11-04*
