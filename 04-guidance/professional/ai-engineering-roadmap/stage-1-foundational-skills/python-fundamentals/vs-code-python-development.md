# 🐍 VS Code for Python Development: Debugging and Professional Workflow

Master Visual Studio Code for professional Python development. This guide covers essential extensions, debugging techniques, testing integration, and practical workflows that complement the Complete Modern Python Project Tutorial.

**← Back to**: [Complete Tutorial Index](./complete-modern-project-tutorial.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn

### Environment Setup
- Install and configure VS Code for Python
- Set up essential extensions
- Configure Python interpreter
- Create workspace settings

### Development Workflow
- Code intelligence and navigation
- Linting and formatting integration
- Running tests directly from VS Code
- Git integration and workflows

### Debugging (In-Depth)
- **Breakpoints** - line, conditional, logpoint
- **Watch expressions** - monitor variables in real-time
- **Call stack navigation** - step through code execution
- **Interactive debugging** - pause and inspect program state
- **Debug console** - execute code during debugging
- **Multi-threaded debugging** - debug concurrent code

### Practical Skills
- Debug the calculator from the Complete Tutorial
- Debug failing tests
- Remote debugging
- Performance profiling

---

## 🎯 Prerequisites

- VS Code installed ([download](https://code.visualstudio.com/))
- Python 3.11+ installed
- Completed or working on [Complete Modern Python Project Tutorial](./complete-modern-project-tutorial.md)
- Basic VS Code familiarity

---

## Part 1: Initial Setup

### Step 1.1: Install VS Code

1. Download from https://code.visualstudio.com/
2. Install for your operating system
3. Open VS Code

### Step 1.2: Install Essential Extensions

Open the Extensions panel (Ctrl+Shift+X) and install:

| Extension | ID | Purpose |
|-----------|----|----|
| **Python** | `ms-python.python` | Core Python support |
| **Pylance** | `ms-python.vscode-pylance` | Type checking and IntelliSense |
| **Ruff** | `charliermarsh.ruff` | Linting and formatting |
| **Pytest** | `ms-python.pytest` | Test discovery and running |
| **Python Debugger** | `ms-python.debugpy` | Advanced debugging (included with Python extension) |
| **autoDocstring** | `njpwerner.autodocstring` | Generate docstrings |
| **Git Graph** | `mhutchie.git-graph` | Visualize Git history |

**Install via command line:**
```bash
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension charliermarsh.ruff
code --install-extension ms-python.pytest
code --install-extension njpwerner.autodocstring
code --install-extension mhutchie.git-graph
```

### Step 1.3: Configure Python Interpreter

1. Open command palette: `Ctrl+Shift+P`
2. Type: "Python: Select Interpreter"
3. Choose your virtual environment (`./venv/bin/python`)

Your status bar should show the selected Python version.

### Step 1.4: Create Workspace Settings

Create `.vscode/settings.json` in your project root:

```json
{
  // Python path
  "python.defaultInterpreterPath": "${workspaceFolder}/venv/bin/python",

  // Pylance type checking
  "python.analysis.typeCheckingMode": "basic",
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit"
    }
  },

  // Ruff configuration
  "ruff.path": ["${workspaceFolder}/venv/bin/ruff"],
  "ruff.lint.args": ["--line-length=100"],

  // Pytest configuration
  "python.testing.pytestEnabled": true,
  "python.testing.pytestArgs": [
    "tests",
    "--cov=src/simple_calculator",
    "--cov-report=term-missing"
  ],

  // Debugging
  "python.debugging.logDir": "${workspaceFolder}/.vscode/debug_logs",

  // Editor settings
  "editor.rulers": [100],
  "editor.wordWrap": "on",
  "files.exclude": {
    "**/__pycache__": true,
    "**/*.pyc": true,
    "**/.pytest_cache": true
  }
}
```

---

## Part 2: Code Intelligence and Navigation

### IntelliSense (Auto-completion)

VS Code provides intelligent code completion powered by Pylance:

**Trigger IntelliSense:**
- Type automatically as you write
- Press `Ctrl+Space` to manually trigger
- Shows function signatures and documentation

**Example:**
```python
# Type: calc = Calculator.
# VS Code shows:
# - add(...)
# - subtract(...)
# - multiply(...)
# - divide(...)
```

### Go to Definition

Navigate to where code is defined:

**Keyboard Shortcuts:**
- `F12` or `Ctrl+Click` - Go to definition
- `Ctrl+Alt+Click` - Go to definition in side-by-side view
- `Alt+F12` - Peek definition (preview in overlay)

**Example:**
```python
# Click F12 on Calculator.add()
# VS Code opens core.py and shows the add() method
```

### Find References

Find all places where code is used:

**Keyboard Shortcuts:**
- `Shift+F12` - Find all references
- `Ctrl+F` - Find in file
- `Ctrl+H` - Find and replace

### Go to Symbol

Jump to specific functions or classes:

**Keyboard Shortcut:**
- `Ctrl+T` - Go to symbol in workspace
- `Ctrl+O` - Go to symbol in file

**Example:**
```
Ctrl+T → type "Calculator" → Jump to Calculator class
Ctrl+O → type "test_divide" → Jump to test_divide function
```

---

## Part 3: Testing Integration

### Discover and Run Tests

VS Code automatically discovers pytest tests:

1. **Open Test Explorer:**
   - Click Testing icon in activity bar (flask icon)
   - Or use `Ctrl+Shift+P` → "Test: Focus on Test Explorer"

2. **View Tests:**
   - All tests in `tests/` appear as a tree
   - Green checkmarks show passing tests
   - Red X shows failing tests

3. **Run Tests:**
   - Click play icon next to test name to run single test
   - Click play icon next to file name to run all tests in file
   - Click play icon at top to run all tests

### Debug Failing Tests

When a test fails, you can debug it:

1. **Set breakpoint** in test file (see Debugging section)
2. **Right-click test** → "Debug Test"
3. **Debugger pauses** at breakpoint
4. **Inspect variables** in debug panel

### View Test Coverage

After running tests, view coverage:

```json
// In .vscode/settings.json
"python.testing.pytestArgs": [
  "tests",
  "--cov=src/simple_calculator",
  "--cov-report=term-missing"
]
```

Run tests via Test Explorer to see coverage in terminal.

---

## Part 4: Debugging (Comprehensive Guide)

Debugging is the most powerful way to understand your code. VS Code provides professional-grade debugging capabilities.

### 4.1: Basic Debugging Workflow

**The Debug Process:**

```
1. Set breakpoint (where to pause)
   ↓
2. Start debugging (run code until breakpoint)
   ↓
3. Code pauses at breakpoint
   ↓
4. Inspect variables (what are they?)
   ↓
5. Step through code (line by line)
   ↓
6. Continue or modify execution
```

### 4.2: Breakpoints

**Line Breakpoint (most common):**

Click on the line number margin to set a red dot. Execution pauses when this line is reached.

```python
def divide(a: float, b: float) -> float:
    if b == 0:              # ← Click here to add breakpoint
        raise ValueError("Cannot divide by zero")
    return a / b
```

**Set Breakpoint:**
- Click in the margin left of line numbers
- Red dot appears
- Code pauses here when running

**Conditional Breakpoint:**

Pause only when a condition is true:

1. Right-click on breakpoint dot
2. Select "Edit Breakpoint"
3. Enter condition: `b == 0`

Now debugging only stops when b equals zero.

```python
# Example: Stop only for division by zero
def divide(a: float, b: float) -> float:
    if b == 0:              # Breakpoint with condition: b == 0
        raise ValueError("Cannot divide by zero")
    return a / b
```

**Logpoint:**

Print to console without stopping (useful for high-frequency code):

1. Right-click on line number
2. Select "Add Logpoint"
3. Enter message: `"b = {b}"`

Now every time code passes this line, it logs to console.

### 4.3: Start Debugging

**Method 1: Run with Debugging**
- Press `F5` to start debugging
- Or use Debug menu → "Start Debugging"

**Method 2: Debug Specific File**
- Open file you want to debug
- Press `F5`
- VS Code runs and pauses at breakpoints

**Method 3: Debug Tests**
- Open test file
- Right-click test name
- Select "Debug Test"

### 4.4: Debug Panel

When paused at breakpoint, three key sections appear:

#### Variables Panel
Shows all variables in current scope:

```
Local
  a: 10.0
  b: 0  ← This is the problem!

Closure
  (none)
```

Hover over variable names in code to see their value as tooltip.

#### Watch Expressions
Monitor specific variables across execution:

1. Click "+" in Watch panel
2. Enter variable name: `a`
3. Enter expression: `a / b` (shows error when b=0)

Watch expressions update as you step through code.

#### Call Stack
Shows how you got here (function call chain):

```
divide (core.py:692)
  └─ test_divide_by_zero (test_core.py:924)
    └─ <test runner>
```

Click on any frame to see its variables.

### 4.5: Step Commands

Control code execution:

| Command | Shortcut | What It Does |
|---------|----------|------------|
| **Step Over** | F10 | Execute current line, move to next |
| **Step Into** | F11 | Enter function call |
| **Step Out** | Shift+F11 | Exit current function |
| **Continue** | F5 | Resume until next breakpoint |
| **Pause** | Ctrl+Alt+Break | Pause running code |

**Example Debug Session:**

```python
def divide(a: float, b: float) -> float:
    if b == 0:                          # ← Breakpoint 1: Pause here
        raise ValueError(...)           # ← Step Into (F11)
    return a / b                        # ← Continue (F5)
```

1. Set breakpoint at `if b == 0:`
2. Start debugging (F5)
3. Code pauses at breakpoint
4. Press F11 (Step Into) to enter if block
5. Press F10 (Step Over) to go to next line
6. Press F5 (Continue) to finish

### 4.6: Debug Console

Execute code while paused at breakpoint:

1. Open Debug Console (Ctrl+Shift+Y)
2. Type Python code
3. Press Enter to execute

**Example:**
```python
# While paused at breakpoint where a=10, b=0:

> a + 5           # Evaluates to 15
15

> a / b if b != 0 else "infinite"
'infinite'

> len(str(a))     # String functions work too
2

> import math
> math.sqrt(a)
3.1622776601683795
```

This is incredibly powerful for understanding what's happening.

### 4.7: Debug the Calculator

**Practical Exercise: Debug Division by Zero**

File: `src/simple_calculator/core.py`

```python
def divide(a: Union[int, float], b: Union[int, float]) -> float:
    """Divide two numbers."""
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
```

**Debug Steps:**

1. **Set Breakpoint** - Click margin before `if b == 0:`
2. **Start Debugging** - Press F5
3. **Run test or CLI** - The breakpoint will be hit
4. **Inspect Variables** - Look at Variables panel (see a and b values)
5. **Step Into** - Press F11 to enter the if block
6. **Debug Console** - Press Ctrl+Shift+Y and type: `b == 0`
7. **Continue** - Press F5 to finish

### 4.8: Debug Failing Tests

**Debug the test_divide_by_zero test:**

File: `tests/test_core.py`

```python
def test_divide_by_zero(self) -> None:
    """Test division by zero raises ValueError."""
    with pytest.raises(ValueError, match="Cannot divide by zero"):
        Calculator.divide(5, 0)
```

**Debug Steps:**

1. Open `tests/test_core.py`
2. Right-click on `test_divide_by_zero`
3. Select "Debug Test"
4. Debugger pauses in test
5. Set breakpoint in `core.py` divide() function
6. Continue (F5) - jumps to breakpoint in core.py
7. Watch the `if b == 0:` condition
8. Step through the error being raised

### 4.9: Advanced Debugging

#### Debug CLI Commands

Debug the calculator CLI:

File: `src/simple_calculator/cli.py`

```python
def main() -> None:
    """Run the calculator CLI."""
    if len(sys.argv) != 4:
        print("Usage: calc Operation num1 num2", file=sys.stderr)
        sys.exit(1)

    operation = sys.argv[1]  # ← Set breakpoint here
    # ...
```

**Debug CLI:**

1. Create debug configuration (see section 4.10)
2. Set breakpoints in cli.py
3. Press F5 to start debugging
4. Use Debug Console to see parsed arguments

#### Debug with Arguments

Edit `.vscode/launch.json`:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Debug Calculator",
            "type": "python",
            "request": "launch",
            "program": "${workspaceFolder}/src/simple_calculator/cli.py",
            "args": ["Add", "5", "3"],
            "console": "integratedTerminal"
        }
    ]
}
```

This runs: `python src/simple_calculator/cli.py Add 5 3` with debugging.

#### Remote Debugging

Debug code running on another machine:

1. Install debugpy: `pip install debugpy`
2. Add to remote script:
   ```python
   import debugpy
   debugpy.listen(("0.0.0.0", 5678))
   print("Waiting for debugger...")
   debugpy.wait_for_client()
   ```
3. Connect from VS Code Debug Console

### 4.10: Create Debug Configurations

Create `.vscode/launch.json` for custom debug setups:

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Current File",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "console": "integratedTerminal"
        },
        {
            "name": "Python: Module",
            "type": "python",
            "request": "launch",
            "module": "simple_calculator.cli",
            "args": ["Add", "5", "3"],
            "console": "integratedTerminal"
        },
        {
            "name": "pytest: Current File",
            "type": "python",
            "request": "launch",
            "module": "pytest",
            "args": ["${file}", "-v"],
            "console": "integratedTerminal",
            "justMyCode": true
        },
        {
            "name": "pytest: All Tests",
            "type": "python",
            "request": "launch",
            "module": "pytest",
            "args": ["tests", "-v", "--cov"],
            "console": "integratedTerminal"
        }
    ]
}
```

Select configuration from Debug menu dropdown.

---

## Part 5: Code Quality Integration

### Run Ruff in VS Code

VS Code automatically runs ruff as you type:

1. Install Ruff extension (done in setup)
2. VS Code shows squiggly lines under issues
3. Hover to see error message
4. Click lightbulb to auto-fix

**Example:**
```python
import os  # ← Unused import, red squiggly line
from simple_calculator import Calculator

# Hover → "os is imported but unused"
# Click lightbulb → Auto-removes import
```

### Format on Save

Your `.vscode/settings.json` already configured:

```json
"[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true
}
```

Every time you save (Ctrl+S), your code is formatted.

### Type Checking with Pylance

Pylance shows type errors in real-time:

```python
def add(a: int, b: int) -> int:
    return a + b

result = add("5", "3")  # ← Red squiggly: str instead of int
```

Hover to see error message and suggestion.

---

## Part 6: Git Integration

### Source Control Panel

VS Code has built-in Git integration:

1. Click Source Control icon (left sidebar)
2. See all changed files
3. Stage/unstage files by clicking ±
4. Enter commit message
5. Click checkmark to commit

### View Git History

Install "Git Graph" extension (done in setup):

1. Open Git Graph (command palette: "Git Graph: View Git Graph")
2. See visual commit history
3. Click commits to see changes
4. Compare branches visually

---

## Part 7: Professional Workflow

### Typical Development Session

```
1. Start VS Code
2. Open project folder
3. Open file to edit
4. Make changes
5. Save (Ctrl+S) → auto-formats and fixes with Ruff
6. Check for type errors (see red squiggles)
7. Run tests (click test in Test Explorer)
8. If test fails, debug it (set breakpoint, F5)
9. Fix code
10. Commit changes (Source Control panel)
11. Push to GitHub
```

### Debugging Workflow

When code doesn't work:

```
1. Set breakpoint where issue might be
2. Press F5 to debug
3. Code pauses at breakpoint
4. Inspect variables in Variables panel
5. Step through code (F10/F11)
6. Use Debug Console to test expressions
7. Understand the problem
8. Fix code
9. Remove breakpoint
10. Run tests again
```

### Testing Workflow

```
1. Open Test Explorer (left sidebar)
2. See all tests
3. Click play icon to run test
4. Red X = failed test
5. Green checkmark = passed test
6. Right-click failed test → Debug Test
7. Set breakpoint in test or code
8. Debug to find issue
9. Fix code
10. Rerun test
```

---

## Part 8: Tips and Tricks

### Multi-Cursor Editing

Edit multiple places at once:

- `Ctrl+D` - Select next occurrence
- `Ctrl+Shift+L` - Select all occurrences
- `Alt+Click` - Add cursor at click location

Example: Rename variable across file

### Command Palette

Access any VS Code feature:

- `Ctrl+Shift+P` - Open command palette
- Type command name (partial works)
- Press Enter

**Useful commands:**
- "Sort lines" - Sort selected lines
- "Fold all" - Collapse all code blocks
- "Format document" - Format entire file
- "Run test" - Run current test

### Quick File Open

Jump to any file instantly:

- `Ctrl+P` - Quick open
- Type filename (partial works)
- Press Enter

### Focus Mode

Hide distracting UI elements:

- `Ctrl+K Ctrl+J` - Toggle Zen Mode
- `Ctrl+Shift+P` → "Zen Mode"

---

## Part 9: Common Debugging Scenarios

### Scenario 1: Function Returns Wrong Value

```python
def multiply(a: int, b: int) -> int:
    return a + b  # ← Bug: should be *
```

**Debug:**
1. Set breakpoint at return statement
2. Start debug, watch a and b values
3. Step over, see result in Debug Console
4. Notice it's addition, not multiplication
5. Fix bug

### Scenario 2: Loop Variable Has Wrong Value

```python
for i in range(10):
    result = i * 2
    if result > 10:  # ← Why doesn't this work?
        print(i)
```

**Debug:**
1. Set breakpoint inside if block
2. Debug, watch i and result values
3. Understand when condition is true
4. Modify logic if needed

### Scenario 3: Function Crashes

```python
def process(items: list):
    for item in items:
        value = item["key"]  # ← Crashes if key missing
        print(value)
```

**Debug:**
1. Set breakpoint at crash line
2. Debug, inspect item value
3. Add `if "key" in item:` check
4. Handle missing key gracefully

---

## Part 10: Shortcuts Reference

### Essential Debugging Shortcuts

| Action | Shortcut |
|--------|----------|
| Start/Continue Debugging | F5 |
| Stop Debugging | Shift+F5 |
| Step Over | F10 |
| Step Into | F11 |
| Step Out | Shift+F11 |
| Toggle Breakpoint | Ctrl+F8 |
| Run to Cursor | Ctrl+F10 |

### Essential Editing Shortcuts

| Action | Shortcut |
|--------|----------|
| Save File | Ctrl+S |
| Command Palette | Ctrl+Shift+P |
| Quick File Open | Ctrl+P |
| Find | Ctrl+F |
| Find & Replace | Ctrl+H |
| Go to Line | Ctrl+G |
| Go to Definition | F12 |
| Find References | Shift+F12 |
| Format Document | Shift+Alt+F |

### Essential Navigation

| Action | Shortcut |
|--------|----------|
| Toggle Sidebar | Ctrl+B |
| Toggle Terminal | Ctrl+` |
| Focus Test Explorer | Ctrl+Shift+P → "Test" |
| Focus Debug Panel | Ctrl+Shift+D |

---

## Next Steps

Now that you understand VS Code:

1. **Apply to Your Project** - Use VS Code with the Complete Python Tutorial
2. **Practice Debugging** - Debug each part of the calculator
3. **Speed Up Workflow** - Use keyboard shortcuts daily
4. **Explore Extensions** - Find more extensions as you need them
5. **Customize** - Adjust settings and keybindings to your preferences

---

## Additional Resources

### Official Documentation
- [VS Code Python Docs](https://code.visualstudio.com/docs/languages/python)
- [VS Code Debugging Guide](https://code.visualstudio.com/docs/editor/debugging)
- [Pylance Documentation](https://github.com/microsoft/pylance-release)
- [Ruff Extension](https://github.com/charliermarsh/ruff-vscode)

### Recommended Extensions
- **Pylint** - Alternative linter
- **Better Comments** - Highlight important comments
- **Peacock** - Color code workspaces
- **Rainbow Brackets** - Color matched brackets

---

## Summary

You now have:

✅ **Professional Python environment** in VS Code
✅ **Powerful debugging tools** at your fingertips
✅ **Integrated testing** directly in editor
✅ **Code quality automation** with ruff and Pylance
✅ **Professional workflow** matching industry standards

Use this guide alongside the [Complete Modern Python Project Tutorial](./complete-modern-project-tutorial.md) to master Python development!

---

*Last updated: 2025-11-12*

**← Back to**: [Python Fundamentals](./README.md)
