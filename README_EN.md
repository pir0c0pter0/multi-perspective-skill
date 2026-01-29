<p align="center">
  <img src="https://img.shields.io/badge/version-1.1.0-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/claude-code-purple?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/agents-5-orange?style=for-the-badge" alt="Agents">
</p>

<h1 align="center">🎯 Multi-Perspective Analysis</h1>

<p align="center">
  <strong>Run an analysis with 5 specialized agents in parallel and synthesize into an optimal solution</strong>
</p>

<p align="center">
  <a href="#-features">Features</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-how-it-works">How It Works</a> •
  <a href="#-usage">Usage</a> •
  <a href="#-examples">Examples</a> •
  <a href="#-configuration">Configuration</a>
</p>

<p align="center">
  <a href="README.md">🇧🇷 Português</a> | <a href="README_EN.md">🇺🇸 English</a>
</p>

---

## 🌟 Features

| Feature | Description |
|---------|-------------|
| 🚀 **Parallel Execution** | 5 agents run simultaneously for maximum speed |
| 🧠 **5 Perspectives** | Architect, Planner, Security, Code Quality, Creative |
| 🔄 **Smart Synthesis** | Reviewer agent (Opus) combines insights into optimal solution |
| 🛡️ **Fault Tolerant** | Quorum 3/5 - continues even if agents fail |
| 📊 **Real-time Tracking** | Visual progress feedback |
| ⚡ **3 Modes** | Quick (3 agents), Balanced (5), Comprehensive (5+time) |

---

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/pir0c0pter0/multi-perspective-skill.git

# Copy to Claude Code skills directory
cp -r multi-perspective-skill ~/.claude/skills/skills/multi-perspective
```

### Basic Usage

```bash
# In Claude Code, simply use:
/multi-perspective "How to implement JWT authentication in Node.js?"
```

---

## 🔄 How It Works

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      MULTI-PERSPECTIVE FLOW                             │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   📝 User Request                                                       │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────┐                                                       │
│   │  Validate   │ ─── Input > 10k chars? ──▶ ❌ Reject                  │
│   │   Input     │ ─── Injection pattern? ──▶ ⚠️  Sanitize               │
│   └─────────────┘                                                       │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────────────────────────────────────────────────┐          │
│   │            PARALLEL EXECUTION (5 Agents)                 │          │
│   ├─────────────────────────────────────────────────────────┤          │
│   │                                                         │          │
│   │  🏛️ Architect    🗺️ Planner    🔒 Security              │          │
│   │     (sonnet)       (sonnet)      (sonnet)               │          │
│   │                                                         │          │
│   │  ✨ Code Quality  💡 Creative                            │          │
│   │     (sonnet)        (sonnet)                            │          │
│   │                                                         │          │
│   └─────────────────────────────────────────────────────────┘          │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────┐                                                       │
│   │   Verify    │ ─── < 3 agents? ──▶ 📋 Degraded Mode                 │
│   │   Quorum    │                                                       │
│   └─────────────┘                                                       │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────────────────────────────────────────────────┐          │
│   │               SYNTHESIS (Opus Model)                     │          │
│   ├─────────────────────────────────────────────────────────┤          │
│   │  • Consensus Points      • Conflict Resolution          │          │
│   │  • Final Recommendation  • Confidence Level             │          │
│   │  • Dissenting Opinions                                  │          │
│   └─────────────────────────────────────────────────────────┘          │
│         │                                                               │
│         ▼                                                               │
│   📊 Final Result                                                       │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 📖 Usage

### Syntax

```bash
/multi-perspective [--mode=MODE] "your question or request"
```

### Execution Modes

| Mode | Agents | Timeout | Synthesis | Use Case |
|:----:|:------:|:-------:|:---------:|:---------|
| 🟢 `quick` | 3 | 60s | Sonnet | Simple questions, quick answers |
| 🟡 `balanced` | 5 | 90s | Opus | **Default** - Complete analysis |
| 🔴 `comprehensive` | 5 | 120s | Opus | Critical decisions, deep analysis |

### Command Examples

```bash
# Default mode (balanced)
/multi-perspective "How to structure a monorepo with Turborepo?"

# Quick mode
/multi-perspective --mode=quick "Which ORM to use for PostgreSQL?"

# Comprehensive mode
/multi-perspective --mode=comprehensive "Architecture for payment system"
```

---

## 🎭 The 5 Agents

<table>
<tr>
<td width="20%" align="center">

### 🏛️ Architect

**System Design**

</td>
<td>

- Architecture and scalability
- Design patterns (CQRS, Event Sourcing, etc.)
- Technology trade-offs
- Component diagrams

</td>
</tr>
<tr>
<td width="20%" align="center">

### 🗺️ Planner

**Implementation Strategy**

</td>
<td>

- Implementation phases
- Task breakdown
- Timeline and dependencies
- Risks and mitigations

</td>
</tr>
<tr>
<td width="20%" align="center">

### 🔒 Security

**Vulnerability Analysis**

</td>
<td>

- OWASP Top 10
- Specific vulnerabilities
- Secure code patterns
- Security checklist

</td>
</tr>
<tr>
<td width="20%" align="center">

### ✨ Code Quality

**Best Practices**

</td>
<td>

- SOLID principles
- Clean Code patterns
- Testing strategies
- Maintainability

</td>
</tr>
<tr>
<td width="20%" align="center">

### 💡 Creative

**Alternative Thinking**

</td>
<td>

- Unconventional solutions
- Overlooked edge cases
- When NOT to do something
- Low-cost alternatives

</td>
</tr>
</table>

---

## 📊 Output Format

```markdown
## Multi-Perspective Analysis Result

**Confidence:** 🟢 HIGH | 🟡 MEDIUM | 🔴 LOW

### Summary
[1-2 paragraph overview]

### Final Recommendation
[Prioritized action list]

### Key Insights by Perspective
- **🏛️ Architect:** [main insight]
- **🗺️ Planner:** [main insight]
- **🔒 Security:** [main insight]
- **✨ Code Quality:** [main insight]
- **💡 Creative:** [main insight]

### Dissenting Opinions
[Valuable minority opinions]

---
*Analysis performed with 5 specialized agents in parallel.*
```

---

## ⚙️ Configuration

### File: `config/settings.yaml`

```yaml
execution:
  timeout_seconds: 90      # Timeout per agent
  quorum_minimum: 3        # Minimum agents for synthesis
  max_agents: 5

rate_limiting:
  enabled: true
  max_per_hour: 10         # Executions limit per hour

security:
  max_input_length: 10000  # Maximum characters
  sanitize_input: true
  reject_injection_patterns:
    - "ignore.*instructions"
    - "you are now"
    - "system:"

models:
  agents: "sonnet"         # Model for the 5 agents
  synthesis: "opus"        # Model for the synthesizer
```

---

## 🛡️ Error Handling

| Scenario | Action | Result |
|:---------|:-------|:-------|
| ⚠️ Input > 10k characters | Reject | Error message |
| ⚠️ Injection detected | Sanitize | Warning + continue |
| ❌ 1 agent fails | Continue | Note in synthesis |
| ❌ 2 agents fail | Continue | Warning displayed |
| ❌ 3+ agents fail | Degraded | Individual results |
| ❌ Synthesis fails | Fallback | Individual results |
| ⏱️ Timeout (90s) | Mark as failed | Continue with others |

---

## 📁 Project Structure

```
multi-perspective/
├── 📄 SKILL.md                    # Main skill definition
├── 📄 LICENSE                     # MIT License
├── 📄 README.md                   # Portuguese documentation
├── 📄 README_EN.md                # English documentation (this file)
│
├── 📁 config/
│   └── settings.yaml              # Configuration
│
├── 📁 templates/
│   ├── 📁 agent-prompts/
│   │   ├── architect.md           # 🏛️ Architect prompt
│   │   ├── planner.md             # 🗺️ Planner prompt
│   │   ├── security.md            # 🔒 Security prompt
│   │   ├── code-quality.md        # ✨ Code Quality prompt
│   │   └── creative.md            # 💡 Creative prompt
│   └── synthesis-prompt.md        # Synthesis template
│
├── 📁 docs/
│   ├── MANUAL.md                  # Detailed manual
│   ├── EXAMPLES.md                # Usage examples
│   └── example-execution.md       # Full execution trace
│
└── 📁 scripts/
    └── validate.sh                # Structure validator
```

---

## 📈 Cost Estimation

| Operation | Tokens | Model | Cost (USD) |
|:----------|:------:|:-----:|:-----------:|
| 5 Agents (input) | ~10,000 | Sonnet | $0.03 |
| 5 Agents (output) | ~10,000 | Sonnet | $0.15 |
| Synthesis (input) | ~15,000 | Opus | $0.23 |
| Synthesis (output) | ~3,000 | Opus | $0.23 |
| **Total per execution** | | | **~$0.64** |

---

## 🤝 Contributing

Contributions are welcome! Feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Built for [Claude Code](https://claude.ai/claude-code) CLI
- Powered by Claude Sonnet 4.5 and Opus 4.5
- Inspired by ensemble learning and multi-agent systems

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/pir0c0pter0">Mario St Jr</a>
</p>

<p align="center">
  <a href="https://github.com/pir0c0pter0/multi-perspective-skill/issues">Report Bug</a> •
  <a href="https://github.com/pir0c0pter0/multi-perspective-skill/issues">Request Feature</a>
</p>
