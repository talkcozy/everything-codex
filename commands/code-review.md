---
description: 代码审查 — 本地未提交更改或 GitHub PR
description-zh: Code review — local uncommitted changes or GitHub PR
---

# 代码审查 / Code Review

全面审查代码质量和安全性。

## 使用方式

```bash
# 本地审查
codex /code-review

# PR 审查
codex /code-review 123
codex /code-review https://github.com/owner/repo/pull/123
```

## 审查内容

### 安全性检查
- [ ] 硬编码凭证、API 密钥、令牌
- [ ] SQL 注入漏洞
- [ ] XSS 漏洞
- [ ] 缺少输入验证
- [ ] 不安全的依赖
- [ ] 路径遍历风险

### 代码质量
- [ ] 函数 > 50 行
- [ ] 文件 > 800 行
- [ ] 重复代码
- [ ] 复杂度过高
- [ ] 缺少错误处理
- [ ] 注释不足

### 性能考虑
- [ ] N+1 查询
- [ ] 不必要的计算
- [ ] 内存泄漏风险
- [ ] 资源未释放

## 输出格式

```markdown
## 代码审查报告

### 概要
- **审查范围**: [文件列表]
- **问题数量**: [严重/高/中/低]
- **总体评价**: [通过/需修改]

### 🔴 严重问题
1. **[问题类型]** @ `文件:行号`
   - 描述: [问题描述]
   - 建议: [修复建议]

### 🟡 建议改进
...

### ✅ 良好实践
...
```
