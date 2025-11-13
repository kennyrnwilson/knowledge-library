# 🚀 Complete Modern Python Project Tutorial: Calculator Package

A comprehensive, hands-on tutorial that walks through building a professional Python package from scratch, testing, packaging, setting up CI/CD, and publishing to PyPI. This tutorial demonstrates the complete modern Python development workflow.

**← Back to**: [Modern Python Project Setup (2025)](./modern-project-setup.md) | [Python Fundamentals](./README.md)

---

## 📚 Tutorial Overview

This tutorial is organized into **4 focused guides** that build upon each other:

### [Part 1-3: Project Setup and Package Basics](./01-project-setup-and-basics.md)
**Learn project structure, configuration, and writing your first package code**

- Modern project setup with src-layout and pyproject.toml
- Environment management with pyenv and virtual environments
- Building a professional package with proper code organization
- Understanding Python packages vs modules
- Creating the calculator core and CLI
- Verifying your calculator works from the command line

**Duration:** ~1-2 hours | **Difficulty:** Beginner

---

### [Part 4-5: Testing and Code Quality](./02-testing-and-code-quality.md)
**Write comprehensive tests and set up professional code quality tools**

- Writing comprehensive tests with pytest (13+ tests)
- Unit testing the calculator core
- CLI testing using subprocess
- Setting up code quality tools (ruff, mypy, pre-commit)
- Understanding git hooks vs pre-commit framework
- Running quality checks manually
- Test coverage measurement

**Duration:** ~1-2 hours | **Difficulty:** Beginner

---

### [Part 4.5-6: Version Control, CI/CD, and Building](./03-version-control-and-ci.md)
**Put your code on GitHub and automate testing with CI/CD**

- Git version control basics
- Create GitHub repository and push code
- GitHub Actions CI/CD setup
- Testing across multiple Python versions automatically
- Building wheel and source distributions
- Inspecting package contents
- Publishing to Test PyPI and production PyPI
- Comprehensive troubleshooting for common errors

**Duration:** ~1-2 hours | **Difficulty:** Intermediate

---

### [Part 9-10: Maintenance and Best Practices](./04-publishing-and-maintenance.md)
**Professional package maintenance and release workflows**

- Complete development workflow for daily coding
- Release workflow with version bumping
- Semantic versioning (MAJOR.MINOR.PATCH)
- Dependency management
- Creating GitHub releases
- Monitoring package health
- Installing and using your published package

**Duration:** ~30 minutes | **Difficulty:** Intermediate

---

## 🎯 What You'll Build

**A professional command-line calculator package** that demonstrates:

- Modern Python package structure (src-layout)
- Professional configuration (pyproject.toml with PEP 621)
- Comprehensive testing (pytest with coverage)
- Code quality tools (ruff, mypy, pre-commit)
- Continuous integration (GitHub Actions)
- Professional distribution (wheel + source distributions)
- Public publishing (PyPI)
- Version control (Git + GitHub)

### Final Project Structure

```
simple-calculator/
├── .github/
│   └── workflows/
│       └── tests.yml                 # CI/CD pipeline
├── src/
│   └── simple_calculator/
│       ├── __init__.py
│       ├── _version.py               # Version management
│       ├── core.py                   # Calculator logic
│       └── cli.py                    # Command-line interface
├── tests/
│   ├── __init__.py
│   ├── test_core.py                  # Unit tests
│   └── test_cli.py                   # CLI tests
├── pyproject.toml                    # Modern project config
├── .gitignore                        # Git ignore rules
├── .pre-commit-config.yaml           # Code quality hooks
├── README.md                         # Project documentation
├── LICENSE                           # MIT License
└── .github/
    └── workflows/
        └── tests.yml                 # Automated testing
```

---

## 📋 Prerequisites

- Linux/WSL environment with Python 3.11+
- Git installed and configured
- GitHub account (for hosting code)
- PyPI account (for publishing)
- Basic command-line knowledge
- ~4-6 hours total time

---

## 🚀 Getting Started

Choose your preferred learning approach:

### 💻 VS Code-Focused Path (Recommended for most learners)

**[VS Code Project Workflow: Build a Calculator](./vs-code-project-workflow.md)** - **~3.5 hours**

This guide teaches the exact same calculator project but **entirely within VS Code** with emphasis on:
- Virtual environment integration at every step
- Debugging throughout development
- VS Code extensions (Pylance, Ruff, pytest)
- Integrated testing with Test Explorer
- Git integration via Source Control panel

**Best for:**
- VS Code users (most developers)
- Those wanting to master IDE-based development
- Learning debugging hands-on
- Understanding venv integration in IDE context

---

### 📚 Command-Line First Path

Each guide builds on the previous one. **Start with Part 1-3:**

1. **[Part 1-3: Project Setup](./01-project-setup-and-basics.md)** - 1-2 hours
   - Create project structure
   - Write calculator code
   - Verify it works locally

2. **[Part 4-5: Testing & Quality](./02-testing-and-code-quality.md)** - 1-2 hours
   - Write comprehensive tests
   - Set up code quality tools
   - Verify tests pass

3. **[Part 4.5-6: CI/CD & Publishing](./03-version-control-and-ci.md)** - 1-2 hours
   - Push to GitHub
   - Set up GitHub Actions
   - Publish to PyPI

4. **[Part 9-10: Maintenance](./04-publishing-and-maintenance.md)** - 30 minutes
   - Learn release workflow
   - Create GitHub releases
   - Manage versions

**Total: ~4-6 hours** of hands-on learning

**Best for:**
- Understanding the full CI/CD pipeline
- Professional package publishing
- Multi-version testing with GitHub Actions
- Comprehensive packaging knowledge

---

## 🎓 What You'll Learn

### Python Development Fundamentals
- ✅ Modern Python project structure (src-layout)
- ✅ PEP 621 project configuration (pyproject.toml)
- ✅ Package structure and imports
- ✅ Entry points and CLI creation
- ✅ Type hints and static analysis
- ✅ Code documentation

### Testing & Quality
- ✅ Unit testing with pytest
- ✅ CLI testing with subprocess
- ✅ Code coverage measurement
- ✅ Linting with ruff
- ✅ Type checking with mypy
- ✅ Pre-commit hooks for automation

### Professional Development
- ✅ Version control with Git
- ✅ Remote repository management (GitHub)
- ✅ Continuous integration (GitHub Actions)
- ✅ Testing across Python versions
- ✅ Professional package distribution
- ✅ Publishing to PyPI

### Release Management
- ✅ Semantic versioning
- ✅ Release workflows
- ✅ Dependency management
- ✅ Creating GitHub releases
- ✅ Long-term package maintenance

---

## 🎯 Key Learning Outcomes

By completing this tutorial, you will:

1. **Understand modern Python packaging** - Know how to structure professional Python projects
2. **Master pytest and testing** - Write comprehensive test suites with good coverage
3. **Use professional tools** - Know ruff, mypy, pre-commit, and GitHub Actions
4. **Publish to PyPI** - Get your code in front of the Python community
5. **Manage versions professionally** - Use semantic versioning and proper releases
6. **Work with CI/CD** - Automate testing and quality checks
7. **Maintain code quality** - Use linting, type checking, and pre-commit hooks
8. **Collaborate professionally** - Use Git and GitHub properly

---

## 📚 Complete Table of Contents

### Part 1: Project Initialization
- Create project directory and initialize Git
- Set up Python environment with pyenv
- Create virtual environment
- Create project structure

### Part 2: Project Configuration
- Create pyproject.toml (modern PEP 621 config)
- Create version file
- Create README.md
- Create .gitignore
- Create LICENSE
- Install development dependencies

### Part 3: Write Package Code
- Create calculator core with type hints
- Create CLI interface
- Create package __init__.py
- Test locally from command line

### Part 4: Write Comprehensive Tests
- Write unit tests for calculator core
- Write CLI tests using subprocess
- Achieve >80% code coverage
- Handle error cases

### 🧪 Checkpoint: Run All Tests
- Verify all 13+ tests pass
- Check code coverage
- Troubleshoot test failures

### Part 4.5: Initialize Git and GitHub
- Initialize local Git repository
- Create GitHub repository
- Push code to GitHub
- Set up version control

### Part 5: Code Quality Tools
- Understand git hooks vs pre-commit framework
- Create .pre-commit-config.yaml
- Install pre-commit hooks
- Run quality checks manually

### Part 6: GitHub CI/CD Setup
- Create GitHub Actions workflow
- Test across multiple Python versions
- Automate linting and type checking
- Upload coverage reports

### Part 7: Build and Package
- Install build tools
- Create wheel and source distributions
- Inspect package contents
- Troubleshoot build errors

### Part 8: Publishing to PyPI
- Create PyPI account
- Generate API tokens
- Create .pypirc configuration
- Upload to Test PyPI first
- Publish to production PyPI
- Verify installation from PyPI

### Part 9: Complete Development Workflow
- Daily development cycle
- Release workflow
- Version bumping
- Creating releases

### Part 10: Maintenance and Best Practices
- Semantic versioning
- Updating dependencies
- Creating GitHub releases
- Monitoring package health

---

## 🔗 All Guides

### 💻 IDE-Focused (Recommended)
- **[VS Code Project Workflow](./vs-code-project-workflow.md)** - Build calculator entirely in VS Code with debugging

### 📚 Modular Command-Line Guides
- **[Part 1-3: Project Setup and Basics](./01-project-setup-and-basics.md)** - Start here!
- **[Part 4-5: Testing and Code Quality](./02-testing-and-code-quality.md)** - After setup
- **[Part 4.5-6: Version Control, CI/CD, and Building](./03-version-control-and-ci.md)** - After testing
- **[Part 9-10: Maintenance and Best Practices](./04-publishing-and-maintenance.md)** - After publishing

### 🎓 Supporting Guides
- **[VS Code Python Development Guide](./vs-code-python-development.md)** - Deep dive on VS Code features and debugging

---

## 💡 Tips for Success

1. **Follow in order** - Each part builds on previous knowledge
2. **Type along** - Don't just read, actually create the files and run the commands
3. **Test as you go** - Run the milestone checks and checkpoints
4. **Google errors** - Real development means troubleshooting; use the solutions provided
5. **Customize** - After completing, modify the calculator to add your own features

---

## 🆘 Getting Help

If you encounter issues:

1. **Check the troubleshooting sections** - Each part has common problems and solutions
2. **Read error messages carefully** - They usually tell you what's wrong
3. **Verify prerequisites** - Make sure Python, Git, and all tools are installed
4. **Check file paths** - Many errors come from running commands in the wrong directory
5. **Reference the complete guides** - Each part has detailed explanations

---

## 📖 Additional Resources

### Official Documentation
- [Python Packaging User Guide](https://packaging.python.org/)
- [PEP 621 - pyproject.toml](https://peps.python.org/pep-0621/)
- [pytest Documentation](https://docs.pytest.org/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [mypy Documentation](https://mypy.readthedocs.io/)
- [GitHub Actions Docs](https://docs.github.com/en/actions)

### Tools
- [PyPI](https://pypi.org/) - Python Package Index
- [TestPyPI](https://test.pypi.org/) - Test repository
- [GitHub](https://github.com/) - Code hosting
- [twine](https://twine.readthedocs.io/) - PyPI upload tool

---

## 📝 Next Steps After This Tutorial

Once you complete this tutorial, you can:

1. **Expand the calculator** - Add new operations (power, square root, etc.)
2. **Build a web interface** - Create a Flask or FastAPI web app
3. **Write more documentation** - Generate HTML docs with Sphinx
4. **Add plugins** - Create an extensible plugin system
5. **Optimize performance** - Profile and optimize the code
6. **Add configuration files** - Support YAML/JSON configuration
7. **Write a CLI guide** - Create a more sophisticated command-line tool
8. **Build a community** - Open source your project and accept contributions

---

*Last updated: 2025-11-12*

**← Back to**: [Python Fundamentals](./README.md)
