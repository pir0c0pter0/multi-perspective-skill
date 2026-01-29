# Multi-Perspective Skill - Exemplo de Execução

## Visão Geral

Este documento descreve a execução completa do skill `/multi-perspective`, que analisa um pedido usando 5 agentes especializados em paralelo e depois sintetiza os resultados em uma solução ótima.

---

## Prompt Original

```
Como implementar um sistema de cache em uma API REST Node.js?
```

---

## Fase 1: Execução Paralela (5 Agentes)

Todos os 5 agentes foram lançados simultaneamente com prompts customizados para suas perspectivas.

### Agente 1: Architect (System Design)

**Subagent Type:** `architect`

**Prompt Enviado:**
```
Analyze from SYSTEM ARCHITECTURE perspective:

REQUEST: Como implementar um sistema de cache em uma API REST Node.js?

Provide:
1. Analysis and architectural findings
2. Prioritized recommendations (cache layers, patterns, technologies)
3. Implementation suggestions with architecture diagrams or code structure
4. Architectural risks and scalability concerns

Focus on: cache invalidation strategies, distributed vs in-memory cache,
cache-aside vs write-through patterns, Redis vs Memcached vs in-process
cache decisions.

Be thorough but concise. Respond in Portuguese.
```

**Resultado Principal:**
- Recomendou arquitetura multi-camadas: L1 (in-memory LRU-cache) + L2 (Redis) + CDN
- Padrão Cache-Aside para 95% dos casos
- Redis como backbone com Pub/Sub para invalidação distribuída
- TTLs diferenciados por tipo de dado:
  - Static: 24h (configs, categorias)
  - Quasi-static: 1h (produtos, posts)
  - Dynamic: 5min (usuários, estoque)
  - Real-time: 1min (preços)
- Estrutura modular proposta: `cache.service.ts`, `cache-invalidation.service.ts`, `cache-tags.service.ts`
- Métricas alvo: Hit Rate > 80%, Latency P95 < 10ms
- Diagrama de arquitetura completo com fluxo de invalidação via Pub/Sub

---

### Agente 2: Planner (Implementation Strategy)

**Subagent Type:** `planner`

**Prompt Enviado:**
```
Analyze from IMPLEMENTATION PLANNING perspective:

REQUEST: Como implementar um sistema de cache em uma API REST Node.js?

Provide:
1. Analysis of implementation phases
2. Prioritized recommendations (step-by-step approach)
3. Implementation plan with concrete tasks and dependencies
4. Risks and mitigation strategies for each phase

Focus on: phased rollout, testing strategy, migration plan, monitoring
setup, rollback procedures.

Be thorough but concise. Respond in Portuguese.
```

**Resultado Principal:**
- Plano de 6 fases:
  - **Fase 1:** Infraestrutura Base (Redis + módulo de cache)
  - **Fase 2:** Middleware de cache tRPC
  - **Fase 3:** Aplicar cache em routers (clients, invoices, systemSettings)
  - **Fase 4:** Cache em camada de dados (opcional)
  - **Fase 5:** Monitoramento e observabilidade
  - **Fase 6:** Testes e validação
- Riscos identificados:
  - Cache stale (dados desatualizados)
  - Redis SPOF (single point of failure)
  - Invalidação incompleta
- Plano de rollback: flag `enabled = false` para desabilitar instantaneamente
- Critérios de sucesso definidos
- Ordem de implementação por sprints

---

### Agente 3: Security Expert

**Subagent Type:** `security-reviewer`

**Prompt Enviado:**
```
Analyze from SECURITY perspective:

REQUEST: Como implementar um sistema de cache em uma API REST Node.js?

Provide:
1. Security analysis and potential vulnerabilities
2. Prioritized security recommendations
3. Secure implementation patterns with code examples
4. Security risks (cache poisoning, data leakage, timing attacks, etc.)

Focus on: OWASP guidelines, cache poisoning prevention, sensitive data
handling, access control, encryption at rest/transit, cache key security.

Be thorough but concise. Respond in Portuguese.
```

**Resultado Principal:**
- Vulnerabilidades críticas identificadas:
  - **Cache Poisoning:** Atacante injeta dados maliciosos
  - **Data Leakage:** Cache keys inadequadas expõem dados entre usuários
  - **Sensitive Data Exposure:** PII armazenado sem criptografia
  - **Timing Attacks:** Tempo de resposta revela informações
  - **DoS via Cache Exhaustion:** Atacante preenche cache com lixo
- Recomendações de segurança:
  - Hash de cache keys com SHA-256
  - SEMPRE incluir user ID na cache key (isolamento)
  - Criptografia AES-256-GCM para dados sensíveis
  - NUNCA cachear senhas, tokens, PII
  - Redis com TLS + AUTH obrigatório em produção
  - Rate limiting em todos os endpoints
- Código seguro de exemplo para:
  - Configuração segura do Redis
  - Geração de cache keys seguras
  - Criptografia de dados em cache
  - Middleware com isolamento de usuário

---

### Agente 4: Code Quality Expert

**Subagent Type:** `code-reviewer`

**Prompt Enviado:**
```
Analyze from CODE QUALITY perspective:

REQUEST: Como implementar um sistema de cache em uma API REST Node.js?

Provide:
1. Code quality analysis and best practices
2. Prioritized recommendations (patterns, abstractions, testing)
3. Clean code implementation examples
4. Code maintainability risks and anti-patterns to avoid

Focus on: DRY principles, dependency injection for cache layer, interface
segregation, unit testing cache logic, error handling, logging patterns.

Be thorough but concise. Respond in Portuguese.
```

**Resultado Principal:**
- Princípios aplicados:
  - **DRY:** Centralizar lógica de cache em módulo reutilizável
  - **SOLID:** Interface abstrata, dependency injection, providers substituíveis
- Anti-patterns a evitar:
  - Mutação de estado global
  - Cache sem TTL
  - Serialização insegura
  - Cache stampede (thundering herd)
- Padrões implementados:
  - Interface abstrata `CacheProvider`
  - Providers: `RedisCacheProvider`, `MemoryCacheProvider`
  - `CacheManager` com Circuit Breaker
  - Graceful degradation (cache nunca quebra API)
- Testes unitários com 80%+ coverage
- Métricas expostas: hits, misses, errors, avgLatency
- Middleware de cache para Express com interceptação de resposta

---

### Agente 5: General/Creative Expert

**Subagent Type:** `general-purpose`

**Prompt Enviado:**
```
Analyze from GENERAL/CREATIVE perspective:

REQUEST: Como implementar um sistema de cache em uma API REST Node.js?

Provide:
1. Broad analysis including edge cases and creative solutions
2. Alternative approaches and unconventional recommendations
3. Implementation ideas that others might miss
4. Potential risks and unexpected scenarios

Focus on: edge cases (cache stampede, thundering herd), alternative
solutions (CDN caching, HTTP caching headers, stale-while-revalidate),
cost considerations, when NOT to cache.

Be thorough but concise. Respond in Portuguese.
```

**Resultado Principal:**
- Edge cases críticos:
  - **Cache Stampede:** Lock-based caching para primeira requisição
  - **Thundering Herd:** Jittered TTL (randomização do tempo de expiração)
  - **Hot Keys:** Uma chave recebe 90% das requisições
- Soluções alternativas (custo-benefício):
  - **HTTP Cache Headers** (Cache-Control, ETag) - custo ZERO
  - **CDN caching** (Cloudflare, CloudFront) - cache global distribuído
  - **Service Worker Cache** - funciona offline em PWAs
  - **Stale-While-Revalidate** - retorna stale imediatamente, revalida em background
- Ideias criativas:
  - **Cache Negativo:** Cachear "não encontrado" para prevenir ataques
  - **Adaptive TTL:** TTL dinâmico baseado em padrões de acesso
  - **Cache Compression:** Reduzir uso de memória em 60-80%
- Quando NÃO cachear:
  - Dados altamente voláteis (preços em tempo real)
  - Dados sensíveis sem encriptação
  - Queries raramente repetidas
  - Dados pequenos e baratos de computar
- **Regra de ouro:** "Se você não está medindo, não otimize"

---

## Fase 2: Síntese Final

### Agente Sintetizador

**Subagent Type:** `general-purpose` (modelo: `opus`)

**Prompt Enviado:**
```
Você é o SYNTHESIS REVIEWER. Analise estas 5 perspectivas de especialistas
e produza o resultado ÓTIMO.

## Pedido Original
Como implementar um sistema de cache em uma API REST Node.js?

## Análises dos Especialistas

### 1. ARCHITECT (System Design)
[Resumo dos principais pontos]

### 2. PLANNER (Implementation Strategy)
[Resumo dos principais pontos]

### 3. SECURITY EXPERT
[Resumo dos principais pontos]

### 4. CODE QUALITY EXPERT
[Resumo dos principais pontos]

### 5. GENERAL/CREATIVE EXPERT
[Resumo dos principais pontos]

## Sua Tarefa

Sintetize estas perspectivas em uma solução UNIFICADA e ÓTIMA:

1. **Pontos de Consenso**: O que múltiplos experts concordam?
2. **Conflitos Resolvidos**: Onde experts discordam? Resolva com raciocínio.
3. **Melhores Práticas Combinadas**: Combine as recomendações mais fortes.
4. **Recomendação Final**: Produza a resposta/solução definitiva.
5. **Implementação**: Forneça código/implementação final consolidada.

Produza um resultado claro e acionável que incorpore o melhor de cada
perspectiva. Responda em Português.
```

---

## Resultado Final Sintetizado

### Pontos de Consenso (5/5 Especialistas)

| Aspecto | Consenso |
|---------|----------|
| **Redis como L2** | Todos recomendam Redis como cache distribuído principal |
| **TTL Obrigatório** | Nunca cachear sem expiração definida |
| **Isolamento por Usuário** | Cache key DEVE incluir identificador do usuário |
| **Graceful Degradation** | Cache nunca deve quebrar a aplicação principal |
| **Métricas** | Monitorar hit rate, latency, errors é essencial |
| **Cache-Aside Pattern** | Padrão recomendado para a maioria dos casos |

### Conflitos Resolvidos

| Conflito | Resolução |
|----------|-----------|
| **L1 In-Memory vs Apenas Redis** | L1 apenas para dados não-sensíveis e configurações. Redis para tudo mais. |
| **Complexidade vs Simplicidade** | Implementação incremental. Fase 0: HTTP Headers. Depois Redis se métricas justificarem. |
| **Criptografia de Cache** | Classificar dados. Nunca cachear PII/tokens. Dados de negócio sem criptografia se Redis em rede privada com TLS+AUTH. |

### Arquitetura Final

```
┌─────────────────────────────────────────────────────────────┐
│                    ARQUITETURA FINAL                        │
├─────────────────────────────────────────────────────────────┤
│  Client → CDN → API Gateway → [Cache Middleware] → Handler │
│                                      │                      │
│                              ┌───────┴───────┐              │
│                              │  CacheManager │              │
│                              │ (Circuit Breaker)            │
│                              └───────┬───────┘              │
│                         ┌────────────┼────────────┐         │
│                         ▼            ▼            ▼         │
│                   [L1 Memory]   [L2 Redis]   [Fallback]     │
│                    (LRU 1000)   (Primary)    (No-cache)     │
└─────────────────────────────────────────────────────────────┘
```

### Estratégia de TTL Final

| Categoria | TTL | Exemplos | Invalidação |
|-----------|-----|----------|-------------|
| **Static** | 24h | Configurações, traduções | Deploy/Manual |
| **Quasi-Static** | 1h | Categorias, metadados | Event-based |
| **Dynamic** | 5min | Listagens, dashboards | TTL + Event |
| **User-Specific** | 1-5min | Perfil, preferências | TTL + User action |
| **Never Cache** | - | Tokens, senhas, PII | - |

### Checklist de Segurança Final

- [ ] Cache key inclui `userId` ou `tenantId`
- [ ] Redis com TLS + AUTH em produção
- [ ] Rate limiting no endpoint
- [ ] Validação de input antes de gerar cache key
- [ ] Dados sensíveis NUNCA cacheados
- [ ] TTL máximo definido (24h)

### Métricas Alvo

| Métrica | Target |
|---------|--------|
| Hit Rate | > 80% |
| Latency P95 | < 10ms |
| Error Rate | < 0.1% |

### Estrutura de Código Final

```
src/
├── cache/
│   ├── index.ts                 # Export público
│   ├── cache.types.ts           # Interfaces e tipos
│   ├── cache.manager.ts         # Orquestrador com Circuit Breaker
│   ├── providers/
│   │   ├── cache.provider.ts    # Interface abstrata
│   │   ├── redis.provider.ts    # Implementação Redis
│   │   └── memory.provider.ts   # Implementação LRU in-memory
│   ├── middleware/
│   │   └── cache.middleware.ts  # Middleware Express/tRPC
│   └── utils/
│       ├── cache-key.builder.ts # Geração segura de keys
│       └── cache.metrics.ts     # Métricas e observabilidade
```

---

## Resumo da Execução

| Fase | Descrição | Duração |
|------|-----------|---------|
| **Fase 1** | 5 agentes executando em paralelo | ~30s |
| **Fase 2** | Coleta de resultados | Instantâneo |
| **Fase 3** | Síntese com agente revisor (opus) | ~20s |
| **Fase 4** | Apresentação do resultado | Instantâneo |

### Contribuição de Cada Agente

| Agente | Contribuição Única |
|--------|-------------------|
| **Architect** | Arquitetura multi-camadas, diagramas, padrões de design |
| **Planner** | Fases de implementação, cronograma, rollback plan |
| **Security** | Vulnerabilidades, criptografia, checklist de segurança |
| **Code Quality** | Interfaces, testes, anti-patterns, clean code |
| **Creative** | Alternativas de baixo custo, edge cases, quando NÃO cachear |

---

## Conclusão

O skill `/multi-perspective` demonstrou sua eficácia ao:

1. **Paralelizar análises** - 5 agentes trabalhando simultaneamente
2. **Diversificar perspectivas** - cada agente trouxe insights únicos
3. **Resolver conflitos** - o sintetizador combinou visões divergentes
4. **Produzir resultado acionável** - código pronto para implementação

A abordagem ensemble garante que a solução final seja mais robusta do que qualquer análise individual poderia produzir.
