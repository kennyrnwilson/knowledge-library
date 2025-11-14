# 🚀 VS Code Python Project Workflow: Build a Calculator with Full IDE Integration

A hands-on tutorial that builds a professional Python calculator package **entirely within VS Code**, with special emphasis on virtual environment integration, debugging, and using VS Code extensions throughout the development lifecycle.

**← Back to**: [Complete Tutorial Index](./complete-modern-project-tutorial.md) | [VS Code Setup Guide](./vs-code-python-development.md) | [Python Fundamentals](./README.md)

---

## 📚 Tutorial Overview

**This tutorial teaches the same calculator project as the Complete Modern Python Project Tutorial, but with:**

✅ **VS Code-centric approach** - All work done in the IDE
✅ **Virtual environment focus** - Understand venv integration at every step
✅ **Debugging throughout** - Debug code as you write it
✅ **Extension-driven** - Leverage VS Code plugins for productivity
✅ **Simplified workflow** - Less command-line, more IDE
✅ **Practical troubleshooting** - Common VS Code + venv issues

---

## 🎯 What You'll Build

**A professional command-line calculator package** (same as Complete Tutorial)

```
simple-calculator/
├── venv/                         # Virtual environment (in VS Code)
├── src/
│   └── simple_calculator/
│       ├── __init__.py
│       ├── _version.py
│       ├── core.py               # Calculator logic
│       └── cli.py                # Command-line interface
├── tests/
│   ├── __init__.py
│   ├── test_core.py              # Tests (debug here!)
│   └── test_cli.py
├── .vscode/
│   ├── settings.json             # IDE configuration
│   └── launch.json               # Debug configurations
├── pyproject.toml
├── .gitignore
└── .pre-commit-config.yaml
```

---

## 📋 Prerequisites

- **VS Code** installed ([download](https://code.visualstudio.com/))
- **Python 3.11+** installed on your system
- **Git** installed
- Completed [VS Code Python Development Guide](./vs-code-python-development.md) (especially Parts 1-2)
- ~3-4 hours total time

---

## 🎓 Learning Path

| Part | Duration | Focus |
|------|----------|-------|
| Part 1: Project Setup in VS Code | 30 min | Create structure, venv, settings |
| Part 2: Write Calculator Code | 45 min | Code with IntelliSense, type checking |
| Part 3: Debug Calculator Code | 30 min | Use VS Code debugger |
| Part 4: Write Tests in VS Code | 45 min | Test Explorer, debug failing tests |
| Part 5: Code Quality Tools | 30 min | Ruff, Pylance, formatting |
| Part 6: Git & GitHub Integration | 30 min | Source Control panel |
| Part 7: Advanced Debugging | 30 min | Common debugging scenarios |

**Total: ~3.5 hours** of hands-on VS Code usage

---

## Part 1: Project Setup in VS Code

### 1.1: Create Project Folder and Open in VS Code

**In your file explorer:**
1. Create a new folder: `simple-calculator`
2. Inside it, create subfolder: `src/simple_calculator`
3. Inside `src/simple_calculator`, create subfolder: `tests`

**In VS Code:**
1. Open VS Code
2. `File` → `Open Folder` → Select `simple-calculator`
3. VS Code opens with folder explorer on left

### 1.1b: Install Required VS Code Extensions

⚠️ **CRITICAL: These extensions are required for the tutorial to work!**

Ruff auto-formatting, type checking, and testing all require specific VS Code extensions. Without them, features shown in this tutorial won't work.

**Required Extensions:**

| Extension | ID | Why You Need It |
|-----------|----|----|
| **Python** | `ms-python.python` | Core Python support (required for everything) |
| **Pylance** | `ms-python.vscode-pylance` | Type checking and IntelliSense (shows errors in editor) |
| **Ruff** | `charliermarsh.ruff` | Auto-formatting on save (format code instantly when you save) |
| **Pytest** | `ms-python.pytest` | Test discovery (Part 4: shows tests in sidebar) |
| **autoDocstring** | `njpwerner.autodocstring` | Docstring generation (optional: type `"""` and it completes) |

**How to Install:**

**Method 1: Via VS Code UI (Recommended - easier)**

1. Click **Extensions** icon on left sidebar (looks like 4 squares)
2. Search for: `Python` (by Microsoft)
   - Click **Install**
   - This installs the main Python extension + Debugger automatically
3. Repeat search for each:
   - `Pylance` (by Microsoft)
   - `Ruff` (by Astral)
   - `Pytest` (by Microsoft)
   - Each time: Search → Install
4. **Reload VS Code** when prompted

**Method 2: Via Command Line (If you prefer CLI)**

Open your system terminal (not VS Code terminal) and run:

```bash
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension charliermarsh.ruff
code --install-extension ms-python.pytest
code --install-extension njpwerner.autodocstring
```

**Verify Extensions are Installed:**

1. Click Extensions icon on left (4 squares)
2. You should see these in "Installed" section:
   - Python (green checkmark)
   - Pylance (green checkmark)
   - Ruff (green checkmark)
   - Pytest (green checkmark)

If any are missing, the tutorial features won't work as expected.

**Why This Matters:**

- **Without Python extension**: You can't select interpreter, no IntelliSense
- **Without Pylance**: No type checking errors shown in editor
- **Without Ruff**: No auto-formatting on save (Part 2's example won't work!)
- **Without Pytest**: Test Explorer won't show your tests (Part 4)

**Troubleshooting Extensions:**

| Issue | Fix |
|-------|-----|
| Extension shows "Install" button (not installed) | Click Install button, wait for completion |
| Extension installed but not working | Reload VS Code (Ctrl+Shift+P → "Developer: Reload Window") |
| Pylance says "need to sign in" | Click "Allow" when prompted; Microsoft account not required |
| Ruff shows "ruff not found" | Wait until Part 1.5 when you install ruff via pip |

### 1.2: Create Virtual Environment in VS Code Terminal

1. **Open integrated terminal**: `Ctrl+`
2. **Create venv**:
   ```bash
   python -m venv venv
   ```
3. **Wait** for venv creation (30 seconds)
4. **New prompt** shows `(venv)` - venv is activated!

### 1.3: Select Venv as Interpreter (Critical!)

**Important: Prerequisites for seeing the Python interpreter in status bar**

The Python interpreter selector only appears in the status bar when BOTH conditions are true:
1. ✅ **Python VS Code extension is installed and enabled** (should be done from Part 1.1b)
2. ✅ **You have a Python file open** in the editor

If you don't see the Python interpreter in the status bar, create a Python file first:
1. Create any Python file: `src/simple_calculator/test.py` (or similar)
2. The status bar will now show `Python` text on the right side

**Finding the status bar:**
1. Look at the **very bottom** of the VS Code window (below the editor)
2. You'll see a gray bar with text like `LF` and line/column numbers
3. On the **right side** of this bar, look for text starting with `Python`
   - This only appears IF you have a .py file open

**If you don't see "Python" text:**
- Check: Do you have the Python extension installed? (Extensions panel, search "Python")
- Check: Do you have a .py file open in the editor?
- If both are yes, use keyboard shortcut instead: `Ctrl+Shift+P`

**Selecting the interpreter:**

**Method 1: Via Status Bar (if visible)**
1. Make sure a `.py` file is open
2. Click the text on the right side of the bottom bar that mentions `Python`
3. A dropdown menu appears with Python interpreters
4. Look for one with `venv` in the path (e.g., `./venv/bin/python`)
5. Click it to select it

**Method 2: Via Command Palette (recommended, works anytime)**
1. Press `Ctrl+Shift+P` (opens Command Palette)
2. Type: `Python: Select Interpreter`
3. Press Enter
4. Choose the one with `venv` in the path
5. Press Enter to select

**After selection:**
- Status bar at bottom-right should show: `[Python 3.11.5 64-bit ('./venv': venv)]`
- This appears anytime you have a .py file open
- If it shows system Python path instead of venv, repeat the selection steps

**Why this matters:**
- VS Code debugging uses this interpreter
- IntelliSense searches venv's site-packages
- Test Explorer runs tests with this Python
- All extensions use this interpreter
- Without this step, VS Code won't find installed packages

### 1.4: Create VS Code Workspace Settings

1. **Create folder** `.vscode` (if doesn't exist)
2. **Create file** `.vscode/settings.json`
3. **Paste** (this tells VS Code where the venv is):

```json
{
  // ============================================================================
  // VIRTUAL ENVIRONMENT - THE MOST IMPORTANT SETTINGS
  // ============================================================================
  "python.defaultInterpreterPath": "${workspaceFolder}/venv/bin/python",
  "python.pythonPath": "${workspaceFolder}/venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "python.terminal.executeInFileDir": true,

  // ============================================================================
  // TOOLS FROM VENV
  // ============================================================================
  "ruff.path": ["${workspaceFolder}/venv/bin/ruff"],
  "python.testing.pytestPath": "${workspaceFolder}/venv/bin/pytest",
  "python.analysis.pythonPath": "${workspaceFolder}/venv/bin/python",

  // ============================================================================
  // CODE QUALITY
  // ============================================================================
  "python.analysis.typeCheckingMode": "basic",
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit"
    }
  },

  // ============================================================================
  // TESTING
  // ============================================================================
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": [
    "tests",
    "-v",
    "--tb=short"
  ],

  // ============================================================================
  // DEBUGGING
  // ============================================================================
  "python.debugging.logDir": "${workspaceFolder}/.vscode/debug_logs",

  // ============================================================================
  // EDITOR
  // ============================================================================
  "editor.rulers": [100],
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    "**/.pytest_cache": true
  }
}
```

4. **Save** (`Ctrl+S`)

**Verify settings work:**
1. Open terminal: `Ctrl+` `
2. You should see `(venv)` in prompt
3. Type: `pip list`
4. Should show empty (only base packages)

### 1.5: Create pyproject.toml (CRITICAL: Must be before pip install)

⚠️ **IMPORTANT: Do Steps 1.5-1.8 IN ORDER before running pip install**

The `pyproject.toml` file references `_version.py`, so you must create both before pip install works.

1. **Create file** in root: `pyproject.toml`
2. **Paste** (modern Python project config):

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "simple-calculator"
dynamic = ["version"]
description = "A simple calculator package demonstrating modern Python development"
readme = "README.md"
requires-python = ">=3.11"
license = {text = "MIT"}
authors = [{name = "You", email = "you@example.com"}]

[project.optional-dependencies]
dev = [
    "pytest>=7.0",
    "pytest-cov>=4.0",
    "ruff>=0.1.0",
    "mypy>=1.0",
    "pre-commit>=3.0",
]

[project.scripts]
calc = "simple_calculator.cli:main"

[tool.hatch.version]
path = "src/simple_calculator/_version.py"

[tool.pytest.ini_options]
minversion = "7.0"
addopts = ["-v", "--tb=short", "--cov=src/simple_calculator", "--cov-report=term-missing"]
testpaths = ["tests"]

[tool.ruff]
line-length = 100
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "W", "I"]

[tool.mypy]
python_version = "3.11"
check_untyped_defs = true
```

3. **Save**

### 1.6: Create Version File

1. **Create file** `src/simple_calculator/_version.py`
2. **Paste**:

```python
"""Version information for simple_calculator."""

__version__ = "0.1.0"
```

3. **Save**

### 1.7: Create Package __init__.py

1. **Create file** `src/simple_calculator/__init__.py`
2. **Paste**:

```python
"""Simple calculator package."""

from simple_calculator._version import __version__

__all__ = ["__version__"]
```

3. **Save**

### 1.8: Create README.md

1. **Create file** in root: `README.md`
2. **Paste**:

```markdown
# Simple Calculator

A simple command-line calculator demonstrating modern Python development practices.

## Installation

```bash
pip install simple-calculator
```

## Usage

```bash
calc Add 5 3
calc Subtract 10 4
calc Multiply 6 7
calc Divide 20 5
```

## Development

```bash
# Install development dependencies
pip install -e ".[dev]"

# Run tests
pytest

# Format code
ruff format .

# Type check
mypy src/
```
```

3. **Save**

### 1.9: Install Development Dependencies (Now Will Work!)

⚠️ **PREREQUISITE CHECK: Before running this, verify Steps 1.5-1.8 are complete:**
- [ ] `pyproject.toml` exists in root
- [ ] `src/simple_calculator/_version.py` exists
- [ ] `src/simple_calculator/__init__.py` exists
- [ ] `README.md` exists in root

If any file is missing, pip install will fail with "file does not exist" error.

In terminal (with venv activated):
```bash
pip install -e ".[dev]"
```

This command:
- `-e` = install in editable mode (so changes to code are reflected immediately)
- `.[dev]` = install this package + all dev dependencies from pyproject.toml

**VS Code should now:**
- Recognize `pytest` in venv
- Show type checking from Pylance
- Detect ruff for formatting
- Find all installed packages

**Verify success:**
- [ ] Terminal shows `(venv)` in prompt
- [ ] Type: `pip list` - shows pytest, ruff, mypy
- [ ] Expected output shows packages installed in venv:
   ```
   pytest           7.x.x
   ruff             0.x.x
   mypy             1.x.x
   pytest-cov       4.x.x
   ```

**If pip install fails with "file does not exist":**
- [ ] All files from Steps 1.5-1.8 created?
- [ ] `src/simple_calculator/_version.py` exists? (This is the most common missing file)
- [ ] `pyproject.toml` in root directory?
- [ ] `README.md` exists in root?
- [ ] Is venv activated (do you see `(venv)` in prompt)?

---

## Part 2: Write Calculator Code with IntelliSense

### 2.1: Create Core Calculator (core.py)

1. **Create file** `src/simple_calculator/core.py`
2. **Start typing** (notice IntelliSense):

```python
"""Calculator core operations."""

from typing import Union


class Calculator:
    """A simple calculator with basic arithmetic operations."""

    @staticmethod
    def add(a: Union[int, float], b: Union[int, float]) -> float:
        """Add two numbers.

        Args:
            a: First number
            b: Second number

        Returns:
            Sum of a and b
        """
        return a + b

    @staticmethod
    def subtract(a: Union[int, float], b: Union[int, float]) -> float:
        """Subtract b from a."""
        return a - b

    @staticmethod
    def multiply(a: Union[int, float], b: Union[int, float]) -> float:
        """Multiply two numbers."""
        return a * b

    @staticmethod
    def divide(a: Union[int, float], b: Union[int, float]) -> float:
        """Divide a by b.

        Raises:
            ValueError: If b is zero
        """
        if b == 0:
            raise ValueError("Cannot divide by zero")
        return a / b
```

3. **Save** - Ruff auto-formats on save!

**VS Code Features Used:**
- ✅ Type hints with autocomplete
- ✅ Docstring generation (type `"""`, VS Code completes)
- ✅ IntelliSense for class/function names
- ✅ Auto-formatting with Ruff

#### How Auto-Formatting with Ruff Works

When you save a Python file, VS Code automatically runs Ruff to format your code. Here's what happens:

**What Ruff Does:**
- Fixes spacing and indentation automatically
- Removes trailing whitespace
- Ensures consistent quote style (single vs double quotes)
- Fixes line length (wraps long lines at 100 characters)
- Removes unused imports
- Fixes import ordering
- All happens **instantly when you press Ctrl+S**

**Example: Before and After Ruff Formatting**

Before saving (messy code):
```python
def add(a,b):  # Missing spaces, no type hints
    """Add numbers"""
    x=a+b  # Missing spaces
    return x
```

After you save (Ctrl+S), Ruff automatically fixes it to:
```python
def add(a: float, b: float) -> float:
    """Add numbers."""
    x = a + b
    return x
```

**How to Test Auto-Formatting:**

1. **Create a messy Python file to test:**
   - Open `src/simple_calculator/core.py` (the one you just created)
   - Intentionally mess up the formatting:
     ```python
     # Add this line at the end of the file (with bad spacing):
     x=1+2;y=3*4  # Bad: missing spaces, unnecessary semicolon
     ```

2. **Save the file:**
   - Press `Ctrl+S`
   - Watch the line automatically reformat!
   - It becomes: `x = 1 + 2\ny = 3 * 4`

3. **Verify it worked:**
   - The line now has proper spacing
   - Each statement is on its own line
   - The code follows PEP 8 style guide

**Why This Matters:**

Without auto-formatting, developers spend time:
- Manually fixing spacing
- Adjusting indentation
- Reformatting imports
- Debating code style in code reviews

With Ruff auto-formatting:
- **Instant fixes** - Just save and done
- **Consistent style** - All code looks the same
- **No debates** - Everyone's code formatted the same way
- **Fewer bugs** - Properly spaced code is easier to read

**Advanced: Understanding Ruff Configuration**

Your `pyproject.toml` has this Ruff configuration:
```toml
[tool.ruff]
line-length = 100  # Wrap lines at 100 characters
target-version = "py311"  # Optimize for Python 3.11
```

This means Ruff will:
- Break lines longer than 100 characters
- Use Python 3.11 compatible syntax
- Follow the rules you specified in pyproject.toml

**Troubleshooting Auto-Formatting:**

| Issue | Cause | Fix |
|-------|-------|-----|
| File doesn't format on save | Ruff not installed in venv | Run: `pip install ruff` |
| Formatting applies but then reverts | Conflict with another formatter | Disable others: Python extension → Settings → Formatting provider |
| Can't see changes | Editor not refreshing | File actually was changed; check git diff |
| Ruff errors shown but won't auto-fix | Some issues require manual fixes | Read the error message (e.g., unused import) |
| Save is slow | Ruff taking time to run | Normal for large files; usually <1 second |

**Testing Auto-Formatting Step-by-Step:**

1. **Make code intentionally ugly:**
   - Open `src/simple_calculator/core.py`
   - At the very end, add: `a=1` (no spaces)

2. **Look at the squiggly lines:**
   - You'll see a yellow/orange squiggly line under `a=1`
   - This is Ruff saying "I can fix this!"

3. **Save and watch the magic:**
   - Press `Ctrl+S`
   - The line becomes: `a = 1` (spaces added automatically)
   - No squiggly line anymore

4. **Undo to verify:**
   - Press `Ctrl+Z` to undo the format
   - Line goes back to `a=1` with squiggly line
   - Press `Ctrl+S` again
   - Ruff fixes it back to `a = 1`

**Pro Tips:**

1. **Format on save is enabled** - You don't need to do anything; it just happens
2. **It's using Ruff from your venv** - The `.vscode/settings.json` you created points to it
3. **You can manually format** - Press `Shift+Alt+F` to format without saving
4. **See what changed** - Open VS Code's Source Control panel to see the formatting changes

### 2.2: Create CLI Interface (cli.py)

1. **Create file** `src/simple_calculator/cli.py`
2. **Paste**:

```python
"""Command-line interface for the calculator."""

import sys
from typing import NoReturn

from simple_calculator.core import Calculator


def main() -> NoReturn:
    """Run the calculator CLI.

    Usage: calc Operation num1 num2

    Operations: Add, Subtract, Multiply, Divide
    """
    if len(sys.argv) != 4:
        print(
            "Usage: calc Operation num1 num2 (e.g., calc Add 5 3)",
            file=sys.stderr
        )
        sys.exit(1)

    operation = sys.argv[1].lower()
    try:
        num1 = float(sys.argv[2])
        num2 = float(sys.argv[3])
    except ValueError:
        print(
            f"Error: {sys.argv[2]} and {sys.argv[3]} must be numbers",
            file=sys.stderr
        )
        sys.exit(1)

    try:
        if operation == "add":
            result = Calculator.add(num1, num2)
        elif operation == "subtract":
            result = Calculator.subtract(num1, num2)
        elif operation == "multiply":
            result = Calculator.multiply(num1, num2)
        elif operation == "divide":
            result = Calculator.divide(num1, num2)
        else:
            print(
                f"Error: Unknown operation '{operation}'",
                file=sys.stderr
            )
            sys.exit(1)

        print(f"{num1} {operation} {num2} = {result}")
        sys.exit(0)
    except ValueError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
```

#### Understanding `if __name__ == "__main__"`

This pattern is one of the most important idioms in Python. Here's what it means:

**What is `__name__`?**
- `__name__` is a special built-in variable in Python
- When you run a Python file directly, `__name__` is automatically set to `"__main__"`
- When a file is imported as a module, `__name__` is set to the module's name (e.g., `"simple_calculator.cli"`)

**Why does this matter?**

Without this guard, your `main()` function runs automatically whenever the file is imported, which can cause problems:

```python
# BAD - without the guard:
def main():
    print("Running calculator!")

main()  # Runs even if someone imports this module!
```

```python
# GOOD - with the guard:
def main():
    print("Running calculator!")

if __name__ == "__main__":
    main()  # Only runs when executed directly
```

**Real-world example:**

```python
# Someone imports your calculator for their own code:
from simple_calculator.cli import main  # This works because main() didn't auto-run

# They run a script directly:
python src/simple_calculator/cli.py  # This runs main() as expected
```

**In your project:**
- Running `python src/simple_calculator/cli.py` → `__name__` is `"__main__"` → `main()` executes
- Running `python -m simple_calculator.cli` → same result
- Importing `from simple_calculator.cli import main` → `__name__` is not `"__main__"` → `main()` doesn't auto-run

**Pro tip:** Always use this guard in files that have a `main()` function!

3. **Save**

### 2.2a: Understanding Pylance Quick Fixes

As you write code, you'll notice a lightbulb icon (💡) appearing in the editor. This is VS Code's **Quick Fix** feature, powered by **Pylance** (the type checker you installed). Here's what it means and how to use it:

**What is the Lightbulb Icon?**

The lightbulb appears when VS Code detects an issue in your code that it can automatically fix for you:

```
def divide(a: float, b: float) -> float:
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
    # 💡 Lightbulb appears here if code doesn't return on all paths
```

**Where Does the Quick Fix Come From?**

The Quick Fix feature comes from:
1. **Pylance** - The type checker extension you installed (analyzes code for errors)
2. **VS Code's Code Actions** - The infrastructure that displays the fixes
3. **Optional: GitHub Copilot** - If installed, can enhance suggestions with AI

You don't need to do anything special—these suggestions appear automatically when Pylance finds issues.

**How to Use Quick Fixes:**

1. **Spot the lightbulb** - When you see the 💡 icon, click it
2. **Choose an action** - VS Code shows you options like:
   - "Rewrite" - Replace/fix the code
   - "Modify" - Adjust the code
   - "Review" - Show what would change
3. **Apply or ignore** - Click to apply the fix, or press `Escape` to dismiss

**Example from Your Calculator:**

When you create the `divide()` method without a return statement, Pylance shows:

```
def divide(a: float, b: float) -> float:
    if b == 0:  # 💡 Quick Fix here
        raise ValueError("Cannot divide by zero")
    # Function says it returns float but has path with no return!
```

The Quick Fix might suggest:
- Adding a return statement
- Rewriting the function logic
- Adding `-> None` to the type hint if that's your intent

**Common Quick Fixes You'll See:**

| Issue | Quick Fix Suggestion |
|-------|---------------------|
| Unused import | Remove the import |
| Variable never used | Remove the variable |
| Type mismatch | Cast to the correct type |
| Missing return statement | Add return statement |
| Undefined name | Import the module |
| Typo in function name | Suggest correct name |

**Pro Tips:**

1. **Don't blindly apply fixes** - Always understand what the fix does before clicking
2. **Read the error first** - Hover over the squiggly line to see the full explanation
3. **It's not magic** - Quick Fixes are based on rules, not AI (unless Copilot is installed)
4. **You can ignore fixes** - If you disagree with Pylance, just press `Escape`

### 2.3: Verify Type Checking Works

Now that you understand Quick Fixes (from section 2.2a), let's verify type checking is working:

**Step 1: Open the files and look for type checking indicators**
1. Open `src/simple_calculator/core.py`
2. Open `src/simple_calculator/cli.py`
3. Look for:
   - Red/orange squiggly lines under errors (type mismatches)
   - Lightbulb icons (💡) with Quick Fix suggestions
   - Hover over the squiggles to see what the errors are

**Step 2: Test a Quick Fix**
1. In `cli.py`, hover over any yellow/orange squiggly line
2. Click the lightbulb icon that appears
3. You'll see suggested fixes like "Rewrite", "Modify", or "Review"
4. Try clicking one to see how it works (you can always undo with `Ctrl+Z`)

**Step 3: Test the import**
1. Open terminal: `Ctrl+``
2. Type: `python -c "from simple_calculator.core import Calculator; print(Calculator.add(5, 3))"`
3. Should print: `8.0`

If you see any red errors, Pylance is catching type issues before you run the code. This is powerful!

**What Type Checking Prevents:**

```python
# Without type hints - no warning:
def add(a, b):
    return a + b

add("hello", 5)  # Oops! String + int. Only caught at runtime!

# With type hints - caught immediately:
def add(a: float, b: float) -> float:
    return a + b

add("hello", 5)  # 🔴 Pylance shows error immediately, before running!
```

---

## Part 3: Debug Calculator Code with Breakpoints

### 3.1: Create Debug Configuration

⚠️ **IMPORTANT: VS Code now uses `debugpy` instead of `python` for debugging**

The old `"type": "python"` format is deprecated. Use `"type": "debugpy"` instead (shown below).

1. **Create file** `.vscode/launch.json`
2. **Paste** (using the modern `debugpy` type):

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Debug Current File",
            "type": "debugpy",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        },
        {
            "name": "Calculator: Add 5 3",
            "type": "debugpy",
            "request": "launch",
            "module": "simple_calculator.cli",
            "args": ["Add", "5", "3"],
            "console": "integratedTerminal"
        },
        {
            "name": "Calculator: Divide by Zero",
            "type": "debugpy",
            "request": "launch",
            "module": "simple_calculator.cli",
            "args": ["Divide", "10", "0"],
            "console": "integratedTerminal"
        },
        {
            "name": "Python: pytest All",
            "type": "debugpy",
            "request": "launch",
            "module": "pytest",
            "args": ["tests", "-v"],
            "console": "integratedTerminal"
        }
    ]
}
```

3. **Save**

**Why this changed:**
- The old `"type": "python"` is deprecated and shows a warning
- VS Code now uses `"type": "debugpy"` (the Python Debugger extension)
- The new format is more efficient and better maintained
- Both work the same way for your debugging workflows

### 3.2: Debug the Divide Function

1. **Open** `src/simple_calculator/core.py`
2. **Click line 40** (the `if b == 0:` line) in the margin to set breakpoint
   - Red dot appears
3. **Open the Debug view:**
   - Press `Ctrl+Shift+D` (or click the Debug icon on the left sidebar)
   - The Debug panel opens showing debug configurations
4. **Select the debug configuration dropdown:**
   - At the top of the Debug panel, you'll see a dropdown that says something like "Python: Debug Current File"
   - Click this dropdown to see all available configurations
   - Select **"Calculator: Divide by Zero"**
5. **Press** `F5` to start debugging

**What happens:**
- Code runs
- Breakpoint is hit
- Debugger pauses
- Variables panel shows `a` and `b`
- Step through code with `F10` (Step Over)

**Stop debugging:** Press `Shift+F5`

### 3.3: Debug the Add Function

1. **Set breakpoint** on line 32 (the `return` line in `add()`)
2. **Select debug config** "Calculator: Add 5 3"
3. **Press** `F5`
4. **Open Debug Console** (`Ctrl+Shift+Y`)
5. **Type**: `a + b + 10`
6. **Press Enter** - should show `18.0`
7. **Continue** - Press `F5`

This shows the power of the Debug Console - you can execute code while paused!

---

## Part 4: Write Tests with Test Explorer

### 4.1: Create Unit Tests for Calculator Core

1. **Create file** `tests/test_core.py`
2. **Paste**:

```python
"""Tests for calculator core operations."""

import pytest

from simple_calculator.core import Calculator


class TestCalculatorAdd:
    """Test Calculator.add() method."""

    def test_add_positive_numbers(self) -> None:
        """Test adding two positive numbers."""
        assert Calculator.add(5, 3) == 8.0

    def test_add_negative_numbers(self) -> None:
        """Test adding negative numbers."""
        assert Calculator.add(-5, -3) == -8.0

    def test_add_mixed_numbers(self) -> None:
        """Test adding positive and negative numbers."""
        assert Calculator.add(5, -3) == 2.0

    def test_add_float_numbers(self) -> None:
        """Test adding floating point numbers."""
        assert Calculator.add(5.5, 3.2) == pytest.approx(8.7)


class TestCalculatorSubtract:
    """Test Calculator.subtract() method."""

    def test_subtract_positive_numbers(self) -> None:
        """Test subtracting positive numbers."""
        assert Calculator.subtract(10, 3) == 7.0

    def test_subtract_negative_numbers(self) -> None:
        """Test subtracting negative numbers."""
        assert Calculator.subtract(-10, -3) == -7.0


class TestCalculatorMultiply:
    """Test Calculator.multiply() method."""

    def test_multiply_positive_numbers(self) -> None:
        """Test multiplying positive numbers."""
        assert Calculator.multiply(5, 3) == 15.0

    def test_multiply_by_zero(self) -> None:
        """Test multiplying by zero."""
        assert Calculator.multiply(5, 0) == 0.0


class TestCalculatorDivide:
    """Test Calculator.divide() method."""

    def test_divide_positive_numbers(self) -> None:
        """Test dividing positive numbers."""
        assert Calculator.divide(10, 2) == 5.0

    def test_divide_by_zero(self) -> None:
        """Test that dividing by zero raises ValueError."""
        with pytest.raises(ValueError, match="Cannot divide by zero"):
            Calculator.divide(10, 0)

    def test_divide_float_result(self) -> None:
        """Test division resulting in float."""
        assert Calculator.divide(10, 3) == pytest.approx(3.333, abs=0.001)
```

3. **Save** - Watch the status bar at bottom-right

### 4.2: Run Tests in Test Explorer

1. **Click Testing icon** (left sidebar, flask icon)
2. **Test Explorer appears** with test tree
3. **Click play icon** next to `TestCalculatorAdd` to run those tests
4. **Watch tests execute** in right panel
5. **Green checkmarks** = tests pass

### 4.3: Debug a Failing Test

Let's intentionally break a test:

1. **Open** `tests/test_core.py`
2. **Change line** in `test_add_positive_numbers`: `assert Calculator.add(5, 3) == 9.0`
3. **Right-click test** → "Debug Test"
4. **Debugger starts** and stops at the assertion
5. **Variables panel** shows `a=5.0`, `b=3.0`, but result is 8.0
6. **Fix the test** back to `== 8.0`
7. **Rerun** - now passes

### 4.4: Create CLI Tests

1. **Create file** `tests/test_cli.py`
2. **Paste**:

```python
"""Tests for calculator CLI."""

import subprocess
import sys
from typing import Any

import pytest


def run_calc(*args: Any) -> tuple[int, str, str]:
    """Run calculator CLI and return (exit_code, stdout, stderr)."""
    result = subprocess.run(
        [sys.executable, "-m", "simple_calculator.cli"] + list(args),
        capture_output=True,
        text=True,
    )
    return result.returncode, result.stdout, result.stderr


class TestCalculatorCLI:
    """Test calculator CLI."""

    def test_cli_add(self) -> None:
        """Test CLI add operation."""
        exit_code, stdout, stderr = run_calc("Add", "5", "3")
        assert exit_code == 0
        assert "8.0" in stdout
        assert stderr == ""

    def test_cli_divide_by_zero(self) -> None:
        """Test CLI divide by zero error."""
        exit_code, stdout, stderr = run_calc("Divide", "10", "0")
        assert exit_code == 1
        assert "Cannot divide by zero" in stderr

    def test_cli_invalid_operation(self) -> None:
        """Test CLI with invalid operation."""
        exit_code, stdout, stderr = run_calc("Invalid", "5", "3")
        assert exit_code == 1
        assert "Unknown operation" in stderr

    def test_cli_missing_args(self) -> None:
        """Test CLI with missing arguments."""
        exit_code, stdout, stderr = run_calc("Add", "5")
        assert exit_code == 1
        assert "Usage:" in stderr

    def test_cli_invalid_number(self) -> None:
        """Test CLI with non-numeric input."""
        exit_code, stdout, stderr = run_calc("Add", "abc", "5")
        assert exit_code == 1
        assert "must be numbers" in stderr
```

3. **Save**

### 4.5: Run All Tests and View Coverage

In Test Explorer:
1. **Click play icon** at very top (runs all tests)
2. **Watch all tests execute**
3. **Coverage report** appears in terminal

You should see something like:
```
============ test session starts =============
tests/test_core.py::TestCalculatorAdd::test_add_positive_numbers PASSED
tests/test_core.py::TestCalculatorAdd::test_add_negative_numbers PASSED
...
============ 11 passed, coverage 100% ========
```

---

## Part 5: Code Quality Tools Integration

### 5.1: Ruff Auto-Formatting

Ruff is already configured to format on save!

1. **Open** any Python file
2. **Add a badly formatted line**: `x=5+3` (no spaces)
3. **Save** (`Ctrl+S`)
4. **Notice** it auto-formats to: `x = 5 + 3`

### 5.2: Type Checking with Pylance

1. **Open** `src/simple_calculator/cli.py`
2. **Add a type error** on a line:
   ```python
   result: int = Calculator.add(5, 3)  # Wrong! add returns float
   ```
3. **Notice** red squiggle under `result`
4. **Hover** to see error: "Expression of type float cannot be assigned to declared type int"
5. **Click lightbulb** → "Ignore this expression"
6. **Remove the incorrect type**

### 5.3: Linting with Ruff

Ruff provides real-time linting:

1. **Add unused import**: `import os`
2. **Notice** red squiggle
3. **Hover** to see: "os is imported but unused"
4. **Click lightbulb** → "Remove unused import"
5. **Ruff auto-fixes** it

---

## Part 6: Git Integration in VS Code

### 6.1: Initialize Git Repository

1. **Open Source Control** panel (left sidebar, source control icon)
2. **Click** "Initialize Repository"
3. **Confirm** (creates `.git` folder)

### 6.2: Create .gitignore

1. **Create file** `.gitignore` in root
2. **Paste**:

```
# Virtual environments
venv/

# Python
__pycache__/
*.pyc
*.pyo
*.egg-info/
.pytest_cache/
.coverage
htmlcov/

# IDE
.vscode/settings.local.json

# OS
.DS_Store
```

3. **Save**

### 6.3: Commit Initial Code

In Source Control panel:
1. **Type message** in "Message" box: "Initial: calculator package setup"
2. **Stage files** (click + on each file or "Stage All")
3. **Click checkmark** to commit
4. **Done!** - All files committed

### 6.4: Create GitHub Repository (Optional)

If you want to push to GitHub:

1. Go to [GitHub.com](https://github.com)
2. Create new repository "simple-calculator"
3. Copy the `git remote add` command
4. In VS Code terminal, paste it
5. Push to GitHub

---

## Part 7: Advanced Debugging Scenarios

### 7.1: Debug Test Failures

A test is failing and you need to understand why:

1. **In Test Explorer**, find failing test
2. **Right-click** → "Debug Test"
3. **Debugger pauses** at the failing assertion
4. **Variables panel** shows all local variables
5. **Debug Console** lets you execute Python code
6. **Example**: Type `Calculator.add(5, 3)` to verify result

### 7.2: Debug CLI with Arguments

The calculator might behave differently with different arguments:

1. **Open** `.vscode/launch.json`
2. **Select config**: "Calculator: Divide by Zero"
3. **Press** `F5`
4. **Debugger pauses** at your breakpoint
5. **Watch how the error is handled**
6. **Debug Console** shows variables: `num1=10.0`, `num2=0`

### 7.3: Conditional Breakpoints

Only break when a specific condition is true:

1. **Right-click** on breakpoint dot
2. **Select** "Edit Breakpoint"
3. **Enter condition**: `b == 0`
4. **Now debugging only stops** when dividing by zero!

### 7.4: Logpoints (Print Without Breaking)

Debug code that runs often:

1. **Right-click** on line number
2. **Select** "Add Logpoint"
3. **Enter message**: `"Dividing {a} by {b}"`
4. **Every time this line runs**, it logs to console
5. **No breakpoint, no slowdown!**

---

## Part 8: Troubleshooting Common VS Code + Venv Issues

### Issue: "Module not found" in VS Code but works in terminal

**Cause**: VS Code isn't using the venv interpreter

**Solution**:
1. Click status bar: `[Python 3.11 64-bit]`
2. Select `./venv/bin/python`
3. Reload VS Code (File → Reload Window)

### Issue: Tests discover but won't run

**Cause**: pytest isn't installed in venv

**Solution**:
1. Terminal: `pip install pytest`
2. Restart VS Code
3. Test Explorer should now work

### Issue: Breakpoint is set but debugging doesn't stop there

**Cause**: Debugging using system Python instead of venv

**Solution**:
1. Verify venv selected in status bar
2. Check `.vscode/settings.json` has correct path
3. Use Debug Console to verify:
   ```python
   import sys
   print(sys.executable)  # Should show venv path
   ```

### Issue: Formatting doesn't work on save

**Cause**: Ruff not installed or settings incorrect

**Solution**:
1. Install ruff: `pip install ruff`
2. Verify settings.json: `"[python]": {"editor.formatOnSave": true}`
3. Reload VS Code

### Issue: Type hints show errors but code works

**Cause**: Pylance using wrong interpreter

**Solution**:
1. Verify interpreter selection
2. Add to settings.json: `"python.analysis.pythonPath": "${workspaceFolder}/venv/bin/python"`
3. Reload VS Code

---

## Quick Reference: Common VS Code Actions

| Action | Keyboard Shortcut |
|--------|------------------|
| **Open Terminal** | `Ctrl+` ` |
| **Debug Current File** | `F5` |
| **Step Over** | `F10` |
| **Step Into** | `F11` |
| **Step Out** | `Shift+F11` |
| **Continue Debugging** | `F5` |
| **Toggle Breakpoint** | `Ctrl+F8` |
| **Debug Console** | `Ctrl+Shift+Y` |
| **Test Explorer** | `Ctrl+Shift+P` → "Test" |
| **Run All Tests** | Click play icon in Test Explorer |
| **Format Document** | `Shift+Alt+F` |
| **Find and Replace** | `Ctrl+H` |
| **Go to Definition** | `F12` |
| **Source Control** | `Ctrl+Shift+G` |
| **Command Palette** | `Ctrl+Shift+P` |

---

## Next Steps

Now that you've built a calculator with full VS Code integration:

1. **Add more operations** - Power, square root, etc.
2. **Build a web interface** - Flask or FastAPI
3. **Deploy to PyPI** - Publish your package
4. **Extend with plugins** - Modular calculator system
5. **Write documentation** - Sphinx or MkDocs
6. **Team collaboration** - Push to GitHub, accept contributions

---

## 📚 Related Guides

- **[VS Code Python Development Guide](./vs-code-python-development.md)** - Deep dive on VS Code features
- **[Complete Modern Python Project Tutorial](./complete-modern-project-tutorial.md)** - Extended version with CI/CD
- **[Python Fundamentals](./README.md)** - Learn Python basics first

---

*Last updated: 2025-11-13*

**← Back to**: [Python Fundamentals](./README.md)
