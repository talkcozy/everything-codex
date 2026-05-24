# Everything Codex

<p align="center">
  <img src="https://img.shields.io/badge/Codex-Optimized-412991?style=for-the-badge&logo=openai&logoColor=white" alt="Codex Optimized">
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README.zh-CN.md">简体中文</a>
</p>

---

**The ultimate configuration collection for OpenAI Codex — optimized for the Codex CLI and Codex App.**

> **🙏 Inspired by [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) by Affaan Mustafa**
>
> This project is a Codex-focused adaptation inspired by the excellent ECC project. We extend our gratitude to the original author for the groundbreaking work in agent configuration systems.

---

## What is Everything Codex?

Everything Codex is a comprehensive configuration system designed specifically for **OpenAI Codex** — the next-generation AI coding assistant from OpenAI. It provides:

- 🎯 **Optimized Agents** — Pre-configured agents for common development tasks
- 🛠️ **Production-Ready Skills** — Reusable skill modules for consistent workflows
- 📋 **Smart Rules** — Context-aware coding rules and guidelines
- ⚡ **MCP Integration** — Pre-configured Model Context Protocol servers
- 🔧 **Multi-Agent Workflows** — Collaborative agent configurations for complex tasks

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/talkcozy/everything-codex.git
cd everything-codex

# Install to your Codex configuration
cp .codex/config.toml ~/.codex/config.toml

# Copy agents
cp -r .codex/agents ~/.codex/agents

# Copy skills (if using skill directory mode)
cp -r skills ~/.codex/skills
```

### Verify Installation

```bash
# Check Codex configuration
codex config

# List available MCP servers
codex mcp list

# Test multi-agent setup
codex --agent explorer "Explore the codebase structure"
```

## Project Structure

```
everything-codex/
├── .codex/
│   ├── config.toml          # Main Codex configuration
│   └── agents/              # Agent role definitions
│       ├── explorer.toml    # Read-only codebase explorer
│       ├── reviewer.toml    # Code reviewer
│       └── architect.toml   # System architect
├── agents/                  # Detailed agent instructions
├── skills/                  # Reusable skill modules
├── rules/                   # Coding rules by language
├── docs/                    # Documentation
└── examples/                # Usage examples
```

## Configuration Highlights

### MCP Servers Pre-configured

| Server | Purpose | Command |
|--------|---------|---------|
| `github` | GitHub integration | `npx @modelcontextprotocol/server-github` |
| `context7` | Documentation lookup | `npx @upstash/context7-mcp` |
| `memory` | Persistent memory | `npx @modelcontextprotocol/server-memory` |
| `playwright` | Browser automation | `npx @playwright/mcp` |
| `sequential-thinking` | Structured reasoning | `npx @modelcontextprotocol/server-sequential-thinking` |

### Multi-Agent Roles

| Role | Description | Use Case |
|------|-------------|----------|
| `explorer` | Read-only evidence gathering | Initial codebase analysis |
| `reviewer` | Code review & security | PR reviews, audits |
| `architect` | High-level design | System design, refactoring |
| `docs` | Documentation specialist | API docs, guides |

## Usage Examples

### Basic Task

```bash
# Simple coding task
codex "Add error handling to the API endpoint"
```

### With Specific Agent

```bash
# Use explorer agent for codebase analysis
codex --agent explorer "Find all authentication-related code"

# Use reviewer agent for code review
codex --agent reviewer "Review the recent changes in src/"
```

### With Skills

```bash
# Use TDD workflow skill
codex --skill tdd "Implement user registration"

# Use security review skill
codex --skill security-review "Check for vulnerabilities in auth module"
```

## Language Support

Everything Codex provides optimized rules for:

- **TypeScript/JavaScript** — React, Next.js, Node.js patterns
- **Python** — FastAPI, Django, data science workflows
- **Go** — API design, concurrency patterns
- **Rust** — Systems programming, safety patterns
- **Java/Kotlin** — Spring Boot, Android development
- **More** — C++, C#, Swift, Dart, PHP, Perl

## Documentation

| Document | Description |
|----------|-------------|
| [AGENTS.md](AGENTS.md) | Agent configuration guide |
| [SKILLS.md](SKILLS.md) | Skill development guide |
| [RULES.md](RULES.md) | Rule authoring reference |
| [MCP.md](MCP.md) | MCP server setup |

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Acknowledgments

This project is **heavily inspired by** and built upon ideas from:

- **[ECC (Everything Claude Code)](https://github.com/affaan-m/ECC)** by [Affaan Mustafa](https://github.com/affaan-m) — The groundbreaking agent configuration system that pioneered many of the patterns used here.

The ECC project demonstrated the power of structured agent configurations, skill modules, and multi-agent workflows. Everything Codex adapts these concepts specifically for the OpenAI Codex ecosystem.

## License

MIT License — see [LICENSE](LICENSE) for details.

## Author

**talkcozy** — [GitHub](https://github.com/talkcozy)

---

<p align="center">
  <sub>Built with ❤️ for the Codex community</sub>
</p>
