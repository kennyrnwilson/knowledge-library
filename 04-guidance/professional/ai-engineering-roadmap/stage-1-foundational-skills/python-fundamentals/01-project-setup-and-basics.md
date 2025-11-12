# 🚀 Part 1-3: Project Setup and Package Basics

Setting up your Python project correctly from the start is crucial. This guide covers initializing your project, configuring it with modern Python standards, and writing your first package code.

**← Back to**: [Complete Tutorial Index](./complete-modern-project-tutorial.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn in This Section

- **Modern project setup** with src-layout and pyproject.toml
- **Environment management** with pyenv and virtual environments (Linux/WSL)
- **Building a professional package** with proper code organization
- **Understanding Python packages vs modules**
- **Creating the calculator core functionality**
- **Building a command-line interface**

---

## Prerequisites

- Linux/WSL environment with Python 3.11+
- Git installed and configured
- Basic command-line knowledge

---

## Project Overview

**Goal:** Build the foundation of a professional Python calculator package that supports:
- Addition (+), Subtraction (-), Multiplication (*), Division (/)
- Error handling for division by zero
- Professional packaging structure
- Command-line interface

**Project Structure After This Section:**

```
simple-calculator/
├── src/
│   └── simple_calculator/
│       ├── __init__.py
│       ├── _version.py
│       ├── core.py
│       └── cli.py
├── tests/
│   ├── __init__.py
│   ├── test_core.py
│   └── test_cli.py
├── pyproject.toml
├── .gitignore
├── README.md
└── LICENSE
```

---

## Understanding Packages vs Modules

Before building the project, it's crucial to understand two fundamental concepts you'll encounter throughout this tutorial: **packages** and **modules**. These terms are often used in Python, and understanding the distinction is key to organizing professional Python projects.

### What is a Module?

A **module** is a single `.py` file that contains Python code. Any Python file can be imported and used in other code.

**Examples of modules:**
- `simple_calculator/core.py` - a module containing the Calculator class
- `simple_calculator/cli.py` - a module containing the command-line interface
- `simple_calculator/_version.py` - a module containing version information

When you import a module, you use:
```python
from simple_calculator import core        # Import the core module
from simple_calculator.core import Calculator  # Import a class from core module
import simple_calculator.cli              # Import the cli module
```

### What is a Package?

A **package** is a directory that contains Python modules AND a special `__init__.py` file. The `__init__.py` file tells Python: "This directory is a package that can be imported."

**Characteristics of a package:**
- Must contain an `__init__.py` file (even if empty)
- Can contain multiple modules (.py files)
- Can contain sub-packages (directories with their own `__init__.py`)
- Can be imported as a single unit

**Example package structure:**
```
simple_calculator/          ← This is a PACKAGE (directory with __init__.py)
├── __init__.py            ← Makes this a package
├── _version.py            ← A module (single .py file)
├── core.py                ← A module (single .py file)
└── cli.py                 ← A module (single .py file)
```

### Packages vs Modules in This Tutorial

In this calculator project:

| Name | Type | What It Is |
|------|------|-----------|
| `simple_calculator` | **Package** | Directory with `__init__.py` that contains all calculator code |
| `simple_calculator.core` | **Module** | Single file `core.py` inside the package with the Calculator class |
| `simple_calculator.cli` | **Module** | Single file `cli.py` inside the package with command-line interface |
| `simple_calculator._version` | **Module** | Single file `_version.py` inside the package with version info |
| `tests` | **Package** | Directory with `__init__.py` containing test files |
| `tests.test_core` | **Module** | Single file `test_core.py` inside the tests package |

### How Imports Work

When Python encounters an import statement, it looks for packages (directories with `__init__.py`) and modules (`.py` files):

```python
# Importing a module from a package
from simple_calculator.core import Calculator
# Reads: From the simple_calculator PACKAGE, import the Calculator from the core MODULE

# Importing the entire module
import simple_calculator.cli
# Reads: Import the cli MODULE from the simple_calculator PACKAGE

# Importing from __init__.py
from simple_calculator import Calculator
# Works because __init__.py imports Calculator (from simple_calculator.core import Calculator)
```

### The __init__.py File

The `__init__.py` file is the magic that transforms a directory into a package. It can be:

1. **Empty** - The directory is still a valid package
2. **With code** - Runs when the package is imported (great for initialization)
3. **With imports** - Re-exports classes/functions for convenience

In this project, `simple_calculator/__init__.py` does:
```python
from simple_calculator._version import __version__
from simple_calculator.core import Calculator

__all__ = ["Calculator", "__version__"]
```

This allows users to write cleaner code:
```python
# Instead of:
from simple_calculator.core import Calculator
from simple_calculator._version import __version__

# Users can write:
from simple_calculator import Calculator, __version__
```

### Why This Matters for This Project

Throughout this tutorial, you'll see references to:
- **`simple_calculator`** - This is the package (directory) you're building
- **`simple_calculator.core`** - This is a module inside the package
- **`simple_calculator.cli`** - This is another module inside the package
- **`simple_calculator._version`** - This is another module inside the package

In `pyproject.toml`, you'll see:
```toml
[tool.hatchling.packages]
include = ["simple_calculator"]    # The PACKAGE to include
from = ["src"]                     # Look in src/ directory
```

This tells the build system: "Find the `simple_calculator` PACKAGE in the `src/` directory and include it in the distribution."

And you'll see import statements like:
```python
from simple_calculator.core import Calculator  # Import from the core MODULE in the package
from simple_calculator import Calculator       # Convenience import via __init__.py
```

Understanding this distinction helps you write cleaner, more maintainable code and understand how Python's import system works.

---

## Part 1: Project Initialization

### Step 1.1: Create Project Directory and Initialize Git

```bash
# Create project directory
mkdir simple-calculator
cd simple-calculator

# Initialize git repository
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

### Step 1.2: Set Up Python Environment with pyenv (WSL/Linux)

```bash
# Check available Python versions
pyenv versions

# Install Python 3.13 if not available
pyenv install 3.13.0

# Set local Python version for this project
pyenv local 3.13.0

# Verify
python --version
# Output: Python 3.13.0
```

### Step 1.3: Create Virtual Environment

```bash
# Create virtual environment in Linux filesystem (NOT /mnt/c/)
python -m venv venv

# Activate virtual environment
source venv/bin/activate

# Verify activation (prompt shows (venv))
which python
# Output: /home/username/projects/simple-calculator/venv/bin/python

# Upgrade pip
pip install --upgrade pip
```

### Step 1.4: Create Project Structure

```bash
# Create directories
mkdir -p src/simple_calculator
mkdir -p tests
mkdir -p docs
mkdir -p .github/workflows

# Create initial files
touch src/simple_calculator/__init__.py
touch src/simple_calculator/_version.py
touch src/simple_calculator/core.py
touch src/simple_calculator/cli.py
touch tests/__init__.py
touch tests/test_core.py
touch tests/test_cli.py
touch pyproject.toml
touch README.md
touch .gitignore
touch .pre-commit-config.yaml
touch .github/workflows/tests.yml
touch LICENSE
```

---

## Part 2: Project Configuration

### Step 2.1: Create pyproject.toml

Create `pyproject.toml` with complete modern configuration:

```toml
[build-system]
requires = ["hatchling>=1.25"]
build-backend = "hatchling.build"

[project]
name = "simple-calculator"
dynamic = ["version"]
description = "A simple but professional command-line calculator package"
readme = "README.md"
requires-python = ">=3.11"
license = {text = "MIT"}
authors = [
    {name = "Your Name", email = "your.email@example.com"}
]
keywords = ["calculator", "cli", "arithmetic"]
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.11",
    "Programming Language :: Python :: 3.12",
    "Programming Language :: Python :: 3.13",
    "Topic :: Software Development :: Libraries",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov>=4.0",
    "ruff>=0.1.0",
    "mypy>=1.0",
    "pre-commit>=3.0",
    "twine>=4.0",
]

[project.scripts]
calc = "simple_calculator.cli:main"

[project.urls]
Homepage = "https://github.com/yourusername/simple-calculator"
Documentation = "https://github.com/yourusername/simple-calculator#readme"
Repository = "https://github.com/yourusername/simple-calculator.git"
Issues = "https://github.com/yourusername/simple-calculator/issues"

[tool.hatchling.packages]
include = ["simple_calculator"]
from = ["src"]

[tool.hatch.version]
path = "src/simple_calculator/_version.py"

# Ruff linting configuration
[tool.ruff]
line-length = 100
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "W", "I", "N"]
ignore = ["E501"]  # Line length handled separately

[tool.ruff.lint.isort]
known-first-party = ["simple_calculator"]

# MyPy type checking configuration
[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = false
disallow_incomplete_defs = false
check_untyped_defs = true

# Pytest configuration
[tool.pytest.ini_options]
minversion = "7.0"
addopts = "-v -ra --strict-markers --cov=src/simple_calculator --cov-report=term-missing --cov-report=html"
testpaths = ["tests"]
pythonpath = ["src"]

[tool.coverage.run]
source = ["src/simple_calculator"]
omit = ["*/tests/*"]

[tool.coverage.report]
exclude_lines = [
    "pragma: no cover",
    "def __repr__",
    "raise AssertionError",
    "raise NotImplementedError",
    "if __name__ == .__main__.:",
]
```

### Understanding pyproject.toml Line by Line

**`[build-system]` Section** - Tells Python how to build your package

- `requires = ["hatchling>=1.25"]` - Specifies that Hatchling (version 1.25+) is needed to build this package. This is installed automatically when building
- `build-backend = "hatchling.build"` - Tells pip which tool to use for building. Hatchling is modern, fast, and requires minimal configuration

**`[project]` Section** - Core metadata about your package (PEP 621 standard)

- `name = "simple-calculator"` - The package name on PyPI (lowercase, dashes instead of underscores for display)
- `dynamic = ["version"]` - **Dynamic versioning**: tells Hatchling the version will be read from `_version.py` instead of hardcoding it here. This is the recommended approach because you only update the version in one place
- `description = "..."` - Short one-line description shown on PyPI
- `readme = "README.md"` - Points to your README file. pip will display this as the long description on PyPI
- `requires-python = ">=3.11"` - Specifies minimum Python version. pip will prevent installation on older Python versions
- `license = {text = "MIT"}` - License type. Using `{text = "MIT"}` embeds the license type without requiring a separate file reference
- `authors = [...]` - Author information. Can be multiple people. Email is optional but recommended
- `keywords = [...]` - Search keywords for PyPI. Helps people find your package
- `classifiers = [...]` - Metadata categories for PyPI organization:
  - `Development Status :: 4 - Beta` - Shows maturity level (Alpha → Beta → Stable, etc.)
  - `Intended Audience :: Developers` - Who should use this
  - License classifier - Must match your actual license
  - Python version classifiers - List all versions you officially support (matches `requires-python`)
  - Topic classifier - What category the package belongs to

**`[project.optional-dependencies]` Section** - Extra dependencies only for development

- `dev = [...]` - Installs with `pip install .[dev]` (all packages listed)
  - `pytest>=7.0` - Testing framework
  - `pytest-cov>=4.0` - Code coverage reporting
  - `ruff>=0.1.0` - Fast linter and formatter
  - `mypy>=1.0` - Static type checker
  - `pre-commit>=3.0` - Git hooks framework
  - `twine>=4.0` - Tool for uploading to PyPI

**`[project.scripts]` Section** - Creates command-line commands

- `calc = "simple_calculator.cli:main"` - Creates a `calc` command that runs the `main()` function from `simple_calculator.cli` module. After installation, users can just type `calc` instead of `python -m simple_calculator.cli`

**`[project.urls]` Section** - Links shown on PyPI package page

- Each URL provides important information:
  - `Homepage` - Your project's main website
  - `Documentation` - Where users can learn how to use it
  - `Repository` - The Git repository URL
  - `Issues` - Where users can report bugs

**`[tool.hatchling.packages]` Section** - Tells Hatchling where your code is

- `include = ["simple_calculator"]` - Which packages to include (the folder name in src/)
- `from = ["src"]` - Look in the `src/` directory (src-layout). Hatchling will find `src/simple_calculator/` and include it

**`[tool.hatch.version]` Section** - Tells Hatchling where to find the version

- `path = "src/simple_calculator/_version.py"` - Read the version from this file. Hatchling looks for `__version__ = "0.1.0"` in this file and uses that as the package version

**`[tool.ruff]` Section** - Configuration for Ruff linter/formatter

- `line-length = 100` - Maximum line length before wrapping (100 characters is common)
- `target-version = "py312"` - Minimum Python version to target (affects which Python features Ruff checks for)

**`[tool.ruff.lint]` Section** - Which rules Ruff enforces

- `select = ["E", "F", "W", "I", "N"]` - Error rules to enforce:
  - `E` - PEP 8 errors (spacing, indentation, etc.)
  - `F` - Pyflakes errors (undefined names, unused imports, etc.)
  - `W` - PEP 8 warnings
  - `I` - isort import sorting
  - `N` - Naming conventions (PEP 8 names)
- `ignore = ["E501"]` - Don't enforce line length in linter (handled separately by formatter)

**`[tool.ruff.lint.isort]` Section** - How to sort imports

- `known-first-party = ["simple_calculator"]` - Tells Ruff that `simple_calculator` is your package (not a third-party library), so imports are grouped correctly

**`[tool.mypy]` Section** - Configuration for MyPy type checker

- `python_version = "3.11"` - Assume code runs on Python 3.11+ (affects type checking rules)
- `warn_return_any = true` - Warn if a function returns `Any` type (could indicate missing type hints)
- `warn_unused_configs = true` - Warn about unused configuration options
- `disallow_untyped_defs = false` - Don't require type hints on all functions (too strict for beginners)
- `disallow_incomplete_defs = false` - Allow partial type hints (some params typed, some not)
- `check_untyped_defs = true` - Still check functions without type hints for obvious errors

**`[tool.pytest.ini_options]` Section** - Configuration for Pytest testing framework

- `minversion = "7.0"` - Require at least Pytest 7.0
- `addopts = "-v -ra --strict-markers --cov=src/simple_calculator --cov-report=term-missing --cov-report=html"` - Default options when running `pytest`:
  - `-v` - Verbose output (show individual test names)
  - `-ra` - Show all test results summary (passed, failed, skipped, etc.)
  - `--strict-markers` - Require declared markers (catch typos in `@pytest.mark.xxx`)
  - `--cov=src/simple_calculator` - Measure code coverage for your package
  - `--cov-report=term-missing` - Show coverage in terminal with missing lines
  - `--cov-report=html` - Also generate HTML coverage report
- `testpaths = ["tests"]` - Where to find test files
- `pythonpath = ["src"]` - Add `src/` to Python path so tests can import your package

**`[tool.coverage.run]` Section** - Code coverage measurement

- `source = ["src/simple_calculator"]` - Only measure coverage for your package (not test files)
- `omit = ["*/tests/*"]` - Don't include test files in coverage calculations

**`[tool.coverage.report]` Section** - What to exclude from coverage reports

- `exclude_lines` - Lines that shouldn't count against coverage:
  - `pragma: no cover` - Lines marked with this comment
  - `def __repr__` - Special methods often not covered
  - `raise AssertionError` - Defensive assertions
  - `raise NotImplementedError` - Placeholder methods
  - `if __name__ == .__main__.` - Module-level main execution

### Step 2.2: Create Version File

Create `src/simple_calculator/_version.py`:

```python
"""Version information for simple_calculator."""

__version__ = "0.1.0"
```

### Step 2.3: Create README.md

Create `README.md`:

```markdown
# Simple Calculator

A professional command-line calculator package demonstrating modern Python development practices.

## Features

- Basic arithmetic operations: addition, subtraction, multiplication, division
- Command-line interface
- Comprehensive test coverage
- Type hints and static analysis
- Professional packaging and distribution

## Installation

```bash
pip install simple-calculator
```
```

### Step 2.4: Create .gitignore

Create `.gitignore`:

```
# Virtual environments
venv/
env/
.venv/

# Python cache
__pycache__/
*.py[cod]
*$py.class
*.so

# Distribution / packaging
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Testing
.pytest_cache/
.coverage
htmlcov/
.hypothesis/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db

# PyPI
.pypirc

# mypy
.mypy_cache/
.dmypy.json
dmypy.json
```

### Step 2.5: Create License

Create `LICENSE`:

```
MIT License

Copyright (c) 2025 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, IN AN ACTION
OF THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```

### Step 2.6: Install Development Dependencies

Before writing code, install all development tools you'll need:

```bash
# Install the package in editable mode with dev dependencies
pip install -e ".[dev]"

# Verify all tools are installed
pytest --version
ruff --version
mypy --version
pre-commit --version
twine --version
```

You should see version numbers for all tools. If any are missing, the installation failed.

---

## Part 3: Write the Package Code

### Step 3.1: Create Calculator Core

Create `src/simple_calculator/core.py`:

```python
"""Core calculator functionality."""

from typing import Union


class Calculator:
    """A calculator that performs basic arithmetic operations."""

    @staticmethod
    def add(a: Union[int, float], b: Union[int, float]) -> Union[int, float]:
        """Add two numbers.

        Args:
            a: First number
            b: Second number

        Returns:
            Sum of a and b
        """
        return a + b

    @staticmethod
    def subtract(
        a: Union[int, float], b: Union[int, float]
    ) -> Union[int, float]:
        """Subtract two numbers.

        Args:
            a: First number
            b: Second number (will be subtracted from a)

        Returns:
            Difference of a and b
        """
        return a - b

    @staticmethod
    def multiply(a: Union[int, float], b: Union[int, float]) -> Union[int, float]:
        """Multiply two numbers.

        Args:
            a: First number
            b: Second number

        Returns:
            Product of a and b
        """
        return a * b

    @staticmethod
    def divide(a: Union[int, float], b: Union[int, float]) -> float:
        """Divide two numbers.

        Args:
            a: Dividend (numerator)
            b: Divisor (denominator)

        Returns:
            Quotient of a divided by b

        Raises:
            ValueError: If b (divisor) is zero
        """
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b
```

### Step 3.2: Create CLI Interface

Create `src/simple_calculator/cli.py`:

```python
"""Command-line interface for the calculator."""

import sys

from simple_calculator.core import Calculator


def main() -> None:
    """Run the calculator CLI.

    Usage:
        calc Add 2 6
        calc Multiply 3 4
        calc Divide 20 5
    """
    if len(sys.argv) != 4:
        print("Usage: calc Operation num1 num2", file=sys.stderr)
        print("Example: calc Add 2 6", file=sys.stderr)
        print("Operations: Add, Subtract, Multiply, Divide", file=sys.stderr)
        sys.exit(1)

    operation = sys.argv[1]
    num1_str = sys.argv[2]
    num2_str = sys.argv[3]

    try:
        num1 = float(num1_str)
        num2 = float(num2_str)
    except ValueError:
        print(f"Error: Numbers must be valid numbers, got '{num1_str}' and '{num2_str}'", file=sys.stderr)
        sys.exit(1)

    operation_lower = operation.lower()

    try:
        if operation_lower == "add":
            result = Calculator.add(num1, num2)
        elif operation_lower == "subtract":
            result = Calculator.subtract(num1, num2)
        elif operation_lower == "multiply":
            result = Calculator.multiply(num1, num2)
        elif operation_lower == "divide":
            result = Calculator.divide(num1, num2)
        else:
            print(f"Error: Unknown operation: {operation}", file=sys.stderr)
            print("Operations: Add, Subtract, Multiply, Divide", file=sys.stderr)
            sys.exit(1)

        print(f"{num1} {operation.lower()} {num2} = {result}")
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
```

### Step 3.3: Create Package __init__.py

Create `src/simple_calculator/__init__.py`:

```python
"""Simple Calculator - A professional command-line calculator package."""

from simple_calculator._version import __version__
from simple_calculator.core import Calculator

__all__ = ["Calculator", "__version__"]
```

---

## 🎯 Milestone Check: Can You Run the Calculator?

Before moving to the next section, let's verify everything works! You should be able to run the calculator from the command line.

### Step 1: Install the Package in Editable Mode

First, install the package with dev dependencies:

```bash
# Make sure you're in the project root
cd ~/simple-calculator

# Make sure venv is activated
source venv/bin/activate

# Install in editable mode with dev dependencies
pip install -e ".[dev]"

# Verify all tools installed
pytest --version
ruff --version
mypy --version
pre-commit --version
twine --version
```

You should see version numbers for all tools. If this fails, fix it before proceeding.

### Step 2: Test the Calculator Works

```bash
# Verify you're in the right directory
pwd
# Should end with: /path/to/simple-calculator

# Verify venv is activated
which python
# Should show: /path/to/simple-calculator/venv/bin/python

# Test the calculator
calc Add 2 6
# Expected output: 2.0 add 6.0 = 8.0

calc Multiply 3 4
# Expected output: 3.0 multiply 3.0 = 12.0

calc Divide 20 4
# Expected output: 20.0 divide 4.0 = 5.0

calc Subtract 10 3
# Expected output: 10.0 subtract 10.0 = 7.0
```

### Step 3: Test Error Handling

```bash
# Missing arguments
calc Add 5
# Expected: Shows usage error

# Invalid operation
calc Power 2 3
# Expected: Unknown operation error

# Invalid numbers
calc Add abc 5
# Expected: Numbers must be valid error

# Division by zero
calc Divide 10 0
# Expected: Cannot divide by zero error
```

### Step 4: If Everything Works ✅

Great! You've successfully:
- Created a Python package with proper structure
- Configured it with pyproject.toml
- Written working code (core.py, cli.py, __init__.py)
- Installed dev dependencies with `pip install -e ".[dev]"`
- Built the package
- **Can run it from the command line!**

You're ready to move to the next section: [Testing and Code Quality](./02-testing-and-code-quality.md).

### Step 5: If Something Doesn't Work ❌

**Issue: "Command 'calc' not found"**
- Verify venv is activated: `source venv/bin/activate`
- Verify installation: `pip install -e ".[dev]"`
- Check package was found: `python -m simple_calculator.cli Add 2 6`

**Issue: ModuleNotFoundError**
- Make sure you're in the project root directory
- Make sure venv is activated
- Reinstall: `pip install -e ".[dev]"`

**Issue: Import errors in cli.py or __init__.py**
- Check spelling of all imports
- Verify Calculator is defined in core.py
- Try: `python -c "from simple_calculator import Calculator; print(Calculator.add(5, 3))"`

---

## Next Steps

Once you've verified the calculator works, proceed to:

**[Part 4-5: Testing and Code Quality](./02-testing-and-code-quality.md)**
- Write comprehensive tests with pytest
- Set up code quality tools (ruff, mypy, pre-commit)
- Learn debugging techniques

---

## Related Guides

- **[Complete Tutorial Index](./complete-modern-project-tutorial.md)** - Overview of all parts
- **[Python Fundamentals](./README.md)** - Back to main Python guide
