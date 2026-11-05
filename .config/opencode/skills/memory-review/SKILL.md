---
name: memory-review
description: "Use at the start of a session or before a non-trivial task, when the user asks to remember/forget/review facts, or at the end of a task to consolidate durable knowledge. Manages ~/.local/share/opencode/memory/PERSONALITY.md, USER.md and project AGENTS.md."
---

# Memory Review

## When to use

- Start of a session or before a non-trivial task.
- User says: remember this, forget that, review memory, update notes.
- End of any task where you learned something durable.

## Workflow

1. Read relevant memory files:
   - `~/.local/share/opencode/memory/USER.md` — global environment/workflow facts.
   - `~/.local/share/opencode/memory/PERSONALITY.md` — style and behaviour corrections.
   - `./AGENTS.md` in the workspace root — project conventions.
2. Search existing notes (Grep, or just read the small files) to avoid duplicates.
3. Surface relevant facts silently; do not dump them to the user.
4. After the task, decide if any durable fact was learned.
5. Write one fact per line, concise.
6. Choose the right place:
   - Cross-project environment/workflow fact -> `USER.md`.
   - Style or behaviour correction -> `PERSONALITY.md`.
   - Project-specific fact (build/test/deploy, architecture) -> project `./AGENTS.md`.
   - Reusable multi-step workflow -> skill in `~/.config/opencode/skills/` or `.opencode/skills/`.

## Rules

- Never write secrets, API keys, tokens, internal URLs/hostnames, PII, or NDA-bound info.
- No duplicates; edit the existing line if the fact changes.
- Keep entries scannable: one bullet per fact.
- If a file grows too long, propose a compact rewrite.

## Anti-patterns

- Appending without reading first.
- Writing long paragraphs instead of concise facts.
- Putting project-specific facts in global memory files.
