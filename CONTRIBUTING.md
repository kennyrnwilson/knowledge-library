# Contributing Guidelines

This document describes how to maintain consistency and quality across the Knowledge Library. Follow these guidelines when creating or updating notes.

---

## 📝 Writing Standards

### Formatting Rules

**Markdown Syntax:**
- Use standard markdown (GitHub-flavored markdown)
- Use relative paths for all internal links: `[Link text](../path/to/file.md)`
- Use headers for hierarchy: `#` for main title, `##` for sections, `###` for subsections
- Use bold for emphasis: `**important concept**`
- Use italics for notes or asides: `*for example*`

**Tone:**
- Clear and direct
- First-person where appropriate ("I use this when...")
- Conversational but professional
- Avoid jargon unless explained
- Practical and actionable

**Structure:**
- Start with a clear summary or title
- Use headers to break up content
- Include concrete examples
- Add "Related Notes" at the end
- Keep paragraphs short (2-3 sentences)

### Template Usage

**Always use templates** from `.templates/` for new content:

- **Permanent Notes** → Use `note.md`
- **Books/Articles** → Use `literature-summary.md`
- **Projects** → Use `project.md`
- **Daily Thoughts** → Use `daily-note.md`
- **Folder Overviews** → Use `index.md`

### File Naming

- Use lowercase with hyphens: `this-is-a-file.md`
- Be descriptive but concise: `spaced-repetition.md` not `sr.md`
- For daily notes, include date: `2025-11-03-topic.md`
- For folder overviews, always use: `index.md`

---

## 🔗 Linking & Organization

### Internal Links

**Format:** Use relative paths from file location
```markdown
[Link text](../personal-development/learning/spaced-repetition.md)
[Management Skills](./management/index.md)
[Archive](../../06-archive/index.md)
```

**Guidelines:**
- Always use relative paths (start with `./` or `../`)
- Point to specific files, not folders (unless it's an `index.md`)
- Provide descriptive link text
- Keep "Related Notes" sections at the end of files
- Update related files when adding new connections

### External Links

```markdown
[Source Title](https://example.com/resource)
```

Include sources when citing ideas from external materials.

---

## 📊 Folder Organization

### Fleeting Notes (`01-fleeting-notes/`)

- **Purpose:** Rapid capture of unprocessed thoughts
- **Structure:** Single folder (no date subfolders)
- **Naming:** `YYYY-MM-DD-topic.md`
- **Quality:** Raw and unpolished—that's okay
- **Review:** Monthly review for promotion to permanent notes

### Literature Notes (`02-literature-notes/`)

- **Purpose:** Summaries of external sources
- **Structure:** Organize by type (books/, articles/, courses/)
- **Naming:** Use source title: `the-managers-path.md`
- **Quality:** Well-organized, linked to permanent notes
- **Status:** Track read status (To Read, Reading, Completed)

### Permanent Notes (`03-permanent-notes/`)

- **Purpose:** Your knowledge library
- **Structure:** Organized by topic hierarchy
- **Naming:** Topic/concept: `delegation.md`, `oop.md`
- **Quality:** Polished, interconnected, actionable
- **Status:** Mark as Active, Draft, or Archived
- **Key sections:**
  - Summary (1 paragraph)
  - Key Ideas (3-5 main points)
  - How I Use This (practical application)
  - Related Notes (links to other concepts)

### Projects (`04-projects/`)

- **Purpose:** Track active and past projects
- **Structure:** One folder per project
- **Naming:** Project name folder with `index.md` overview
- **Contents:** Progress tracking, milestones, learnings
- **Review:** Update regularly with progress

### Tracking (`05-tracking/`)

- **Purpose:** Goals, habits, and reviews
- **Structure:** goals.md, habit-tracking.md, weekly-reviews/, annual-reviews/
- **Frequency:** Weekly reviews, monthly checks, annual reflections
- **Format:** Use tracking templates and tables

### Archive (`06-archive/`)

- **Purpose:** Cold storage for deprecated content
- **Structure:** Organize by year and type
- **Naming:** Same as original files
- **When to archive:**
  - Content is outdated or no longer relevant
  - Concepts have been replaced by better notes
  - Historical reference only
- **Note:** Include a brief comment about why archived

---

## ✅ Checklist for New Notes

Before saving a new note, verify:

- [ ] Uses appropriate template from `.templates/`
- [ ] File is named correctly (lowercase, hyphens)
- [ ] Placed in correct folder hierarchy
- [ ] Title is clear and descriptive
- [ ] Summary paragraph explains the concept
- [ ] Includes 2-3 key ideas with details
- [ ] "How I Use This" section is practical
- [ ] Links to 2-3 related notes
- [ ] All internal links use relative paths
- [ ] Metadata is filled in (Status, Created, Updated dates)
- [ ] No typos or formatting issues
- [ ] Related index.md files are updated

---

## 🔄 Regular Maintenance

### Weekly
- Review fleeting notes for promotion candidates
- Update project progress
- Check for broken links in recently edited files

### Monthly
- Archive old fleeting notes
- Review organization structure
- Add missing connections between related notes

### Quarterly
- Review entire structure for gaps
- Consolidate similar notes if needed
- Update PLAN.md with progress

### Annually
- Major review and restructuring if needed
- Archive completed projects
- Set focus areas for next year

---

## 📈 Quality Standards

### Excellent Note
- ✅ Clear, specific title
- ✅ 1-2 paragraph summary
- ✅ 3-5 key ideas with explanation
- ✅ Practical "How I Use This" section
- ✅ Related notes section with 2+ links
- ✅ Sources cited if applicable
- ✅ Well-formatted, readable
- ✅ Current date in metadata

### Permanent Note Specifics
- ✅ Covers one main concept
- ✅ Written in plain language
- ✅ Includes concrete examples
- ✅ Connected to broader knowledge
- ✅ Actionable and useful

### Literature Note Specifics
- ✅ 3+ key takeaways identified
- ✅ Concepts explained in your own words
- ✅ Links to related permanent notes
- ✅ Status clearly marked
- ✅ Rating/assessment if completed

---

## 🚫 What Not to Do

- ❌ Don't duplicate content—link instead
- ❌ Don't use absolute paths for links
- ❌ Don't create deep folder hierarchies (max 4 levels)
- ❌ Don't leave metadata incomplete
- ❌ Don't create random notes—they should fit the system
- ❌ Don't copy/paste—summarize in your own words
- ❌ Don't ignore broken links—fix them
- ❌ Don't forget to update index.md files

---

## 📞 Questions?

If unsure about:
- **Format** → Check the `.templates/` folder
- **Structure** → Review this document and README.md
- **Organization** → Look at existing notes in that folder
- **Approach** → Update PLAN.md to discuss and decide

---

## 🎯 Remember

The goal is a **beautiful, interconnected knowledge system** that grows over time. Quality > Quantity. Take time to write well, link thoughtfully, and maintain the structure.

---

*Last updated: 2025-11-03*
