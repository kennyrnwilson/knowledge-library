# Claude Code

**Status:** Fleeting Note
**Created:** 2025-11-04
**Source:** Personal experience and usage

## Summary

Claude Code is Anthropic's official CLI tool for software engineering that integrates Claude AI capabilities directly into your development workflow. It provides intelligent code assistance, file management, git integration, and multi-file editing within a command-line interface optimized for developers.

## Key Capabilities

### File Operations
- Read files with smart context preservation
- Edit files with precise find-and-replace operations
- Create and manage multiple files
- Search and grep across codebases
- Navigate complex project structures

### Development Tools
- **Bash Integration:** Execute shell commands, manage git operations
- **Git Support:** Commit, branch, push operations with automatic message generation
- **Debugging:** Execute code, test runs, inspect output
- **Multiple Parallel Operations:** Run independent tasks in parallel for speed

### Advanced Features
- **Multi-Step Task Planning:** Break complex tasks into actionable todos with progress tracking
- **Specialized Agents:** Route tasks to expert agents (Explore for codebases, Plan for architecture, general-purpose for complex work)
- **Context Management:** Intelligent context reduction to fit token budgets
- **Code Analysis:** Search patterns, find function definitions, understand structure

## Workflow Patterns

### Code Discovery
- Use **Glob** for fast file pattern matching
- Use **Grep** for content searching across files
- Use **Task(Explore)** agent for open-ended codebase questions

### Editing Efficiency
- **Read** before editing (required by Edit tool)
- Use **Edit** for precise replacements instead of Bash
- Create files only when absolutely necessary (prefer editing existing)

### Task Management
- Use **TodoWrite** to plan multi-step tasks
- Update todos as in_progress before starting work
- Mark todos completed immediately after finishing
- Only ONE task should be in_progress at a time

### Git Workflow
- Verify status before committing: `git status`
- Inspect changes: `git diff`
- Stage and commit: `git add` and `git commit` with descriptive messages
- Use heredocs for multi-line commit messages

## Best Practices Learned

### Do's ✅
- **Plan first:** Use TodoWrite for complex tasks
- **Parallel execution:** Call multiple independent tools in one request
- **Specialized tools:** Use Glob, Grep, Read, Edit instead of Bash for file work
- **Large tasks:** Use Task tool with specialized agents (Explore, Plan, general-purpose)
- **Commit early:** Make focused commits with clear intent

### Don'ts ❌
- **Avoid file operations in Bash:** Use dedicated tools instead
- **Don't batch completions:** Mark todos complete immediately
- **Don't create unnecessary files:** Edit existing ones instead
- **Don't guess parameters:** Ask user or use available tools first
- **Don't skip planning:** Use TodoWrite for anything with 3+ steps

## Feature Highlights

### Speed Optimization
- Parallel tool calls for independent operations
- Specialized agents (Explore, Plan) are much faster than general-purpose
- Glob and Grep are optimized for large codebases
- Background bash execution with run_in_background

### Reliability
- Proper error handling and recovery
- Verification steps after major operations
- Git safety protocols (no force pushes, no --amend for others' commits)
- Token budget tracking and optimization

### Integration Points
- **MCP Servers:** Connect to external tools and APIs
- **VS Code:** IDE diagnostics and language features
- **Jupyter:** Execute Python in notebooks
- **Notion:** Fetch and create pages with full markdown support
- **GitHub:** PR creation, issue management with gh command

## Common Use Cases

1. **Large Refactoring:** Plan with TodoWrite → Use Explore for understanding → Edit with precision
2. **Bug Investigation:** Grep for patterns → Read affected files → Trace through code mentally
3. **Documentation:** Fetch Notion pages → Convert to markdown → Organize with proper structure
4. **Project Setup:** Use Task(Plan) → Execute with Bash for commands → Verify with tests
5. **Code Review:** Use Explore to understand changes → Read affected files → Provide feedback

## Limitations & Workarounds

| Limitation | Workaround |
|-----------|-----------|
| No interactive git commands | Use non-interactive alternatives (commit, push, add, etc.) |
| Can't modify VS Code UI directly | Use settings.json for configuration |
| Large file context limits | Request specific line ranges with Read tool |
| No GUI tools | Use command-line alternatives |

## Personal Observations

Claude Code excels at:
- **Batch file operations** (renaming, updating links across 50+ files)
- **Architectural planning** (understanding complex projects quickly)
- **Repetitive tasks** (applying same pattern across codebase)
- **Documentation building** (converting structured data to markdown)

Challenges:
- **Real-time debugging** (limited to print statements and command output)
- **GUI tool integration** (must use CLI alternatives)
- **Very large files** (context limitations on files >2000 lines)

## Tools I Use Most Frequently

1. **TodoWrite** - Essential for all multi-step work
2. **Task(Explore)** - Fast codebase understanding
3. **Bash** - For git, commands, and terminal operations
4. **Read/Edit** - Precise file operations
5. **Glob/Grep** - Fast searching

## Integration with Knowledge Library

This note documents my learning about Claude Code as a development tool. Cross-references:
- [AI Engineering Roadmap](../04-guidance/professional/ai-engineering-roadmap/README.md) - Uses Claude Code for content creation
- [Python Fundamentals](../04-guidance/professional/ai-engineering-roadmap/stage-1-foundational-skills/python-fundamentals/README.md) - Built and tested with Claude Code

## Quick Reference

### Essential Commands
```bash
# Git operations
git status                    # Check changes
git add <file>               # Stage files
git commit -m "message"      # Create commit
git diff                     # View changes

# File exploration
find . -name "*.py"         # Find files
grep -r "pattern" .         # Search content
```

### Tool Invocation Pattern
```
1. Read file (if editing)
2. Plan with TodoWrite
3. Execute (Edit, Bash, Task, etc.)
4. Update todos
5. Verify results
6. Commit changes
```

## Resources

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code/claude_code_docs_map.md)
- [Anthropic GitHub](https://github.com/anthropics/claude-code)
- [Claude Code Issues](https://github.com/anthropics/claude-code/issues)

## Next Steps

- Explore more specialized agents and their capabilities
- Learn advanced Task routing strategies
- Master multi-agent parallel execution patterns
- Document custom workflows and patterns

---

*Last updated: 2025-11-04*
