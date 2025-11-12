# 📦 Part 9-10: Maintenance, Releases, and Best Practices

Learn professional package maintenance workflows, manage versions with semantic versioning, and create releases on GitHub. This section covers everything after your initial publication.

**← Back to**: [Complete Tutorial Index](./complete-modern-project-tutorial.md) | [Version Control & CI/CD](./03-version-control-and-ci.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn in This Section

- **Complete development workflow** - Daily development practices
- **Release workflow** - Version bumping and publishing
- **Semantic versioning** - Understanding MAJOR.MINOR.PATCH
- **Dependency management** - Keeping packages updated
- **GitHub releases** - Creating proper releases with notes
- **Package health monitoring** - Ensuring installations work correctly

---

## Part 9: Complete Development Workflow

### Regular Development Cycle

```bash
# 1. Make changes to code
nano src/simple_calculator/core.py

# 2. Run tests
pytest

# 3. Check code quality (pre-commit will do this)
ruff check . --fix
mypy .

# 4. Commit changes
git add .
git commit -m "Add new feature"

# 5. Push to GitHub (CI/CD runs automatically)
git push origin main
```

### Release Workflow

```bash
# 1. Update version
nano src/simple_calculator/_version.py
# Change: __version__ = "0.2.0"

# 2. Update README if needed
nano README.md

# 3. Run full test suite
pytest --cov

# 4. Commit version bump
git add -A
git commit -m "Bump version to 0.2.0"
git tag v0.2.0

# 5. Push and create release
git push origin main
git push origin v0.2.0

# 6. Build distributions
python -m build

# 7. Upload to PyPI
twine upload dist/*

# 8. Verify on PyPI
pip install --upgrade simple-calculator
calc "5 + 3"
```

---

## Part 10: Maintenance and Best Practices

### Semantic Versioning

```
MAJOR.MINOR.PATCH
  0.1.0

- MAJOR: Breaking changes
- MINOR: New features, backwards compatible
- PATCH: Bug fixes, no new features
```

### Update Dependencies

```bash
# Check for outdated packages
pip list --outdated

# Update a package
pip install --upgrade requests

# Update all
pip install --upgrade pip setuptools wheel

# Freeze current state
pip freeze > requirements.txt
```

### Create GitHub Release

After tagging:

1. Go to https://github.com/yourusername/simple-calculator/releases
2. Click "Draft a new release"
3. Select tag (e.g., v0.2.0)
4. Add release notes
5. Publish release

### Monitor Package Health

```bash
# Test installation in clean environment
cd /tmp
python -m venv clean_test
source clean_test/bin/activate
pip install simple-calculator
python -c "from simple_calculator import Calculator; print(Calculator.add(1, 2))"
```

---

## Usage

Now that you've built, tested, and deployed your calculator package, here's how to use it:

### Command Line Usage

After installing the package (either locally or from PyPI), use the `calc` command with the format: `calc Operation num1 num2`

```bash
# Basic arithmetic operations
calc Add 2 6
calc Subtract 20 8
calc Multiply 5 4
calc Divide 20 4

# Decimal numbers
calc Add 3.5 2.5
calc Divide 10.5 2

# Negative numbers
calc Add -10 5
calc Multiply -3 -4
```

### Python Code Usage

Import the Calculator class in your own Python code:

```python
from simple_calculator import Calculator

# Use static methods
result = Calculator.add(10, 5)
print(result)  # Output: 15

result = Calculator.subtract(20, 8)
print(result)  # Output: 12

result = Calculator.multiply(4, 3)
print(result)  # Output: 12

result = Calculator.divide(20, 4)
print(result)  # Output: 5.0

# Error handling
try:
    Calculator.divide(10, 0)
except ValueError as e:
    print(f"Error: {e}")  # Output: Error: Cannot divide by zero
```

### Installation

If you're using your locally developed version:

```bash
# Development installation (with editable mode)
pip install -e ".[dev]"

# Then use the calc command
calc Add 5 3
calc Multiply 10 2
```

If you published to PyPI and want to install from there:

```bash
# Install from PyPI
pip install simple-calculator

# Use the calc command
calc Add 5 3
calc Divide 20 4

# Check version
python -c "import simple_calculator; print(simple_calculator.__version__)"
```

---

## ✅ Learning Checklist

### Project Setup
- [ ] Create project directory and initialize git
- [ ] Set up pyenv with correct Python version
- [ ] Create virtual environment
- [ ] Create modern project structure (src-layout)

### Configuration
- [ ] Create pyproject.toml with all sections
- [ ] Create version file (_version.py)
- [ ] Create README.md with complete documentation
- [ ] Create LICENSE file
- [ ] Create .gitignore with Python patterns

### Code Development
- [ ] Write calculator core with type hints
- [ ] Write CLI interface
- [ ] Write package __init__.py
- [ ] Create comprehensive tests
- [ ] Achieve >80% code coverage

### Quality Assurance & Debugging
- [ ] Install development tools (pytest, ruff, mypy)
- [ ] Set up pre-commit hooks
- [ ] Run linting and fix issues
- [ ] Run type checking
- [ ] Run tests and verify coverage
- [ ] Understand print debugging
- [ ] Use breakpoint() for interactive debugging
- [ ] Debug tests with pytest --pdb
- [ ] Use logging for production debugging
- [ ] Test command-line debugging approaches

### CI/CD
- [ ] Create .github/workflows/tests.yml
- [ ] Push to GitHub repository
- [ ] Verify GitHub Actions runs successfully
- [ ] Check that CI/CD passes for all Python versions

### Packaging
- [ ] Install build tools
- [ ] Build wheel and source distributions
- [ ] Verify package contents
- [ ] Test local installation

### Publishing
- [ ] Create PyPI account
- [ ] Create and secure API token
- [ ] Configure .pypirc
- [ ] Test upload to TestPyPI
- [ ] Upload to production PyPI
- [ ] Verify package on PyPI
- [ ] Install and test from PyPI

### Maintenance
- [ ] Understand semantic versioning
- [ ] Practice release workflow
- [ ] Create GitHub releases
- [ ] Monitor package health
- [ ] Keep dependencies updated

---

## 🔗 Learning Resources

### Official Documentation

- [Python Packaging User Guide](https://packaging.python.org/)
- [PEP 621 - pyproject.toml](https://peps.python.org/pep-0621/)
- [PEP 517 - Build Backend](https://peps.python.org/pep-0517/)
- [pytest Documentation](https://docs.pytest.org/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [mypy Documentation](https://mypy.readthedocs.io/)
- [Python pdb Debugger](https://docs.python.org/3/library/pdb.html) - Interactive debugger
- [Python logging Module](https://docs.python.org/3/library/logging.html) - Logging framework

### Tools and Services

- [PyPI](https://pypi.org/) - Python Package Index
- [TestPyPI](https://test.pypi.org/) - Test repository
- [GitHub Actions](https://github.com/features/actions) - CI/CD
- [twine](https://twine.readthedocs.io/) - Upload packages

### Related Guides

- [Modern Python Project Setup (2025)](./modern-project-setup.md)
- [Modern Python Dependency Management](./dependency-management.md)
- [WSL Installation](./wsl-installation.md)
- [pyenv Guide](./pyenv-guide.md)

---

## Common Issues and Solutions

### Issue: "ModuleNotFoundError" when importing package

**Solution:** Make sure you're in venv and installed with `pip install -e ".[dev]"`

```bash
source venv/bin/activate
pip install -e ".[dev]"
```

### Issue: Tests fail with import errors

**Solution:** Verify pythonpath is set in pyproject.toml:

```toml
[tool.pytest.ini_options]
pythonpath = ["src"]
testpaths = ["tests"]
```

### Issue: PyPI upload fails with "403 Forbidden"

**Solution:** Check .pypirc permissions and ensure token is valid:

```bash
chmod 600 ~/.pypirc
# Check token hasn't expired on PyPI
```

### Issue: GitHub Actions fails on Python 3.13

**Solution:** Ensure Python 3.13 is available and compatible:

```yaml
python-version: ["3.11", "3.12", "3.13"]
```

---

## Next Steps

1. **Expand the calculator** - Add more operations (power, modulo, square root)
2. **Add configuration** - Support for configuration files
3. **Documentation** - Generate HTML docs with Sphinx
4. **Plugins** - Create a plugin system for custom operations
5. **Web UI** - Create a web interface with Flask or FastAPI

---



*Last updated: 2025-11-12*

---

## Summary

Congratulations! You've successfully completed this comprehensive Python project tutorial. You now have:

✅ **A professional Python package** - Properly structured with src-layout  
✅ **Comprehensive tests** - 13+ tests with >80% coverage  
✅ **Code quality tools** - Ruff, mypy, pre-commit all configured  
✅ **Automated CI/CD** - GitHub Actions testing on every push  
✅ **Published package** - Available on PyPI  
✅ **Version control** - Code hosted on GitHub with full history  
✅ **Release workflow** - Semantic versioning and GitHub releases  

### Your Package is Now:

- 🔒 Version controlled on GitHub
- ✅ Automatically tested on Python 3.11, 3.12, and 3.13
- 🔍 Type-checked with mypy
- 📊 Linted and formatted with ruff
- 📦 Installable from PyPI
- 📚 Documented with comprehensive README
- 🎯 Ready for real-world use

### Continue Learning

- Expand the calculator with more operations
- Add more comprehensive documentation with Sphinx
- Implement logging for production debugging
- Create web interface with Flask or FastAPI
- Build plugins system for extensibility

---

## Related Guides

- **[Complete Tutorial Index](./complete-modern-project-tutorial.md)** - Overview of all parts
- **[Project Setup](./01-project-setup-and-basics.md)** - Back to setup section
- **[Testing & Code Quality](./02-testing-and-code-quality.md)** - Testing section
- **[Version Control & CI/CD](./03-version-control-and-ci.md)** - CI/CD section
- **[Python Fundamentals](./README.md)** - Main Python guide
