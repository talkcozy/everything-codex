# TypeScript 编码规则

受 ECC 项目启发，专为 TypeScript/JavaScript 项目的编码准则。

## 类型安全

### 启用严格模式

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

### 优先使用类型而非 any

```typescript
// ❌ 避免
function process(data: any): any {
  return data.value;
}

// ✅ 推荐
interface Data<T> {
  value: T;
}

function process<T>(data: Data<T>): T {
  return data.value;
}
```

### 使用类型推断

```typescript
// ✅ 推荐 - TypeScript 能推断类型
const users = ['Alice', 'Bob']; // 类型: string[]

// ❌ 避免不必要的类型注解
const users: string[] = ['Alice', 'Bob'];
```

### 明确处理 null/undefined

```typescript
// ✅ 使用可选链和空值合并
const name = user?.profile?.name ?? 'Anonymous';

// ✅ 使用类型守卫
function process(value: string | null) {
  if (value === null) {
    return 'default';
  }
  // TypeScript 知道这里 value 是 string
  return value.toUpperCase();
}
```

## 接口与类型

### 优先使用 interface

```typescript
// ✅ 推荐 - 可扩展、更清晰
interface User {
  id: string;
  name: string;
}

// 扩展接口
interface AdminUser extends User {
  permissions: string[];
}

// 对于联合类型使用 type
type Status = 'pending' | 'active' | 'inactive';
```

### 使用 readonly

```typescript
interface Config {
  readonly apiUrl: string;
  readonly timeout: number;
}

// 或使用 Readonly<T>
function processConfig(config: Readonly<Config>) {
  // config.apiUrl = 'new'; // ❌ 编译错误
}
```

## 函数

### 使用箭头函数

```typescript
// ✅ 推荐
const add = (a: number, b: number): number => a + b;

// 对于对象方法使用常规函数
class Calculator {
  add(a: number, b: number): number {
    return a + b;
  }
}
```

### 参数解构

```typescript
// ✅ 推荐
function createUser({ name, email }: CreateUserInput): User {
  return { id: generateId(), name, email };
}

// ❌ 避免
function createUser(input: CreateUserInput): User {
  return { id: generateId(), name: input.name, email: input.email };
}
```

### 默认参数

```typescript
// ✅ 推荐
function fetchData(url: string, options: RequestOptions = {}): Promise<Data> {
  // ...
}
```

## 类

### 使用访问修饰符

```typescript
class UserService {
  private readonly repository: UserRepository;
  protected logger: Logger;

  constructor(repository: UserRepository) {
    this.repository = repository;
  }

  // 或简化写法
  // constructor(private readonly repository: UserRepository) {}
}
```

### 优先使用组合而非继承

```typescript
// ✅ 推荐 - 组合
class UserService {
  constructor(
    private readonly repository: UserRepository,
    private readonly validator: UserValidator
  ) {}
}

// ❌ 避免 - 过度继承
class UserService extends Repository<User> {}
```

## 异步代码

### 使用 async/await

```typescript
// ✅ 推荐
async function getUser(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  if (!response.ok) {
    throw new Error('Failed to fetch user');
  }
  return response.json();
}

// ❌ 避免回调地狱
fetch('/api/users/1')
  .then(r => r.json())
  .then(user => fetch(`/api/posts?userId=${user.id}`))
  .then(r => r.json())
  .then(posts => console.log(posts));
```

### 错误处理

```typescript
// ✅ 推荐
try {
  const user = await getUser(id);
  return user;
} catch (error) {
  if (error instanceof NetworkError) {
    return null;
  }
  throw error;
}
```

### Promise 类型

```typescript
// ✅ 明确返回类型
async function fetchUsers(): Promise<User[]> {
  // ...
}

// ✅ 使用 Promise.all 并行执行
const [users, posts] = await Promise.all([
  fetchUsers(),
  fetchPosts()
]);
```

## React 特定规则

### 组件类型

```typescript
// ✅ 使用 FC (Function Component)
import { FC } from 'react';

interface ButtonProps {
  label: string;
  onClick: () => void;
  disabled?: boolean;
}

export const Button: FC<ButtonProps> = ({ label, onClick, disabled }) => {
  return <button onClick={onClick} disabled={disabled}>{label}</button>;
};

// ✅ 或使用显式返回类型
export function Button({ label, onClick }: ButtonProps): JSX.Element {
  return <button onClick={onClick}>{label}</button>;
}
```

### 自定义 Hook

```typescript
// ✅ Hook 名称以 use 开头
function useUser(userId: string): UseUserReturn {
  const [user, setUser] = useState<User | null>(null);
  // ...
  return { user, loading, error };
}
```

### 事件处理

```typescript
// ✅ 使用正确的类型
import { ChangeEvent, FormEvent } from 'react';

function Form() {
  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    setValue(e.target.value);
  };

  const handleSubmit = (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    // ...
  };
}
```

## 工具配置

### ESLint 推荐配置

```json
{
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking"
  ],
  "rules": {
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error"
  }
}
```

## 文件结构

```
src/
├── components/          # React 组件
│   ├── Button/
│   │   ├── index.tsx
│   │   ├── Button.tsx
│   │   ├── Button.test.tsx
│   │   └── Button.module.css
├── hooks/              # 自定义 hooks
├── utils/              # 工具函数
├── types/              # 全局类型定义
├── services/           # API 服务
└── store/              # 状态管理
```
