# Rules

Everything Codex 编码规则指南

受 [ECC (Everything Claude Code)](https://github.com/affaan-m/ECC) 项目启发

---

## 什么是规则？

规则是编码标准和最佳实践的集合，用于指导代码编写和审查。

## 规则目录

### Common

**路径**: `rules/common/coding-rules.md`

**描述**: 适用于所有语言的通用编码准则

**包含内容**:
- 核心原则（可读性、DRY、防御性编程）
- 代码风格（命名规范、文件组织）
- 错误处理
- 安全准则
- 性能准则
- 测试准则
- Git 工作流

---

### TypeScript

**路径**: `rules/typescript/typescript-rules.md`

**描述**: TypeScript/JavaScript 编码准则

**包含内容**:
- 类型安全（严格模式、类型注解）
- 接口与类型
- 函数和类
- 异步代码
- React 特定规则
- ESLint 配置

**适用场景**:
- React/Next.js 项目
- Node.js 后端
- 纯 TypeScript 项目

---

### Python

**路径**: `rules/python/python-rules.md`

**描述**: Python 编码准则

**包含内容**:
- 代码风格（PEP 8）
- 类型注解
- 函数和类
- 错误处理
- 异步代码
- FastAPI 特定规则

**适用场景**:
- Web 后端（FastAPI、Django）
- 数据科学
- CLI 工具
- 自动化脚本

---

### Go

**路径**: `rules/golang/go-rules.md`

**描述**: Go 编码准则

**包含内容**:
- 代码风格（gofmt）
- 包设计
- 接口设计
- 错误处理
- 并发
- 测试

**适用场景**:
- API 服务
- 微服务
- CLI 工具
- 系统编程

---

## 使用规则

### 安装规则

```bash
# 复制需要的规则到 Codex 配置目录
mkdir -p ~/.codex/rules
cp -r rules/common ~/.codex/rules/
cp -r rules/typescript ~/.codex/rules/  # 根据需要选择
```

### 在对话中引用

```
请遵循 TypeScript 规则，确保类型安全...

根据 Go 规则，接口应该...
```

---

## 创建自定义规则

### 规则文件结构

在 `rules/` 目录下创建新的规则文件：

```
rules/
├── common/
├── typescript/
├── python/
├── golang/
└── your-language/
    └── your-language-rules.md
```

### 规则文件模板

```markdown
# [语言] 编码规则

[语言] 项目的编码准则

## 代码风格

### 命名规范
[命名规范说明]

### 文件组织
[文件组织结构]

## 核心原则

1. [原则 1]
2. [原则 2]

## 最佳实践

### [主题]
```[语言]
[代码示例]
```

## 反模式

### [反模式]
```[语言]
[不好的代码]
```

应该改为:
```[语言]
[好的代码]
```

## 工具配置

### [工具]
```[配置格式]
[配置内容]
```
```

---

## 规则最佳实践

1. **基于标准**: 参考语言官方规范
2. **具体示例**: 提供好的和坏的示例
3. **可执行**: 与 lint 工具配合
4. **一致性**: 保持风格一致
5. **持续更新**: 跟进语言演进
