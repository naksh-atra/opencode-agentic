# opencode-agentic

Production-ready agentic toolkit for [OpenCode](https://opencode.ai) — clone, configure, and go.

## What This Is

A complete OpenCode configuration with:

- **15 specialized agents** for code review, security, testing, architecture, and more
- **30+ slash commands** for development workflows
- **29 skills** covering best practices across languages and frameworks
- **Custom tools** for testing, coverage, security, and code formatting
- **Memory system** that persists context across sessions

All tuned, tested, and ready to use in any project.

## Quick Start (1 Command)

```bash
# Run the setup script - it handles everything
curl -sSL https://raw.githubusercontent.com/naksh-atra/opencode-agentic/main/setup.sh | bash -s /path/to/your-project

# Or clone and setup manually:
gh repo clone naksh-atra/opencode-agentic
cd opencode-agentic
./setup.sh /path/to/your-project
```

That's it! The script:
- Copies `.opencode/` to your project
- Creates memory file with your project name
- Adds memory file to OpenCode instructions

Open your project in OpenCode and start coding.

---

## What's Included

### 13 Specialized Agents

| Agent | Purpose | Mode |
|-------|---------|------|
| build | Primary coding agent | primary |
| planner | Implementation planning | subagent |
| architect | System design | subagent |
| code-reviewer | Code quality review | subagent |
| security-reviewer | Vulnerability detection | subagent |
| tdd-guide | Test-driven development | subagent |
| build-error-resolver | Fix build/type errors | subagent |
| e2e-runner | Playwright E2E testing | subagent |
| doc-updater | Documentation | subagent |
| refactor-cleaner | Dead code cleanup | subagent |
| go-reviewer | Go code review | subagent |
| go-build-resolver | Go build errors | subagent |
| database-reviewer | PostgreSQL optimization | subagent |
| rust-reviewer | Rust code review | subagent |
| rust-build-resolver | Rust build errors | subagent |

### 30+ Slash Commands

| Command | Description |
|---------|-------------|
| `/plan` | Create implementation plan |
| `/tdd` | Enforce TDD workflow |
| `/code-review` | Review code changes |
| `/security` | Security review |
| `/build-fix` | Fix build errors |
| `/e2e` | Generate E2E tests |
| `/refactor-clean` | Remove dead code |
| `/orchestrate` | Multi-agent workflow |
| `/learn` | Save context to memory |
| `/checkpoint` | Save verification state |
| `/verify` | Run verification loop |
| `/eval` | Run evaluation criteria |
| `/update-docs` | Update documentation |
| `/update-codemaps` | Update codemaps |
| `/test-coverage` | Analyze test coverage |
| `/setup-pm` | Configure package manager |
| `/go-review` | Go code review |
| `/go-test` | Go TDD workflow |
| `/go-build` | Go build errors |
| `/rust-review` | Rust code review |
| `/rust-test` | Rust TDD workflow |
| `/rust-build` | Rust build errors |
| `/skill-create` | Generate skills from git |
| `/instinct-status` | View learned instincts |
| `/instinct-import` | Import instincts |
| `/instinct-export` | Export instincts |
| `/evolve` | Cluster instincts into skills |
| `/promote` | Promote project to global |
| `/projects` | List known projects |

### 29 Skills

Best practices for: TypeScript, JavaScript, React, Next.js, Node.js, Go, Python, Rust, API design, testing, security, E2E testing, and more.

---

## Memory System

The memory system persists important context across sessions.

### How It Works

1. **Auto-loaded on start** - Memory file from `opencode.json` instructions
2. **Append during session** - Use `/learn` to save decisions and patterns
3. **Persist for next time** - Context survives context compaction

### What Gets Saved

- Project purpose and context
- Architectural decisions and tradeoffs
- Custom patterns and conventions
- Known issues and incomplete work
- Lessons learned from debugging

### Best Practices

- Run `/learn` periodically during long sessions
- Be specific about decisions (why, not just what)
- Track open issues for next session
- Don't overwrite - append to existing sections

---

## Customization

### Change Models

Edit `.opencode/opencode.json`:

```json
{
  "model": "anthropic/claude-sonnet-4-5-20250929",
  "small_model": "anthropic/claude-haiku-4-5-20251001"
}
```

Available models:
- `anthropic/claude-sonnet-4-5-20250929` - Best coding model
- `anthropic/claude-opus-4-5-20251101` - Deepest reasoning
- `anthropic/claude-haiku-4-5-20251001` - Fastest, cost savings

### Add Custom Agents

Create a new agent prompt file in `.opencode/prompts/agents/` and add it to `opencode.json`:

```json
{
  "agent": {
    "my-agent": {
      "description": "What this agent does",
      "mode": "subagent",
      "prompt": "{file:prompts/agents/my-agent.txt}",
      "tools": {
        "read": true,
        "bash": true
      }
    }
  }
}
```

### Add Custom Commands

Create a new command file in `.opencode/commands/` and add it to `opencode.json`:

```json
{
  "command": {
    "my-command": {
      "description": "What this command does",
      "template": "{file:commands/my-command.md}\n\n$ARGUMENTS"
    }
  }
}
```

---

## File Structure

```
.opencode/
├── opencode.json          # Main config (agents, commands, tools)
├── instructions/
│   └── INSTRUCTIONS.md   # Core rules and guidelines
├── memory/
│   └── MEMORY.md         # Project memory template
├── commands/
│   └── *.md              # Slash command definitions
├── prompts/
│   └── agents/
│       └── *.txt         # Agent prompt templates
├── skills/
│   └── */SKILL.md        # Best practice skill definitions
├── tools/
│   └── *.ts              # Custom tool implementations
├── plugins/
│   ├── ecc-hooks.ts      # Plugin hooks
│   └── index.ts          # Plugin entry point
```

---

## Troubleshooting

### Model Validation Errors

If you get validation errors when switching agents:

- **Don't set `model` at `agent.*.model` level** - use only root-level `model`
- This is a known OpenCode quirk

### Memory Not Loading

- Check that `opencode.json` includes your memory file in `instructions` array
- Verify the file path matches exactly
- Check file permissions

### Agent Not Responding

- Verify agent is defined in `opencode.json`
- Check that prompt file exists in `.opencode/prompts/agents/`
- Ensure tools are properly configured

---

## Credits

Built on the [Everything Claude Code](https://github.com/affaan-m/everything-claude-code) project, optimized for OpenCode.

## License

MIT
