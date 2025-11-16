# Claude Code Instructions Reference

This document explains the Claude Code setup for professional Python project creation.

## Quick Setup

1. **Copy the CLAUDE.md file** from this directory
2. **Save to your Claude Code config:**
   - Windows: `C:\Users\YourName\.claude\CLAUDE.md`
   - macOS/Linux/WSL: `~/.claude/CLAUDE.md`
3. **Restart Claude Code**

For detailed installation instructions, see [01-quick-start.md](./01-quick-start.md)

## What CLAUDE.md Does

The `CLAUDE.md` file is Claude Code's configuration mechanism for custom instructions. When you save it to `~/.claude/CLAUDE.md`, Claude Code automatically loads these instructions for all Python projects.

**Official Documentation:** [Anthropic Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### How It Works

CLAUDE.md uses Claude Code's import feature to modularly load additional instructions:

```markdown
@python-project-setup.md
```

This imports the `python-project-setup.md` file, which contains all the professional Python setup instructions.

## File Structure

- **CLAUDE.md** - The main Claude Code configuration file (what you copy to `~/.claude/`)
- **python-project-setup.md** - The imported file containing all Python setup instructions
- **01-quick-start.md** - Installation guide for your operating system
- **03-detailed-setup-guide.md** - Detailed help and troubleshooting

## What Claude Code Will Do

Once installed, when you ask Claude Code to create a Python project:

```
Create a new Python project called "my-project" at ~/projects
```

Claude Code will automatically:

- ✅ Create project directories (src/, tests/, docs/)
- ✅ Initialize git repository
- ✅ Create virtual environment
- ✅ Generate pyproject.toml with proper configuration
- ✅ Generate .vscode/settings.json (configured for your OS)
- ✅ Generate .vscode/launch.json with debug configurations
- ✅ Install pytest, ruff, and development tools
- ✅ Create initial test files
- ✅ Verify everything works

## Python Setup Instructions Overview

The `python-project-setup.md` file contains comprehensive instructions for:

### Core Setup Principles
- Virtual environment isolation at `./venv`
- Professional project structure with src/, tests/, docs/
- pyproject.toml for configuration (PEP 621 standard)
- Git initialization with .gitignore
- VS Code integration
- Code quality tools (ruff, pytest)
- Debugging configuration

### Configuration Templates
- **pyproject.toml** - Project metadata, dependencies, tool configuration
- **.gitignore** - Python, IDE, and OS-specific ignores
- **.vscode/settings.json** - Separate templates for Windows and Unix systems
- **.vscode/launch.json** - Debug and pytest configurations

### Setup Process (9 Steps)
1. Gather information (name, location, OS, Python version)
2. Create project structure
3. Create configuration files
4. Create VS Code configuration
5. Create virtual environment
6. Install dependencies
7. Create initial package files
8. Create initial test
9. Verify installation

### Platform-Specific Handling
- **Windows PowerShell** - venv\Scripts\ paths, .ps1 activation
- **WSL** - venv/bin/ paths, bash activation
- **macOS** - Homebrew Python, venv/bin/ paths

### Verification Checklist
Complete checklist ensuring:
- Virtual environment created
- Configuration files correct
- Git initialized
- Packages installed
- VS Code properly configured
- Tests pass
- Linting and formatting work

### Common Issues and Solutions
- ModuleNotFoundError (interpreter selection)
- Tests won't run (missing pytest or venv)
- Ruff linting not working (missing ruff)
- venv not activating (terminal profile)

### Customization Examples
- Adding project dependencies
- Changing Python version target
- Adding test coverage

## Usage Examples

### Example 1: Create a new project
```
User: Create a new Python project called "data-analyzer" at ~/projects
Claude Code will:
- Create ~/projects/data-analyzer/
- Set up complete project structure
- Configure for your OS
- Install all tools
```

### Example 2: Add dependencies
```
User: Add requests and pandas to the project
Claude Code will:
- Update pyproject.toml
- Install the packages
```

### Example 3: Change Python version
```
User: Use Python 3.12 instead
Claude Code will:
- Update pyproject.toml
- Help recreate venv with correct version
```

## Integration with VS Code

The setup creates complete VS Code integration:

- **Python Interpreter:** Configured to use venv interpreter
- **Linting:** Ruff configured with proper settings
- **Formatting:** Auto-format on save
- **Testing:** pytest with test discovery
- **Debugging:** F5 to debug, breakpoints work
- **Terminal:** Auto-activates venv on new terminal

## Related Documentation

- [Quick Start Guide](./01-quick-start.md) - Installation for your OS
- [Detailed Setup Guide](./03-detailed-setup-guide.md) - Comprehensive help
- [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md) - Manual setup reference
- [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices) - Official Claude Code documentation

## Source

Based on professional Python development practices as documented in the [VS Code Python Development Guide](../../../ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/vs-code-python-development.md).

---

**Version:** 2.0 (Modular with imports)

**Last Updated:** 2025-11-16

**Status:** Production Ready



> **Note:** The detailed setup instructions are now in [python-project-setup.md](./python-project-setup.md), which is imported by CLAUDE.md using Claude Code's import feature (`@python-project-setup.md`). See that file for complete setup details including templates, step-by-step instructions, platform considerations, troubleshooting, and customization examples.
