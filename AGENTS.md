# AGENTS.md

Everything Codex 智能体配置指南

受 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) 项目启发

---

## 什么是智能体？

智能体（Agents）是 Codex 中预配置的角色，每个角色都有特定的专长和行为模式。通过使用智能体，你可以让 Codex 以特定的方式进行工作。

## 可用智能体

### Explorer（探索者）

**用途**：只读代码库分析

**特点**：
- 只读模式，不会修改代码
- 专注于理解代码结构和逻辑
- 提供详细的代码分析报告

**使用场景**：
- 新项目 onboarding
- 代码审查准备
- 技术债务评估
- 影响分析

**使用方式**：
```bash
codex --agent explorer "分析这个项目的架构"
```

---

### Reviewer（审查者）

**用途**：代码审查和质量保证

**特点**：
- 严格的质量标准
- 安全检查清单
- 建设性的反馈

**使用场景**：
- PR 审查
- 安全审计
- 代码质量检查

**使用方式**：
```bash
codex --agent reviewer "审查最近的代码更改"
```

---

### Architect（架构师）

**用途**：系统设计和架构决策

**特点**：
- 高层设计思维
- 多方案比较
- 技术决策记录

**使用场景**：
- 系统设计
- 技术选型
- 重构规划

**使用方式**：
```bash
codex --agent architect "设计一个新的用户认证系统"
```

---

### Docs（文档专家）

**用途**：文档编写和维护

**特点**：
- 专业的文档编写
- API 文档生成
- 用户指南编写

**使用场景**：
- API 文档
- 用户手册
- README 维护

**使用方式**：
```bash
codex --agent docs "为这个项目编写 API 文档"
```

---

## 自定义智能体

### 创建新智能体

1. 在 `.codex/agents/` 目录创建新的 TOML 文件
2. 参考现有智能体配置
3. 定义智能体的 `developer_instructions`
4. 在 `config.toml` 中注册

### 智能体配置模板

```toml
# .codex/agents/custom.toml

model = "gpt-5.4"
model_reasoning_effort = "medium"  # low | medium | high
sandbox_mode = "read-only"         # read-only | workspace-write

developer_instructions = """
你是 [智能体名称]，专门用于 [用途描述]。

## 核心职责
1. [职责一]
2. [职责二]
3. [职责三]

## 行为准则
- [准则一]
- [准则二]
- [准则三]

## 工作流程
1. [步骤一]
2. [步骤二]
3. [步骤三]

## 输出格式
[定义输出格式]
"""
```

---

## 智能体协作

### 工作流模式

```
1. Explorer 分析代码库
   ↓
2. Architect 设计方案
   ↓
3. [实现代码]
   ↓
4. Reviewer 审查代码
   ↓
5. Docs 编写文档
```

### 示例：完整开发流程

```bash
# 1. 探索和分析
codex --agent explorer "分析用户认证模块的当前实现"

# 2. 设计新功能
codex --agent architect "设计基于 JWT 的新认证系统，考虑安全性和性能"

# 3. 编写代码（默认智能体）
codex "实现 JWT 认证系统，包含登录、刷新 token、登出功能"

# 4. 代码审查
codex --agent reviewer "审查 JWT 认证实现的代码质量和安全性"

# 5. 编写文档
codex --agent docs "为 JWT 认证 API 编写使用文档"
```

---

## 智能体最佳实践

1. **选择合适的智能体**：根据任务类型选择最匹配的智能体
2. **提供明确指令**：清晰的指令帮助智能体更好地理解任务
3. **迭代优化**：根据反馈调整智能体配置
4. **保持简洁**：智能体指令应简洁明了，避免过于复杂
5. **版本控制**：将智能体配置纳入版本控制

---

## 故障排除

### 智能体没有生效

检查：
- 配置文件路径是否正确
- 是否在 `config.toml` 中正确注册
- 语法是否正确（特别是 TOML）

### 智能体行为不符合预期

检查：
- `developer_instructions` 是否清晰
- 是否包含具体的指导
- 输出格式是否定义明确
