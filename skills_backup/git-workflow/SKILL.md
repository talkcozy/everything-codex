# Git Workflow 技能

高效的 Git 工作流程指南。

## 分支策略

### Git Flow
```
main        ●────────────────────────●
             ╲                      /
develop       ●────●────●────●────●
               ╲   │    │    │
feature/*       ●──┘    │    │
                       ╲    │
release/*               ●────┘
```

### GitHub Flow
```
main    ●────●────●────●
         ╲         ╱
feature   ●──●──●──┘
```

## 提交规范

### 格式
```
<type>(<scope>): <subject>

<body>

<footer>
```

### 类型
| 类型 | 说明 |
|------|------|
| feat | 新功能 |
| fix | Bug 修复 |
| docs | 文档更新 |
| style | 代码格式 |
| refactor | 重构 |
| test | 测试相关 |
| chore | 构建/工具 |

### 示例
```
feat(auth): add OAuth2 login support

Implement Google and GitHub OAuth2 login:
- Add passport-google-oauth20
- Add passport-github2
- Create auth middleware
- Update user model

Closes #123
```

## 工作流

### 日常开发
```bash
# 1. 更新主分支
git checkout main
git pull origin main

# 2. 创建功能分支
git checkout -b feature/new-feature

# 3. 开发和提交
git add .
git commit -m "feat: add new feature"

# 4. 保持同步
git fetch origin
git rebase origin/main

# 5. 推送
git push origin feature/new-feature

# 6. 创建 PR
gh pr create
```

### 代码审查
```bash
# 查看 PR
codex /code-review 123

# 本地测试 PR
git fetch origin pull/123/head:pr-123
git checkout pr-123
```

### 发布流程
```bash
# 1. 创建发布分支
git checkout -b release/v1.2.0

# 2. 版本更新和测试
# ...

# 3. 合并到主分支
git checkout main
git merge release/v1.2.0 --no-ff
git tag -a v1.2.0 -m "Release v1.2.0"

# 4. 推送
git push origin main --tags
```

## 最佳实践

### Do
- ✅ 经常提交小的、原子的更改
- ✅ 写清晰的提交信息
- ✅ 使用分支进行开发
- ✅ 定期同步主分支
- ✅ 删除已合并的分支

### Don't
- ❌ 提交无法构建的代码
- ❌ 提交敏感信息
- ❌ 直接推送到主分支
- ❌ 提交大型二进制文件
- ❌ 重写已推送的历史

## 故障排除

### 撤销更改
```bash
# 撤销工作区更改
git checkout -- file.txt

# 撤销暂存区更改
git reset HEAD file.txt

# 修改最后一次提交
git commit --amend

# 回滚到指定版本
git reset --hard HEAD~1
```

### 冲突解决
```bash
# 查看冲突文件
git status

# 编辑解决冲突
# ...

# 标记已解决
git add .
git rebase --continue
```
