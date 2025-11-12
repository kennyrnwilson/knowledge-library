# 🔧 Part 4.5-6: Version Control, CI/CD, and Publishing Setup

Push your code to GitHub, set up continuous integration with GitHub Actions, and prepare for publishing. This section ensures your code is professionally hosted and automatically tested.

**← Back to**: [Complete Tutorial Index](./complete-modern-project-tutorial.md) | [Testing & Quality](./02-testing-and-code-quality.md) | [Python Fundamentals](./README.md)

---

## 📚 What You'll Learn in This Section

- **Git version control** - Initialize repository and push to GitHub
- **GitHub setup** - Create repository and manage remote code
- **GitHub Actions CI/CD** - Automatic testing on every push
- **Building packages** - Create distributable wheel and source distributions
- **PyPI publishing** - Upload to Test PyPI and production PyPI
- **Package inspection** - Verify your package contents

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

The `.pypirc` file stores your PyPI authentication credentials. It goes in your home directory (`~/.pypirc`).

Create `~/.pypirc`:

```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
repository = https://upload.pypi.org/legacy/
username = __token__
password = pypi-AgEIcHlwaS5vcmc...  # Your API token from PyPI

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-AgEIcHlwaS5vcmc...  # Your API token from TestPyPI (can be different)
```

#### Understanding .pypirc

**`[distutils]` Section**
- Tells twine which package repositories are configured
- `index-servers = pypi testpypi` lists all available repositories
- When you use `twine upload`, it defaults to `pypi`
- When you use `twine upload --repository testpypi`, it uses the `testpypi` configuration
- You must list all repositories you want to use here

**`[pypi]` Section - PyPI Configuration (Production)**

**`repository = https://upload.pypi.org/legacy/`**
- The URL where PyPI packages are uploaded
- `/legacy/` is the legacy API (works with twine)

**`username = __token__`**
- **This is NOT your actual PyPI username!**
- `__token__` is a special keyword that tells PyPI "I'm using an API token"
- It's the same for all PyPI users using token authentication
- You don't change this to your actual username

**`password = pypi-AgEIcHlwaS5vcmc...`**
- This is your actual API token (generated on PyPI)
- Starts with `pypi-` prefix
- Unique to you - keep it secret!
- Example: `pypi-AgEIcHlwaS5vcmc2FudHJvcGljLnNvY2kv`

**`[testpypi]` Section - TestPyPI Configuration**

TestPyPI is a separate, safe test environment for practicing package uploads before publishing to production PyPI.

**`repository = https://test.pypi.org/legacy/`**
- The test repository URL (different from production PyPI)
- Use this when developing and testing your package

**`username = __token__` and `password = ...`**
- Same format as PyPI section
- You need separate API tokens for TestPyPI and PyPI
- Get TestPyPI token from https://test.pypi.org/manage/account/tokens/

**Why Test First?**
- TestPyPI is isolated - no one installs from it by accident
- You can test the upload process without affecting production
- Good for checking package metadata, README rendering, etc.
- You can upload the same version multiple times to TestPyPI (unlike production PyPI)

#### Creating Your API Tokens

**For PyPI (Production):**
1. Go to https://pypi.org/manage/account/tokens/
2. Click "Create token"
3. Give it a name: `simple-calculator-prod`
4. Scope: Choose "Entire account" or "Project specific"
5. Copy the token (it's only shown once!)
6. Add to `.pypirc` under `[pypi]` section

**For TestPyPI (Testing):**
1. Go to https://test.pypi.org/manage/account/tokens/
2. Click "Create token"
3. Give it a name: `simple-calculator-test`
4. Scope: Choose "Entire account" or "Project specific"
5. Copy the token (it's only shown once!)
6. Add to `.pypirc` under `[testpypi]` section

**Your .pypirc should look like:**
```ini
[distutils]
index-servers =
    pypi
    testpypi

[testpypi]
repository = https://test.pypi.org/legacy/
username = __token__
password = pypi-AgEIcHlwaS5vcmc2FudHRvcG9waXMub3Jn  # TestPyPI API token

[pypi]
repository = https://upload.pypi.org/legacy/
username = __token__
password = pypi-AgEIcHlwaS5vcmc2FudHRvcG9waXMub3Jn  # Production PyPI API token
```

**Security Note:**
- ⚠️ NEVER commit `.pypirc` to git (it contains your secret token!)
- ⚠️ Add `~/.pypirc` to your global `.gitignore`
- ⚠️ If you accidentally leaked a token, regenerate it immediately at https://pypi.org/manage/account/tokens/

### Step 8.3: Upload to TestPyPI (Test First!)

Always test on TestPyPI before uploading to production PyPI. This is crucial!

```bash
# Upload to TestPyPI
twine upload --repository testpypi dist/*
```

**Expected output:**
```
Uploading distributions to https://test.pypi.org/legacy/
Uploading simple_calculator-0.1.0-py3-none-any.whl
[100%] ████████████████████████████████████
Uploading simple_calculator-0.1.0.tar.gz
[100%] ████████████████████████████████████

View at:
https://test.pypi.org/project/simple-calculator/
```

**Troubleshooting TestPyPI Upload:**

**Missing `[testpypi]` section in `.pypirc`**
- Error: `InvalidConfiguration: Missing 'testpypi' section from ~/.pypirc`
- Solution: Add the `[testpypi]` section per instructions above

**Invalid token**
- Error: `HTTPError: 403 Forbidden`
- Solution: Create new token at https://test.pypi.org/manage/account/tokens/
- Remember: TestPyPI and PyPI tokens are separate!

**Project name already exists or too similar**
- Error: `400 Bad Request - The name 'simple-calculator' is too similar to an existing project`
- Cause: Someone else already registered that package name (common with tutorial examples)
- Solution: Use a unique name like `simple-calculator-{your-username}`
  ```toml
  [project]
  name = "simple-calculator-kenne"  # Use your username instead of kenne
  ```
- Then rebuild and re-upload:
  ```bash
  python -m build
  twine upload --repository testpypi dist/*
  ```

**Package already uploaded with same version**
- Error: `400 Bad Request - File already exists`
- Solution: TestPyPI allows re-uploads of the same version, but if you get this error:
  - Increment the version: `version = "0.1.1"`
  - Rebuild: `python -m build`
  - Upload: `twine upload --repository testpypi dist/*`

### Step 8.4: Upload to Production PyPI

Once TestPyPI upload is successful and you've verified the package looks correct:

```bash
# Upload to production PyPI
twine upload dist/*

# Verify on PyPI
# https://pypi.org/project/simple-calculator/
```

**Important:** You can only upload each version number **once** to production PyPI. You cannot delete or re-upload the same version. Make sure everything is correct before uploading!

### Step 8.5: Verify Installation from PyPI

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


## Next Steps

Once publishing is complete, proceed to:

**[Part 9-10: Maintenance and Best Practices](./04-publishing-and-maintenance.md)**
- Complete development workflow
- Maintaining your package
- Keeping dependencies updated
- Creating releases

---

## Related Guides

- **[Complete Tutorial Index](./complete-modern-project-tutorial.md)** - Overview of all parts
- **[Testing & Code Quality](./02-testing-and-code-quality.md)** - Back to testing section
- **[Python Fundamentals](./README.md)** - Main Python guide
