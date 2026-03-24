# Changes from Everything Claude Code (ECC)

This document describes the changes made to adapt the [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) project for OpenCode.

---

## Summary

Three main changes were made to fix bugs and add a memory system for better OpenCode compatibility.

---

## Change 1: Model Configuration Fix (CRITICAL)

### Issue

Setting `model` at `agent.*.model` level causes validation errors when switching agents via tab.

### Root Cause

OpenCode validates `agent.*.model` stricter than root-level `model`. This is a known OpenCode quirk.

### Fix

Remove `model` from all agent configurations. Use only root-level `model`.

```json
// BEFORE (causes errors):
"agent": {
  "build": {
    "model": "anthropic/claude-sonnet-4-5"  // ERROR on tab-switch
  }
}

// AFTER (works):
"agent": {
  "build": {
    // model not specified - uses root level
  }
}
```

All 12 agent configs were updated to remove `model` field.

---

## Change 2: Model Identifiers Updated

### Issue

Short model IDs may not resolve correctly. Full versioned identifiers are more reliable.

### Fix

Updated root-level model configuration:

```json
// BEFORE:
"model": "anthropic/claude-sonnet-4-5",
"small_model": "anthropic/claude-haiku-4-5"

// AFTER:
"model": "anthropic/claude-sonnet-4-5-20250929",
"small_model": "anthropic/claude-haiku-4-5-20251001"
```

---

## Change 3: Memory System Added

### Issue

No persistent context across sessions. Every new session starts fresh.

### Fix

Added a memory system that:

1. **Creates a memory template** at `.opencode/memory/PROJECT_NAME.md`
2. **Auto-loads on session start** via `opencode.json` instructions
3. **Updates via `/learn` command** to save patterns and decisions

#### Files Changed

| File | Change |
|------|--------|
| `.opencode/memory/PROJECT_NAME.md` | New - Template memory file |
| `.opencode/commands/learn.md` | Rewritten - Now saves to memory file |
| `.opencode/instructions/INSTRUCTIONS.md` | Updated - Added Memory System section |
| `.opencode/opencode.json` | Updated - `learn` command now uses `build` agent |

---

## File-by-File Changes

### `.opencode/opencode.json`

- Removed `"model"` from all 12 agent configurations
- Updated root-level `model` to `anthropic/claude-sonnet-4-5-20250929`
- Updated `small_model` to `anthropic/claude-haiku-4-5-20251001`
- Removed `AGENTS.md` and `CONTRIBUTING.md` from instructions (these were Claude Code-specific)
- Updated `learn` command description and agent

### `.opencode/commands/learn.md`

- Completely rewritten to save context to memory file
- New description: "Save important context to project memory file"
- Includes template for creating memory file if it doesn't exist

### `.opencode/instructions/INSTRUCTIONS.md`

- Added "Memory System" section with overview, setup guide, and best practices
- Added `/learn` command to available commands list

### `.opencode/memory/PROJECT_NAME.md` (New)

- Template file for project memory
- Includes session-based structure
- Auto-loaded on session start

---

## How to Replicate These Changes in Your Project

### Quick Setup

```bash
# 1. Copy .opencode/ from this repo
cp -r .opencode/ /path/to/your-project/

# 2. Create memory file
PROJECT_NAME=$(basename "$PWD")
mkdir -p .opencode/memory

cat > ".opencode/memory/${PROJECT_NAME}.md" << 'EOF'
# PROJECT_NAME Project Memory

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
EOF

sed -i "s/PROJECT_NAME/${PROJECT_NAME}/g" ".opencode/memory/${PROJECT_NAME}.md"

# 3. Update opencode.json to include memory file
# Add ".opencode/memory/YOUR_PROJECT.md" to the instructions array
```

### Model Configuration

If you need to change models, update only the root-level:

```json
{
  "model": "anthropic/claude-sonnet-4-5-20250929",
  "small_model": "anthropic/claude-haiku-4-5-20251001"
}
```

Do NOT add `model` to agent configurations.

---

## Version

Based on: Everything Claude Code v1.9.0
OpenCode plugin version: 1.3.0

---

## References

- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code)
- [OpenCode Documentation](https://opencode.ai)
- [OpenCode Models](https://models.dev)
