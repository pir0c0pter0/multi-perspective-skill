# 🎯 Exemplos de Uso - Multi-Perspective Skill

<p align="center">
  <img src="https://img.shields.io/badge/examples-10+-green?style=flat-square" alt="Examples">
  <img src="https://img.shields.io/badge/languages-PT%20%7C%20EN-blue?style=flat-square" alt="Languages">
</p>

---

## 📑 Índice

1. [Implementação de Autenticação](#1-implementação-de-autenticação)
2. [Sistema de Cache](#2-sistema-de-cache)
3. [Arquitetura de Microserviços](#3-arquitetura-de-microserviços)
4. [API Rate Limiting](#4-api-rate-limiting)
5. [Database Schema Design](#5-database-schema-design)
6. [Real-time Features](#6-real-time-features)
7. [CI/CD Pipeline](#7-cicd-pipeline)
8. [Error Handling Strategy](#8-error-handling-strategy)
9. [Migração de Monolito](#9-migração-de-monolito)
10. [Performance Optimization](#10-performance-optimization)

---

## 1. Implementação de Autenticação

### Prompt

```bash
/multi-perspective "Como implementar autenticação JWT em uma API
Node.js Express com refresh tokens, logout em todos dispositivos,
e proteção contra roubo de tokens? Stack: Node.js, Express, PostgreSQL, Redis."
```

### Resultado Esperado

#### Confidence: 🟢 HIGH

#### Summary
Sistema de autenticação robusto com JWT access tokens (15min TTL), refresh tokens rotativos armazenados em Redis, e blacklist para invalidação imediata.

#### Final Recommendation

1. **Access Token:** JWT com 15min TTL, claims mínimas
2. **Refresh Token:** Opaque token em Redis, rotativo a cada uso
3. **Logout:** Blacklist do refresh token + versão de sessão no user
4. **Proteção:** Fingerprint do dispositivo no token, rate limiting

#### Key Insights by Perspective

| Agent | Insight |
|-------|---------|
| 🏛️ Architect | Separar auth service, usar Redis para tokens |
| 🗺️ Planner | Fase 1: Basic JWT → Fase 2: Refresh → Fase 3: Device mgmt |
| 🔒 Security | NUNCA armazenar JWT no localStorage, usar httpOnly cookies |
| ✨ Quality | Interface `AuthProvider` para abstrair estratégia |
| 💡 Creative | Considere Passport.js ao invés de implementar do zero |

---

## 2. Sistema de Cache

### Prompt

```bash
/multi-perspective "Como implementar um sistema de cache em uma
API REST Node.js? Considere invalidação, cache stampede, e dados
sensíveis. Stack: Node.js, tRPC, PostgreSQL."
```

### Resultado Esperado

#### Confidence: 🟢 HIGH

#### Summary
Arquitetura multi-camadas: L1 (in-memory LRU) + L2 (Redis) com padrão Cache-Aside, TTLs diferenciados por tipo de dado, e invalidação via Pub/Sub.

#### Final Recommendation

```typescript
// Estrutura recomendada
src/cache/
├── cache.manager.ts      // Orquestrador com Circuit Breaker
├── providers/
│   ├── redis.provider.ts // L2 cache
│   └── memory.provider.ts// L1 cache (LRU)
└── middleware/
    └── cache.middleware.ts
```

#### Estratégia de TTL

| Categoria | TTL | Exemplos |
|-----------|-----|----------|
| Static | 24h | Configs, traduções |
| Quasi-Static | 1h | Categorias, metadados |
| Dynamic | 5min | Listagens |
| Never Cache | - | Tokens, PII |

---

## 3. Arquitetura de Microserviços

### Prompt

```bash
/multi-perspective --mode=comprehensive "Estou migrando um monolito
e-commerce para microserviços. Como dividir os domínios e qual
padrão de comunicação usar? Contexto: 50k usuários/dia, 3 devs,
stack Node.js/PostgreSQL."
```

### Resultado Esperado

#### Confidence: 🟡 MEDIUM

#### Summary
Para 3 devs e 50k usuários/dia, recomenda-se **modular monolith** primeiro, com extração gradual. Se insistir em microserviços, comece com 3 serviços core.

#### Proposed Domain Split

```
┌─────────────────────────────────────────────┐
│              API Gateway (Kong)              │
└─────────────────┬───────────────────────────┘
                  │
    ┌─────────────┼─────────────┐
    ▼             ▼             ▼
┌───────┐   ┌───────────┐   ┌───────────┐
│ Users │   │  Catalog  │   │  Orders   │
│Service│   │  Service  │   │  Service  │
└───┬───┘   └─────┬─────┘   └─────┬─────┘
    │             │               │
    └─────────────┴───────────────┘
                  │
          [Event Bus - RabbitMQ]
```

#### Dissenting Opinion

> 💡 **Creative:** Com 3 devs, microserviços vai TRIPLICAR sua complexidade operacional. Considere Modular Monolith com boundaries claros primeiro. Extraia para microserviços apenas quando tiver DOR real de escala.

---

## 4. API Rate Limiting

### Prompt

```bash
/multi-perspective "Como implementar rate limiting em uma API pública?
Preciso de limites por IP, por usuário autenticado, e por endpoint.
Stack: Node.js, Express, Redis."
```

### Resultado Esperado

#### Confidence: 🟢 HIGH

#### Final Recommendation

```typescript
// Estratégia de limites
const rateLimits = {
  // Por IP (não autenticado)
  anonymous: {
    window: '15m',
    max: 100,
    message: 'Too many requests, try again later'
  },

  // Por usuário autenticado
  authenticated: {
    window: '15m',
    max: 1000,
    keyGenerator: (req) => req.user.id
  },

  // Por endpoint sensível
  sensitive: {
    window: '1h',
    max: 10,
    endpoints: ['/auth/login', '/auth/reset-password']
  }
}
```

#### Implementation

| Layer | Solution |
|-------|----------|
| Global | `express-rate-limit` + Redis store |
| Per-endpoint | Middleware decorator |
| Distributed | Redis Sliding Window |

---

## 5. Database Schema Design

### Prompt

```bash
/multi-perspective "Preciso modelar um sistema de permissões RBAC
com suporte a permissões por recurso específico (ex: user X pode
editar projeto Y). PostgreSQL, ~10k usuários."
```

### Resultado Esperado

#### Schema Recomendado

```sql
-- Core RBAC
users (id, email, ...)
roles (id, name, description)
permissions (id, resource, action)  -- 'project:read', 'project:write'
role_permissions (role_id, permission_id)
user_roles (user_id, role_id)

-- Resource-level permissions
resource_permissions (
  id,
  user_id,
  resource_type,    -- 'project', 'document'
  resource_id,      -- UUID do recurso específico
  permission_id,
  granted_by,
  expires_at
)
```

#### Query Pattern

```typescript
async function canUserAccess(
  userId: string,
  resource: string,
  action: string,
  resourceId?: string
): Promise<boolean> {
  // 1. Check role-based permissions
  // 2. Check resource-specific permissions
  // 3. Return true if any grants access
}
```

---

## 6. Real-time Features

### Prompt

```bash
/multi-perspective "Quero adicionar notificações real-time no meu
SaaS. WebSockets vs SSE vs polling? Contexto: React frontend,
Node.js backend, ~5k conexões simultâneas, hospedado na Vercel."
```

### Resultado Esperado

#### Confidence: 🟢 HIGH

#### Comparison Matrix

| Feature | WebSocket | SSE | Long Polling |
|---------|:---------:|:---:|:------------:|
| Bidirecional | ✅ | ❌ | ❌ |
| Reconexão auto | ❌ | ✅ | ❌ |
| Vercel friendly | ❌ | ✅ | ✅ |
| Complexidade | Alta | Baixa | Média |
| 5k conexões | ⚠️ | ✅ | ✅ |

#### Final Recommendation

**SSE (Server-Sent Events)** para seu caso:

1. ✅ Funciona na Vercel (Edge Functions)
2. ✅ Reconexão automática
3. ✅ Simples de implementar
4. ✅ Suficiente para notificações (unidirecional)

```typescript
// Backend (Edge Function)
export default function handler(req: Request) {
  return new Response(
    new ReadableStream({
      start(controller) {
        // Send events
      }
    }),
    { headers: { 'Content-Type': 'text/event-stream' } }
  )
}
```

#### Dissenting Opinion

> 🏛️ **Architect:** Se futuramente precisar de chat ou colaboração real-time, WebSocket será necessário. Considere abstrair com interface `RealtimeProvider` para trocar depois.

---

## 7. CI/CD Pipeline

### Prompt

```bash
/multi-perspective "Como estruturar um pipeline CI/CD para um
monorepo com 3 apps Next.js e 2 APIs Node.js? GitHub Actions,
deploy na Vercel (frontend) e Railway (backend)."
```

### Resultado Esperado

#### Pipeline Structure

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:

jobs:
  # 1. Detect changes
  changes:
    runs-on: ubuntu-latest
    outputs:
      apps: ${{ steps.filter.outputs.changes }}
    steps:
      - uses: dorny/paths-filter@v2
        id: filter
        with:
          filters: |
            app-web: 'apps/web/**'
            app-admin: 'apps/admin/**'
            api-core: 'services/api-core/**'

  # 2. Parallel tests per changed app
  test:
    needs: changes
    strategy:
      matrix:
        app: ${{ fromJson(needs.changes.outputs.apps) }}
    steps:
      - run: pnpm --filter ${{ matrix.app }} test

  # 3. Deploy (only on main)
  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    # ...
```

#### Best Practices

| Practice | Implementation |
|----------|----------------|
| Only build changed | `paths-filter` action |
| Parallel jobs | `matrix` strategy |
| Cache dependencies | `pnpm` cache action |
| Preview deploys | Vercel auto-preview |

---

## 8. Error Handling Strategy

### Prompt

```bash
/multi-perspective "Como estruturar error handling consistente em
uma API Node.js? Preciso de erros tipados, logging estruturado,
e respostas consistentes pro frontend."
```

### Resultado Esperado

#### Error Class Hierarchy

```typescript
// Base error
abstract class AppError extends Error {
  abstract statusCode: number
  abstract code: string
  isOperational = true
}

// Specific errors
class ValidationError extends AppError {
  statusCode = 400
  code = 'VALIDATION_ERROR'
  constructor(public errors: FieldError[]) {
    super('Validation failed')
  }
}

class NotFoundError extends AppError {
  statusCode = 404
  code = 'NOT_FOUND'
  constructor(resource: string) {
    super(`${resource} not found`)
  }
}

class UnauthorizedError extends AppError {
  statusCode = 401
  code = 'UNAUTHORIZED'
}
```

#### Response Format

```typescript
// Success
{
  "success": true,
  "data": { ... }
}

// Error
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      { "field": "email", "message": "Invalid email format" }
    ]
  }
}
```

---

## 9. Migração de Monolito

### Prompt

```bash
/multi-perspective --mode=comprehensive "Tenho um monolito Django
com 200k linhas de código e 5 anos de idade. Como começar a
migração para microserviços sem parar o desenvolvimento de features?"
```

### Resultado Esperado

#### Confidence: 🟡 MEDIUM

#### Estratégia: Strangler Fig Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                      Strangler Fig Pattern                   │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Fase 1: API Gateway na frente                              │
│  ┌─────────┐                                                │
│  │ Gateway │ ──▶ 100% tráfego ──▶ [Monolito Django]        │
│  └─────────┘                                                │
│                                                             │
│  Fase 2: Primeira extração (Auth)                           │
│  ┌─────────┐     ┌──────────────┐                          │
│  │ Gateway │ ──▶ │ Auth Service │ (10% tráfego)            │
│  └─────────┘     └──────────────┘                          │
│       │                                                     │
│       └──▶ 90% tráfego ──▶ [Monolito Django]               │
│                                                             │
│  Fase N: Monolito vira minority                             │
│  ┌─────────┐     ┌─────┐ ┌─────┐ ┌─────┐                   │
│  │ Gateway │ ──▶ │ Svc │ │ Svc │ │ Svc │ (90%)             │
│  └─────────┘     └─────┘ └─────┘ └─────┘                   │
│       │                                                     │
│       └──▶ 10% legacy ──▶ [Monolito Django]                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

#### Ordem de Extração Sugerida

| Ordem | Serviço | Justificativa |
|:-----:|---------|---------------|
| 1 | Auth/Identity | Bounded context claro |
| 2 | Notifications | Pouco acoplamento |
| 3 | File Storage | Domínio isolado |
| 4 | Search | Performance crítica |
| 5-N | Domain services | Por bounded context |

#### Dissenting Opinion

> 💡 **Creative:** 200k linhas em 5 anos = ~40k linhas/ano de crescimento. Com essa taxa, em 2 anos de migração você terá +80k linhas NOVAS no monolito. Considere FREEZE do monolito para features novas, direcionando-as para novos serviços.

---

## 10. Performance Optimization

### Prompt

```bash
/multi-perspective "Minha API Node.js está com latência P95 de 2s
em algumas rotas. Como diagnosticar e otimizar? Stack: Express,
Prisma, PostgreSQL, hospedado no Railway."
```

### Resultado Esperado

#### Diagnostic Checklist

```
┌─────────────────────────────────────────────────────────────┐
│                   Performance Diagnostic                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. Database Queries                                        │
│     □ Enable Prisma query logging                           │
│     □ Check for N+1 queries                                 │
│     □ Analyze slow query log (PostgreSQL)                   │
│     □ Verify indexes exist                                  │
│                                                             │
│  2. Application                                             │
│     □ Add APM (Sentry, DataDog)                            │
│     □ Profile memory usage                                  │
│     □ Check for sync operations in async context            │
│     □ Verify connection pooling                             │
│                                                             │
│  3. Infrastructure                                          │
│     □ Check Railway metrics (CPU, Memory)                   │
│     □ Verify geographic proximity DB <-> API                │
│     □ Check for cold starts                                 │
│                                                             │
│  4. Network                                                 │
│     □ Payload sizes (compress responses)                    │
│     □ Connection reuse (keep-alive)                         │
│     □ CDN for static assets                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

#### Quick Wins

| Optimization | Impact | Effort |
|--------------|:------:|:------:|
| Add missing indexes | 🟢 High | 🟢 Low |
| Enable compression | 🟢 High | 🟢 Low |
| Fix N+1 queries | 🟢 High | 🟡 Medium |
| Add response caching | 🟢 High | 🟡 Medium |
| Connection pooling | 🟡 Medium | 🟢 Low |
| Query pagination | 🟡 Medium | 🟢 Low |

---

## 🎓 Dicas Finais

### Para Melhores Resultados

1. **Seja específico** - Stack, escala, constraints
2. **Contextualize** - Time size, budget, deadline
3. **Use o modo certo** - Quick para validação, Comprehensive para decisões críticas
4. **Valorize dissent** - Opiniões minoritárias frequentemente revelam blind spots

### Prompts Templates

```bash
# Feature implementation
/multi-perspective "Como implementar [FEATURE] em [STACK]?
Contexto: [SCALE], [TEAM_SIZE] devs, hospedado em [INFRA]."

# Architecture decision
/multi-perspective --mode=comprehensive "Preciso decidir entre
[OPTION_A] vs [OPTION_B] para [USE_CASE]. Trade-offs?"

# Code review
/multi-perspective "Analise esta abordagem para [PROBLEM]:
[BRIEF_DESCRIPTION]. O que estou perdendo?"

# Troubleshooting
/multi-perspective "Meu [SYSTEM] está com [SYMPTOM].
Stack: [TECH]. Como diagnosticar e resolver?"
```

---

<p align="center">
  <strong>Use esses exemplos como inspiração para seus próprios prompts! 🚀</strong>
</p>
