# 🚀 Complete Modern Python Project Tutorial: Calculator Package

A comprehensive, hands-on tutorial that walks through building a professional Python package from scratch, testing, packaging, setting up CI/CD, and publishing to PyPI. This tutorial demonstrates the complete modern Python development workflow without requiring VS Code.

**← Back to**: [Modern Python Project Setup (2025)](./modern-project-setup.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn

- **Modern project setup** with src-layout and pyproject.toml
- **Environment management** with pyenv and virtual environments (Linux/WSL)
- **Building a professional package** with proper code organization
- **Writing comprehensive tests** with pytest
- **Code quality tools** (ruff, mypy, pytest)
- **Debugging techniques** (print, pdb, logging, pytest)
- **Pre-commit hooks** for automated checks
- **CI/CD setup** with GitHub Actions
- **Publishing to PyPI** using twine
- **Installing and using** your package from PyPI

---

## Prerequisites

- Linux/WSL environment with Python 3.11+
- Git installed and configured
- GitHub account (for CI/CD and publishing)
- PyPI account (for publishing)
- Basic command-line knowledge

---

## Project Overview

**Goal:** Build a professional Python package for a command-line calculator that supports:
- Addition (+), Subtraction (-), Multiplication (*), Division (/)
- Error handling for division by zero
- Comprehensive test coverage
- Professional packaging and distribution

**Final Project Structure:**

```
simple-calculator/
├── .github/
│   └── workflows/
│       └── tests.yml           # CI/CD pipeline
├── src/
│   └── simple_calculator/
│       ├── __init__.py
│       ├── _version.py         # Version management
│       ├── core.py             # Calculator logic
│       └── cli.py              # Command-line interface
├── tests/
│   ├── __init__.py
│   ├── test_core.py
│   └── test_cli.py
├── docs/
│   └── README.md
├── pyproject.toml              # Modern project config
├── .gitignore
├── .pre-commit-config.yaml
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
target-version = "py311"

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
- `target-version = "py311"` - Minimum Python version to target (affects which Python features Ruff checks for)

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
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, OR IN THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

Before writing tests, let's verify everything works! You should be able to run the calculator from the command line.

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

You're ready to move to Part 4: Write Comprehensive Tests.

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

**You're ready for Part 4.5: Initialize Git Repository and Push to GitHub!**

---

## Part 4.5: Initialize Git Repository and Push to GitHub

Now that you have working code and tests, it's time to put your project under version control and push it to GitHub. This is essential before setting up pre-commit hooks and CI/CD.

### Step 4.5.1: Initialize Local Git Repository

First, initialize Git in your project directory:

```bash
# Make sure you're in the project root
cd ~/simple-calculator

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial project setup with calculator implementation and tests"
```

You should see output like:
```
create mode 100644 .gitignore
create mode 100644 README.md
create mode 100644 pyproject.toml
create mode 100644 src/simple_calculator/__init__.py
create mode 100644 src/simple_calculator/_version.py
create mode 100644 src/simple_calculator/cli.py
create mode 100644 src/simple_calculator/core.py
create mode 100644 tests/__init__.py
create mode 100644 tests/test_cli.py
create mode 100644 tests/test_core.py
```

### Step 4.5.2: Create GitHub Repository

1. Go to [https://github.com/new](https://github.com/new)
2. **Repository name:** `simple-calculator` (or your preferred name)
3. **Description:** `A professional command-line calculator package`
4. **Public** or **Private:** Choose based on preference
5. **Initialize repository:** Leave unchecked (we already have local commits)
6. Click **Create repository**

GitHub will show you commands to push an existing repository. Copy the commands they show.

### Step 4.5.3: Connect Local Repo to GitHub

After creating the GitHub repo, you'll see something like this. Run these commands:

```bash
# Add the remote repository
git remote add origin https://github.com/YOUR_USERNAME/simple-calculator.git

# Rename branch to main (if not already)
git branch -M main

# Push to GitHub
git push -u origin main
```

**Replace `YOUR_USERNAME`** with your actual GitHub username.

**What `-u` does:** Sets the upstream tracking, so future `git push` and `git pull` commands know which remote branch to use.

### Step 4.5.4: Verify on GitHub

1. Go to your GitHub repository URL: `https://github.com/YOUR_USERNAME/simple-calculator`
2. You should see:
   - All your project files
   - Your commit history
   - The README.md file displayed on the main page
   - A green checkmark next to your initial commit (if CI/CD is working)

### Step 4.5.5: Update .gitignore (If Needed)

Make sure your `.gitignore` file has these common Python project entries:

```gitignore
# Virtual environments
venv/
env/
ENV/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
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
.tox/

# Type checking
.mypy_cache/
.dmypy.json
dmypy.json

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
```

### If Something Goes Wrong ❌

**Error: "fatal: not a git repository"**
```bash
# Make sure you're in the project root
cd ~/simple-calculator
# Check if .git directory exists
ls -la | grep .git
```

**Error: "fatal: remote origin already exists"**
```bash
# Remove the old remote
git remote remove origin
# Then add the correct one
git remote add origin https://github.com/YOUR_USERNAME/simple-calculator.git
```

**Error: "failed to push some refs to origin"**
```bash
# Pull any changes from GitHub first
git pull origin main --allow-unrelated-histories
# Then push
git push -u origin main
```

**Error: "Please make sure you have the correct access rights"**
- Check that you're logged in to GitHub
- Verify your username is correct in the URL
- Consider using SSH keys instead of HTTPS (see GitHub docs)

### If Setup Works ✅

Excellent! You've successfully:
- ✅ Initialized a local Git repository
- ✅ Made your first commit with all project files
- ✅ Connected to GitHub
- ✅ Pushed your code to the remote repository
- ✅ Set up version control for your project

**You're ready for Part 5: Code Quality Tools Setup!**

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

**Note:** Debugging techniques (print statements, breakpoints, pdb, logging, VS Code debugger) are covered in detail in our **Visual Studio Code Tutorial** in the next section of the knowledge library.

For now, remember:
- ✅ Your calculator code is simple and well-tested
- ✅ Pytest runs automatically and shows failures clearly
- ✅ Type checking with mypy catches errors early
- ✅ Pre-commit hooks ensure code quality

If you encounter issues during development, check:
1. Test output (run `pytest -v` to see detailed test results)
2. Type errors (run `mypy .` to check for type issues)
3. Code quality (run `ruff check .` to find style issues)

---

## Part 6: GitHub CI/CD Setup

GitHub Actions is GitHub's built-in continuous integration/continuous deployment (CI/CD) system. It automatically runs tests, linting, and type checking every time you push code to GitHub.

### Understanding GitHub Actions

**What it does:**
1. When you push code to GitHub → GitHub Actions automatically runs
2. Sets up a clean Linux machine (ubuntu-latest)
3. Installs Python and your dependencies
4. Runs your tests, linting, type checking
5. Reports success/failure in your GitHub repo
6. Optionally uploads coverage data

**Why it's useful:**
- ✅ Catch bugs before merging code
- ✅ Ensure code quality standards
- ✅ Test across multiple Python versions automatically
- ✅ Get a green checkmark ✓ on your commits if tests pass
- ✅ Prevent merging broken code to main branch

---

### Step 6.1: Create GitHub Actions Workflow

Create `.github/workflows/tests.yml`:

```yaml
name: Tests

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.11", "3.12", "3.13"]

    steps:
      - uses: actions/checkout@v4

      - name: Set up Python ${{ matrix.python-version }}
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}

      - name: Upgrade pip
        run: python -m pip install --upgrade pip

      - name: Install dependencies
        run: pip install -e ".[dev]"

      - name: Lint with Ruff
        run: ruff check .

      - name: Type check with mypy
        run: mypy .

      - name: Run tests with pytest
        run: pytest --cov --cov-report=xml

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
          flags: unittests
          name: codecov-umbrella
```

---

### Understanding the Workflow File (Line by Line)

#### **`name: Tests`**
- The name displayed in GitHub Actions UI
- Shows as "Tests" in your GitHub repo's "Actions" tab

#### **`on:` Section (When to Run)**
```yaml
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]
```
- **`push:` on branches** - Runs workflow when you push code to `main` or `develop`
- **`pull_request:` on branches** - Runs workflow when you create a pull request to `main` or `develop`
- This means tests run automatically before code gets merged

**Workflow triggered when:**
```
You make a commit → git push → GitHub Actions starts
                               ↓
                     Runs all steps in workflow
                               ↓
                     Shows ✓ (pass) or ✗ (fail)
```

#### **`jobs:` Section (What to Do)**
```yaml
jobs:
  test:    # Job name - can have multiple jobs
    runs-on: ubuntu-latest
```
- **`jobs:`** - List of tasks to run (you could have `test`, `lint`, `deploy`, etc.)
- **`test:`** - This job's name (what you call it)
- **`runs-on: ubuntu-latest`** - Run on Ubuntu Linux (free GitHub-hosted runner)

#### **`strategy: matrix:` Section (Test Multiple Versions)**
```yaml
strategy:
  matrix:
    python-version: ["3.11", "3.12", "3.13"]
```

**This creates 3 parallel jobs, one for each Python version:**

```
Workflow "Tests" starts
    ↓
Creates 3 identical jobs:
  Job 1: Test on Python 3.11
  Job 2: Test on Python 3.12
  Job 3: Test on Python 3.13
    ↓
All run in parallel (faster than sequentially)
    ↓
Workflow passes if ALL 3 pass
```

**Why test multiple versions?**
- ✅ Ensures code works on Python 3.11, 3.12, AND 3.13
- ✅ Catches version-specific bugs early
- ✅ Guarantees compatibility

#### **`steps:` Section (Individual Tasks)**

Each step runs sequentially. Here's what each does:

**Step 1: Checkout Code**
```yaml
- uses: actions/checkout@v4
```
- Downloads your repository code onto the GitHub Actions machine
- `v4` is the version of this pre-built action

**Step 2: Set Up Python**
```yaml
- name: Set up Python ${{ matrix.python-version }}
  uses: actions/setup-python@v4
  with:
    python-version: ${{ matrix.python-version }}
```
- Installs Python (version from matrix: 3.11, 3.12, or 3.13)
- `${{ matrix.python-version }}` is a variable - gets replaced with actual version
- Example: `${{ matrix.python-version }}` → `3.11` in first job, `3.12` in second, etc.

**Step 3: Upgrade pip**
```yaml
- name: Upgrade pip
  run: python -m pip install --upgrade pip
```
- Upgrades pip to latest version
- `run:` means execute a shell command

**Step 4: Install Dependencies**
```yaml
- name: Install dependencies
  run: pip install -e ".[dev]"
```
- Installs your package in editable mode with dev dependencies
- Same as you did locally: `pip install -e ".[dev]"`
- Downloads: pytest, ruff, mypy, and your package code

**Step 5: Lint with Ruff**
```yaml
- name: Lint with Ruff
  run: ruff check .
```
- Runs ruff to check for style issues
- Fails job if style issues found
- Forces consistent code quality

**Step 6: Type Check with mypy**
```yaml
- name: Type check with mypy
  run: mypy .
```
- Runs mypy to check for type errors
- Fails job if type errors found
- Ensures type safety

**Step 7: Run Tests**
```yaml
- name: Run tests with pytest
  run: pytest --cov --cov-report=xml
```
- Runs all your tests with coverage reporting
- `--cov` - measure code coverage
- `--cov-report=xml` - output coverage as XML (for Codecov)
- Fails job if any test fails

**Step 8: Upload Coverage (Optional)**
```yaml
- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v3
  with:
    file: ./coverage.xml
```
- Sends coverage report to Codecov.io
- Shows coverage badge and trends
- Requires signing up at codecov.io (optional step)

---

### What Happens When You Push Code

```
You run:
  git push origin main
       ↓
GitHub receives code
       ↓
Detects .github/workflows/tests.yml
       ↓
Creates 3 jobs (Python 3.11, 3.12, 3.13)
       ↓
Each job:
  1. Checks out code
  2. Sets up Python
  3. Installs dependencies
  4. Runs ruff (linting)
  5. Runs mypy (type checking)
  6. Runs pytest (tests)
  7. Uploads coverage
       ↓
If all steps pass → ✓ Green checkmark on commit
If any step fails → ✗ Red X on commit
       ↓
Commit in GitHub shows:
  "All checks passed" or "Some checks failed"
```

---

### Seeing Results in GitHub

After pushing with this workflow:

1. Go to your GitHub repo
2. Click "Actions" tab
3. See your workflow run:
   ```
   Tests #1 ✓
   - test (3.11) ✓
   - test (3.12) ✓
   - test (3.13) ✓
   Duration: 45 seconds
   ```

4. Click on a failed job to see error details
5. Each commit on main shows the status

### Step 6.2: Push to GitHub

```bash
# Create repository on GitHub (https://github.com/new)
# Then add remote and push

git remote add origin https://github.com/yourusername/simple-calculator.git
git branch -M main
git push -u origin main

# GitHub Actions will automatically run tests on push!
```

---

## Part 7: Build and Package

### Step 7.1: Install Build Tools

```bash
pip install build twine
```

### Step 7.2: Build Distribution

```bash
# Build both wheel and source distribution
python -m build

# Check contents
ls -lah dist/
# Output:
# simple_calculator-0.1.0-py3-none-any.whl
# simple_calculator-0.1.0.tar.gz
```

#### Troubleshooting Build Errors

**Error: `AbsoluteLinkError: 'simple_calculator-0.1.0/venv/bin/python' is a link to an absolute path`**

```
ERROR 'simple_calculator-0.1.0/venv/bin/python' is a link to an absolute path
```

**Cause:** Your virtual environment directory (`venv/`) is being included in the package. This happens when .gitignore is not committed or `venv/` is tracked by git.

**Solution 1: Remove venv from git tracking (Recommended)**

```bash
# Check if venv is tracked by git
git ls-files | grep venv

# If it shows venv files, remove them:
git rm -r --cached venv/

# Verify .gitignore has venv/ listed
cat .gitignore | grep venv

# Commit the change
git add .gitignore
git commit -m "Remove venv from git tracking"

# Now try building again
python -m build
```

**Solution 2: Delete and recreate venv**

```bash
# Deactivate if currently activated
deactivate

# Remove venv
rm -rf venv/

# Recreate venv
python -m venv venv
source venv/bin/activate

# Reinstall dependencies
pip install -e ".[dev]"

# Try building again
python -m build
```

**Why this happens:**
- Virtual environments contain symlinks to your system Python interpreter
- These symlinks have absolute paths that differ on each machine
- You should NEVER commit `venv/` to git (only on one computer per project)
- `.gitignore` prevents this, but only if venv/ wasn't already tracked

**How to prevent in future projects:**
1. Create `.gitignore` BEFORE creating `venv/`
2. Commit `.gitignore` early
3. Never commit `venv/`, `env/`, `.venv/`, or other virtual environments

### Step 7.3: Inspect Package

Wheels are ZIP files containing your package code and metadata. You can inspect them to verify everything was packaged correctly.

```bash
# Option 1: Using Python's zipfile module (Recommended - always available)
python -m zipfile -l dist/simple_calculator-0.1.0-py3-none-any.whl

# Option 2: Using unzip command (if installed)
unzip -l dist/simple_calculator-0.1.0-py3-none-any.whl

# Option 3: Extract and inspect with Python
python -c "
import zipfile
with zipfile.ZipFile('dist/simple_calculator-0.1.0-py3-none-any.whl') as z:
    for name in z.namelist():
        print(name)
"
```

**Expected output (with Option 1):**
```
Archive:  dist/simple_calculator-0.1.0-py3-none-any.whl
  Length      Date    Time    Name
---------  ---------- -----   ----
       45  2025-11-12 10:30   simple_calculator/__init__.py
       20  2025-11-12 10:30   simple_calculator/_version.py
     1234  2025-11-12 10:30   simple_calculator/core.py
      890  2025-11-12 10:30   simple_calculator/cli.py
      542  2025-11-12 10:30   simple_calculator-0.1.0.dist-info/WHEEL
      124  2025-11-12 10:30   simple_calculator-0.1.0.dist-info/METADATA
      145  2025-11-12 10:30   simple_calculator-0.1.0.dist-info/entry_points.txt
      256  2025-11-12 10:30   simple_calculator-0.1.0.dist-info/RECORD
```

#### Troubleshooting: `unzip` Command Not Found

**Error:** `Command 'unzip' not found`

**Why:** `unzip` is a system utility that's not always installed by default.

**Solutions:**

**Option A: Install unzip (Recommended if you use it frequently)**
```bash
# On Ubuntu/Debian
sudo apt install unzip

# On macOS
brew install unzip

# On Windows (via WSL2)
sudo apt install unzip
```

**Option B: Use Python instead (No installation needed)**
```bash
# Always works - Python is required for the project anyway
python -m zipfile -l dist/simple_calculator-0.1.0-py3-none-any.whl
```

**Why we recommend Option B for this tutorial:**
- ✅ Python is always available (you need it for the project)
- ✅ Cross-platform (works on Windows, macOS, Linux)
- ✅ No additional system dependencies
- ✅ Included in Python's standard library

**What to look for in the wheel:**
- ✓ Your source code files (`core.py`, `cli.py`, etc.)
- ✓ Package metadata directory (`.dist-info/`)
- ✓ METADATA file (with your project description)
- ✓ entry_points.txt (with your `calc` command)
- ✗ Should NOT have: `venv/`, `tests/`, `.git/`, `__pycache__/`

---

## Part 8: Publishing to PyPI

### Step 8.1: Create PyPI Account

1. Go to https://pypi.org/account/register/
2. Create account
3. Enable two-factor authentication
4. Create API token at https://pypi.org/manage/account/tokens/

### Step 8.2: Create .pypirc Configuration

Create `~/.pypirc`:

```ini
[distutils]
index-servers =
    pypi

[pypi]
repository = https://upload.pypi.org/legacy/
username = __token__
password = pypi-AgEIcHlwaS5vcmc...  # Your API token
```

**Security Note:** Store token securely, never commit to git!

### Step 8.3: Upload to PyPI (Test First)

```bash
# Test PyPI upload first
twine upload --repository testpypi dist/*

# If successful, upload to production PyPI
twine upload dist/*

# Verify on PyPI
# https://pypi.org/project/simple-calculator/
```

### Step 8.4: Verify Installation from PyPI

```bash
# Create new test environment
cd /tmp
python -m venv test_env
source test_env/bin/activate

# Install from PyPI
pip install simple-calculator

# Test usage
calc "10 + 5"
calc "20 * 3"

# Use in Python
python -c "from simple_calculator import Calculator; print(Calculator.add(10, 5))"

# Check version
python -c "import simple_calculator; print(simple_calculator.__version__)"
```

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

*Last updated: 2025-11-11*
