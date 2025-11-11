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
version = {attr = "simple_calculator._version.__version__"}
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
addopts = "-ra -q --strict-markers --cov=src/simple_calculator --cov-report=term-missing --cov-report=html"
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
- `version = {attr = "simple_calculator._version.__version__"}` - **Dynamic versioning**: reads version from `_version.py` instead of hardcoding it here. This is the recommended approach because you only update the version in one place
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
- `addopts = "-ra -q --strict-markers --cov=src/simple_calculator --cov-report=term-missing --cov-report=html"` - Default options when running `pytest`:
  - `-ra` - Show all test results summary
  - `-q` - Quiet output (less verbose)
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
```

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
        print("Usage: calc Operation num1 num2")
        print("Example: calc Add 2 6")
        print("Operations: Add, Subtract, Multiply, Divide")
        sys.exit(1)

    operation = sys.argv[1]
    num1_str = sys.argv[2]
    num2_str = sys.argv[3]

    try:
        num1 = float(num1_str)
        num2 = float(num2_str)
    except ValueError:
        print(f"Error: Numbers must be valid numbers, got '{num1_str}' and '{num2_str}'")
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
            print(f"Error: Unknown operation: {operation}")
            print("Operations: Add, Subtract, Multiply, Divide")
            sys.exit(1)

        print(f"{num1} {operation.lower()} {num2} = {result}")
    except ValueError as e:
        print(f"Error: {e}")
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

## Part 5: Code Quality Tools Setup

### Step 5.1: Install Development Dependencies

```bash
# Install all dev tools
pip install -e ".[dev]"

# Verify installations
pytest --version
ruff --version
mypy --version
pre-commit --version
twine --version
```

### Step 5.2: Create Pre-commit Configuration

Create `.pre-commit-config.yaml`:

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
        additional_dependencies: ["types-all"]
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

### Step 5.3: Install Pre-commit Hooks

```bash
# Install git hooks
pre-commit install

# Run on all files to check
pre-commit run --all-files

# Commit hook will run automatically before commits
git add .
git commit -m "Initial project setup"
```

### Step 5.4: Run Quality Checks Manually

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

Debugging is essential for understanding what your code is doing and finding problems. There are several approaches from simple to advanced.

### Using Print Debugging

The simplest approach is using `print()` statements:

```python
# src/simple_calculator/core.py
@staticmethod
def divide(a: Union[int, float], b: Union[int, float]) -> float:
    """Divide two numbers."""
    print(f"DEBUG: divide called with a={a}, b={b}")  # Add debug info

    if b == 0:
        print(f"DEBUG: b is zero, raising ValueError")
        raise ValueError("Cannot divide by zero")

    result = a / b
    print(f"DEBUG: returning result={result}")
    return result
```

Run with print debugging:

```bash
# Activate venv
source venv/bin/activate

# Run with calculator in interactive mode
python -m simple_calculator.cli

# Or test specific function
python -c "from simple_calculator.core import Calculator; print(Calculator.divide(10, 2))"
```

**Pros:** Simple, no setup needed
**Cons:** Requires manual addition/removal, clutters code

### Using Python Debugger (pdb)

Python includes a built-in debugger `pdb` (Python Debugger) for interactive debugging.

**Set a breakpoint in your code:**

```python
# src/simple_calculator/core.py
import pdb

@staticmethod
def divide(a: Union[int, float], b: Union[int, float]) -> float:
    """Divide two numbers."""
    pdb.set_trace()  # Debugger will pause here

    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
```

**Or use the built-in breakpoint():**

```python
# Modern Python 3.7+ approach
@staticmethod
def divide(a: Union[int, float], b: Union[int, float]) -> float:
    """Divide two numbers."""
    breakpoint()  # Debugger will pause here

    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
```

**Debug in interactive mode:**

```bash
# Start calculator in interactive mode
python -m simple_calculator.cli

# When you hit a breakpoint, you'll see:
# > /home/user/simple-calculator/src/simple_calculator/core.py(14)divide()
# -> if b == 0:

# Common pdb commands:
(Pdb) n          # Next line
(Pdb) s          # Step into function
(Pdb) c          # Continue execution
(Pdb) l          # List source code
(Pdb) p a        # Print variable a
(Pdb) p locals() # Print all local variables
(Pdb) w          # Show where you are in stack
(Pdb) u          # Move up in stack
(Pdb) d          # Move down in stack
(Pdb) h          # Help
(Pdb) q          # Quit debugger
```

**Example debugging session:**

```bash
$ python -c "from simple_calculator.core import Calculator; Calculator.divide(10, 0)"

> /home/user/simple-calculator/src/simple_calculator/core.py(14)divide()
-> if b == 0:
(Pdb) p a
10
(Pdb) p b
0
(Pdb) p b == 0
True
(Pdb) c
ValueError: Cannot divide by zero
```

### Debugging Tests with pytest

Debug failing tests interactively:

```bash
# Run pytest with pdb on failures
pytest --pdb tests/test_core.py

# When a test fails, drop into debugger automatically

# Run pytest with pdb on first failure, then stop
pytest --pdb --lf tests/

# Show local variables on failure
pytest -l tests/test_core.py
```

**Example: Debug a failing test**

```bash
$ pytest --pdb tests/test_core.py::TestCalculatorBasicOperations::test_divide

# Test runs and hits a failure
# You drop into pdb automatically at the failure point
(Pdb) p result
5.0
(Pdb) p expected
5
(Pdb) result == expected
False
(Pdb) c  # Continue to next failure or exit
```

### Using Logging Instead of Print

For production code, use `logging` module instead of print:

```python
# src/simple_calculator/core.py
import logging

logger = logging.getLogger(__name__)

class Calculator:
    @staticmethod
    def divide(a: Union[int, float], b: Union[int, float]) -> float:
        """Divide two numbers."""
        logger.debug(f"Dividing {a} by {b}")

        if b == 0:
            logger.error("Attempted division by zero")
            raise ValueError("Cannot divide by zero")

        result = a / b
        logger.debug(f"Division result: {result}")
        return result
```

**Configure logging in CLI:**

```python
# src/simple_calculator/cli.py
import logging
import sys

# Configure logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('calculator.log')
    ]
)

def main() -> None:
    """Run the calculator CLI."""
    logger = logging.getLogger(__name__)
    logger.info("Starting calculator")
    # ... rest of code
```

**Run with logging:**

```bash
# See debug output
python -m simple_calculator.cli

# Output:
# 2025-11-11 14:32:10,123 - simple_calculator.cli - INFO - Starting calculator
# 2025-11-11 14:32:15,456 - simple_calculator.core - DEBUG - Dividing 10 by 2
```

**Change logging level:**

```python
# Control verbosity
logging.basicConfig(level=logging.WARNING)  # Only warnings and errors
logging.basicConfig(level=logging.DEBUG)    # Everything
logging.basicConfig(level=logging.INFO)     # Info level and higher
```

### Debugging from Command Line

Test individual functions directly:

```bash
# Test function with print debugging
python -c "
from simple_calculator.core import Calculator
result = Calculator.add(5, 3)
print(f'5 + 3 = {result}')
"

# Interactive Python shell
python
>>> from simple_calculator.core import Calculator
>>> calc = Calculator()
>>> calc.add(10, 5)
15
>>> calc.divide(10, 0)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "src/simple_calculator/core.py", line 25, in divide
    raise ValueError("Cannot divide by zero")
ValueError: Cannot divide by zero
```

### Debugging Tips and Common Issues

**Issue: "ModuleNotFoundError" when debugging**

```bash
# Make sure you're in venv and package is installed
source venv/bin/activate
pip install -e .  # Editable install for debugging

# Then debug
python -m simple_calculator.cli
```

**Issue: Breakpoints not stopping**

```python
# Make sure to use correct syntax
breakpoint()  # Python 3.7+

# Or
import pdb; pdb.set_trace()

# Not:
pdb.breakpoint()  # Wrong - doesn't exist
```

**Issue: Debug prints showing in test output**

```bash
# Use -s flag to show output
pytest -s tests/

# Or redirect to file
pytest -s tests/ > debug.log 2>&1
```

**Debugging async code:**

For async functions, use debugger with asyncio:

```python
import asyncio
import pdb

async def divide_async(a, b):
    breakpoint()  # Still works with async
    return a / b

asyncio.run(divide_async(10, 2))
```

### Debugging Checklist

- [ ] Use `print()` for quick debugging
- [ ] Use `breakpoint()` for interactive debugging
- [ ] Learn key pdb commands (n, s, c, p, l)
- [ ] Run pytest with `--pdb` for test debugging
- [ ] Use logging for production-level debugging
- [ ] Log to both console and file
- [ ] Set appropriate logging levels
- [ ] Never commit debug code with print/breakpoint
- [ ] Use `.gitignore` to ignore `.log` files
- [ ] Test clean code path after debugging

---

## Part 6: GitHub CI/CD Setup

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

### Step 7.3: Inspect Package

```bash
# Inspect wheel contents (it's a ZIP file)
unzip -l dist/simple_calculator-0.1.0-py3-none-any.whl

# Verify metadata
python -m zipfile -l dist/simple_calculator-0.1.0-py3-none-any.whl
```

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
