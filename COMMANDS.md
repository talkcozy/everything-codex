# Commands

Everything Codex 命令指南

受 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) 项目启发

---

## 什么是命令？

命令是 Codex 中可以调用的预定义指令，每个命令都有特定的功能和参数格式。

## 可用命令

### `/code-review` - 代码审查

**描述**: 代码审查 — 本地未提交更改或 GitHub PR

**使用方式**:
```bash
# 本地审查
codex /code-review

# PR 审查
codex /code-review 123
codex /code-review https://github.com/owner/repo/pull/123
```

**功能**:
- 安全检查（硬编码密钥、注入漏洞、XSS 等）
- 代码质量检查（函数长度、重复代码等）
- 性能考虑（N+1 查询、资源释放等）

---

### `/security-scan` - 安全扫描

**描述**: 安全扫描 — 检查代码中的安全漏洞

**使用方式**:
```bash
# 扫描整个项目
codex /security-scan

# 扫描特定文件
codex /security-scan src/auth.js

# 扫描特定目录
codex /security-scan src/
```

**功能**:
- OWASP Top 10 检查
- 代码安全审计
- 配置安全检查
- 依赖漏洞扫描

---

### `/refactor` - 重构

**描述**: 重构 — 系统化代码改进

**使用方式**:
```bash
# 重构特定文件
codex /refactor src/utils.js

# 重构特定函数
codex /refactor "extract function from src/auth.js login method"

# 大规模重构
codex /refactor "refactor authentication module to use repository pattern"
```

**功能**:
- 代码级重构（提取函数、重命名等）
- 结构级重构（提取模块、引入设计模式等）

---

### `/debug` - 调试

**描述**: 调试 — 诊断和修复问题

**使用方式**:
```bash
# 调试特定错误
codex /debug "API returns 500 error on login"

# 调试性能问题
codex /debug "page loads slowly"

# 调试测试失败
codex /debug "test UserService.test.js is failing"
```

**功能**:
- 系统化问题诊断
- 根因分析
- 修复方案建议
- 预防措施

---

## 创建自定义命令

### 命令文件结构

在 `commands/` 目录创建新的 Markdown 文件：

```markdown
---
description: 命令描述
description-zh: 中文描述
---

# 命令名称 / Command Name

## 使用方式

```bash
codex /command-name [参数]
```

## 功能说明

[命令功能详细说明]

## 参数说明

| 参数 | 类型 | 必填 | 描述 |
|------|------|------|------|
| param | string | 否 | 参数说明 |

## 输出格式

[命令输出格式]
```

### 注册命令

在 `.codex/config.toml` 中添加命令配置（如需要）：

```toml
[commands.custom-command]
description = "自定义命令描述"
script = "scripts/custom-command.sh"
```

---

## 最佳实践

1. **命令命名**: 使用简洁、描述性的名称
2. **参数设计**: 提供合理的默认值
3. **输出格式**: 使用统一的输出格式
4. **文档完整**: 包含使用示例和说明
