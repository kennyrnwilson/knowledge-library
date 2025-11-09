# Control Flow

Master if/else statements, loops, and comprehensions to control program execution.

**← Back to**: [Core Python Concepts](./README.md) | [Python Fundamentals](../README.md)

---

## 📚 What You'll Learn

### Conditional Statements (if/elif/else)

Control which code runs based on conditions.

```python
# Simple if statement
age = 20
if age >= 18:
    print("You can vote")

# if/else
score = 45
if score >= 60:
    print("Passed")
else:
    print("Failed")

# if/elif/else (multiple conditions)
grade = 85
if grade >= 90:
    letter = "A"
elif grade >= 80:
    letter = "B"
elif grade >= 70:
    letter = "C"
else:
    letter = "F"
```

**How it works:**
1. Evaluate the condition (True/False)
2. If True, execute the indented block
3. Skip else/elif blocks
4. If False, check elif, then else

### Boolean Expressions

Conditions must evaluate to True or False:

```python
# Comparison operators
age = 25
age > 18        # True
age == 25       # True
name = "Alice"
name != "Bob"   # True

# Combining with and/or/not
age = 25
is_student = False
if age >= 18 and not is_student:  # True and True = True
    print("Can vote and work")

if age < 21 or is_student:  # False or False = False
    print("This won't print")

# Checking membership
colors = ["red", "green", "blue"]
"red" in colors    # True
"yellow" in colors # False
```

### Truthiness in Conditionals

Not all values are True/False, but Python evaluates them:

```python
# These are "falsy" - treated as False
if 0:           # False
    print("Won't print")

if "":          # False
    print("Won't print")

if []:          # False
    print("Won't print")

if None:        # False
    print("Won't print")

# These are "truthy" - treated as True
if 1:
    print("Prints")

if "hello":
    print("Prints")

if [1, 2, 3]:
    print("Prints")
```

### The Ternary Operator

Inline conditional expression:

```python
# Traditional if/else
age = 20
if age >= 18:
    status = "adult"
else:
    status = "minor"

# Ternary operator (one line)
status = "adult" if age >= 18 else "minor"

# Complex example
x = 10
y = 20
max_value = x if x > y else y  # 20
```

---

## For Loops

Iterate over sequences (lists, strings, ranges, etc.)

### Basic For Loop

```python
# Loop through a list
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)
# Output: apple, banana, cherry

# Loop through a string
for letter in "hello":
    print(letter)
# Output: h, e, l, l, o
```

### Using range()

Generate sequences of numbers:

```python
# range(stop)
for i in range(5):      # 0, 1, 2, 3, 4
    print(i)

# range(start, stop)
for i in range(2, 5):   # 2, 3, 4
    print(i)

# range(start, stop, step)
for i in range(0, 10, 2):  # 0, 2, 4, 6, 8
    print(i)

# Backwards
for i in range(5, 0, -1):  # 5, 4, 3, 2, 1
    print(i)
```

### Using enumerate()

Get both index and value:

```python
fruits = ["apple", "banana", "cherry"]
for i, fruit in enumerate(fruits):
    print(f"{i}: {fruit}")
# Output:
# 0: apple
# 1: banana
# 2: cherry

# With custom start index
for i, fruit in enumerate(fruits, start=1):
    print(f"{i}: {fruit}")
# Output:
# 1: apple
# 2: banana
# 3: cherry
```

### Unpacking in Loops

Extract values from sequences:

```python
# Unpacking tuples
pairs = [(1, "a"), (2, "b"), (3, "c")]
for number, letter in pairs:
    print(f"{number}: {letter}")

# Unpacking dictionaries
person = {"name": "Alice", "age": 25}
for key, value in person.items():
    print(f"{key}: {value}")
```

---

## While Loops

Repeat until a condition becomes False:

```python
# Simple while loop
count = 0
while count < 5:
    print(count)
    count += 1
# Output: 0, 1, 2, 3, 4

# User input loop
password = ""
while password != "secret":
    password = input("Enter password: ")
print("Correct!")
```

**Avoiding Infinite Loops:**

```python
# BAD - infinite loop (never ends)
# while True:
#     print("Never ends")

# GOOD - has exit condition
counter = 0
while counter < 5:
    print(counter)
    counter += 1
```

**When to use while vs for:**
- `for`: When you know the sequence to loop through
- `while`: When you loop until a condition is met

---

## Loop Control: break and continue

### break - Exit the Loop

```python
# Find first even number
numbers = [1, 3, 5, 2, 7]
for num in numbers:
    if num % 2 == 0:
        print(f"Found even: {num}")
        break  # Exit loop
# Output: Found even: 2

# Breaking out of while loop
while True:
    user_input = input("Enter 'quit' to exit: ")
    if user_input == "quit":
        break  # Exit while loop
```

### continue - Skip to Next Iteration

```python
# Skip odd numbers
numbers = [1, 2, 3, 4, 5]
for num in numbers:
    if num % 2 == 1:
        continue  # Skip this iteration
    print(num)
# Output: 2, 4

# Skip invalid entries
for entry in user_entries:
    if entry is None:
        continue  # Skip to next entry
    process(entry)
```

### Using else with Loops

Else block runs if loop completes normally (not via break):

```python
# Else executes (no break)
for num in [1, 2, 3]:
    print(num)
else:
    print("Loop completed")
# Output: 1, 2, 3, Loop completed

# Else doesn't execute (break occurred)
for num in [1, 2, 3]:
    if num == 2:
        break
else:
    print("Won't print")  # Skipped because of break
```

---

## List Comprehensions

Create lists concisely from existing sequences:

### Basic List Comprehension

```python
# Traditional approach
squares = []
for i in range(5):
    squares.append(i ** 2)
# Result: [0, 1, 4, 9, 16]

# List comprehension
squares = [i ** 2 for i in range(5)]
# Much more concise!

# String example
words = ["hello", "world", "python"]
uppercase = [word.upper() for word in words]
# Result: ['HELLO', 'WORLD', 'PYTHON']
```

### List Comprehension with Conditions

```python
# Filter even numbers
numbers = [1, 2, 3, 4, 5, 6]
evens = [n for n in numbers if n % 2 == 0]
# Result: [2, 4, 6]

# Complex condition
students = [
    {"name": "Alice", "grade": 85},
    {"name": "Bob", "grade": 75},
    {"name": "Charlie", "grade": 95}
]
high_performers = [
    s["name"] for s in students if s["grade"] >= 90
]
# Result: ['Charlie']
```

### Nested Comprehensions

```python
# Create multiplication table
multiplication = [
    [i * j for j in range(1, 4)] for i in range(1, 4)
]
# Result: [[1, 2, 3], [2, 4, 6], [3, 6, 9]]

# Flatten a list
nested = [[1, 2], [3, 4], [5, 6]]
flat = [item for sublist in nested for item in sublist]
# Result: [1, 2, 3, 4, 5, 6]
```

### Dictionary and Set Comprehensions

```python
# Dictionary comprehension
numbers = [1, 2, 3, 4]
squares_dict = {n: n ** 2 for n in numbers}
# Result: {1: 1, 2: 4, 3: 9, 4: 16}

# From existing dict
original = {"a": 1, "b": 2, "c": 3}
doubled = {k: v * 2 for k, v in original.items()}
# Result: {'a': 2, 'b': 4, 'c': 6}

# Set comprehension
unique_lengths = {len(word) for word in ["hello", "world", "hi"]}
# Result: {2, 5}
```

---

## Nested Control Flow

Combining multiple structures:

```python
# Nested loops
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
for row in matrix:
    for value in row:
        print(value, end=" ")
    print()  # New line

# If inside loop
numbers = [1, 2, 3, 4, 5, 6]
for num in numbers:
    if num % 2 == 0:
        print(f"{num} is even")

# Comprehension with nested conditions
matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
evens = [n for row in matrix for n in row if n % 2 == 0]
# Result: [2, 4, 6, 8]
```

---

## Common Patterns

### Iterate with Counter

```python
index = 0
for item in items:
    # Can use index here
    print(f"{index}: {item}")
    index += 1

# Better: use enumerate()
for index, item in enumerate(items):
    print(f"{index}: {item}")
```

### Filter and Transform

```python
# Get only positive numbers, double them
numbers = [-2, -1, 0, 1, 2]
result = [n * 2 for n in numbers if n > 0]
# Result: [2, 4]
```

### Search for Item

```python
target = "apple"
fruits = ["apple", "banana", "cherry"]

# Method 1: In operator
if target in fruits:
    print("Found")

# Method 2: Loop with break
found = False
for fruit in fruits:
    if fruit == target:
        found = True
        break

# Method 3: Try to get index
try:
    index = fruits.index(target)
except ValueError:
    print("Not found")
```

---

## 🔗 Learning Resources

### Official Documentation

- [Python Control Flow](https://docs.python.org/3/tutorial/controlflow.html) - Official tutorial
- [for Statement](https://docs.python.org/3/reference/compound_stmts.html#for) - For loops reference
- [while Statement](https://docs.python.org/3/reference/compound_stmts.html#while) - While loops reference

### Tutorials

- [Real Python: if/elif/else](https://realpython.com/python-conditional-statements/) - Comprehensive guide
- [Real Python: for Loops](https://realpython.com/for-in-python/) - For loop tutorial
- [Real Python: List Comprehensions](https://realpython.com/list-comprehensions-and-generator-expressions/) - Advanced comprehensions

### Tools

- [Python Tutor](https://pythontutor.com/) - Visualize loop execution step-by-step
- Python REPL: Experiment with loops interactively

---

## ✅ Learning Checklist

### Conditional Statements

- [ ] Write if/else statements
- [ ] Write if/elif/else chains
- [ ] Combine conditions with and, or, not
- [ ] Use comparison operators correctly
- [ ] Understand truthiness and falsy values
- [ ] Use ternary operator for simple conditionals

### For Loops

- [ ] Loop through lists and strings
- [ ] Use range() with different parameters
- [ ] Use enumerate() to get index and value
- [ ] Unpack values in loop headers
- [ ] Loop through dictionaries with .items()

### While Loops

- [ ] Write while loops with proper exit conditions
- [ ] Avoid infinite loops
- [ ] Update loop counter properly
- [ ] Know when to use while vs for

### Loop Control

- [ ] Use break to exit loops early
- [ ] Use continue to skip iterations
- [ ] Use else clause with loops
- [ ] Know when each is appropriate

### List Comprehensions

- [ ] Write basic list comprehensions
- [ ] Add filtering conditions to comprehensions
- [ ] Nest comprehensions appropriately
- [ ] Write dictionary comprehensions
- [ ] Write set comprehensions
- [ ] Know when to use comprehensions vs loops

### Nested Control Flow

- [ ] Write nested loops correctly
- [ ] Combine if statements with loops
- [ ] Use comprehensions with nested conditions
- [ ] Understand indentation and scope

### Hands-On Practice

- [ ] Write a program with multiple conditional paths
- [ ] Create loops that process collections
- [ ] Use break and continue effectively
- [ ] Refactor loops into comprehensions
- [ ] Build a program combining multiple concepts

---

*Last updated: 2025-11-04*
