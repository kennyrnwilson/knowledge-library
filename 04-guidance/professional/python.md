# Python Resources

**Purpose:** Quick reference and guidance for Python programming and development.

## Core Python Learning Path

### Foundational Courses
- **Python for Everybody (Py4E)** - Best for beginners
  - Free on Coursera
  - Focus on fundamentals and syntax

- **CS50's Introduction to Computer Science** - Broader CS foundation
  - Harvard's edX course (free audit)
  - Includes Python and computer science concepts

### Practice and Application
- **LeetCode and HackerRank** - Algorithm practice
- **Real Python** - Comprehensive tutorials and articles
- **Official Python Docs** - Always your best reference

## Python Best Practices

### Code Style
- Follow PEP 8 style guide
- Use meaningful variable names
- Write docstrings for functions and classes
- Keep functions focused and modular

### Development Workflow
1. **Virtual Environments** - Isolate dependencies with venv
2. **Package Management** - Use pip for installing packages
3. **Version Control** - Always use Git for your code
4. **Testing** - Write unit tests with pytest
5. **Documentation** - Document your code well

### Common Libraries

| Library | Purpose | Use Case |
|---------|---------|----------|
| NumPy | Numerical computing | Data processing, math |
| Pandas | Data manipulation | Data analysis, CSV/Excel |
| Matplotlib/Seaborn | Visualization | Plotting and charts |
| Scikit-learn | Machine learning | ML models and preprocessing |
| TensorFlow/PyTorch | Deep learning | Neural networks |
| Flask/Django | Web frameworks | Building APIs and web apps |
| Requests | HTTP client | Working with APIs |
| Pytest | Testing | Writing unit tests |

## Quick Reference

### Virtual Environment Setup
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

### Common Commands
```bash
pip list              # See installed packages
pip freeze > requirements.txt  # Save dependencies
python script.py      # Run a script
python -m module      # Run a module
```

## Project Structure

```
my_project/
├── venv/
├── src/
│   └── my_package/
│       ├── __init__.py
│       └── module.py
├── tests/
│       └── test_module.py
├── docs/
├── requirements.txt
├── README.md
└── .gitignore
```

## Learning Progression

1. **Basics** - Syntax, data types, control flow
2. **Functions** - Parameters, returns, scope
3. **OOP** - Classes, inheritance, polymorphism
4. **Modules** - Organizing code, imports
5. **Web** - APIs, frameworks, databases
6. **Data** - NumPy, Pandas, visualization
7. **ML** - Scikit-learn, TensorFlow, PyTorch

## Related Areas

- [AI/ML Learning Roadmap](../../02-literature-notes/professional/ai-ml-learning-roadmap.md) - Comprehensive ML learning guide
- [Technical Skills](../../03-permanent-notes/profession/technical-skills/README.md) - Technical skill development
- [Profession](../../03-permanent-notes/profession/README.md) - Professional development

---

*Last updated: 2025-11-03*
