<p align="center">
  <img src="https://img.shields.io/badge/versão-1.1.0-blue?style=for-the-badge" alt="Versão">
  <img src="https://img.shields.io/badge/licença-MIT-green?style=for-the-badge" alt="Licença">
  <img src="https://img.shields.io/badge/claude-code-purple?style=for-the-badge" alt="Claude Code">
  <img src="https://img.shields.io/badge/agentes-5-orange?style=for-the-badge" alt="Agentes">
</p>

<h1 align="center">🎯 Multi-Perspective Analysis</h1>

<p align="center">
  <strong>Execute uma análise com 5 agentes especializados em paralelo e sintetize em uma solução ótima</strong>
</p>

<p align="center">
  <a href="#-funcionalidades">Funcionalidades</a> •
  <a href="#-início-rápido">Início Rápido</a> •
  <a href="#-como-funciona">Como Funciona</a> •
  <a href="#-uso">Uso</a> •
  <a href="#-exemplos">Exemplos</a> •
  <a href="#-configuração">Configuração</a>
</p>

<p align="center">
  <a href="README.md">🇧🇷 Português</a> | <a href="README_EN.md">🇺🇸 English</a>
</p>

---

## 🌟 Funcionalidades

| Funcionalidade | Descrição |
|----------------|-----------|
| 🚀 **Execução Paralela** | 5 agentes executam simultaneamente para máxima velocidade |
| 🧠 **5 Perspectivas** | Architect, Planner, Security, Code Quality, Creative |
| 🔄 **Síntese Inteligente** | Agente revisor (Opus) combina insights em solução ótima |
| 🛡️ **Tolerante a Falhas** | Quorum 3/5 - continua mesmo se agentes falharem |
| 📊 **Acompanhamento em Tempo Real** | Feedback visual do progresso |
| ⚡ **3 Modos** | Quick (3 agentes), Balanced (5), Comprehensive (5+tempo) |

---

## 🚀 Início Rápido

### Instalação

```bash
# Clone o repositório
git clone https://github.com/pir0c0pter0/multi-perspective-skill.git

# Copie para o diretório de skills do Claude Code
cp -r multi-perspective-skill ~/.claude/skills/skills/multi-perspective
```

### Uso Básico

```bash
# No Claude Code, simplesmente use:
/multi-perspective "Como implementar autenticação JWT em Node.js?"
```

---

## 🔄 Como Funciona

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      FLUXO DO MULTI-PERSPECTIVE                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│   📝 Requisição do Usuário                                              │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────┐                                                       │
│   │  Validar    │ ─── Input > 10k chars? ──▶ ❌ Rejeitar               │
│   │   Input     │ ─── Padrão de injeção? ──▶ ⚠️  Sanitizar             │
│   └─────────────┘                                                       │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────────────────────────────────────────────────┐           │
│   │            EXECUÇÃO PARALELA (5 Agentes)                │           │
│   ├─────────────────────────────────────────────────────────┤           │
│   │                                                         │           │
│   │  🏛️ Architect    🗺️ Planner    🔒 Security              │           │
│   │     (sonnet)       (sonnet)      (sonnet)               │           │
│   │                                                         │           │
│   │  ✨ Code Quality  💡 Creative                           │           │
│   │     (sonnet)        (sonnet)                            │           │
│   │                                                         │           │
│   └─────────────────────────────────────────────────────────┘           │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────┐                                                       │
│   │  Verificar  │ ─── < 3 agentes? ──▶ 📋 Modo Degradado               │
│   │   Quorum    │                                                       │
│   └─────────────┘                                                       │
│         │                                                               │
│         ▼                                                               │
│   ┌─────────────────────────────────────────────────────────┐           │
│   │               SÍNTESE (Modelo Opus)                     │           │
│   ├─────────────────────────────────────────────────────────┤           │
│   │  • Pontos de Consenso    • Resolução de Conflitos       │           │
│   │  • Recomendação Final    • Nível de Confiança           │           │
│   │  • Opiniões Divergentes                                 │           │
│   └─────────────────────────────────────────────────────────┘           │
│         │                                                               │
│         ▼                                                               │
│   📊 Resultado Final                                                    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 📖 Uso

### Sintaxe

```bash
/multi-perspective [--mode=MODE] "sua pergunta ou requisição"
```

### Modos de Execução

| Modo | Agentes | Timeout | Síntese | Caso de Uso |
|:----:|:-------:|:-------:|:-------:|:------------|
| 🟢 `quick` | 3 | 60s | Sonnet | Perguntas simples, respostas rápidas |
| 🟡 `balanced` | 5 | 90s | Opus | **Padrão** - Análise completa |
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

## 🎭 Os 5 Agentes

<table>
<tr>
<td width="20%" align="center">

### 🏛️ Architect

**Design de Sistema**

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

**Estratégia de Implementação**

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

**Análise de Vulnerabilidades**

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

**Boas Práticas**

</td>
<td>

- Princípios SOLID
- Padrões de Clean Code
- Estratégias de testes
- Manutenibilidade

</td>
</tr>
<tr>
<td width="20%" align="center">

### 💡 Creative

**Pensamento Alternativo**

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

## 📊 Formato de Saída

```markdown
## Resultado da Análise Multi-Perspective

**Confiança:** 🟢 ALTA | 🟡 MÉDIA | 🔴 BAIXA

### Resumo
[Visão geral de 1-2 parágrafos]

### Recomendação Final
[Lista priorizada de ações]

### Insights Principais por Perspectiva
- **🏛️ Architect:** [insight principal]
- **🗺️ Planner:** [insight principal]
- **🔒 Security:** [insight principal]
- **✨ Code Quality:** [insight principal]
- **💡 Creative:** [insight principal]

### Opiniões Divergentes
[Opiniões minoritárias valiosas]

---
*Análise realizada com 5 agentes especializados em paralelo.*
```

---

## ⚙️ Configuração

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

## 🛡️ Tratamento de Erros

| Cenário | Ação | Resultado |
|:--------|:-----|:----------|
| ⚠️ Input > 10k caracteres | Rejeitar | Mensagem de erro |
| ⚠️ Injeção detectada | Sanitizar | Aviso + continuar |
| ❌ 1 agente falha | Continuar | Nota na síntese |
| ❌ 2 agentes falham | Continuar | Aviso exibido |
| ❌ 3+ agentes falham | Degradado | Resultados individuais |
| ❌ Síntese falha | Fallback | Resultados individuais |
| ⏱️ Timeout (90s) | Marcar como falha | Continuar com os outros |

---

## 📁 Estrutura do Projeto

```
multi-perspective/
├── 📄 SKILL.md                    # Definição principal do skill
├── 📄 LICENSE                     # Licença MIT
├── 📄 README.md                   # Documentação em Português
├── 📄 README_EN.md                # Documentação em Inglês
│
├── 📁 config/
│   └── settings.yaml              # Configurações
│
├── 📁 templates/
│   ├── 📁 agent-prompts/
│   │   ├── architect.md           # 🏛️ Prompt do Architect
│   │   ├── planner.md             # 🗺️ Prompt do Planner
│   │   ├── security.md            # 🔒 Prompt do Security
│   │   ├── code-quality.md        # ✨ Prompt do Code Quality
│   │   └── creative.md            # 💡 Prompt do Creative
│   └── synthesis-prompt.md        # Template de síntese
│
├── 📁 docs/
│   ├── MANUAL.md                  # Manual detalhado
│   ├── EXAMPLES.md                # Exemplos de uso
│   └── example-execution.md       # Trace completo de execução
│
└── 📁 scripts/
    └── validate.sh                # Validador de estrutura
```

---

## 📈 Estimativa de Custos

| Operação | Tokens | Modelo | Custo (USD) |
|:---------|:------:|:------:|:-----------:|
| 5 Agentes (input) | ~10.000 | Sonnet | $0,03 |
| 5 Agentes (output) | ~10.000 | Sonnet | $0,15 |
| Síntese (input) | ~15.000 | Opus | $0,23 |
| Síntese (output) | ~3.000 | Opus | $0,23 |
| **Total por execução** | | | **~$0,64** |

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para enviar um Pull Request.

1. Faça um fork do repositório
2. Crie sua branch de feature (`git checkout -b feature/feature-incrivel`)
3. Commit suas mudanças (`git commit -m 'feat: adiciona feature incrível'`)
4. Push para a branch (`git push origin feature/feature-incrivel`)
5. Abra um Pull Request

---

## 📜 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

## 🙏 Agradecimentos

- Construído para o CLI [Claude Code](https://claude.ai/claude-code)
- Powered by Claude Sonnet 4.5 e Opus 4.5
- Inspirado em ensemble learning e sistemas multi-agentes

---

<p align="center">
  Feito com ❤️ por <a href="https://github.com/pir0c0pter0">Mario St Jr</a> (pir0c0pter0000@gmail.com)
</p>

<p align="center">
  <a href="https://github.com/pir0c0pter0/multi-perspective-skill/issues">Reportar Bug</a> •
  <a href="https://github.com/pir0c0pter0/multi-perspective-skill/issues">Solicitar Feature</a>
</p>
