# Everything Codex 使用示例

## 示例 1: 代码探索

```bash
# 使用 explorer 智能体分析新项目
codex --agent explorer "分析这个项目的架构，识别主要模块和它们之间的关系"

# 定位特定功能
codex --agent explorer "找到处理用户认证的所有代码位置"
```

## 示例 2: 代码审查

```bash
# 审查最近的更改
codex --agent reviewer "审查 src/auth/ 目录的代码，特别关注安全性和错误处理"

# PR 审查
codex --agent reviewer "检查这个 PR 是否包含适当的测试和文档"
```

## 示例 3: 系统设计

```bash
# 设计新功能
codex --agent architect "设计一个基于 Redis 的缓存系统，需要支持：
- 设置和获取缓存
- TTL 支持
- 缓存失效策略
- 分布式锁"

# 重构规划
codex --agent architect "这个模块变得太复杂了，帮我设计一个重构方案"
```

## 示例 4: 使用技能

```bash
# TDD 开发
codex --skill tdd-workflow "使用 TDD 实现一个用户注册 API"

# 安全审查
codex --skill security-review "检查认证模块的安全漏洞"

# API 设计
codex --skill api-design "为电商平台设计商品管理 API"
```

## 示例 5: 多智能体协作

```bash
# 完整的开发流程

# 1. 探索现有代码
codex --agent explorer "分析当前的用户认证实现"

# 2. 设计新方案
codex --agent architect "基于分析结果，设计一个更安全、可扩展的新认证系统"

# 3. 实现（使用默认智能体）
codex "实现刚才设计的认证系统"

# 4. 审查
codex --agent reviewer "审查新实现的认证系统"

# 5. 编写文档
codex --agent docs "为新认证系统编写 API 文档"
```

## 示例 6: 配置管理

```bash
# 列出 MCP 服务器
codex mcp list

# 添加 MCP 服务器
codex mcp add supabase npx supabase-mcp-server

# 使用特定配置文件
codex -p strict "执行敏感操作"
```

## 示例 7: 复杂任务

```bash
# 使用多智能体处理复杂任务
codex --agent explorer "分析 codebase" && \
codex --agent architect "识别需要重构的模块" && \
codex "执行重构" && \
codex --agent reviewer "验证重构结果"
```
