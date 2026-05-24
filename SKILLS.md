# Skills

Everything Codex 技能指南

受 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) 项目启发

---

## 什么是技能？

技能是可复用的工作流程模块，指导 Codex 以特定方式完成任务。每个技能包含详细的指令、示例和检查清单。

## 可用技能

### TDD Workflow

**路径**: `skills/tdd-workflow/SKILL.md`

**描述**: 测试驱动开发工作流

**使用场景**:
- 新增功能开发
- 重构现有代码
- Bug 修复

**使用方法**:
```bash
codex --skill tdd "实现用户注册功能"
```

---

### Security Review

**路径**: `skills/security-review/SKILL.md`

**描述**: 安全审查工作流

**使用场景**:
- 代码提交前安全检查
- 安全审计
- 敏感功能审查

**使用方法**:
```bash
codex --skill security-review "检查认证模块"
```

---

### Code Exploration

**路径**: `skills/code-exploration/SKILL.md`

**描述**: 代码库分析工作流

**使用场景**:
- 新项目 onboarding
- 代码库健康检查
- 技术债务评估

**使用方法**:
```bash
codex --skill code-exploration "分析项目架构"
```

---

### API Design

**路径**: `skills/api-design/SKILL.md`

**描述**: API 设计工作流

**使用场景**:
- 设计新 API
- 审查现有 API
- API 文档生成

**使用方法**:
```bash
codex --skill api-design "设计用户管理 API"
```

---

### Testing Strategy

**路径**: `skills/testing-strategy/SKILL.md`

**描述**: 测试策略规划与执行

**使用场景**:
- 规划测试策略
- 提高测试覆盖率
- 优化测试结构

**使用方法**:
```bash
codex --skill testing-strategy "为项目设计测试方案"
```

---

### Documentation

**路径**: `skills/documentation/SKILL.md`

**描述**: 技术文档编写指南

**使用场景**:
- 编写 API 文档
- 创建架构文档
- 编写开发指南

**使用方法**:
```bash
codex --skill documentation "编写 API 文档"
```

---

### Performance Optimization

**路径**: `skills/performance-optimization/SKILL.md`

**描述**: 系统性能分析与优化

**使用场景**:
- 性能瓶颈分析
- 优化策略制定
- 性能监控

**使用方法**:
```bash
codex --skill performance-optimization "优化 API 响应时间"
```

---

### Git Workflow

**路径**: `skills/git-workflow/SKILL.md`

**描述**: 高效的 Git 工作流程

**使用场景**:
- 分支管理
- 提交规范
- 发布流程

**使用方法**:
```bash
codex --skill git-workflow "创建发布分支"
```

---

## 创建自定义技能

### 技能文件结构

在 `skills/` 目录下创建新目录和 SKILL.md 文件：

```
skills/
└── your-skill/
    └── SKILL.md
```

### SKILL.md 模板

```markdown
# 技能名称

技能描述

## 使用场景

- [场景 1]
- [场景 2]

## 工作流程

### Phase 1: 准备
```
[步骤]
```

### Phase 2: 执行
```
[步骤]
```

## 检查清单

- [ ] [检查项]

## 示例

```bash
codex --skill your-skill "任务描述"
```
```

### 注册技能

在 `.codex/config.toml` 中添加技能配置（如需要）：

```toml
[skills.your-skill]
description = "技能描述"
path = "skills/your-skill"
```

---

## 技能最佳实践

1. **单一职责**: 每个技能专注于一个工作流程
2. **清晰结构**: 使用清晰的阶段划分
3. **具体示例**: 提供具体的使用示例
4. **可检查**: 包含检查清单
5. **可复用**: 设计通用的工作流程
