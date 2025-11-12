# 🧪 Part 4-5: Testing and Code Quality

Write comprehensive tests, set up code quality tools, and learn debugging techniques. This section ensures your code is well-tested and follows professional standards.

**← Back to**: [Complete Tutorial Index](./complete-modern-project-tutorial.md) | [Project Setup](./01-project-setup-and-basics.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn in This Section

- **Writing comprehensive tests** with pytest
- **Unit testing** the calculator core
- **CLI testing** using subprocess
- **Setting up code quality tools** (ruff, mypy, pre-commit)
- **Understanding git hooks vs pre-commit framework**
- **Debugging techniques** (print, assertions, pytest)
- **Test coverage measurement**

---

## Part 4: Write Comprehensive Tests

### Step 4.1: Test Core Functionality

Create `tests/test_core.py`:

```python
"""Tests for calculator core functionality."""

import pytest

from simple_calculator.core import Calculator


class TestCalculatorBasicOperations:
    """Test basic arithmetic operations."""

    def test_add(self) -> None:
        """Test addition."""
        assert Calculator.add(5, 3) == 8
        assert Calculator.add(-5, 3) == -2
        assert Calculator.add(0, 0) == 0
        assert Calculator.add(1.5, 2.5) == 4.0

    def test_subtract(self) -> None:
        """Test subtraction."""
        assert Calculator.subtract(5, 3) == 2
        assert Calculator.subtract(3, 5) == -2
        assert Calculator.subtract(0, 0) == 0
        assert Calculator.subtract(5.5, 2.5) == 3.0

    def test_multiply(self) -> None:
        """Test multiplication."""
        assert Calculator.multiply(5, 3) == 15
        assert Calculator.multiply(-5, 3) == -15
        assert Calculator.multiply(0, 100) == 0
        assert Calculator.multiply(2.5, 4) == 10.0

    def test_divide(self) -> None:
        """Test division."""
        assert Calculator.divide(10, 2) == 5.0
        assert Calculator.divide(7, 2) == 3.5
        assert Calculator.divide(-10, 2) == -5.0
        assert Calculator.divide(0, 5) == 0.0

    def test_divide_by_zero(self) -> None:
        """Test division by zero raises ValueError."""
        with pytest.raises(ValueError, match="Cannot divide by zero"):
            Calculator.divide(5, 0)
```

### Step 4.2: Test CLI Functionality

Create `tests/test_cli.py`:

```python
"""Tests for CLI functionality."""

import subprocess

import pytest


def run_calc(operation: str, num1: str, num2: str) -> str:
    """Run calc command and return output.

    Args:
        operation: Calculator operation (Add, Subtract, etc.)
        num1: First number
        num2: Second number

    Returns:
        Output from calc command
    """
    result = subprocess.run(
        ["python", "-m", "simple_calculator.cli", operation, num1, num2],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr)
    return result.stdout


def test_add_command() -> None:
    """Test Add command."""
    output = run_calc("Add", "5", "3")
    assert "5.0 add 3.0 = 8.0" in output


def test_subtract_command() -> None:
    """Test Subtract command."""
    output = run_calc("Subtract", "10", "3")
    assert "10.0 subtract 3.0 = 7.0" in output


def test_multiply_command() -> None:
    """Test Multiply command."""
    output = run_calc("Multiply", "5", "4")
    assert "5.0 multiply 4.0 = 20.0" in output


def test_divide_command() -> None:
    """Test Divide command."""
    output = run_calc("Divide", "10", "2")
    assert "10.0 divide 2.0 = 5.0" in output


def test_divide_by_zero_error() -> None:
    """Test Divide by zero error."""
    result = subprocess.run(
        ["python", "-m", "simple_calculator.cli", "Divide", "10", "0"],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "Cannot divide by zero" in result.stderr


def test_invalid_operation_error() -> None:
    """Test invalid operation error."""
    result = subprocess.run(
        ["python", "-m", "simple_calculator.cli", "Power", "2", "3"],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "Unknown operation" in result.stderr


def test_missing_arguments_error() -> None:
    """Test missing arguments error."""
    result = subprocess.run(
        ["python", "-m", "simple_calculator.cli", "Add", "5"],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "Usage" in result.stderr


def test_invalid_number_error() -> None:
    """Test invalid number error."""
    result = subprocess.run(
        ["python", "-m", "simple_calculator.cli", "Add", "abc", "5"],
        capture_output=True,
        text=True,
    )
    assert result.returncode != 0
    assert "Numbers must be valid" in result.stderr
```

### Step 4.3: Create Empty Test __init__.py

Create `tests/__init__.py` (empty file for package recognition)

---

## 🧪 Checkpoint: Run All Tests

Before moving to code quality tools, let's verify all tests pass!

### Run the Full Test Suite

```bash
# Run all tests with coverage report
pytest

# You should see:
# - All tests pass (green checkmarks)
# - Test count (should be 13 tests from test_core.py and test_cli.py)
# - No errors or failures
```

### Expected Output

```
======================================================= test session starts =======================================================
platform linux -- Python 3.13.0, pytest-9.0.0, pluggy-1.6.0
rootdir: /path/to/simple-calculator
configfile: pyproject.toml
testpaths: tests
plugins: cov-7.0.0
collected 13 items

tests/test_cli.py::test_add_command PASSED                                                                                [ 7%]
tests/test_cli.py::test_subtract_command PASSED                                                                           [ 15%]
tests/test_cli.py::test_multiply_command PASSED                                                                           [ 23%]
tests/test_cli.py::test_divide_command PASSED                                                                             [ 30%]
tests/test_cli.py::test_divide_by_zero_error PASSED                                                                       [ 38%]
tests/test_cli.py::test_invalid_operation_error PASSED                                                                    [ 46%]
tests/test_cli.py::test_missing_arguments_error PASSED                                                                    [ 53%]
tests/test_cli.py::test_invalid_number_error PASSED                                                                       [ 61%]
tests/test_core.py::TestCalculatorBasicOperations::test_add PASSED                                                        [ 69%]
tests/test_core.py::TestCalculatorBasicOperations::test_subtract PASSED                                                   [ 76%]
tests/test_core.py::TestCalculatorBasicOperations::test_multiply PASSED                                                   [ 84%]
tests/test_core.py::TestCalculatorBasicOperations::test_divide PASSED                                                     [ 92%]
tests/test_core.py::TestCalculatorBasicOperations::test_divide_by_zero PASSED                                             [100%]

========================================================= tests coverage ==========================================================
_________________________________________ coverage: platform linux, python 3.13.0-final-0 _________________________________________

Name                                Stmts   Miss  Cover   Missing
-----------------------------------------------------------------
src/simple_calculator/__init__.py       3      0   100%
src/simple_calculator/_version.py       1      0   100%
src/simple_calculator/cli.py           34     34     0%   3-52
src/simple_calculator/core.py          16      0   100%
-----------------------------------------------------------------
TOTAL                                  54     34     37%

======================================================= 13 passed in 0.31s ========================================================
```

**What you'll see:**
- All 13 individual test names listed with `PASSED` status
- 8 CLI tests shown first
- 5 core operation tests shown next
- Progress percentage for each test (7%, 15%, 23%, etc.)
- Full coverage report showing core.py at 100% and cli.py at 0% (subprocess testing)
- Summary: **13 passed in ~0.31s**

### Test Coverage Explained

The coverage report shows:
- **src/simple_calculator/core.py:** 100% coverage (fully tested with unit tests)
- **src/simple_calculator/cli.py:** 0% coverage (tested via subprocess calls, which is the correct way to test CLI)
- **Overall:** 37% (but that's only because the coverage tool can't measure subprocess calls)

**Goal:** Aim for >80% coverage on direct unit test coverage (core.py shows 100%!)

### If Tests Fail ❌

**Common issues:**

1. **ModuleNotFoundError**
   ```bash
   # Make sure pythonpath is set in pyproject.toml
   # Should have: pythonpath = ["src"]
   cat pyproject.toml | grep pythonpath
   ```

2. **Test file not found**
   ```bash
   # Verify test files exist
   ls -la tests/
   # Should show: test_core.py, test_cli.py, __init__.py
   ```

3. **Import errors**
   ```bash
   # Test manual import
   python -c "from simple_calculator import Calculator; print('OK')"
   ```

### If Tests Pass ✅

Excellent! You've successfully:
- ✅ Written 13 comprehensive tests
- ✅ Achieved 100% code coverage on core logic
- ✅ Tested all operations (add, subtract, multiply, divide)
- ✅ Tested error cases (division by zero, invalid args, etc.)
- ✅ Tested CLI input/output validation
- ✅ Tests pass consistently

**You're ready for the next section: [Version Control and CI/CD](./03-version-control-and-ci.md)!**

---

## Part 5: Code Quality Tools Setup

### Understanding Git Hooks vs Pre-commit Framework

Before we configure code quality tools, let's clarify an important distinction:

#### **Git Hooks (Built-in Git Technology)**

Git itself provides a **hooks** system - these are scripts that Git runs at specific points:

- **Location:** `.git/hooks/` directory (created by Git automatically)
- **Who defines it:** Git (the version control system)
- **How it works:** Git checks for scripts with specific names and runs them
- **Pre-commit hook:** `.git/hooks/pre-commit` - runs BEFORE you commit code
- **Other hooks:** `pre-push` (before push), `post-commit` (after commit), etc.
- **Writing them:** Bash, Python, or any executable script

**Example raw git hook (bash):**
```bash
#!/bin/bash
# .git/hooks/pre-commit - Git will run this before commits
python -m pytest  # Run tests
if [ $? -ne 0 ]; then
  echo "Tests failed, commit blocked"
  exit 1
fi
```

**Problems with raw git hooks:**
- ❌ Need to write all logic yourself
- ❌ Hard to manage multiple tools
- ❌ Everyone on team needs same hooks configured
- ❌ No versioning or sharing between projects

---

#### **Pre-commit Framework (Python Tool)**

The "pre-commit" framework is a **Python tool that makes git hooks easier to manage**:

- **Creator:** Open source project (not part of Git)
- **Written in:** Python
- **What it does:** Automatically manages `.git/hooks/pre-commit` for you
- **Configuration file:** `.pre-commit-config.yaml` (YAML, not Git)
- **How it works:**
  1. You define which tools/checks you want in `.pre-commit-config.yaml`
  2. Pre-commit framework generates the actual git hooks
  3. Git runs them automatically before commits

**Key advantage:** Abstracts away git hook complexity, lets you focus on WHAT checks to run, not HOW to run them.

---

#### **Visual Comparison**

```
┌─────────────────────────────────────────────────────────────┐
│                    Git (Version Control)                    │
│  Provides hook system: .git/hooks/pre-commit               │
│  (built-in technology)                                      │
└─────────────────────────────────────────────────────────────┘
                            ↑
                    (wraps and manages)
                            ↑
┌─────────────────────────────────────────────────────────────┐
│         Pre-commit Framework (Python Tool)                  │
│  Reads: .pre-commit-config.yaml (YOUR configuration)       │
│  Generates: .git/hooks/pre-commit (Git will run this)       │
│  Manages: Ruff, MyPy, other tools (YOUR checks)             │
└─────────────────────────────────────────────────────────────┘
                            ↓
                   (controls and monitors)
                            ↓
┌─────────────────────────────────────────────────────────────┐
│              Your Code Quality Tools                        │
│  • Ruff (linting & formatting)                              │
│  • MyPy (type checking)                                     │
│  • Pytest (testing)                                         │
│  • Other custom checks                                      │
└─────────────────────────────────────────────────────────────┘
```

---

#### **Flow: What Actually Happens When You Commit**

```
You run: git commit -m "message"
         ↓
Git checks: .git/hooks/pre-commit exists?
         ↓
Git runs: .git/hooks/pre-commit (created by pre-commit framework)
         ↓
Pre-commit framework reads: .pre-commit-config.yaml
         ↓
Runs all configured hooks:
  • Ruff (via pre-commit's wrapper)
  • MyPy (via pre-commit's wrapper)
  • Trailing whitespace (via pre-commit-hooks repo)
  • All other checks
         ↓
Each hook either:
  ✅ PASSES → move to next hook
  ❌ FAILS → stop, display error, block commit
         ↓
If all pass:
  ✅ Commit succeeds
If any fail:
  ❌ Commit blocked
  Fix issues → git add . → git commit again
```

---

#### **Why Use Pre-commit Framework Instead of Raw Git Hooks?**

| Aspect | Raw Git Hooks | Pre-commit Framework |
|--------|---------------|----------------------|
| **Setup** | Write bash scripts | Write YAML config |
| **Managing tools** | Manual installation & versioning | Automatic |
| **Team consistency** | Manual sync | Automatic from `.pre-commit-config.yaml` |
| **Tool updates** | Manual | Automatic (run `pre-commit autoupdate`) |
| **Language support** | Limited (mostly bash) | Any language |
| **Reusability** | Project-specific | Share via public repos |

**Answer:** Pre-commit framework is much easier and is the Python community standard.

---

### Step 5.1: Create Pre-commit Configuration

Now let's create `.pre-commit-config.yaml` which tells the pre-commit framework which checks to run:

```yaml
repos:
  # Code formatting with ruff
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.8
    hooks:
      - id: ruff
        args: ["--fix"]
      - id: ruff-format

  # Type checking with mypy
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.7.1
    hooks:
      - id: mypy
        args: [--strict]
        exclude: ^tests/

  # General checks
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
        args: ["--maxkb=1000"]
      - id: debug-statements
```

### Understanding .pre-commit-config.yaml

This file configures automatic checks that run before each commit. Here's what each part does:

#### Overall Structure: `repos:`
- **`repos:`** - A list of repositories containing pre-commit hooks
- Each repository has its own hooks that perform different checks

---

#### **What Does `repo:` URL Do? (Important!)**

The `repo:` URL is a **GitHub repository that contains pre-commit hook definitions**. Here's what happens:

**Yes, the pre-commit framework downloads code from these repositories:**

1. **When you run `pre-commit install`:**
   ```bash
   pre-commit install
   # Downloads all repos listed in .pre-commit-config.yaml
   # Stores them in: ~/.cache/pre-commit/
   ```

2. **What gets downloaded:**
   - The entire GitHub repository
   - Specifically, the version you specified with `rev:`
   - These repos contain shell scripts that define how to run each hook

3. **Example: `https://github.com/astral-sh/ruff-pre-commit`**
   - This is a public GitHub repo
   - It contains a `.pre-commit-hooks.yaml` file (hook definitions)
   - Also contains bash/Python scripts that run ruff
   - Pre-commit downloads this and caches it locally

4. **Why a separate repository?**
   - Decouples the tool (ruff) from its pre-commit wrapper
   - Allows updates to hooks without updating the tool itself
   - Communities maintain these wrapper repos

---

#### **The Three Types of Repos You'll See:**

```yaml
# Type 1: Language-specific tool with pre-commit support
- repo: https://github.com/astral-sh/ruff-pre-commit
  # astral-sh maintains this; it wraps their ruff tool

# Type 2: Official pre-commit hooks repository
- repo: https://github.com/pre-commit/mirrors-mypy
  # Community-maintained mirror of mypy with pre-commit hooks

# Type 3: Generic pre-commit hooks collection
- repo: https://github.com/pre-commit/pre-commit-hooks
  # Utilities like trailing-whitespace, end-of-file-fixer, etc.
```

---

#### **How Pre-commit Uses These Repos:**

```
Your .pre-commit-config.yaml says:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.8
         ↓
Pre-commit framework:
  1. Clones that GitHub repo
  2. Checks out the specific version (rev: v0.1.8)
  3. Finds .pre-commit-hooks.yaml in that repo
  4. Reads hook definitions (what commands to run)
  5. Caches everything in ~/.cache/pre-commit/
  6. When you commit, runs those commands on your code
```

---

#### **Cached Repos Location:**

```bash
# All downloaded repos are stored here
~/.cache/pre-commit/

# Example structure:
~/.cache/pre-commit/
  astral-sh_ruff-pre-commit_v0.1.8/
  pre-commit_mirrors-mypy_v1.7.1/
  pre-commit_pre-commit-hooks_v4.5.0/
```

**Tip:** You can update all cached repos:
```bash
pre-commit autoupdate
# Downloads latest versions of all repos
```

---

#### **Section 1: Ruff (Code Formatting & Linting)**

```yaml
- repo: https://github.com/astral-sh/ruff-pre-commit
  rev: v0.1.8
  hooks:
    - id: ruff
      args: ["--fix"]
    - id: ruff-format
```

**What it does:**
- **`repo:`** - The URL of the GitHub repository containing pre-commit hook definitions for ruff
  - This repository will be downloaded and cached when you run `pre-commit install`
  - It contains instructions on how to run ruff
- **`rev: v0.1.8`** - The specific version (tag) of that repository to download and use
  - Pre-commit clones the repo and checks out this exact tag
  - Ensures everyone on your team uses the same version
- **`- id: ruff`** - First hook: Checks for style issues and fixes them automatically
  - `args: ["--fix"]` - Automatically fix problems it finds (imports, unused variables, etc.)
- **`- id: ruff-format`** - Second hook: Formats code consistently (spacing, indentation, etc.)

**Why it's useful:**
- ✅ Enforces consistent code style across your project
- ✅ Catches unused imports
- ✅ Finds obvious bugs (undefined variables, unreachable code)
- ✅ Automatically fixes many issues

**Example:** If you accidentally import something you don't use:
```python
import os  # Not used
from simple_calculator import Calculator

result = Calculator.add(5, 3)
```
Ruff will remove the unused import automatically before the commit.

---

#### **Section 2: MyPy (Type Checking)**

```yaml
- repo: https://github.com/pre-commit/mirrors-mypy
  rev: v1.7.1
  hooks:
    - id: mypy
      args: [--strict]
      exclude: ^tests/
```

**What it does:**
- **`- id: mypy`** - Runs MyPy type checker to find type-related bugs
- **`args: [--strict]`** - Enables strict mode (most strict type checking)
- **`exclude: ^tests/`** - Don't check test files (regex pattern: `^tests/` means "files starting with tests/")

**Note:** We removed `additional_dependencies: ["types-all"]` because:
- ❌ `types-all` includes type stubs for hundreds of packages you don't use
- ❌ It's currently broken (trying to install removed package `types-pkg-resources`)
- ✅ Your simple calculator project doesn't need it
- ✅ MyPy works fine without it for standard Python types

**Why it's useful:**
- ✅ Catches type errors before runtime (e.g., passing a string where an int is expected)
- ✅ Makes your code more maintainable
- ✅ Acts as inline documentation
- ✅ Prevents common bugs

**Example:** If you try to pass a string to a function expecting a number:
```python
# This would be caught by mypy:
result = Calculator.add("5", 3)  # TypeError: string, int instead of int, int
```

**Why exclude tests?**
- Tests often use mock objects and dynamic behavior that strict type checking doesn't like
- Tests don't need to be as strictly typed as production code

---

#### **Section 3: General Checks (pre-commit-hooks)**

```yaml
- repo: https://github.com/pre-commit/pre-commit-hooks
  rev: v4.5.0
  hooks:
    - id: trailing-whitespace
    - id: end-of-file-fixer
    - id: check-yaml
    - id: check-added-large-files
      args: ["--maxkb=1000"]
    - id: debug-statements
```

**Hook 1: `trailing-whitespace`**
- **What it does:** Removes extra whitespace at the end of lines
- **Why it matters:** Keeps files clean and prevents unnecessary diffs
- **Example:**
  ```python
  x = 5    # <- removes these extra spaces
  ```

**Hook 2: `end-of-file-fixer`**
- **What it does:** Ensures files end with exactly one newline
- **Why it matters:** Git expects files to end with a newline (standard Unix convention)
- **Example:**
  ```python
  print("hello")
  # <- adds a newline here
  ```

**Hook 3: `check-yaml`**
- **What it does:** Validates YAML syntax in `.yaml` and `.yml` files
- **Why it matters:** Catches YAML formatting errors early (indentation, colons, etc.)
- **Files it checks:** `.pre-commit-config.yaml`, `pyproject.toml` (partial), etc.

**Hook 4: `check-added-large-files`**
- **What it does:** Prevents committing files larger than 1000 KB
- **Args:** `["--maxkb=1000"]` - Maximum file size is 1000 KB
- **Why it matters:** Large files bloat your git history and slow down cloning
- **Common issues:** Binary files, model weights, large data files

**Hook 5: `debug-statements`**
- **What it does:** Detects leftover debugging code
- **Why it matters:** Prevents accidental debug prints/breakpoints in production code
- **Catches:**
  ```python
  import pdb; pdb.set_trace()  # <- catches this
  breakpoint()                  # <- catches this
  ```

---

### How Pre-commit Hooks Work

```
You run: git commit -m "message"
         ↓
Pre-commit framework:
  1. Detects staged files
  2. Runs all configured hooks
  3. Hooks check/modify files
         ↓
If all hooks pass:
  ✅ Commit succeeds

If any hook fails:
  ❌ Commit is blocked
  💡 Fix the issues
  Re-stage fixed files: git add .
  Try commit again: git commit -m "message"
```

### Step 5.2: Install Pre-commit Hooks

```bash
# Install git hooks
pre-commit install

# Run on all files to check
pre-commit run --all-files

# Commit hook will run automatically before commits
git add .
git commit -m "Initial project setup"
```

#### Troubleshooting Pre-commit Issues

**Error: `unknown variant py313`**

```
ruff failed
  Cause: TOML parse error at line 59
   |
59 | target-version = "py313"
   |                  ^^^^^^^
unknown variant `py313`, expected one of `py37`, `py38`, `py39`, `py310`, `py311`, `py312`
```

**Cause:** You're using Python 3.13, but the ruff version in `.pre-commit-config.yaml` doesn't support `py313` yet.

**Solution:** Change your `pyproject.toml` to use `py312` instead (ruff will still work with Python 3.13):

```toml
# In pyproject.toml, find this line:
[tool.ruff]
target-version = "py313"

# Change it to:
[tool.ruff]
target-version = "py312"
```

**Why this works:**
- `target-version` tells ruff which Python version features to check for
- Setting it to `py312` means "check for Python 3.12 compatibility"
- Your code will still work fine with Python 3.13
- This is just a compatibility measure until ruff's version supports `py313`

**Alternative:** Update ruff in `.pre-commit-config.yaml` to a newer version that supports `py313`:
```yaml
- repo: https://github.com/astral-sh/ruff-pre-commit
  rev: v0.6.0  # Update to a newer version that supports py313
```

**Note on Trailing Whitespace Fixes:**

When you run `pre-commit run --all-files`, you might see:
```
trim trailing whitespace.................................................Failed
- hook id: trailing-whitespace
- exit code: 1
- files were modified by this hook

Fixing src/simple_calculator/core.py
Fixing pyproject.toml
```

**This is normal and expected!** The hooks are:
1. ✅ Detecting issues (trailing whitespace, missing newlines)
2. ✅ Fixing them automatically
3. ✅ Reporting what they changed

You just need to stage the fixed files and commit again:
```bash
git add .
git commit -m "Fix whitespace issues found by pre-commit hooks"
```

---

### Step 5.3: Run Quality Checks Manually

```bash
# Check code style and fix issues
ruff check . --fix

# Format code
ruff format .

# Type checking
mypy .

# Run tests with coverage
pytest --cov

# All checks together
ruff check . && mypy . && pytest --cov
```

---

## Part 5.5: Debugging Your Application

When bugs happen (and they will!), here are the most practical debugging techniques:

### Quick Debugging: Print Debugging

The simplest approach - add print statements to understand what's happening:

```python
def divide(a: Union[int, float], b: Union[int, float]) -> float:
    """Divide two numbers."""
    print(f"DEBUG: divide called with a={a}, b={b}")  # Add temporary print
    if b == 0:
        raise ValueError("Cannot divide by zero")
    result = a / b
    print(f"DEBUG: result={result}")  # See the result
    return result
```

Then run your code:
```bash
python -c "from simple_calculator import Calculator; print(Calculator.divide(10, 2))"
# Output: DEBUG: divide called with a=10, b=2
#         DEBUG: result=5.0
#         5.0
```

**Pros:** Simple, works everywhere
**Cons:** Need to add and remove debug prints

---

### Assertions: Validate Assumptions

Use assertions to verify your assumptions:

```python
def divide(a: Union[int, float], b: Union[int, float]) -> float:
    """Divide two numbers."""
    assert isinstance(a, (int, float)), f"a must be number, got {type(a)}"
    assert isinstance(b, (int, float)), f"b must be number, got {type(b)}"
    assert b != 0, "b cannot be zero"

    return a / b
```

Run with assertions enabled:
```bash
python -c "from simple_calculator import Calculator; Calculator.divide('5', 3)"
# AssertionError: a must be number, got <class 'str'>
```

---

### Using Pytest for Debugging

Run a specific test with more info:

```bash
# Run specific test with verbose output
pytest tests/test_core.py::TestCalculatorBasicOperations::test_divide -v

# Stop on first failure and drop into debugger
pytest --pdb tests/test_core.py

# Show print statements during test run
pytest -s tests/test_core.py
```

---

### Pro Tip: Quick Test During Development

Write temporary test code to debug issues:

```bash
# Test in interactive mode
python

>>> from simple_calculator import Calculator
>>> result = Calculator.divide(10, 2)
>>> print(result)
5.0

>>> Calculator.divide(10, 0)
ValueError: Cannot divide by zero
```

---

## Next Steps

Once you've verified code quality and tests are passing, proceed to:

**[Part 4.5-6: Version Control and CI/CD](./03-version-control-and-ci.md)**
- Initialize Git repository
- Push to GitHub
- Set up GitHub Actions CI/CD

---

## Related Guides

- **[Complete Tutorial Index](./complete-modern-project-tutorial.md)** - Overview of all parts
- **[Project Setup](./01-project-setup-and-basics.md)** - Back to setup section
- **[Python Fundamentals](./README.md)** - Main Python guide
