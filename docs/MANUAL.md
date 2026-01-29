# 📚 Manual Completo - Multi-Perspective Skill

<p align="center">
  <img src="https://img.shields.io/badge/manual-v1.1.0-blue?style=flat-square" alt="Manual Version">
</p>

---

## 📑 Índice

1. [Introdução](#-introdução)
2. [Instalação](#-instalação)
3. [Conceitos Fundamentais](#-conceitos-fundamentais)
4. [Guia de Uso](#-guia-de-uso)
5. [Os 5 Agentes](#-os-5-agentes)
6. [Modos de Execução](#-modos-de-execução)
7. [Interpretando Resultados](#-interpretando-resultados)
8. [Configuração Avançada](#-configuração-avançada)
9. [Troubleshooting](#-troubleshooting)
10. [FAQ](#-faq)

---

## 🎯 Introdução

### O que é o Multi-Perspective Skill?

O **Multi-Perspective** é um skill para Claude Code que implementa uma abordagem de **análise ensemble** - executando 5 agentes especializados em paralelo para analisar sua requisição de diferentes perspectivas, e então sintetizando os resultados em uma solução ótima.

### Por que usar?

| Cenário | Benefício |
|---------|-----------|
| 🏗️ **Decisões arquiteturais** | Visão completa de trade-offs |
| 🔐 **Features sensíveis** | Análise de segurança integrada |
| 🚀 **Novos projetos** | Planejamento estruturado |
| 🐛 **Bugs complexos** | Múltiplas hipóteses |
| 📊 **Code review** | Qualidade + segurança + arquitetura |

### Quando NÃO usar

- ❌ Perguntas simples com resposta direta
- ❌ Tarefas triviais (rename, typo fix)
- ❌ Quando velocidade é mais importante que profundidade
- ❌ Requisições que excedem 10.000 caracteres

---

## 🔧 Instalação

### Pré-requisitos

- Claude Code CLI instalado
- Acesso aos modelos Sonnet e Opus

### Passo a Passo

```bash
# 1. Clone o repositório
git clone https://github.com/mariostjr/multi-perspective-skill.git

# 2. Navegue até o diretório
cd multi-perspective-skill

# 3. Copie para skills do Claude Code
cp -r . ~/.claude/skills/skills/multi-perspective

# 4. Verifique a instalação
ls ~/.claude/skills/skills/multi-perspective/SKILL.md
```

### Verificação

```bash
# No Claude Code, teste com:
/multi-perspective "Teste de instalação"
```

Se aparecer o progresso dos agentes, a instalação foi bem-sucedida.

---

## 🧠 Conceitos Fundamentais

### Arquitetura Ensemble

```
                    ┌─────────────────┐
                    │   Sua Pergunta  │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
        ┌──────────┐  ┌──────────┐  ┌──────────┐
        │ Agente 1 │  │ Agente 2 │  │ Agente 3 │
        │ Architect│  │ Planner  │  │ Security │
        └────┬─────┘  └────┬─────┘  └────┬─────┘
              │              │              │
              │    ┌──────────┐  ┌──────────┐
              │    │ Agente 4 │  │ Agente 5 │
              │    │ Quality  │  │ Creative │
              │    └────┬─────┘  └────┬─────┘
              │         │              │
              └─────────┼──────────────┘
                        │
                        ▼
              ┌─────────────────┐
              │   Sintetizador  │
              │     (Opus)      │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Resultado Final │
              └─────────────────┘
```

### Fluxo de Execução

| Fase | Descrição | Duração |
|:----:|-----------|:-------:|
| **0** | Validação de input | ~1s |
| **1** | Execução paralela (5 agentes) | ~15-30s |
| **2** | Verificação de quorum | ~1s |
| **3** | Síntese (Opus) | ~10-20s |
| **4** | Entrega do resultado | ~1s |

### Sistema de Quorum

O skill usa um sistema de **quorum 3/5** para garantir resultados mesmo com falhas:

| Agentes OK | Status | Ação |
|:----------:|:------:|------|
| 5/5 | 🟢 Normal | Síntese completa |
| 4/5 | 🟢 Normal | Síntese com nota |
| 3/5 | 🟡 Warning | Síntese possível |
| 2/5 | 🔴 Degraded | Resultados individuais |
| 1/5 | 🔴 Degraded | Resultados individuais |
| 0/5 | ❌ Failed | Erro - retry sugerido |

---

## 📖 Guia de Uso

### Sintaxe Básica

```bash
/multi-perspective "sua pergunta ou requisição aqui"
```

### Com Modo Específico

```bash
/multi-perspective --mode=quick "pergunta simples"
/multi-perspective --mode=balanced "análise padrão"
/multi-perspective --mode=comprehensive "decisão crítica"
```

### Boas Práticas para Prompts

#### ✅ Bom Prompt

```
/multi-perspective "Como implementar um sistema de autenticação
com JWT em uma API Node.js Express, considerando refresh tokens,
logout em todos dispositivos, e proteção contra roubo de tokens?"
```

**Por que é bom:**
- Contexto claro (Node.js, Express)
- Requisitos específicos (JWT, refresh tokens)
- Preocupações explícitas (segurança)

#### ❌ Prompt Ruim

```
/multi-perspective "como fazer auth"
```

**Por que é ruim:**
- Muito vago
- Sem contexto tecnológico
- Sem requisitos específicos

### Dicas para Melhores Resultados

1. **Seja específico** - Inclua tecnologias, frameworks, constraints
2. **Contextualize** - Mencione o tipo de aplicação, escala esperada
3. **Liste preocupações** - Segurança, performance, manutenibilidade
4. **Defina scope** - MVP vs produção, time constraints

---

## 🎭 Os 5 Agentes

### 🏛️ Architect Agent

**Foco:** System Design & Scalability

**Analisa:**
- Padrões arquiteturais (MVC, Clean Architecture, Hexagonal)
- Escalabilidade horizontal/vertical
- Integração entre componentes
- Trade-offs tecnológicos

**Output típico:**
- Diagramas de arquitetura
- Recomendações de padrões
- Estrutura de diretórios
- Análise de bottlenecks

---

### 🗺️ Planner Agent

**Foco:** Implementation Strategy

**Analisa:**
- Fases de implementação
- Dependências entre tarefas
- Riscos por fase
- Critérios de sucesso

**Output típico:**
- Roadmap de implementação
- Task breakdown
- Milestones
- Plano de rollback

---

### 🔒 Security Agent

**Foco:** Vulnerability Analysis

**Analisa:**
- OWASP Top 10
- Injection (SQL, XSS, Command)
- Authentication/Authorization
- Data exposure risks

**Output típico:**
- Vulnerabilidades por severidade
- Código seguro de exemplo
- Checklist de segurança
- Threat model

---

### ✨ Code Quality Agent

**Foco:** Best Practices & Maintainability

**Analisa:**
- SOLID principles
- DRY violations
- Code organization
- Testing strategy

**Output típico:**
- Refactoring suggestions
- Clean code examples
- Test coverage recommendations
- Anti-patterns identificados

---

### 💡 Creative Agent

**Foco:** Alternative Thinking

**Analisa:**
- Soluções não-convencionais
- Edge cases ignorados
- Alternativas de baixo custo
- Quando NÃO fazer algo

**Output típico:**
- Abordagens alternativas
- "E se...?" explorations
- Hidden assumptions
- Cost-benefit analysis

---

## ⚡ Modos de Execução

### 🟢 Quick Mode

```bash
/multi-perspective --mode=quick "sua pergunta"
```

| Propriedade | Valor |
|-------------|-------|
| Agentes | 3 (Architect, Security, Creative) |
| Timeout | 60 segundos |
| Síntese | Sonnet |
| Custo | ~$0.30 |

**Quando usar:**
- Perguntas diretas
- Decisões rápidas
- Validação de ideias

---

### 🟡 Balanced Mode (Default)

```bash
/multi-perspective "sua pergunta"
# ou
/multi-perspective --mode=balanced "sua pergunta"
```

| Propriedade | Valor |
|-------------|-------|
| Agentes | 5 (todos) |
| Timeout | 90 segundos |
| Síntese | Opus |
| Custo | ~$0.64 |

**Quando usar:**
- Análise padrão
- Maioria dos casos
- Equilíbrio custo/qualidade

---

### 🔴 Comprehensive Mode

```bash
/multi-perspective --mode=comprehensive "sua pergunta"
```

| Propriedade | Valor |
|-------------|-------|
| Agentes | 5 (todos) |
| Timeout | 120 segundos |
| Síntese | Opus (extended) |
| Custo | ~$0.80 |

**Quando usar:**
- Decisões críticas
- Arquitetura de sistema
- Features de alto risco

---

## 📊 Interpretando Resultados

### Estrutura do Output

```markdown
## Multi-Perspective Analysis Result

**Confidence:** HIGH/MEDIUM/LOW

### Summary
[Visão geral da análise]

### Final Recommendation
[Ações priorizadas]

### Key Insights by Perspective
[Insights de cada agente]

### Dissenting Opinions
[Opiniões minoritárias]
```

### Níveis de Confiança

| Nível | Significado | Ação Sugerida |
|:-----:|-------------|---------------|
| 🟢 **HIGH** | 4-5 agentes concordam | Pode implementar |
| 🟡 **MEDIUM** | 3 agentes concordam | Revisar trade-offs |
| 🔴 **LOW** | Divergência significativa | Investigar mais |

### Lendo os Insights

**Exemplo de insight:**

```markdown
- **🏛️ Architect:** Use Cache-Aside pattern com Redis como L2
```

Cada insight representa o **ponto principal** daquele agente. Para detalhes completos, veja a seção "Dissenting Opinions" ou solicite um drill-down.

### Valorizando Dissenting Opinions

Opiniões minoritárias são valiosas! Elas representam:

- Edge cases que a maioria ignorou
- Trade-offs que merecem consideração
- Alternativas para contextos específicos

**Exemplo:**
> 💡 **Creative dissent:** Considere HTTP Cache Headers antes de Redis - custo zero e resolve 60% dos casos.

---

## ⚙️ Configuração Avançada

### Arquivo de Configuração

**Localização:** `~/.claude/skills/skills/multi-perspective/config/settings.yaml`

### Opções Configuráveis

```yaml
# Timeouts
execution:
  timeout_seconds: 90      # Ajuste para conexões lentas
  quorum_minimum: 3        # Mínimo para síntese (2-5)
  max_agents: 5

# Rate limiting
rate_limiting:
  enabled: true
  max_per_hour: 10         # Previne uso excessivo

# Segurança de input
security:
  max_input_length: 10000  # Caracteres máximos
  sanitize_input: true
  reject_injection_patterns:
    - "ignore.*instructions"
    - "you are now"

# Modelos
models:
  agents: "sonnet"         # ou "haiku" para economia
  synthesis: "opus"        # ou "sonnet" para economia
```

### Customizando Templates

Os templates de cada agente podem ser editados em:

```
templates/agent-prompts/
├── architect.md
├── planner.md
├── security.md
├── code-quality.md
└── creative.md
```

**Exemplo de customização:**

```markdown
# architect.md customizado para seu domínio

Analyze from SYSTEM ARCHITECTURE perspective:

## Request
{{USER_REQUEST}}

## Additional Context
- We use AWS exclusively
- Microservices architecture
- Event-driven patterns preferred

## Your Analysis Must Include:
[...]
```

---

## 🔧 Troubleshooting

### Problema: Timeout em Agentes

**Sintoma:** Um ou mais agentes marcados como TIMEOUT

**Soluções:**
1. Aumente o timeout em `settings.yaml`
2. Use `--mode=quick` para prompts simples
3. Reduza o tamanho do prompt

---

### Problema: Quorum Não Atingido

**Sintoma:** Degraded Mode ativado

**Soluções:**
1. Verifique conexão com API
2. Reduza `quorum_minimum` para 2
3. Retry a requisição

---

### Problema: Resultados Genéricos

**Sintoma:** Análise superficial

**Soluções:**
1. Seja mais específico no prompt
2. Use `--mode=comprehensive`
3. Inclua contexto técnico

---

### Problema: Erro de Injection Pattern

**Sintoma:** Input rejeitado com warning

**Soluções:**
1. Remova frases como "ignore previous instructions"
2. Reformule o prompt
3. Desabilite temporariamente em `settings.yaml`

---

## ❓ FAQ

### Q: Quanto custa cada execução?

**A:** Aproximadamente $0.64 no modo balanced. Veja a seção de custos no README.

---

### Q: Posso usar em qualquer idioma?

**A:** Sim! Os agentes respondem no idioma do prompt. Funciona bem em português, inglês, espanhol, etc.

---

### Q: Os resultados são determinísticos?

**A:** Não. Como usa LLMs, há variação entre execuções. Para decisões críticas, execute 2-3 vezes e compare.

---

### Q: Posso adicionar mais agentes?

**A:** Sim, mas requer modificação do SKILL.md. Adicione um novo template em `templates/agent-prompts/` e atualize o workflow.

---

### Q: Funciona offline?

**A:** Não. Requer conexão com a API da Anthropic.

---

### Q: Posso desabilitar um agente específico?

**A:** Use `--mode=quick` para 3 agentes, ou edite `settings.yaml` para criar um modo customizado.

---

## 📞 Suporte

- **Issues:** [GitHub Issues](https://github.com/mariostjr/multi-perspective-skill/issues)
- **Discussions:** [GitHub Discussions](https://github.com/mariostjr/multi-perspective-skill/discussions)

---

<p align="center">
  <strong>Happy analyzing! 🎯</strong>
</p>
