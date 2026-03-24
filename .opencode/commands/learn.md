---
description: Save important context to project memory file
agent: build
---

# Learn Command

Save important context, decisions, and patterns to the project memory file.

## Your Task

Analyze the current conversation and code changes. Append new context to the project memory file at `.opencode/memory/{PROJECT_NAME}.md`.

### What to Save

1. **Project Context** - What this project does, its purpose
2. **Key Decisions** - Architectural choices, tech stack decisions, tradeoffs made
3. **Custom Patterns** - Project-specific conventions, naming, structure
4. **Open Issues** - Known problems, incomplete work, TODOs to carry forward
5. **Lesson Learned** - Bugs fixed, mistakes avoided, effective approaches

### Rules

- APPEND to existing sections, don't overwrite
- Create new session sections when needed (dated)
- Keep entries concise and actionable
- Focus on context that future sessions need to know

### Output

After updating the memory file, confirm what was added:
- Updated file path
- What sections were modified
- Summary of what was learned

## Memory File Format

The memory file is at `.opencode/memory/{PROJECT_NAME}.md`. If it doesn't exist, create it using this template:

```markdown
# {PROJECT_NAME} Project Memory

> Persistent context loaded on every session start
> Add important context with `/learn` during or after sessions

---

## Session: [DATE]

### Project Context
- [Description of project purpose]

### Key Decisions
- [Architectural decisions]

### Custom Patterns
- [Project-specific conventions]

### Open Issues
- [Things to remember for next session]

---

*This file is auto-loaded on session start. Use `/learn` to add new context.*
```

---

**TIP**: Run `/learn` periodically during long sessions to capture insights before context compaction.
