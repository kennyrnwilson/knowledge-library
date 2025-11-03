# 1.2 Software Engineering Practices

Master Git, testing, code quality, and professional development practices that separate junior developers from professionals.

---

## 📚 What You'll Learn

- **Testing Basics**: Unit testing with pytest, test coverage, mocking and test isolation
- **Documentation**: Docstrings and code comments, README and project documentation, API documentation
- **Git & Version Control**: Git basics, GitHub workflow, branching strategies, .gitignore
- **Code Quality Tools**: Code style (PEP 8), code formatters (Black), linters (pylint/flake8), type checking (mypy)
- **Project Structure**: Python project layout, configuration management

---

## 🔗 Learning Resources

### Related Areas
- [1.1 Python Fundamentals](../python-fundamentals/index.md)
- [1.3 Data & Databases](../data-databases/index.md)
- [Stage 1 Overview](../index.md)

---

## Testing Basics

Testing is how you know your code actually works.

### Unit Testing with pytest

- [ ] **Install pytest** and run a simple test
- [ ] **Write basic unit tests** for functions
- [ ] **Understand test structure** (arrange, act, assert)
- [ ] **Use pytest fixtures** for test setup
- [ ] **Parametrize tests** to reduce duplication
- [ ] **Test exceptions** with pytest.raises()
- [ ] **Mock external dependencies** with unittest.mock

**Practice Exercises:**
1. Write 10+ unit tests for a utility module
2. Test a class with multiple methods
3. Test error handling and edge cases

### Test Coverage

- [ ] **Understand test coverage** (% of code tested)
- [ ] **Measure coverage** with coverage.py
- [ ] **Aim for 80%+ coverage** on projects
- [ ] **Understand coverage gaps** (what's not tested)
- [ ] **Balance coverage with test quality** (not just high %)

**Practice Exercises:**
1. Write tests to achieve 80% coverage on a module
2. Analyze and improve coverage of existing code
3. Run coverage report and identify gaps

### Mocking and Test Isolation

- [ ] **Mock external API calls** in tests
- [ ] **Mock file operations** to avoid side effects
- [ ] **Patch functions** for testing
- [ ] **Create test fixtures** for reusable test data
- [ ] **Understand spy vs stub vs mock**

**Practice Exercises:**
1. Write tests that mock API calls
2. Test database code without connecting to real database
3. Mock file I/O and test file handling code

---

## Documentation

Great code is useless if no one understands it.

### Docstrings and Code Comments

- [ ] **Write docstrings** for all functions
- [ ] **Understand docstring formats** (Google, NumPy, Sphinx)
- [ ] **Document parameters and return types**
- [ ] **Include examples** in docstrings
- [ ] **Write meaningful comments** (not obvious things)
- [ ] **Keep comments updated** with code changes

**Practice Exercises:**
1. Add Google-style docstrings to 10+ functions
2. Convert poorly documented code to well-documented code
3. Extract docstring examples and turn them into tests

### README and Project Documentation

- [ ] **Write a great README** with usage examples
- [ ] **Document installation instructions**
- [ ] **Explain how to run tests**
- [ ] **Include troubleshooting section**
- [ ] **Add badges** (CI status, coverage, etc.)
- [ ] **Keep CHANGELOG** for version history

**Practice Exercises:**
1. Write README for a project from scratch
2. Improve existing documentation
3. Create CONTRIBUTING.md for open-source project

### API Documentation

- [ ] **Generate docs from docstrings** (Sphinx, pdoc)
- [ ] **Auto-generate API reference**
- [ ] **Write getting started guide**
- [ ] **Document error codes and exceptions**
- [ ] **Include usage examples and patterns**

**Practice Exercises:**
1. Generate Sphinx documentation
2. Deploy docs online (ReadTheDocs)
3. Document a FastAPI application

---

## Git & Version Control

Git is how professional teams collaborate on code.

### Git Basics

- [ ] **Initialize a repository** (`git init`)
- [ ] **Add and commit changes** (`git add`, `git commit`)
- [ ] **Understand commit messages** (clear and descriptive)
- [ ] **View history** (`git log`)
- [ ] **Check status** (`git status`)
- [ ] **Push to remote** (`git push`)

**Practice Exercises:**
1. Create 10 commits with clear messages
2. Initialize and set up a repository
3. Practice writing good commit messages

### GitHub Workflow

- [ ] **Create repository on GitHub**
- [ ] **Clone repository** (`git clone`)
- [ ] **Push code to GitHub**
- [ ] **Create and manage branches**
- [ ] **Create pull requests**
- [ ] **Review and merge PRs**

**Practice Exercises:**
1. Fork a repo and create a PR
2. Review a peer's pull request
3. Merge conflicts and resolve them

### Branching Strategies

- [ ] **Create branches** for features (`git checkout -b`)
- [ ] **Understand main/develop branches**
- [ ] **Use feature branches** for new work
- [ ] **Keep branches short-lived**
- [ ] **Understand Git Flow** basics
- [ ] **Understand trunk-based development**

**Practice Exercises:**
1. Practice feature branch workflow
2. Create and merge multiple branches
3. Simulate merge conflicts and resolve

### .gitignore

- [ ] **Create .gitignore file** for Python projects
- [ ] **Ignore virtual environments** (`venv/`)
- [ ] **Ignore sensitive files** (`.env`, `credentials`)
- [ ] **Ignore build artifacts** (`__pycache__`, `.pyc`)
- [ ] **Ignore IDE files** (`.vscode`, `.idea`)

**Practice Exercises:**
1. Create comprehensive .gitignore for project
2. Remove accidentally committed files from history
3. Use .gitignore templates for different languages

---

## Code Quality Tools

Professional code meets standards.

### Code Style (PEP 8)

- [ ] **Understand PEP 8** (Python style guide)
- [ ] **Use consistent naming** (snake_case for functions/variables)
- [ ] **Follow spacing rules** (indentation, blank lines)
- [ ] **Limit line length** (79-88 characters)
- [ ] **Organize imports** (stdlib, third-party, local)

**Practice Exercises:**
1. Fix style violations in code
2. Reformat code to PEP 8 standards
3. Understand reasons behind style rules

### Code Formatters

- [ ] **Use Black** for automatic formatting
- [ ] **Configure Black** in project
- [ ] **Run Black** in CI/CD
- [ ] **Integrate Black** with editor
- [ ] **Understand opinionated formatting** benefits

**Practice Exercises:**
1. Format a messy codebase with Black
2. Configure Black with custom settings
3. Integrate with VS Code

### Linters

- [ ] **Use pylint** or **flake8** for code analysis
- [ ] **Understand linting rules** (style, logic errors)
- [ ] **Fix linting errors**
- [ ] **Configure linter** for project
- [ ] **Integrate with editor and CI**

**Practice Exercises:**
1. Run linter on code and fix issues
2. Configure linter rules
3. Create CI check for linting

### Type Checking

- [ ] **Add type hints** to functions
- [ ] **Understand type hints syntax** (Python 3.6+)
- [ ] **Use mypy** for static type checking
- [ ] **Understand common type errors**
- [ ] **Write strongly-typed code**

**Practice Exercises:**
1. Add type hints to 10+ functions
2. Run mypy and fix type errors
3. Understand complex types (Optional, Union, etc.)

---

## Project Structure

How you organize code matters.

### Python Project Layout

- [ ] **Understand src-layout** vs flat layout
- [ ] **Create proper package structure**
- [ ] **Write `__init__.py` files**
- [ ] **Organize by feature, not by type**
- [ ] **Use configuration files** (config.yaml, .env)

**Example structure:**
```
project/
├── src/
│   └── mypackage/
│       ├── __init__.py
│       ├── main.py
│       └── utils.py
├── tests/
│   ├── __init__.py
│   ├── test_main.py
│   └── test_utils.py
├── docs/
├── README.md
├── pyproject.toml
└── .gitignore
```

**Practice Exercises:**
1. Reorganize existing project to src-layout
2. Create 3 well-structured projects from scratch
3. Move code between modules correctly

### Configuration Management

- [ ] **Store config in .env files** (not code)
- [ ] **Use environment variables**
- [ ] **Different configs** for dev/test/production
- [ ] **Load configs safely** (secrets, not in git)
- [ ] **Use libraries** like python-dotenv

**Practice Exercises:**
1. Move hardcoded values to config
2. Create .env files for different environments
3. Use environment variables in application

---

## ✅ Learning Checklist

You've mastered software engineering basics when you can:

- [ ] Write unit tests with good coverage
- [ ] Use Git confidently and understand workflows
- [ ] Write clear, documented code
- [ ] Set up and configure linting/formatting tools
- [ ] Organize projects professionally
- [ ] Review code quality systematically

---

*Last updated: 2025-11-03*
