# Claude Code Setup: Automated Python Project Setup

Comprehensive guide to setting up Claude Code to automatically create professional Python projects.

> **Based on:** [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md)

---

## 📚 Guide Contents

### 1. [Quick Start Guide](./01-quick-start.md) ⭐ START HERE
- 3-minute installation for your operating system
- Testing checklist
- Common requests to try
- **Best for:** Users who want to install and use immediately

### 2. [Instructions File](./02-instructions.md)
- The actual Claude Code global instructions
- Copy this file to your Claude Code instructions directory
- Contains complete Python project setup process
- **For:** Reference and installation
- **Install to:**
  - Windows: `%APPDATA%\Claude\instructions\python-project-setup.md`
  - macOS/Linux/WSL: `~/.config/Claude/instructions/python-project-setup.md`

### 3. [Detailed Setup Guide](./03-detailed-setup-guide.md)
- Step-by-step installation for each operating system
- Verification and testing procedures
- Troubleshooting common issues
- FAQ and keeping instructions updated
- **Best for:** Users needing detailed help or guidance

---

## 🎯 What This Enables

Once installed, you can ask Claude Code:

```
Create a new Python project called "my-project" at ~/projects
```

Claude Code will automatically:
- ✅ Create directory structure (src/, tests/, docs/)
- ✅ Initialize git repository
- ✅ Create virtual environment
- ✅ Generate pyproject.toml
- ✅ Generate .vscode/settings.json (OS-specific)
- ✅ Generate .vscode/launch.json with debug configs
- ✅ Install pytest, ruff, dev dependencies
- ✅ Create initial test file
- ✅ Verify everything works

**Zero manual setup required.**

---

## 🚀 Quick Start (3 Minutes)

1. **Read:** [Quick Start Guide](./01-quick-start.md)
2. **Copy:** `02-instructions.md` to your Claude Code instructions folder
3. **Restart:** Claude Code
4. **Done!** Ask Claude Code to create a Python project

---

## 📁 Integration with Knowledge Library

These guides are part of the professional development resources:

```
04-guidance/professional/
├── ai-engineering-roadmap/
│   └── stage-1-foundational-skills/python-fundamentals/
│       ├── vs-code-python-development.md (← Source material)
│       └── README.md (← Links to this guide)
│
└── programming-language/python/
    └── claude-code-setup/ (← You are here)
        ├── README.md (this file)
        ├── 01-quick-start.md
        ├── 02-instructions.md
        └── 03-detailed-setup-guide.md
```

---

## 🔗 Related Resources

- [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md) - Comprehensive guide to VS Code setup, debugging, and testing
- [Python Fundamentals](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/README.md) - Complete Python learning path
- [AI Engineering Roadmap](../../../ai-engineering-roadmap/README.md) - Full learning roadmap

---

## 📖 How to Use This Guide

### For Quick Installation
1. Open [Quick Start Guide](./01-quick-start.md)
2. Find your operating system section
3. Follow the 2-3 step installation
4. Restart Claude Code

### For Detailed Help
1. Open [Detailed Setup Guide](./03-detailed-setup-guide.md)
2. Find your OS-specific section
3. Follow step-by-step instructions
4. Use verification checklist
5. Troubleshoot using FAQ section

### For Understanding the System
1. Read [Quick Start Guide](./01-quick-start.md) overview
2. Skim [Instructions File](./02-instructions.md) to see what Claude Code will do
3. Reference [Detailed Setup Guide](./03-detailed-setup-guide.md) as needed

---

## ✨ Key Features

✅ **Platform-Aware**
- Automatically detects Windows/WSL/macOS/Linux
- Creates correct virtual environment paths
- Uses appropriate activation scripts

✅ **Professional Standards**
- Modern pyproject.toml (PEP 621)
- Ruff linting and formatting
- pytest with coverage
- VS Code debugging setup

✅ **VS Code Integration**
- Complete debugging configuration
- Test discovery and running
- Auto-linting and formatting on save
- Type checking with Pylance

✅ **Ready to Use**
- Virtual environment already created
- All dependencies installed
- Initial tests passing
- Start coding immediately

✅ **Fully Customizable**
- Edit templates to match your style
- Add company-specific dependencies
- Customize project structure
- Share custom version with team

---

## 🔄 Keeping Instructions Updated

### Manual Update
Periodically copy the latest `02-instructions.md` to your Claude Code instructions folder.

### Symbolic Link (Recommended)
Create a symlink so it updates automatically:

**macOS/Linux/WSL:**
```bash
mkdir -p ~/.config/Claude/instructions
rm ~/.config/Claude/instructions/python-project-setup.md 2>/dev/null
ln -s ~/path/to/knowledge-library/04-guidance/professional/programming-language/python/claude-code-setup/02-instructions.md \
   ~/.config/Claude/instructions/python-project-setup.md
```

Now updates to the repository automatically update Claude Code's instructions.

---

## ❓ FAQ

**Q: Do I need to install this?**
A: No, but it saves ~10 minutes per project. Highly recommended.

**Q: Can I customize it?**
A: Yes, edit `02-instructions.md` before installing.

**Q: Does it work with existing projects?**
A: Yes, Claude Code can set up existing projects.

**Q: Can I share with my team?**
A: Yes, share the files and each member installs in their instructions folder.

**Q: What if I don't like it?**
A: Delete from instructions folder. Claude Code goes back to normal.

**Q: Does this replace my system Python?**
A: No, it just creates a virtual environment per project.

---

## 🎓 Learning Value

This guide provides:

1. **Automation** - Save time on repetitive setup
2. **Best Practices** - Professional Python project structure
3. **Learning** - Understand what goes into a proper setup
4. **Reference** - Keep for future project creation

The underlying setup principles come from the [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md).

---

## 📋 Files in This Guide

| File | Size | Purpose |
|------|------|---------|
| 01-quick-start.md | ~8 KB | Quick installation guide |
| 02-instructions.md | ~40 KB | Claude Code instructions (install this) |
| 03-detailed-setup-guide.md | ~30 KB | Detailed setup with troubleshooting |
| README.md | This file | Overview and navigation |

---

## 🚀 Next Steps

1. **Install** - Follow [Quick Start Guide](./01-quick-start.md)
2. **Test** - Create a test project and verify
3. **Use** - Create new projects with Claude Code
4. **Customize** - Edit instructions if needed
5. **Share** - Distribute to your team

---

**Version:** 1.0
**Last Updated:** 2025-11-16
**Status:** ✅ Production Ready

**← Back to:** [Professional Development Resources](../)
