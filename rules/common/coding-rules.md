# 通用编码规则

受 ECC 项目启发，适用于所有编程语言的通用编码准则。

## 核心原则

### 1. 可读性优先
- 代码是写给人看的，机器只是顺便执行
- 选择清晰的命名而非简短的缩写
- 保持函数和类的单一职责
- 使用有意义的注释解释"为什么"而非"做什么"

### 2. DRY (Don't Repeat Yourself)
- 消除重复代码
- 提取公共逻辑到函数/方法
- 使用配置而非硬编码

### 3. 防御性编程
- 验证输入，假设最坏情况
- 使用显式类型而非隐式转换
- 处理所有错误路径

### 4. 最小化依赖
- 只引入必要的依赖
- 优先使用标准库
- 定期审计和更新依赖

## 代码风格

### 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 变量/函数 | camelCase | `getUserById`, `userName` |
| 类/接口 | PascalCase | `UserService`, `IRepository` |
| 常量 | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| 文件/目录 | kebab-case | `user-service.ts` |
| 私有属性 | _prefix | `_internalState` |

### 文件组织

```
project/
├── src/                    # 源代码
│   ├── components/         # UI 组件
│   ├── services/           # 业务逻辑
│   ├── utils/              # 工具函数
│   └── types/              # 类型定义
├── tests/                  # 测试文件
├── docs/                   # 文档
├── config/                 # 配置文件
└── scripts/                # 构建脚本
```

### 注释规范

```typescript
/**
 * 计算用户的年龄
 * @param birthDate - 用户出生日期 (ISO 8601 格式)
 * @returns 年龄（岁），如果出生日期无效返回 null
 * @example
 * calculateAge('1990-01-01') // 返回 34
 */
function calculateAge(birthDate: string): number | null {
  // 实现...
}
```

## 错误处理

### 原则
- 失败要早，失败要明显
- 不要吞掉异常
- 提供有用的错误信息
- 区分可恢复和不可恢复错误

### 错误结构

```typescript
interface AppError {
  code: string;           // 错误代码
  message: string;        // 用户友好的消息
  details?: unknown;      // 详细信息
  stack?: string;         // 堆栈跟踪（开发环境）
}
```

## 安全准则

- 永不信任用户输入
- 使用参数化查询防止 SQL 注入
- 转义输出防止 XSS
- 不要硬编码密钥或密码
- 使用 HTTPS 传输敏感数据
- 实施适当的访问控制

## 性能准则

- 避免过早优化
- 使用性能分析工具识别瓶颈
- 考虑算法复杂度
- 缓存昂贵的计算结果
- 使用延迟加载处理大数据

## 测试准则

- 编写测试前先理解需求
- 测试行为而非实现
- 保持测试独立和可重复
- 使用有意义的测试描述
- 目标覆盖率: 核心逻辑 >= 80%

## Git 工作流

### 提交信息规范

```
<type>: <subject>

<body>

<footer>
```

类型：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码风格调整（不影响功能）
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建/工具相关

示例：
```
feat: 添加用户认证功能

- 实现 JWT token 生成和验证
- 添加登录和登出端点
- 集成 bcrypt 密码哈希

Closes #123
```

### 分支策略

- `main`: 生产分支
- `develop`: 开发分支
- `feature/*`: 功能分支
- `fix/*`: 修复分支
- `release/*`: 发布分支

## 代码审查

### 审查清单

- [ ] 代码是否符合项目规范
- [ ] 是否有适当的测试
- [ ] 是否有安全风险
- [ ] 是否有性能问题
- [ ] 文档是否更新
- [ ] 提交信息是否清晰

### 审查语气

- 使用建设性的反馈
- 解释"为什么"而非只说"做什么"
- 认可好的实践
- 提供具体的改进建议
