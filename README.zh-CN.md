# Everything Codex

<p align="center">
  <img src="https://img.shields.io/badge/Codex-Optimized-412991?style=for-the-badge&logo=openai&logoColor=white" alt="Codex Optimized">
</p>

<p align="center">
  <a href="README.md">English</a> | <a href="README.zh-CN.md">简体中文</a>
</p>

---

**专为 OpenAI Codex 打造的终极配置集合 —— 针对 Codex CLI 和 Codex App 优化**

> **🙏 本项目受到 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) 的启发，原作者为 Affaan Mustafa**
>
> 本项目是一个专注于 Codex 的适配版本，受到了优秀 ECC 项目的启发。我们向原作者在智能体配置系统方面的开创性工作表示衷心感谢。

---

## 什么是 Everything Codex？

Everything Codex 是专为 **OpenAI Codex** —— OpenAI 的新一代 AI 编程助手设计的综合配置系统。它提供：

- 🎯 **优化智能体** —— 针对常见开发任务的预配置智能体
- 🛠️ **生产级技能** —— 可复用的技能模块，确保工作流程一致
- 📋 **智能规则** —— 上下文感知的编码规则和指导原则
- ⚡ **MCP 集成** —— 预配置的模型上下文协议服务器
- 🔧 **多智能体工作流** —— 用于复杂任务的协作智能体配置

## 快速开始

### 安装

```bash
# 克隆仓库
git clone https://github.com/talkcozy/everything-codex.git
cd everything-codex

# 安装到 Codex 配置
cp .codex/config.toml ~/.codex/config.toml

# 复制智能体配置
cp -r .codex/agents ~/.codex/agents

# 复制技能（如使用技能目录模式）
cp -r skills ~/.codex/skills
```

### 验证安装

```bash
# 检查 Codex 配置
codex config

# 列出可用的 MCP 服务器
codex mcp list

# 测试多智能体设置
codex --agent explorer "探索代码库结构"
```

## 项目结构

```
everything-codex/
├── .codex/
│   ├── config.toml          # 主 Codex 配置文件
│   └── agents/              # 智能体角色定义
│       ├── explorer.toml    # 只读代码库探索者
│       ├── reviewer.toml    # 代码审查者
│       └── architect.toml   # 系统架构师
├── agents/                  # 详细的智能体指令
├── skills/                  # 可复用的技能模块
├── rules/                   # 按语言分类的编码规则
├── docs/                    # 文档
└── examples/                # 使用示例
```

## 配置亮点

### 预配置的 MCP 服务器

| 服务器 | 用途 | 命令 |
|--------|------|------|
| `github` | GitHub 集成 | `npx @modelcontextprotocol/server-github` |
| `context7` | 文档查询 | `npx @upstash/context7-mcp` |
| `memory` | 持久化记忆 | `npx @modelcontextprotocol/server-memory` |
| `playwright` | 浏览器自动化 | `npx @playwright/mcp` |
| `sequential-thinking` | 结构化推理 | `npx @modelcontextprotocol/server-sequential-thinking` |

### 多智能体角色

| 角色 | 描述 | 使用场景 |
|------|------|----------|
| `explorer` | 只读证据收集 | 初始代码库分析 |
| `reviewer` | 代码审查与安全检查 | PR 审查、审计 |
| `architect` | 高层设计 | 系统设计、重构 |
| `docs` | 文档专家 | API 文档、指南 |
| `coder` | 代码实现 | 功能开发 |
| `debugger` | 问题诊断 | Bug 修复、故障排查 |
| `learner` | 模式提取 | 知识文档化 |

## 可用命令

| 命令 | 描述 |
|------|------|
| `/code-review` | 全面的代码和安全审查 |
| `/security-scan` | OWASP Top 10 安全审计 |
| `/refactor` | 系统化代码改进 |
| `/debug` | 系统化问题诊断 |

## 可用技能

| 技能 | 描述 |
|------|------|
| `tdd-workflow` | 测试驱动开发工作流 |
| `security-review` | 安全审计检查清单 |
| `code-exploration` | 代码库分析方法 |
| `api-design` | RESTful/GraphQL API 设计 |
| `testing-strategy` | 测试规划和执行 |
| `documentation` | 技术写作指南 |
| `performance-optimization` | 性能调优 |
| `git-workflow` | Git 最佳实践 |

## 使用示例

### 基础任务

```bash
# 简单的编码任务
codex "为 API 端点添加错误处理"
```

### 使用特定智能体

```bash
# 使用探索者智能体进行代码库分析
codex --agent explorer "查找所有与认证相关的代码"

# 使用审查者智能体进行代码审查
codex --agent reviewer "审查 src/ 目录中的最新更改"
```

### 使用技能

```bash
# 使用 TDD 工作流技能
codex --skill tdd "实现用户注册功能"

# 使用安全审查技能
codex --skill security-review "检查认证模块中的漏洞"
```

## 语言支持

Everything Codex 为以下语言提供优化规则：

- **TypeScript/JavaScript** —— React、Next.js、Node.js 模式
- **Python** —— FastAPI、Django、数据科学工作流
- **Go** —— API 设计、并发模式
- **Rust** —— 系统编程、安全模式
- **Java/Kotlin** —— Spring Boot、Android 开发
- **更多** —— C++、C#、Swift、Dart、PHP、Perl

## 文档

| 文档 | 描述 |
|------|------|
| [AGENTS.md](AGENTS.md) | 智能体配置指南 |
| [SKILLS.md](SKILLS.md) | 技能开发指南 |
| [RULES.md](RULES.md) | 规则编写参考 |
| [MCP.md](MCP.md) | MCP 服务器设置 |

## 贡献指南

我们欢迎贡献！请参阅 [CONTRIBUTING.md](CONTRIBUTING.md) 了解贡献准则。

## 致谢

本项目**深受以下项目和想法的启发**：

- **[ECC (Everything Claude Code)](https://github.com/affaan-m/ECC)**，作者为 [Affaan Mustafa](https://github.com/affaan-m) —— 开创性的智能体配置系统，率先使用了此处采用的许多模式。

ECC 项目展示了结构化智能体配置、技能模块和多智能体工作流的强大功能。Everything Codex 专为 OpenAI Codex 生态系统适配了这些概念。

## 许可证

MIT 许可证 —— 详见 [LICENSE](LICENSE)。

## 作者

**talkcozy** —— [GitHub](https://github.com/talkcozy)

---

<p align="center">
  <sub>为 Codex 社区用 ❤️ 构建</sub>
</p>
