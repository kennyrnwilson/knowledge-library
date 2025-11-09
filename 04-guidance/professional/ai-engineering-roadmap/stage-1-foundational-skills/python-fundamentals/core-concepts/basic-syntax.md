# Basic Syntax & Data Types

Learn Python's fundamental syntax and built-in data types—the foundation for all Python programming.

**← Back to**: [Core Python Concepts](./README.md) | [Python Fundamentals](../README.md)

---

## 📚 What You'll Learn

### Variables and Assignment

Variables are how Python stores data. Unlike many languages, Python uses **dynamic typing**—you don't declare types upfront.

```python
# Variable assignment
name = "Alice"           # String
age = 25                # Integer
height = 5.8            # Float
is_student = True       # Boolean
grade = None            # None (no value)

# Python figures out the type automatically
print(type(name))       # <class 'str'>
print(type(age))        # <class 'int'>
```

**Naming Conventions** (PEP 8):
- Use `snake_case` (lowercase with underscores) for variables
- Use `UPPER_CASE` for constants
- Start with letter or underscore, not a number
- Avoid Python reserved words (if, for, while, etc.)

```python
# GOOD naming
user_age = 25
max_attempts = 3
_private_var = "hidden"

# BAD naming
userAge = 25            # Use snake_case
25_age = 25            # Can't start with number
if = "reserved word"   # Can't use reserved words
```

### Data Types

Python has several built-in data types:

| Type | Example | Use Case |
|------|---------|----------|
| **int** | `42`, `-5` | Whole numbers |
| **float** | `3.14`, `-2.5` | Decimal numbers |
| **str** | `"hello"` | Text data |
| **bool** | `True`, `False` | True/False values |
| **None** | `None` | "No value" |

```python
# Integers
count = 10
negative = -5
big_number = 1_000_000  # Underscores for readability

# Floats
pi = 3.14159
percentage = 99.9
scientific = 1.5e-10    # Scientific notation

# Strings
message = "Hello"
quote = 'It\'s working'  # Escape apostrophe
multiline = """This is
on multiple
lines"""

# Booleans
is_active = True
is_empty = False

# None (placeholder for "no value")
result = None
```

### Operators

Python supports multiple types of operators:

**Arithmetic Operators:**

| Operator | Operation | Example |
|----------|-----------|---------|
| `+` | Addition | `3 + 2` → 5 |
| `-` | Subtraction | `5 - 2` → 3 |
| `*` | Multiplication | `3 * 4` → 12 |
| `/` | Division (float) | `7 / 2` → 3.5 |
| `//` | Integer division | `7 // 2` → 3 |
| `%` | Modulo (remainder) | `7 % 2` → 1 |
| `**` | Exponentiation | `2 ** 3` → 8 |

```python
# Arithmetic
total = 10 + 5          # 15
difference = 10 - 3     # 7
product = 4 * 5         # 20
quotient = 10 / 3       # 3.3333...
integer_div = 10 // 3   # 3
remainder = 10 % 3      # 1
power = 2 ** 10         # 1024

# Operator precedence (like math)
result = 2 + 3 * 4      # 14 (multiply first)
result = (2 + 3) * 4    # 20 (parentheses first)
```

**Comparison Operators** (return True/False):

```python
# Equality
5 == 5          # True
5 == "5"        # False (different types)

# Inequality
5 != 3          # True
5 != 5          # False

# Greater/Less than
10 > 5          # True
5 > 10          # False
5 < 10          # True
5 <= 5          # True (equal to or less)
5 >= 5          # True (equal to or greater)

# Comparing strings
"apple" < "banana"      # True (alphabetical order)
"apple" == "apple"      # True
```

**Logical Operators:**

```python
# AND - both must be True
True and True           # True
True and False          # False

# OR - at least one must be True
True or False           # True
False or False          # False

# NOT - reverses the value
not True                # False
not False               # True

# Combining conditions
age = 25
is_student = True
can_vote = age >= 18 and not is_student  # True and False = False
```

### Type Conversion

Convert between data types:

```python
# String to integer
age = int("25")         # 25
count = int("42")       # 42

# String to float
price = float("19.99")  # 19.99

# Integer to string
text = str(42)          # "42"

# Converting to boolean
bool(1)                 # True
bool(0)                 # False
bool("")                # False (empty string)
bool("hello")           # True (non-empty string)
bool([])                # False (empty list)
bool([1, 2, 3])         # True (non-empty list)
```

### String Operations

Strings are sequences of characters with special operations:

```python
# Concatenation
greeting = "Hello" + " " + "World"  # "Hello World"
name = "Alice"
message = "Hi, " + name             # "Hi, Alice"

# String methods
text = "python"
text.upper()            # "PYTHON"
text.capitalize()       # "Python"
text.replace("o", "0")  # "pyth0n"
text.startswith("py")   # True
text.endswith("on")     # True

# String indexing
word = "hello"
word[0]                 # "h" (first character)
word[-1]                # "o" (last character)
word[1:4]               # "ell" (slice)

# String formatting (f-strings, Python 3.6+)
name = "Alice"
age = 25
# Old way: "Hello {}".format(name)
# New way:
message = f"Hello {name}, you are {age} years old"
# "Hello Alice, you are 25 years old"

# Expressions in f-strings
price = 19.99
f"Price: ${price:.2f}"  # "Price: $19.99"
f"In 10 years: {age + 10}"  # "In 10 years: 35"
```

### Truthiness and Falsy Values

In Python, some values are considered "falsy" (like False) and others "truthy":

**Falsy values:**
- `False`
- `0`, `0.0`
- Empty string `""`
- Empty collections: `[]`, `{}`, `()`, `set()`
- `None`

**Truthy values:** Everything else

```python
# These evaluate to False in conditionals
if 0:
    print("Won't execute")

if "":
    print("Won't execute")

if []:
    print("Won't execute")

# These evaluate to True
if 1:
    print("Executes")

if "hello":
    print("Executes")

if [1, 2, 3]:
    print("Executes")
```

### Multiple Assignment and Unpacking

Assign or extract multiple values at once:

```python
# Multiple assignment
x = y = z = 0           # All set to 0

# Unpacking from sequences
coordinates = (10, 20)
x, y = coordinates      # x=10, y=20

# Swapping
a = 5
b = 10
a, b = b, a            # a=10, b=5

# Unpacking with *
values = [1, 2, 3, 4, 5]
first, *middle, last = values
# first = 1
# middle = [2, 3, 4]
# last = 5
```

---

## 🔗 Learning Resources

### Official Documentation

- [Python Data Types](https://docs.python.org/3/tutorial/datastructures.html) - Official guide
- [Python Operators](https://docs.python.org/3/reference/lexical_analysis.html#operators) - All operators
- [PEP 8 Style Guide](https://pep8.org/) - Python naming conventions and style

### Tutorials

- [Real Python: Variables and Data Types](https://realpython.com/python-variables/) - Comprehensive guide
- [Real Python: Strings](https://realpython.com/python-strings/) - String operations and formatting
- [W3Schools Python Tutorial](https://www.w3schools.com/python/) - Interactive examples

### Tools

- Python REPL: `python` in terminal to experiment
- [Python Tutor](https://pythontutor.com/) - Visualize variable assignment and execution

---

## ✅ Learning Checklist

### Variables and Assignment

- [ ] Create variables with different data types
- [ ] Understand Python's dynamic typing
- [ ] Use proper snake_case naming conventions
- [ ] Know Python reserved words to avoid
- [ ] Print variables to see their values

### Basic Data Types

- [ ] Create integers (positive, negative, large numbers)
- [ ] Create floats and understand decimal precision
- [ ] Create strings with single and double quotes
- [ ] Use escape sequences (\n, \t, \', \")
- [ ] Create booleans (True, False)
- [ ] Understand None and when to use it
- [ ] Check types with `type()` function

### Arithmetic Operations

- [ ] Perform addition, subtraction, multiplication, division
- [ ] Use integer division (//) and modulo (%)
- [ ] Use exponentiation (**)
- [ ] Understand operator precedence
- [ ] Use parentheses to control order of operations

### Comparison Operations

- [ ] Compare numbers (==, !=, <, >, <=, >=)
- [ ] Compare strings (alphabetical order)
- [ ] Understand that type matters ("5" != 5)
- [ ] Use comparison results in conditionals

### Logical Operations

- [ ] Use `and` to combine conditions
- [ ] Use `or` to combine conditions
- [ ] Use `not` to negate conditions
- [ ] Combine multiple conditions effectively

### Type Conversion

- [ ] Convert strings to integers (`int()`)
- [ ] Convert strings to floats (`float()`)
- [ ] Convert numbers to strings (`str()`)
- [ ] Convert to booleans (`bool()`)
- [ ] Handle conversion errors gracefully

### String Operations

- [ ] Concatenate strings with +
- [ ] Use string methods (upper, lower, replace, etc.)
- [ ] Access characters by index and slice strings
- [ ] Format strings with f-strings
- [ ] Include expressions in f-strings
- [ ] Format decimals in f-strings

### Truthiness and Falsy Values

- [ ] Understand what values are falsy
- [ ] Predict truthiness of different values
- [ ] Use truthiness in conditionals

### Multiple Assignment and Unpacking

- [ ] Assign the same value to multiple variables
- [ ] Unpack tuples and lists into variables
- [ ] Swap variable values
- [ ] Use * to collect remaining values
- [ ] Understand tuple packing and unpacking

### Hands-On Practice

- [ ] Write a script that uses all data types
- [ ] Create a program that does calculations
- [ ] Format and display output with f-strings
- [ ] Practice type conversions with user input
- [ ] Build a simple program combining multiple concepts

---

*Last updated: 2025-11-04*
