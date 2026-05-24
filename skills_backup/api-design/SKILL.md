# API Design 技能

受 ECC 项目启发，专为 Codex 优化的 API 设计工作流。

## 描述

API Design 技能提供设计高质量、一致、可维护的 RESTful 和 GraphQL API 的指导。

## 使用场景

- 设计新的 API 端点
- 审查现有 API 设计
- API 版本升级
- 文档生成
- 客户端 SDK 设计

## 设计原则

### RESTful 设计

#### URL 设计

- 使用名词而非动词
- 使用复数形式
- 层次结构表示关系
- 小写和连字符

```
✅ GET /users
✅ GET /users/{id}
✅ GET /users/{id}/posts
✅ POST /users

❌ GET /getUsers
❌ GET /User
❌ GET /user_posts
❌ POST /createUser
```

#### HTTP 方法

| 方法 | 用途 | 幂等性 |
|------|------|--------|
| GET | 获取资源 | 是 |
| POST | 创建资源 | 否 |
| PUT | 完全更新 | 是 |
| PATCH | 部分更新 | 否 |
| DELETE | 删除资源 | 是 |

#### 状态码

| 状态码 | 使用场景 |
|--------|----------|
| 200 OK | 成功的 GET、PUT、PATCH、DELETE |
| 201 Created | 成功的 POST 创建 |
| 204 No Content | 成功但无返回内容 |
| 400 Bad Request | 请求参数错误 |
| 401 Unauthorized | 未认证 |
| 403 Forbidden | 无权限 |
| 404 Not Found | 资源不存在 |
| 409 Conflict | 资源冲突 |
| 422 Unprocessable | 语义错误 |
| 429 Too Many Requests | 速率限制 |
| 500 Server Error | 服务器错误 |

### 请求/响应格式

#### 请求

```json
{
  "data": {
    "name": "John Doe",
    "email": "john@example.com"
  },
  "meta": {
    "requestId": "uuid"
  }
}
```

#### 成功响应

```json
{
  "data": {
    "id": "123",
    "name": "John Doe",
    "email": "john@example.com",
    "createdAt": "2024-01-15T10:30:00Z"
  },
  "meta": {
    "requestId": "uuid",
    "timestamp": "2024-01-15T10:30:01Z"
  }
}
```

#### 错误响应

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ]
  },
  "meta": {
    "requestId": "uuid"
  }
}
```

### 分页

```
GET /users?page=2&limit=20
```

```json
{
  "data": [...],
  "pagination": {
    "page": 2,
    "limit": 20,
    "total": 150,
    "totalPages": 8,
    "hasNext": true,
    "hasPrev": true
  }
}
```

### 过滤与排序

```
GET /users?status=active&role=admin&sort=name:asc,createdAt:desc
```

## 设计检查清单

- [ ] URL 符合 RESTful 规范
- [ ] 使用正确的 HTTP 方法
- [ ] 返回恰当的 HTTP 状态码
- [ ] 请求/响应格式一致
- [ ] 包含错误处理
- [ ] 实现分页（列表接口）
- [ ] 支持过滤和排序
- [ ] 包含 API 版本
- [ ] 有适当的认证授权
- [ ] 实现速率限制
- [ ] API 文档完整
- [ ] 有变更日志

## Codex 指令模板

```
请帮我设计以下 API：

资源: [资源名称]
操作:
- [操作列表：创建、查询、更新、删除等]

要求:
- 遵循 RESTful 设计原则
- 包含完整的请求/响应示例
- 处理错误情况
- 考虑分页（如适用）
- 考虑过滤和排序（如适用）

请提供:
1. 端点设计
2. 请求/响应格式
3. 错误码定义
4. 示例调用
```

## GraphQL 设计

### Schema 设计原则

- 类型使用 PascalCase
- 字段使用 camelCase
- 枚举使用全大写 SCREAMING_SNAKE_CASE
- 提供有意义的描述

```graphql
type User {
  id: ID!
  email: String!
  name: String
  createdAt: DateTime!
  posts: [Post!]!
}

type Query {
  user(id: ID!): User
  users(filter: UserFilter, pagination: PaginationInput): UserConnection!
}

type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!
}
```

## 资源

- [RESTful API 设计指南](https://github.com/microsoft/api-guidelines)
- [JSON:API 规范](https://jsonapi.org/)
- [GraphQL 最佳实践](https://graphql.org/learn/best-practices/)
- [OpenAPI 规范](https://swagger.io/specification/)
