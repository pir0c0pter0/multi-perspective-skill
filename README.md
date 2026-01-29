<p align="center">
  <img src="https://img.shields.io/badge/version-1.1.0-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License">
  <img src="https://img.shields.io/badge/claude-code-purple?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/agents-5-orange?style=for-the-badge" alt="Agents">
</p>

<h1 align="center">🎯 Multi-Perspective Analysis</h1>

<p align="center">
  <strong>Execute uma análise com 5 agentes especializados em paralelo e sintetize em uma solução ótima</strong>
</p>

<p align="center">
  <a href="#-features">Features</a> •
  <a href="#-quick-start">Quick Start</a> •
  <a href="#-how-it-works">How It Works</a> •
  <a href="#-usage">Usage</a> •
  <a href="#-examples">Examples</a> •
  <a href="#-configuration">Configuration</a>
</p>

---

## 🌟 Features

| Feature | Description |
|---------|-------------|
| 🚀 **Parallel Execution** | 5 agentes executam simultaneamente para máxima velocidade |
| 🧠 **5 Perspectives** | Architect, Planner, Security, Code Quality, Creative |
| 🔄 **Smart Synthesis** | Agente revisor (Opus) combina insights em solução ótima |
| 🛡️ **Fault Tolerant** | Quorum 3/5 - continua mesmo se agentes falharem |
| 📊 **Progress Tracking** | Feedback visual em tempo real |
| ⚡ **3 Modes** | Quick (3 agentes), Balanced (5), Comprehensive (5+tempo) |

---

## 🚀 Quick Start

### Instalação

```bash
# Clone o repositório
git clone https://github.com/mariostjr/multi-perspective-skill.git

# Copie para o diretório de skills do Claude Code
cp -r multi-perspective-skill ~/.claude/skills/skills/multi-perspective
```

### Uso Básico

```bash
# No Claude Code, simplesmente use:
/multi-perspective "Como implementar autenticação JWT em Node.js?"
```

---

## 🔄 How It Works

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         MULTI-PERSPECTIVE FLOW                          │
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
│   │              PARALLEL EXECUTION (5 Agents)               │          │
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
│   │   Quorum    │ ─── < 3 agents? ──▶ 📋 Degraded Mode                 │
│   │   Check     │                                                       │
│   └─────────────┘                                                       │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────────────────────────────────────────────────┐          │
│   │              SYNTHESIS (Opus Model)                      │          │
│   ├─────────────────────────────────────────────────────────┤          │
│   │  • Consensus Points     • Conflict Resolution           │          │
│   │  • Final Recommendation • Confidence Level              │          │
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

### Sintaxe

```bash
/multi-perspective [--mode=MODE] "sua pergunta ou requisição"
```

### Modos de Execução

| Mode | Agents | Timeout | Synthesis | Use Case |
|:----:|:------:|:-------:|:---------:|:---------|
| 🟢 `quick` | 3 | 60s | Sonnet | Perguntas simples, respostas rápidas |
| 🟡 `balanced` | 5 | 90s | Opus | **Default** - Análise completa |
| 🔴 `comprehensive` | 5 | 120s | Opus | Decisões críticas, análise profunda |

### Exemplos de Comando

```bash
# Modo padrão (balanced)
/multi-perspective "Como estruturar um monorepo com Turborepo?"

# Modo rápido
/multi-perspective --mode=quick "Qual ORM usar para PostgreSQL?"

# Modo completo
/multi-perspective --mode=comprehensive "Arquitetura para sistema de pagamentos"
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

- Arquitetura e escalabilidade
- Padrões de design (CQRS, Event Sourcing, etc.)
- Trade-offs tecnológicos
- Diagramas de componentes

</td>
</tr>
<tr>
<td width="20%" align="center">

### 🗺️ Planner

**Implementation Strategy**

</td>
<td>

- Fases de implementação
- Breakdown de tarefas
- Cronograma e dependências
- Riscos e mitigações

</td>
</tr>
<tr>
<td width="20%" align="center">

### 🔒 Security

**Vulnerability Analysis**

</td>
<td>

- OWASP Top 10
- Vulnerabilidades específicas
- Padrões seguros de código
- Checklist de segurança

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
- Manutenibilidade

</td>
</tr>
<tr>
<td width="20%" align="center">

### 💡 Creative

**Alternative Thinking**

</td>
<td>

- Soluções não-convencionais
- Edge cases ignorados
- Quando NÃO fazer algo
- Alternativas de baixo custo

</td>
</tr>
</table>

---

## 📊 Output Format

```markdown
## Multi-Perspective Analysis Result

**Confidence:** 🟢 HIGH | 🟡 MEDIUM | 🔴 LOW

### Summary
[Overview de 1-2 parágrafos]

### Final Recommendation
[Lista priorizada de ações]

### Key Insights by Perspective
- **🏛️ Architect:** [insight principal]
- **🗺️ Planner:** [insight principal]
- **🔒 Security:** [insight principal]
- **✨ Code Quality:** [insight principal]
- **💡 Creative:** [insight principal]

### Dissenting Opinions
[Opiniões minoritárias valiosas]

---
*Análise realizada com 5 agentes especializados em paralelo.*
```

---

## ⚙️ Configuration

### Arquivo: `config/settings.yaml`

```yaml
execution:
  timeout_seconds: 90      # Timeout por agente
  quorum_minimum: 3        # Mínimo de agentes para síntese
  max_agents: 5

rate_limiting:
  enabled: true
  max_per_hour: 10         # Limite de execuções/hora

security:
  max_input_length: 10000  # Caracteres máximos
  sanitize_input: true
  reject_injection_patterns:
    - "ignore.*instructions"
    - "you are now"
    - "system:"

models:
  agents: "sonnet"         # Modelo dos 5 agentes
  synthesis: "opus"        # Modelo do sintetizador
```

---

## 🛡️ Error Handling

| Scenario | Action | Result |
|:---------|:-------|:-------|
| ⚠️ Input > 10k chars | Reject | Error message |
| ⚠️ Injection detected | Sanitize | Warning + proceed |
| ❌ 1 agent fails | Continue | Note in synthesis |
| ❌ 2 agents fail | Continue | Warning shown |
| ❌ 3+ agents fail | Degraded | Individual results |
| ❌ Synthesis fails | Fallback | Individual results |
| ⏱️ Timeout (90s) | Mark failed | Continue with others |

---

## 📁 Project Structure

```
multi-perspective/
├── 📄 SKILL.md                    # Main skill definition
├── 📄 LICENSE                     # MIT License
├── 📄 README.md                   # This file
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
|:----------|:------:|:-----:|:----------:|
| 5 Agents (input) | ~10,000 | Sonnet | $0.03 |
| 5 Agents (output) | ~10,000 | Sonnet | $0.15 |
| Synthesis (input) | ~15,000 | Opus | $0.23 |
| Synthesis (output) | ~3,000 | Opus | $0.23 |
| **Total per execution** | | | **~$0.64** |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
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
  Made with ❤️ by <a href="https://github.com/mariostjr">Mario St Jr</a>
</p>

<p align="center">
  <a href="https://github.com/mariostjr/multi-perspective-skill/issues">Report Bug</a> •
  <a href="https://github.com/mariostjr/multi-perspective-skill/issues">Request Feature</a>
</p>
