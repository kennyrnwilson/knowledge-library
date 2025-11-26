# AI Agent Skills



Skills are a way to use files and folders to expose organisational knowledge and context to the model.

## Folder Structure

```
skills/bigquery/
├── SKILL.md
├── datasources.md
└── rules.md
```

### File Descriptions

* **SKILL.md** - Main skill definition and documentation
* **datasources.md** - Data sources configuration and references
* **rules.md** - Rules and constraints for the skill

---

## 💡 What is a Skill?

> At its simplest, a skill is a directory that contains a **SKILL.md** file. This file must start with **YAML frontmatter** that contains some required metadata: `name` and `description`. At startup, the agent pre-loads the name and description of every installed skill into its system prompt.

---

The yaml provides must enough information so the model knows when to use the skill, without polluting the context. Claude will only load the rest of the file if it decides the skill is relevant to the task at hand.

---

## ⚙️ Executable Code in Skills

Claude skills can include **executable code** that the model can run to perform actions. This allows skills to:

* **Execute logic** - Run Python, JavaScript, or other code to process data
* **Interact with systems** - Call APIs, databases, or other external services
* **Return results** - Provide the model with real-time data or computation results
* **Automate tasks** - Perform complex operations without manual intervention

For example, a BigQuery skill might include Python code that:
- Connects to a BigQuery dataset
- Executes SQL queries
- Returns results to the model for analysis or further processing

The model can decide whether to invoke these code blocks based on the task at hand, making skills a powerful way to extend Claude's capabilities with custom logic and integrations.

---

## 📚 Resources

- [Equipping Agents for the Real World with Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) - Official Anthropic engineering blog post on agent skills


