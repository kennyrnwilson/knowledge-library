# 🔍 Python Linters: Code Quality Analysis

Linters are automated tools that analyze your Python code to find and flag errors, style violations, bugs, and other code quality issues **without running the code**. They're essential for maintaining clean, consistent, and bug-free code.

**← Back to**: [Coding Python in VS Code (2025): A Practical Guide](./vs-code-setup.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn

- **What linting is**: Automated code quality analysis
- **Why linting matters**: Catch bugs early, enforce consistency
- **Popular Python linters**: Detailed setup and configuration for each
- **Integration with VS Code**: Real-time linting while you code
- **Comparison and selection**: How to choose the right linter for your project
- **Best practices**: Making linting effective in your workflow

---

## 🔗 Learning Resources

**Prerequisites:**
- Python installed and working
- VS Code set up with Python extension
- Basic understanding of Python code style

**Related Areas:**
- [[Coding Python in VS Code (2025): A Practical Guide]] - Main Python development guide
- [[Python Fundamentals]] - Core Python concepts

**Key Resources:**
- [PEP 8 - Python Style Guide](https://pep8.org/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [Pylint Documentation](https://pylint.pycqa.org/)
- [flake8 Documentation](https://flake8.pycqa.org/)
- [pycodestyle Documentation](https://pycodestyle.pycqa.org/)

---

## Core Concepts

### What is Linting?

Linting is the process of analyzing your code to find potential errors and style violations. A linter:

1. **Parses** your code without executing it
2. **Analyzes** patterns against a set of rules
3. **Reports** issues it finds with locations and severity levels
4. **Can auto-fix** some issues (not all linters)

**Example: What a linter catches:**

```python
import os  # ❌ Unused import
import sys

def foo( ):  # ❌ Improper spacing
    x=1  # ❌ No spaces around operator
    y = 2
    if x== y:  # ❌ Inconsistent spacing
        print( "equal" )  # ❌ Extra spaces
    return x,y  # ✅ OK, but might warn if not type-hinted

    unreachable_code = "never runs"  # ❌ Unreachable code
```

### Why Linting Matters

**Benefits:**

1. **Catch bugs before runtime**
   - Undefined variables
   - Unreachable code
   - Incorrect function calls

2. **Enforce code style consistency**
   - All developers follow same rules
   - No debates about spacing/naming
   - Easier code reviews

3. **Improve code quality**
   - Simpler functions (complexity checks)
   - Cleaner imports (unused imports removed)
   - Security issues detected

4. **Professional standard**
   - Expected in all production code
   - Part of CI/CD pipelines
   - Industry best practice

**In CI/CD context:**

```yaml
# Example GitHub Actions
- run: ruff check .
- run: mypy .
```

If linting fails, the build fails. This prevents bad code from reaching production.

---

## Linter Options

### 1. Ruff (Recommended 2025)

**What it is:** Ultra-fast, modern linter written in Rust. Combines functionality of multiple tools.

**Speed:** 10-100x faster than alternatives

**What it checks:**
- Code style (pycodestyle)
- Common errors (pyflakes)
- Import sorting (isort-compatible)
- Python code smells (flake8-bugbear)
- Naming conventions (pep8-naming)
- Code complexity
- Security issues
- Many more with plugins

**Installation:**

```bash
# In your project's virtual environment
pip install ruff

# Verify installation
ruff --version
```

**Basic Usage:**

```bash
# Check all Python files
ruff check .

# Check specific file
ruff check src/main.py

# Fix auto-fixable issues
ruff check . --fix

# Check with specific rules
ruff check . --select E,F,W

# Show all issues
ruff check . --show-fixes
```

**Configuration** (`pyproject.toml`):

```toml
[tool.ruff]
# Project line length
line-length = 100

# Target Python version
target-version = "py311"

# Exclude directories
exclude = [
    ".venv",
    "build",
    "dist",
    ".git"
]

[tool.ruff.lint]
# Rules to enable (left side of = is rule code, right is description)
select = [
    "E",    # pycodestyle errors
    "W",    # pycodestyle warnings
    "F",    # Pyflakes (undefined names, etc)
    "I",    # isort (import sorting)
    "N",    # pep8-naming
    "UP",   # pyupgrade
    "B",    # flake8-bugbear (potential bugs)
    "A",    # flake8-builtins (shadowing builtins)
    "C4",   # flake8-comprehensions
    "SIM",  # flake8-simplify
    "RUF",  # Ruff-specific rules
]

# Rules to ignore
ignore = [
    "E501",  # Line too long (handled by formatter)
]

# Import sorting configuration
[tool.ruff.lint.isort]
known-first-party = ["myproject"]

# Per-file ignores
[tool.ruff.lint.per-file-ignores]
"__init__.py" = ["F401"]  # Imported but unused
"tests/*.py" = ["F841"]   # Local variable assigned but never used
```

**VS Code Integration:**

```json
{
  "ruff.enable": true,
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit"
    }
  },
  "ruff.lint.args": ["--select", "E,F,W,I,N,UP,B,A,C4"]
}
```

**Pros:**
- Blazingly fast (10-100x faster than alternatives)
- All-in-one tool (linting + formatting)
- Modern, actively developed
- Great error messages
- Can fix many issues automatically
- Minimal configuration needed

**Cons:**
- Newer tool (less mature than pylint)
- Fewer customization options than pylint
- Less detection of complex issues
- Smaller community (but growing fast)

### 2. Pylint

**What it is:** Comprehensive, strict linter with extensive analysis. Most thorough option.

**Installation:**

```bash
pip install pylint
```

**Basic Usage:**

```bash
# Check all Python files
pylint src/

# Check specific file
pylint src/main.py

# Generate report
pylint src/ --exit-zero --output-format=html > report.html

# Score rating
pylint src/
# Returns: Your code has been rated at 9.5/10
```

**Configuration** (`.pylintrc` or `pyproject.toml`):

Using `.pylintrc`:

```ini
[MASTER]
# Project name
project-name=myproject

# Jobs for parallel execution
jobs=4

[FORMAT]
max-line-length=100

[DESIGN]
max-attributes=10
max-locals=15
max-arguments=5

[MESSAGES CONTROL]
disable=
    missing-module-docstring,
    missing-function-docstring,
    too-few-public-methods
```

Using `pyproject.toml`:

```toml
[tool.pylint.main]
jobs = 4

[tool.pylint.format]
max-line-length = 100

[tool.pylint.design]
max-attributes = 10
max-arguments = 5

[tool.pylint.messages_control]
disable = [
    "missing-module-docstring",
    "missing-function-docstring",
]
```

**VS Code Integration:**

```json
{
  "python.linting.pylintEnabled": true,
  "python.linting.pylintArgs": [
    "--load-plugins=pylint_flask",
    "--rcfile=.pylintrc"
  ]
}
```

**Common Pylint Messages:**

| Code | Type | Meaning |
|------|------|---------|
| C (Convention) | Style | Code style violation |
| R (Refactor) | Quality | Refactoring suggestion |
| W (Warning) | Potential issue | Code smell, likely bug |
| E (Error) | Critical | Definite error |
| F (Fatal) | Critical | Couldn't process file |

**Pros:**
- Most thorough analysis available
- Detects complex issues
- Extensive customization
- Mature, well-established tool
- Detailed messaging and suggestions
- Can rate code quality (0-10)

**Cons:**
- Slower (slower than ruff, mypy)
- Heavy configuration often needed
- Can be noisy with false positives
- Steeper learning curve
- Resource intensive on large projects
- Opinionated defaults many don't like

### 3. Flake8

**What it is:** Lightweight linter combining pycodestyle, pyflakes, and McCabe complexity. Good middle ground.

**Installation:**

```bash
pip install flake8
```

**Basic Usage:**

```bash
# Check all Python files
flake8 .

# Check specific file
flake8 src/main.py

# Count violations by code
flake8 . --statistics

# Show complexity
flake8 . --statistics --tee
```

**Configuration** (`.flake8` or `setup.cfg` or `pyproject.toml`):

Using `.flake8`:

```ini
[flake8]
max-line-length = 100
exclude = .venv,build,dist
ignore = E203,W503
max-complexity = 10
per-file-ignores =
    __init__.py:F401
    tests/*.py:F841
```

Using `pyproject.toml`:

```toml
[tool.flake8]
max-line-length = 100
exclude = [".venv", "build", "dist"]
ignore = ["E203", "W503"]
max-complexity = 10
```

**Popular Plugins:**

```bash
# Additional checks
pip install flake8-bugbear      # Bug detection
pip install flake8-comprehensions  # Comprehension simplification
pip install flake8-simplify    # Simplification suggestions
pip install flake8-docstrings  # Docstring checking
pip install pep8-naming        # Naming conventions

# Then they work automatically with flake8
flake8 .
```

**VS Code Integration:**

```json
{
  "python.linting.flake8Enabled": true,
  "python.linting.flake8Args": [
    "--max-line-length=100",
    "--extend-ignore=E203,W503"
  ]
}
```

**Pros:**
- Lightweight, fast
- Sensible defaults
- Easy to configure
- Extensive plugin ecosystem
- Good balance of features vs simplicity
- Minimal dependencies

**Cons:**
- Doesn't auto-fix (unlike ruff)
- No import sorting (need isort separately)
- Limited customization vs pylint
- Less actively maintained than ruff
- Plugin ecosystem can be fragmented

### 4. MyPy (Type Checking)

**What it is:** Static type checker. Validates type hints without running code.

**Installation:**

```bash
pip install mypy
```

**Basic Usage:**

```bash
# Check all Python files
mypy .

# Check specific file
mypy src/main.py

# Strict mode (recommended)
mypy . --strict
```

**Configuration** (`pyproject.toml` or `mypy.ini`):

```toml
[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
disallow_incomplete_defs = true

# Per-module options
[[tool.mypy.overrides]]
module = "tests.*"
disallow_untyped_defs = false

[[tool.mypy.overrides]]
module = "external_lib.*"
ignore_missing_imports = true
```

**Type Hints Example:**

```python
def add(a: int, b: int) -> int:
    return a + b

# MyPy will catch:
result: int = add(1, 2)  # ✅ OK
result: str = add(1, 2)  # ❌ Type error

# Missing types:
def process(data):  # ❌ Missing type hints (strict mode)
    return data
```

**VS Code Integration:**

```json
{
  "python.analysis.typeCheckingMode": "basic",  // off, basic, or strict
  "mypy.args": ["--strict"]
}
```

**Pros:**
- Catches type-related bugs
- Improves code clarity
- Enables better IDE support
- Growing adoption in Python ecosystem
- Can be used alongside other linters

**Cons:**
- Requires type hints (or auto-inference)
- Strict mode very strict
- Can be slow on large projects
- Learning curve for type syntax
- Not all libraries have type stubs
- Doesn't catch runtime type errors

---

## Comparison Matrix

| Feature | Ruff | Pylint | Flake8 | MyPy |
|---------|------|--------|--------|------|
| **Speed** | ⚡⚡⚡ Fastest | 🐢 Slow | ⚡ Fast | ⚡⚡ Very Fast |
| **Auto-fix** | ✅ Yes | ❌ No | ❌ No | ❌ No |
| **Import sorting** | ✅ Built-in | ❌ Need plugin | ❌ Need isort | ✅ Built-in |
| **Code formatting** | ✅ Yes | ❌ No | ❌ No | ❌ No |
| **Type checking** | ⚠️ Basic | ⚠️ Limited | ❌ No | ✅ Full |
| **Customization** | 🟡 Moderate | 🟢 Extensive | 🟡 Moderate | 🟡 Moderate |
| **Complexity check** | ✅ Yes | ✅ Yes | ✅ Yes | ❌ No |
| **Maturity** | 🆕 New | 🏛️ Mature | 🏛️ Mature | 🟡 Maturing |
| **Community** | 📈 Growing | 📊 Large | 📊 Large | 📈 Growing |
| **Config file** | `pyproject.toml` | `.pylintrc` | `.flake8` | `mypy.ini` |
| **Best for** | Modern projects | Deep analysis | Quick setup | Type safety |

---

## Setup Examples

### Recommended: Ruff + MyPy (2025 Best Practice)

Fast, modern, covers both style and types:

**Installation:**

```bash
pip install ruff mypy
```

**Configuration** (`pyproject.toml`):

```toml
[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "W", "I", "N", "UP", "B", "A", "C4"]
ignore = ["E501"]

[tool.ruff.lint.isort]
known-first-party = ["myproject"]

[tool.mypy]
python_version = "3.11"
warn_return_any = true
disallow_untyped_defs = false  # Less strict by default
```

**VS Code Configuration** (`.vscode/settings.json`):

```json
{
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit"
    }
  },
  "ruff.enable": true,
  "python.analysis.typeCheckingMode": "basic"
}
```

**CI/CD** (GitHub Actions):

```yaml
name: Lint and Type Check
on: [push, pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: "3.11"
      - run: pip install ruff mypy
      - run: ruff check .
      - run: mypy .
```

### Traditional: Pylint + Black

For projects wanting comprehensive analysis:

**Installation:**

```bash
pip install pylint black
```

**Configuration** (`pyproject.toml`):

```toml
[tool.pylint.format]
max-line-length = 100

[tool.pylint.design]
max-arguments = 5

[tool.black]
line-length = 100
target-version = ["py311"]
```

**CI/CD:**

```yaml
- run: pylint src/
- run: black --check .
```

### Lightweight: Flake8 + isort

For small projects or quick setup:

**Installation:**

```bash
pip install flake8 isort
```

**Configuration** (`.flake8`):

```ini
[flake8]
max-line-length = 100
exclude = .venv,build
```

**CI/CD:**

```yaml
- run: flake8 .
- run: isort --check .
```

---

## Best Practices

### 1. Use a Configuration File

Don't rely on defaults. Commit configuration to version control:

```toml
# pyproject.toml (preferred for modern Python)
[tool.ruff]
line-length = 100

[tool.mypy]
python_version = "3.11"
```

All team members get same settings.

### 2. Run in CI/CD Pipeline

Prevent bad code from reaching production:

```yaml
# GitHub Actions
- run: ruff check .
- run: mypy .
# Build fails if linting fails
```

### 3. Auto-fix What You Can

Let linters fix simple issues automatically:

```bash
# Fix auto-fixable issues
ruff check . --fix

# Then commit the changes
git add -A
git commit -m "Auto-fix linting issues"
```

### 4. Ignore Intentional Violations

Sometimes you need to violate rules. Mark them:

```python
# Ignore specific issue
x = 1  # noqa: E701 (multiple statements on one line)

# Ignore all issues on line
some_weird_code()  # noqa

# Ignore in file
# flake8: noqa

# Ignore in block
# pylint: disable=missing-docstring
def weird_function():
    pass
```

### 5. Progressive Strictness

Start loose, tighten over time:

```toml
# Phase 1: Just catch obvious errors
select = ["E", "F"]

# Phase 2: Add style enforcement
select = ["E", "F", "W", "I", "N"]

# Phase 3: Add complexity checks
select = ["E", "F", "W", "I", "N", "B", "C4"]
```

### 6. Type Hints Gradually

Add type hints over time:

```python
# Start: No types
def process(data):
    return data

# Phase 1: Function signatures
def process(data: dict) -> dict:
    return data

# Phase 2: Complex types
from typing import Optional, List

def process(data: List[dict]) -> Optional[dict]:
    return data[0] if data else None
```

### 7. Document Your Rules

Add a section to README:

```markdown
## Code Quality

This project uses:
- **Ruff** for linting and formatting
- **MyPy** for type checking

Run locally:
```bash
ruff check .
ruff format .
mypy .
```

This project enforces:
- 100 character line length
- Python 3.11+
- Type hints on public functions
```

---

## Integration Workflow

### In VS Code (Real-time Feedback)

1. Install linter extension (Ruff or Pylint)
2. See squiggly underlines as you type
3. Hover to see issue details
4. Hit `Ctrl+.` to see fixes
5. Format on save with Ruff

**Example:**

```python
import os  # 🔴 Unused import appears immediately
```

### Pre-commit (Before Committing)

Automatically lint all staged files:

**Installation:**

```bash
pip install pre-commit
```

**`.pre-commit-config.yaml`:**

```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.5.1
    hooks:
      - id: mypy
        additional_dependencies: [types-all]
```

**Setup:**

```bash
pre-commit install
# Linter runs automatically before each commit
```

### CI/CD Pipeline (On Server)

Build fails if linting fails - no bad code reaches production.

---

## Troubleshooting

### Issue: Linter not running in VS Code

**Solution:**
1. Install linter: `pip install ruff`
2. Make sure venv is selected: `Ctrl+Shift+P` → "Python: Select Interpreter"
3. Restart VS Code
4. Check extension is enabled: Settings → search "ruff" → check enable

### Issue: Too many false positives

**Solution:**
1. Use less strict rules: Remove "B", "C4" from select
2. Ignore specific rules: `ignore = ["E501"]`
3. Use type checking instead: Let mypy catch real issues

### Issue: Linter conflicts with formatter

**Solution:**
1. Use Ruff for both (it's compatible with itself)
2. Or configure to match:
   - Black: `ignore = ["E501"]`
   - MyPy: Add type hints gradually

### Issue: Slow linting on large project

**Solution:**
1. Switch to Ruff (fastest option)
2. Exclude directories: `exclude = [".venv", "build"]`
3. Use parallel checking: `mypy . --parallel 4`

---

## ✅ Learning Checklist

### Understanding Linting

- [ ] Read PEP 8 style guide
- [ ] Understand what linting does vs formatting
- [ ] Know common linting errors (unused imports, undefined names)
- [ ] Understand why consistency matters in teams

### Setup with Ruff (Recommended)

- [ ] Install Ruff: `pip install ruff`
- [ ] Run Ruff: `ruff check .`
- [ ] Create `pyproject.toml` config
- [ ] Install Ruff VS Code extension
- [ ] Enable in VS Code settings
- [ ] See squiggly underlines for issues
- [ ] Try auto-fix: `ruff check . --fix`

### Type Checking with MyPy

- [ ] Install MyPy: `pip install mypy`
- [ ] Run MyPy: `mypy .`
- [ ] Create `pyproject.toml` config for MyPy
- [ ] Add basic type hints to a function
- [ ] Run MyPy again, see it catch type errors

### Integration

- [ ] Create `.vscode/settings.json` for team
- [ ] Configure format on save
- [ ] Add linting to CI/CD pipeline
- [ ] Set up pre-commit hooks
- [ ] Document linting rules in README

### Comparison and Choice

- [ ] Understand Ruff vs Pylint vs Flake8
- [ ] Know when to use each tool
- [ ] Configure chosen linter for your project
- [ ] Run in VS Code, on save, and in CI/CD

### Best Practices

- [ ] Use configuration files (commit to repo)
- [ ] Gradually increase strictness
- [ ] Add type hints alongside linting
- [ ] Auto-fix simple issues
- [ ] Document rules in project README
- [ ] Run in pre-commit hooks
- [ ] Fail builds if linting fails

---

## Next Steps

1. **Immediate**: Install Ruff and run on your project
2. **This week**: Configure Ruff in VS Code with format on save
3. **This month**: Add type hints with MyPy
4. **This quarter**: Set up pre-commit hooks and CI/CD
5. **Next**: Move to [[Python Fundamentals: Testing]]

---

*Last updated: 2025-11-10*
