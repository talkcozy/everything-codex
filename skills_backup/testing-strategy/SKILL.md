# Testing Strategy 技能

全面的测试策略规划与执行。

## 测试金字塔

```
    /\
   /  \      E2E 测试 (少量)
  /----\   
 /      \   集成测试 (中等)
/--------\
----------  单元测试 (大量)
```

## 测试类型

### 单元测试
- **目标**: 单个函数/方法
- **范围**: 隔离测试
- **速度**: 快速 (< 100ms)
- **数量**: 最多
- **工具**: Jest, pytest, go test

### 集成测试
- **目标**: 模块交互
- **范围**: 数据库、API、服务
- **速度**: 中等 (秒级)
- **数量**: 中等
- **工具**: TestContainers, Postman

### E2E 测试
- **目标**: 完整用户流程
- **范围**: 整个系统
- **速度**: 慢 (分钟级)
- **数量**: 最少
- **工具**: Playwright, Cypress

## 测试原则

### AAA 模式
```typescript
// Arrange - 准备
test('calculates total correctly', () => {
  const cart = new Cart();
  cart.addItem({ price: 10, quantity: 2 });
  
  // Act - 执行
  const total = cart.calculateTotal();
  
  // Assert - 断言
  expect(total).toBe(20);
});
```

### FIRST 原则
- **F**ast: 快速执行
- **I**ndependent: 相互独立
- **R**epeatable: 可重复执行
- **S**elf-validating: 自我验证
- **T**imely: 及时编写

## 测试策略模板

### 项目评估
```
1. 项目类型: [Web/API/CLI/Library]
2. 技术栈: [语言/框架]
3. 关键路径: [核心功能]
4. 风险点: [高风险区域]
```

### 覆盖率目标
| 层级 | 目标覆盖率 | 优先级 |
|------|-----------|--------|
| 单元测试 | 80%+ | P0 |
| 集成测试 | 60%+ | P1 |
| E2E 测试 | 核心流程 | P1 |

### 测试计划
```markdown
## [模块名称] 测试计划

### 单元测试
- [ ] [函数名] - [测试场景]
- [ ] [函数名] - [测试场景]

### 集成测试
- [ ] [功能] - [集成点]

### E2E 测试
- [ ] [用户流程] - [场景]
```
