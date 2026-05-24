# Everything Codex 快速参考

## 安装

```bash
git clone https://github.com/talkcozy/everything-codex.git
cd everything-codex
cp .codex/config.toml ~/.codex/config.toml
cp -r .codex/agents ~/.codex/
```

## 常用命令

### 基础使用

```bash
# 简单任务
codex "添加错误处理"

# 使用智能体
codex --agent explorer "分析代码库"
codex --agent reviewer "审查代码"

# 列出 MCP 服务器
codex mcp list
```

## 智能体速查

| 智能体 | 用途 | 示例 |
|--------|------|------|
| `explorer` | 代码分析 | `codex --agent explorer "分析架构"` |
| `reviewer` | 代码审查 | `codex --agent reviewer "审查 PR"` |
| `architect` | 系统设计 | `codex --agent architect "设计方案"` |
| `docs` | 文档编写 | `codex --agent docs "编写 API 文档"` |

## 技能速查

| 技能 | 用途 |
|------|------|
| `tdd-workflow` | 测试驱动开发 |
| `security-review` | 安全审查 |
| `code-exploration` | 代码探索 |
| `api-design` | API 设计 |

## MCP 服务器

| 服务器 | 用途 |
|--------|------|
| `github` | GitHub 集成 |
| `context7` | 文档查询 |
| `memory` | 持久化记忆 |
| `playwright` | 浏览器自动化 |

## 配置文件位置

| 文件 | 路径 |
|------|------|
| 配置 | `~/.codex/config.toml` |
| 智能体 | `~/.codex/agents/` |
| 技能 | `~/.codex/skills/` |
