---
name: token-economy
description: "Use when planning a task, choosing which agent to delegate to, or deciding how to interact with the codebase to minimize token spend and context pressure. Covers agent selection, model tiers, context discipline, and subagent caching behavior."
---

# Token Economy

## Core constraints in OpenCode

- Agents cannot switch modes (plan/build/explore) autonomously.
- Agents cannot request a specific model; models are configured per agent in the opencode config.
- A subagent call does not reset the caller's cache, but the subagent starts with no context and no cache.

## Agent model tiers

Route work by tier, not by habit:

- **Build** — strongest coding model.
- **Plan** — best reasoning model.
- **General** — cheap but capable model for parallel work.
- **Explore** — cheap read-only model for search/analysis.
- **Title / Summary / Compaction** — cheapest adequate model.

## Minimizing token spend

- Stay in the current agent when possible.
- Delegate to a subagent only for self-contained, short tasks where the fresh context is acceptable.
- Use Grep/Glob to locate symbols; read only the fragments you need.
- Do not re-send unchanged files in later turns.
- Batch related edits instead of making many tiny changes.
- Use skills and `AGENTS.md` as read-only context instead of restating rules.
- Keep sessions compact; use compaction when history grows.

## When not to save tokens

- Safety-critical changes.
- Complex architecture decisions.
- Tasks where errors are expensive.

In those cases, use the best model and do not skip plan-then-approve.
