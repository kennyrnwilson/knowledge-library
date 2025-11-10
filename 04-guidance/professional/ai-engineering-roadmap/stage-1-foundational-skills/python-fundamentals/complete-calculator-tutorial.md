# 📋 Complete Calculator Tutorial: End-to-End VS Code Setup

A comprehensive, hands-on tutorial that walks through building, testing, linting, and debugging a command-line calculator in VS Code. This tutorial covers the full development workflow from initial setup to running and debugging.

**← Back to**: [Coding Python in VS Code (2025): A Practical Guide](./vs-code-setup.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn

- **Complete VS Code setup** from scratch for a new project
- **Python environment configuration** with virtual environments
- **Project structure** organized for professional Python development
- **Building a complete application** with proper code organization
- **Writing comprehensive tests** with pytest
- **Linting and type checking** with Ruff and MyPy
- **Running and debugging** your application in VS Code
- **Using your code in Jupyter notebooks** for interactive exploration

---

## 🔗 Learning Resources

**Prerequisites:**
- VS Code installed
- Python 3.11+ installed
- Basic Python knowledge
- Understanding of command line

**Related:**
- [[Coding Python in VS Code (2025): A Practical Guide]] - Main guide
- [[Python Linters: Code Quality Analysis]] - Detailed linting guide
- [pytest Documentation](https://docs.pytest.org/)
- [Ruff Documentation](https://docs.astral.sh/ruff/)

---

## Project Overview

**Goal:** Build a command-line calculator that supports:
- Addition (+)
- Subtraction (-)
- Multiplication (*)
- Division (/) with error handling

**Final Project Structure:**
```
calculator-project/
├── .vscode/
│   ├── settings.json       # VS Code configuration
│   ├── launch.json         # Debug configurations
│   └── tasks.json          # Build tasks
├── .venv/                  # Virtual environment
├── src/
│   ├── __init__.py
│   └── calculator.py       # Main calculator module
├── tests/
│   ├── __init__.py
│   └── test_calculator.py  # Comprehensive tests
├── pyproject.toml          # Project configuration
├── README.md               # Project documentation
└── .gitignore
```

---

## Part 1: Initial Setup

### Step 1.1: Create Project Directory

Open a terminal and create your project:

```bash
# Create and navigate to project
mkdir calculator-project
cd calculator-project

# Open in VS Code
code .
```

VS Code opens with your new project folder.

### Step 1.2: Create Virtual Environment

In VS Code's integrated terminal (`Ctrl+\``):

```bash
# Windows
python -m venv .venv
.venv\Scripts\activate

# macOS/Linux
python -m venv .venv
source .venv/bin/activate
```

You should see `(.venv)` at the start of your terminal prompt.

**Verify Python:**

```bash
python --version
# Output: Python 3.11.x
which python
# Shows path to .venv Python
```

### Step 1.3: Install Development Tools

```bash
# Upgrade pip first
pip install --upgrade pip

# Install testing framework
pip install pytest pytest-cov

# Install linting and type checking
pip install ruff mypy
```

**Verify installations:**

```bash
pytest --version
ruff --version
mypy --version
```

### Step 1.4: Select Python Interpreter in VS Code

1. Press `Ctrl+Shift+P` to open Command Palette
2. Type "Python: Select Interpreter"
3. Choose the one showing `.venv` (or your project path)

**Verify selection:**
- Look at bottom-right of VS Code
- Should show interpreter path with `.venv`
- Terminal should auto-activate .venv on open

### Step 1.5: Create Project Structure

In VS Code terminal:

```bash
# Create directories
mkdir src
mkdir tests

# Create Python files
touch src/__init__.py
touch src/calculator.py
touch tests/__init__.py
touch tests/test_calculator.py
touch pyproject.toml
touch README.md
touch .gitignore
```

Your file explorer should show this structure.

---

## Part 2: VS Code Configuration

### Step 2.1: Create Settings File

Create `.vscode/settings.json`:

```json
{
  "python.defaultInterpreterPath": "${workspaceFolder}/.venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit"
    }
  },
  "ruff.enable": true,
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": [
    "tests",
    "-v",
    "--cov=src",
    "--cov-report=term-missing"
  ],
  "python.analysis.typeCheckingMode": "basic",
  "python.analysis.extraPaths": [
    "${workspaceFolder}/src"
  ]
}
```

**What each setting does:**
- `defaultInterpreterPath`: Tells VS Code to use .venv Python
- `activateEnvironment`: Auto-activates venv in terminal
- `defaultFormatter`: Uses Ruff for formatting
- `formatOnSave`: Automatically formats on save
- `pytestEnabled`: Enables pytest integration
- `typeCheckingMode`: Enables basic type checking

### Step 2.2: Create Debug Configurations

Create `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: Calculator Demo",
      "type": "python",
      "request": "launch",
      "program": "${workspaceFolder}/src/calculator.py",
      "console": "integratedTerminal",
      "justMyCode": true
    },
    {
      "name": "Python: Debug Tests",
      "type": "python",
      "request": "launch",
      "module": "pytest",
      "args": [
        "tests",
        "-v",
        "-s"
      ],
      "console": "integratedTerminal",
      "justMyCode": true
    },
    {
      "name": "Python: Debug Specific Test",
      "type": "python",
      "request": "launch",
      "module": "pytest",
      "args": [
        "${file}",
        "-v",
        "-s"
      ],
      "console": "integratedTerminal",
      "justMyCode": true
    }
  ]
}
```

**Configuration explanations:**
- **Calculator Demo**: Runs the interactive calculator
- **Debug Tests**: Runs all tests with output
- **Debug Specific Test**: Runs only the current file's tests

### Step 2.3: Create Build Tasks

Create `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Tests",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/pytest",
      "args": [
        "tests",
        "-v",
        "--cov=src",
        "--cov-report=term-missing"
      ],
      "group": {
        "kind": "test",
        "isDefault": true
      },
      "problemMatcher": []
    },
    {
      "label": "Lint Code (Ruff)",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/ruff",
      "args": [
        "check",
        "."
      ],
      "group": {
        "kind": "build"
      },
      "problemMatcher": []
    },
    {
      "label": "Auto-fix Linting Issues",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/ruff",
      "args": [
        "check",
        ".",
        "--fix"
      ],
      "group": {
        "kind": "build"
      },
      "problemMatcher": []
    },
    {
      "label": "Type Check (MyPy)",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/mypy",
      "args": ["."],
      "group": {
        "kind": "build"
      },
      "problemMatcher": []
    },
    {
      "label": "Run Calculator",
      "type": "shell",
      "command": "${workspaceFolder}/.venv/bin/python",
      "args": ["${workspaceFolder}/src/calculator.py"],
      "group": {
        "kind": "build"
      },
      "problemMatcher": []
    },
    {
      "label": "Full Quality Check",
      "type": "shell",
      "command": "/bin/bash",
      "args": [
        "-c",
        "ruff check . && mypy . && pytest tests -v --cov=src"
      ],
      "group": {
        "kind": "build"
      },
      "problemMatcher": []
    }
  ]
}
```

**Task explanations:**
- **Run Tests**: Execute all tests with coverage
- **Lint Code**: Check for style violations
- **Auto-fix Linting**: Automatically fix issues
- **Type Check**: Validate type hints
- **Run Calculator**: Run the interactive program
- **Full Quality Check**: Run all checks sequentially

---

## Part 3: Create the Calculator Module

### Step 3.1: Write Calculator Code

Edit `src/calculator.py`:

```python
"""Simple command-line calculator supporting basic arithmetic operations."""

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
    def subtract(a: Union[int, float], b: Union[int, float]) -> Union[int, float]:
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


def main() -> None:
    """Run interactive calculator."""
    calculator = Calculator()

    print("Simple Calculator")
    print("================")
    print("Operations: +, -, *, /")
    print("Type 'quit' to exit\n")

    while True:
        try:
            user_input = input("Enter expression (e.g., 5 + 3): ").strip()

            if user_input.lower() == "quit":
                print("Goodbye!")
                break

            # Parse input
            parts = user_input.split()
            if len(parts) != 3:
                print("Invalid format. Use: number operator number")
                continue

            a_str, operator, b_str = parts

            # Convert to numbers
            try:
                a = float(a_str)
                b = float(b_str)
            except ValueError:
                print("Error: Please enter valid numbers")
                continue

            # Perform calculation
            if operator == "+":
                result = calculator.add(a, b)
            elif operator == "-":
                result = calculator.subtract(a, b)
            elif operator == "*":
                result = calculator.multiply(a, b)
            elif operator == "/":
                result = calculator.divide(a, b)
            else:
                print(f"Error: Unknown operator '{operator}'")
                continue

            print(f"Result: {result}\n")

        except ValueError as e:
            print(f"Error: {e}\n")
        except KeyboardInterrupt:
            print("\nCalculator interrupted")
            break
        except Exception as e:
            print(f"Unexpected error: {e}\n")


if __name__ == "__main__":
    main()
```

**Code features:**
- Type hints on all parameters and return values
- Comprehensive docstrings for every method
- Error handling for division by zero
- Interactive command-line interface
- Proper exception handling

### Step 3.2: Watch Linting in Action

As you save `calculator.py`, you should notice:
- Squiggly underlines appear for any issues
- Hover over them to see the problem
- Ruff auto-fixes on save

---

## Part 4: Write Comprehensive Tests

### Step 4.1: Create Test File

Edit `tests/test_calculator.py`:

```python
"""Tests for the calculator module."""

import pytest
from src.calculator import Calculator


class TestCalculatorAdd:
    """Test addition operations."""

    def test_add_positive_integers(self) -> None:
        """Test adding two positive integers."""
        result = Calculator.add(5, 3)
        assert result == 8

    def test_add_negative_integers(self) -> None:
        """Test adding negative integers."""
        result = Calculator.add(-5, -3)
        assert result == -8

    def test_add_mixed_signs(self) -> None:
        """Test adding numbers with different signs."""
        result = Calculator.add(5, -3)
        assert result == 2

    def test_add_floats(self) -> None:
        """Test adding floating point numbers."""
        result = Calculator.add(2.5, 3.5)
        assert result == 6.0

    def test_add_zero(self) -> None:
        """Test adding zero."""
        result = Calculator.add(5, 0)
        assert result == 5


class TestCalculatorSubtract:
    """Test subtraction operations."""

    def test_subtract_positive_integers(self) -> None:
        """Test subtracting positive integers."""
        result = Calculator.subtract(10, 3)
        assert result == 7

    def test_subtract_negative_result(self) -> None:
        """Test subtraction resulting in negative."""
        result = Calculator.subtract(3, 10)
        assert result == -7

    def test_subtract_negative_integers(self) -> None:
        """Test subtracting negative integers."""
        result = Calculator.subtract(-5, -3)
        assert result == -2

    def test_subtract_floats(self) -> None:
        """Test subtracting floats."""
        result = Calculator.subtract(5.5, 2.5)
        assert result == 3.0


class TestCalculatorMultiply:
    """Test multiplication operations."""

    def test_multiply_positive_integers(self) -> None:
        """Test multiplying positive integers."""
        result = Calculator.multiply(4, 5)
        assert result == 20

    def test_multiply_by_zero(self) -> None:
        """Test multiplying by zero."""
        result = Calculator.multiply(5, 0)
        assert result == 0

    def test_multiply_negative_numbers(self) -> None:
        """Test multiplying negative numbers."""
        result = Calculator.multiply(-4, -5)
        assert result == 20

    def test_multiply_mixed_signs(self) -> None:
        """Test multiplying with different signs."""
        result = Calculator.multiply(-4, 5)
        assert result == -20

    def test_multiply_floats(self) -> None:
        """Test multiplying floats."""
        result = Calculator.multiply(2.5, 4.0)
        assert result == 10.0


class TestCalculatorDivide:
    """Test division operations."""

    def test_divide_positive_integers(self) -> None:
        """Test dividing positive integers."""
        result = Calculator.divide(10, 2)
        assert result == 5.0

    def test_divide_negative_numbers(self) -> None:
        """Test dividing negative numbers."""
        result = Calculator.divide(-10, 2)
        assert result == -5.0

    def test_divide_mixed_signs(self) -> None:
        """Test dividing with different signs."""
        result = Calculator.divide(10, -2)
        assert result == -5.0

    def test_divide_floats(self) -> None:
        """Test dividing floats."""
        result = Calculator.divide(10.0, 2.5)
        assert result == 4.0

    def test_divide_by_zero_raises_error(self) -> None:
        """Test that dividing by zero raises ValueError."""
        with pytest.raises(ValueError, match="Cannot divide by zero"):
            Calculator.divide(10, 0)

    def test_divide_zero_by_number(self) -> None:
        """Test dividing zero by a number."""
        result = Calculator.divide(0, 5)
        assert result == 0.0
```

**Test organization:**
- 4 test classes (one per operation)
- 23 total test cases
- Tests for normal operation, edge cases, and error handling
- Clear test names describing what's being tested
- Docstrings explaining each test

---

## Part 5: Configure Project Settings

### Step 5.1: Create pyproject.toml

Edit `pyproject.toml`:

```toml
[project]
name = "calculator"
version = "0.1.0"
description = "A simple command-line calculator"
requires-python = ">=3.11"
authors = [{name = "Your Name", email = "you@example.com"}]

[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[tool.ruff]
line-length = 100
target-version = "py311"
exclude = [".venv", "build", "dist", "__pycache__"]

[tool.ruff.lint]
select = [
    "E",    # pycodestyle errors
    "F",    # Pyflakes
    "W",    # pycodestyle warnings
    "I",    # isort (import sorting)
    "N",    # pep8-naming
    "UP",   # pyupgrade
    "B",    # flake8-bugbear
    "A",    # flake8-builtins
    "C4",   # flake8-comprehensions
]
ignore = ["E501"]  # Line too long

[tool.ruff.lint.isort]
known-first-party = ["calculator"]

[tool.mypy]
python_version = "3.11"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = false
ignore_missing_imports = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = "--cov=src --cov-report=term-missing --cov-report=html"
```

**Configuration sections:**
- **[project]**: Project metadata
- **[tool.ruff]**: Linting and formatting rules
- **[tool.mypy]**: Type checking settings
- **[tool.pytest.ini_options]**: Testing configuration

### Step 5.2: Create .gitignore

Edit `.gitignore`:

```
# Virtual environments
.venv/
venv/
env/

# Python cache
__pycache__/
*.pyc
*.pyo
*.egg-info/

# Testing
.pytest_cache/
.coverage
htmlcov/

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db
```

---

## Part 6: Linting and Type Checking

### Step 6.1: Run Ruff (Linter)

In terminal:

```bash
# Check for issues
ruff check .

# Output should be clean (no errors)
# If there are issues, fix them:
ruff check . --fix
```

### Step 6.2: Run MyPy (Type Checker)

```bash
# Type check all files
mypy .

# Should show no errors
# If issues exist, they'll show with line numbers
```

### Step 6.3: View Issues in Editor

Issues appear as squiggly underlines while you type:
1. Hover over underline to see issue
2. Press `Ctrl+.` to see suggested fixes
3. Save file to auto-fix (if format on save enabled)

---

## Part 7: Running Tests

### Step 7.1: Open Test Explorer

1. Click beaker icon in VS Code sidebar
2. You see test classes and functions listed
3. Test Explorer should show:
   - TestCalculatorAdd (5 tests)
   - TestCalculatorSubtract (4 tests)
   - TestCalculatorMultiply (5 tests)
   - TestCalculatorDivide (6 tests)

### Step 7.2: Run All Tests

Click play button at top of Test Explorer, or:

```bash
# Terminal
pytest tests -v

# Expected output:
# tests/test_calculator.py::TestCalculatorAdd::test_add_positive_integers PASSED
# tests/test_calculator.py::TestCalculatorAdd::test_add_negative_integers PASSED
# ... (20 more tests)
# ======================== 20 passed in 0.15s ========================
```

### Step 7.3: Run Specific Tests

**From Test Explorer:**
- Click play button next to test name
- Only that test runs

**From terminal:**

```bash
# Run specific class
pytest tests/test_calculator.py::TestCalculatorAdd -v

# Run specific test
pytest tests/test_calculator.py::TestCalculatorAdd::test_add_positive_integers -v
```

### Step 7.4: View Coverage Report

Tests already generate coverage. After running:

1. Look in project for `htmlcov/` folder
2. Right-click `htmlcov/index.html`
3. Select "Open with Live Server"
4. See detailed coverage breakdown

Coverage should show:
- `src/calculator.py`: 100% coverage
- All branches tested

### Step 7.5: Run Tests via Task

```
Ctrl+Shift+P → "Tasks: Run Task" → "Run Tests"
```

Output shows in Terminal panel with coverage report.

---

## Part 8: Debugging the Calculator

### Step 8.1: Debug the Main Program

1. Open `src/calculator.py`
2. Click to left of line 51 (in `divide` method)
3. Red breakpoint dot appears
4. Press `F5` or click "Run and Debug" button
5. Select "Python: Calculator Demo"

**In the running calculator:**
```
Enter expression (e.g., 5 + 3): 10 / 2
```

**Execution pauses at breakpoint:**
- Variables panel shows: `a=10.0`, `b=2.0`
- Call stack shows: `divide → main`

**Step through code:**
- `F10`: Step over (execute line, don't enter function)
- `F11`: Step into (enter function calls)
- `Shift+F11`: Step out (exit current function)
- `F5`: Continue execution
- `Shift+F5`: Stop debugging

### Step 8.2: Debug Tests

1. Open `tests/test_calculator.py`
2. Right-click on test function
3. Select "Debug Test"

**Or use launch configuration:**
1. Press `F5`
2. Select "Python: Debug Tests"
3. All tests run with debugging enabled
4. Any breakpoints pause execution

### Step 8.3: Conditional Breakpoints

Right-click on breakpoint dot:
```
Edit Breakpoint → Add condition
```

**Example conditions:**
```
a > 10       # Break when a exceeds 10
b == 0       # Break when dividing by zero
x == y       # Break when condition true
```

---

## Part 9: Running the Calculator

### Step 9.1: Run via Task

```
Ctrl+Shift+P → "Tasks: Run Task" → "Run Calculator"
```

### Step 9.2: Run from Terminal

```bash
python src/calculator.py
```

### Step 9.3: Interactive Session Example

```
Simple Calculator
================
Operations: +, -, *, /
Type 'quit' to exit

Enter expression (e.g., 5 + 3): 10 + 5
Result: 15

Enter expression (e.g., 5 + 3): 20 / 4
Result: 5.0

Enter expression (e.g., 5 + 3): 100 * 2
Result: 200

Enter expression (e.g., 5 + 3): 10 / 0
Error: Cannot divide by zero

Enter expression (e.g., 5 + 3): quit
Goodbye!
```

### Step 9.4: Run Full Quality Check

```
Ctrl+Shift+P → "Tasks: Run Task" → "Full Quality Check"
```

This runs:
1. Ruff linting
2. MyPy type checking
3. Pytest tests with coverage

All in sequence. Build fails if any check fails.

---

## Part 10: Optional - Using in Jupyter Notebooks

### Step 10.1: Install Jupyter

```bash
pip install jupyter ipykernel
```

### Step 10.2: Create Notebook

```
Ctrl+Shift+P → "Create: New Jupyter Notebook"
```

Save as `calculator_exploration.ipynb`

### Step 10.3: Add Notebook Cells

**Cell 1: Setup**

```python
import sys
sys.path.insert(0, '.')
from src.calculator import Calculator

calc = Calculator()
print("Calculator ready!")
```

Run with `Ctrl+Enter`

**Cell 2: Basic Operations**

```python
# Test each operation
print(f"5 + 3 = {calc.add(5, 3)}")
print(f"10 - 4 = {calc.subtract(10, 4)}")
print(f"6 * 7 = {calc.multiply(6, 7)}")
print(f"20 / 5 = {calc.divide(20, 5)}")
```

**Cell 3: Error Handling**

```python
# Test division by zero
try:
    calc.divide(10, 0)
except ValueError as e:
    print(f"Caught error: {e}")
```

**Cell 4: Batch Calculations**

```python
# Calculate multiple results
operations = [
    (10, 5, "add"),
    (20, 8, "subtract"),
    (4, 6, "multiply"),
    (30, 5, "divide"),
]

for a, b, op in operations:
    method = getattr(calc, op)
    result = method(a, b)
    print(f"{op.upper():10} {a:3} and {b:3} = {result:6.1f}")
```

**Cell 5: Visualization (if matplotlib installed)**

```bash
# Install in terminal
pip install matplotlib
```

```python
import matplotlib.pyplot as plt

# Create test data
dividend = 100
divisors = [1, 2, 5, 10, 20, 25]
results = [calc.divide(dividend, d) for d in divisors]

# Plot
plt.figure(figsize=(10, 6))
plt.plot(divisors, results, marker='o', linewidth=2, markersize=8)
plt.xlabel('Divisor')
plt.ylabel(f'Result ({dividend} / divisor)')
plt.title('Division Results with Different Divisors')
plt.grid(True, alpha=0.3)
plt.show()
```

**Cell 6: Interactive Exploration**

```python
# Experiment with different values
x = calc.add(15, 25)
y = calc.multiply(x, 2)
z = calc.divide(y, 5)
print(f"(15 + 25) * 2 / 5 = {z}")

# Test with floats
a, b = 3.5, 2.5
print(f"\n{a} + {b} = {calc.add(a, b)}")
print(f"{a} - {b} = {calc.subtract(a, b)}")
print(f"{a} * {b} = {calc.multiply(a, b)}")
print(f"{a} / {b} = {calc.divide(a, b)}")
```

### Step 10.4: Advantages of Jupyter for Calculator

- **Interactive Testing**: Test operations without restart
- **Visual Output**: See results immediately
- **Documentation**: Mix code and markdown
- **Exploration**: Experiment with edge cases
- **Visualization**: Plot calculation results
- **Sharing**: Save as shareable notebook

---

## ✅ Complete Workflow Checklist

### VS Code and Environment Setup
- [ ] Create project directory and open in VS Code
- [ ] Create and activate virtual environment
- [ ] Install pytest, ruff, mypy
- [ ] Create `.vscode/`, `src/`, `tests/` directories
- [ ] Verify Python interpreter selected in VS Code
- [ ] Create `.vscode/settings.json` with configuration
- [ ] Create `.vscode/launch.json` with debug configs
- [ ] Create `.vscode/tasks.json` with build tasks

### Code Development
- [ ] Write `src/calculator.py` with all operations
- [ ] Add type hints to all functions
- [ ] Write comprehensive docstrings
- [ ] Save and verify linting passes (Ruff underlines resolved)
- [ ] Run `mypy .` to verify type checking passes
- [ ] Create `tests/test_calculator.py` with 20+ tests
- [ ] Organize tests into classes by operation

### Configuration
- [ ] Create `pyproject.toml` with Ruff, MyPy, pytest settings
- [ ] Create `.gitignore` with Python ignores
- [ ] Verify all settings align across configurations

### Testing
- [ ] Open Test Explorer (beaker icon)
- [ ] Verify all test classes visible
- [ ] Run all tests - all should pass
- [ ] Run specific test class
- [ ] Run with coverage report
- [ ] View HTML coverage report

### Linting and Type Checking
- [ ] Run `ruff check .` - should pass
- [ ] Run `mypy .` - should pass
- [ ] See no squiggly underlines in editor
- [ ] Test `Ctrl+.` quick fix on intentional issue
- [ ] Save file and verify auto-formatting works

### Debugging
- [ ] Set breakpoint in `divide` method
- [ ] Run calculator (F5 → Python: Calculator Demo)
- [ ] Pause at breakpoint
- [ ] Inspect variables in Variables panel
- [ ] Step through code with F10/F11
- [ ] Debug specific test (right-click → Debug Test)
- [ ] Set conditional breakpoint

### Running Application
- [ ] Run calculator via task (`Ctrl+Shift+P` → Run Task)
- [ ] Or run directly: `python src/calculator.py`
- [ ] Test all four operations interactively
- [ ] Test error handling (divide by zero)
- [ ] Test invalid input handling
- [ ] Exit gracefully (quit)

### Jupyter Integration (Optional)
- [ ] Install jupyter and ipykernel
- [ ] Create new Jupyter notebook
- [ ] Import calculator module
- [ ] Test operations in notebook cells
- [ ] Create visualizations
- [ ] Document findings in markdown cells

---

## Common Issues and Solutions

### Issue: Import Error in Tests

**Error:** `ModuleNotFoundError: No module named 'src'`

**Solution:**
```bash
# Make sure .venv is activated
# Check pythonPath in settings.json includes src
"python.analysis.extraPaths": ["${workspaceFolder}/src"]

# Or install in editable mode
pip install -e .
```

### Issue: Tests Don't Show in Explorer

**Solution:**
1. Ensure `pytest` is installed: `pip install pytest`
2. Reload VS Code: `Ctrl+Shift+P` → Developer: Reload Window
3. Check test file naming: must be `test_*.py`
4. Check function naming: must be `test_*`

### Issue: Breakpoint Not Working

**Solution:**
1. Ensure `justMyCode: true` in launch.json
2. Close all debuggers: `Shift+F5`
3. Try setting breakpoint again
4. Use `pdb` as alternative:
   ```python
   import pdb; pdb.set_trace()
   ```

### Issue: Linter Keeps Changing Code

**Solution:**
Check if two formatters conflict:
```json
// Remove conflicting formatter
// Keep only Ruff or only Black, not both
"editor.defaultFormatter": "charliermarsh.ruff"
```

### Issue: Type Errors from MyPy

**Solution:**
- Start with `disallow_untyped_defs: false`
- Add type hints gradually
- Use `# type: ignore` for libraries without types
- Check `[[tool.mypy.overrides]]` for per-module settings

---

## Next Steps

1. **Extend the calculator**: Add more operations (exponent, modulo, square root)
2. **Add persistence**: Save calculation history to file
3. **Build GUI**: Create a graphical interface with tkinter
4. **Package it**: Create pip-installable package
5. **Deploy**: Put on GitHub and PyPI
6. **Continue learning**: Move to [[Advanced Python Testing]]

---

## Summary

You've now completed a full professional Python development workflow:

✅ Configured VS Code for Python development
✅ Set up virtual environment and project structure
✅ Created a complete application with proper code organization
✅ Wrote comprehensive tests
✅ Implemented linting and type checking
✅ Debugged code using VS Code debugger
✅ Ran tests and checked coverage
✅ Used the code interactively in Jupyter

This workflow is exactly what professional Python developers use daily!

---

*Last updated: 2025-11-10*
