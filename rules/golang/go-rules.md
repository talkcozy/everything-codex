# Go 编码规则

受 ECC 项目启发，专为 Go 项目的编码准则。

## 代码风格

### 遵循 gofmt

所有 Go 代码必须通过 `gofmt` 格式化：

```bash
gofmt -w .
goimports -w .
```

### 命名规范

```go
// ✅ 推荐 - Go 命名规范

// 包名：小写，简短，有意义
package user

// 接口：描述行为，-er 后缀或名词
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Storage interface {
    Get(id string) (*User, error)
}

// 结构体：PascalCase
type UserService struct {
    repository UserRepository  // 字段名：有语义
}

// 函数：描述动作，动词开头
func GetUserByID(ctx context.Context, id string) (*User, error)
func (s *UserService) CreateUser(ctx context.Context, input CreateUserInput) (*User, error)

// 常量：CamelCase 或 ALL_CAPS（仅当需要与外部系统匹配时）
const maxRetries = 3
const DefaultTimeout = 30 * time.Second
const APIVersion = "v1"

// 变量：CamelCase
var defaultClient = &http.Client{Timeout: 30 * time.Second}
```

## 包设计

### 包命名

```go
// ✅ 简短、描述性
package user      // 而非 userservice
package httputil  // 而非 http_utility

// ✅ 避免冲突
import "github.com/pkg/errors"  // 而非 import errors
import myerrors "github.com/pkg/errors"
```

### 包结构

```
project/
├── cmd/                    # 可执行文件
│   ├── server/
│   │   └── main.go
│   └── cli/
│       └── main.go
├── internal/               # 私有代码
│   ├── user/
│   │   ├── service.go
│   │   ├── repository.go
│   │   └── model.go
│   └── middleware/
├── pkg/                    # 公共库
│   ├── validator/
│   └── logger/
├── api/                    # API 定义
│   └── proto/
├── configs/                # 配置文件
├── scripts/                # 构建脚本
├── go.mod
└── README.md
```

## 接口设计

### 接口在消费者端定义

```go
// ✅ 推荐 - 接口由消费者定义
package main

// Storage 由使用者定义
type Storage interface {
    Get(id string) (*User, error)
    Save(u *User) error
}

func ProcessUsers(store Storage) error {
    // ...
}

// 实现可以在任何包
```

### 接口要小

```go
// ✅ 小而专注的接口
type Reader interface {
    Read(p []byte) (n int, err error)
}

type Writer interface {
    Write(p []byte) (n int, err error)
}

// 组合小接口
type ReadWriter interface {
    Reader
    Writer
}
```

## 错误处理

### 错误类型

```go
package errors

import "fmt"

// ✅ 定义具体错误类型
type NotFoundError struct {
    Resource string
    ID       string
}

func (e *NotFoundError) Error() string {
    return fmt.Sprintf("%s with id '%s' not found", e.Resource, e.ID)
}

// ✅ 使用 errors.Is 检查
var ErrInvalidInput = errors.New("invalid input")

// 使用示例
func GetUser(ctx context.Context, id string) (*User, error) {
    user, err := repo.Find(ctx, id)
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return nil, &NotFoundError{Resource: "User", ID: id}
        }
        return nil, fmt.Errorf("failed to get user: %w", err)
    }
    return user, nil
}

// 检查错误
if _, err := service.GetUser(ctx, "123"); err != nil {
    if notFound := new(errors.NotFoundError); errors.As(err, &notFound) {
        // 处理 404
    }
}
```

### 错误包装

```go
// ✅ 使用 fmt.Errorf 包装错误
if err := doSomething(); err != nil {
    return fmt.Errorf("failed to initialize service: %w", err)
}

// ❌ 不要丢失原始错误
if err := doSomething(); err != nil {
    return errors.New("failed to initialize service")  // 丢失原始错误
}
```

## 并发

### Context 使用

```go
// ✅ 始终传递 context.Context
func (s *Service) Process(ctx context.Context, id string) error {
    ctx, cancel := context.WithTimeout(ctx, 30*time.Second)
    defer cancel()

    user, err := s.repo.Get(ctx, id)
    if err != nil {
        return err
    }

    // 使用 ctx 进行下游调用
    return s.processor.Process(ctx, user)
}

// 调用时
ctx := context.Background()
if err := service.Process(ctx, "user-123"); err != nil {
    // 处理错误
}
```

### Goroutine 安全

```go
// ✅ 避免竞态条件
type Counter struct {
    mu    sync.RWMutex
    value int64
}

func (c *Counter) Inc() {
    c.mu.Lock()
    defer c.mu.Unlock()
    c.value++
}

func (c *Counter) Value() int64 {
    c.mu.RLock()
    defer c.mu.RUnlock()
    return c.value
}

// ✅ 使用 channel 通信
type Worker struct {
    jobs    chan Job
    results chan Result
}

func (w *Worker) Start() {
    go func() {
        for job := range w.jobs {
            result := process(job)
            w.results <- result
        }
    }()
}
```

## 结构体和方法

### 值接收者 vs 指针接收者

```go
// ✅ 小结构体使用值接收者（<= 16 bytes）
type Point struct {
    X, Y float64
}

func (p Point) Distance(q Point) float64 {
    return math.Hypot(p.X-q.X, p.Y-q.Y)
}

// ✅ 可变或大结构体使用指针接收者
type Buffer struct {
    data []byte
    off  int
}

func (b *Buffer) Write(p []byte) (n int, err error) {
    // 修改接收者
    b.data = append(b.data, p...)
    return len(p), nil
}

// ✅ 一致性：如果某个方法需要指针，所有方法都用指针
type UserService struct {
    repo Repository
}

func (s *UserService) Get(id string) (*User, error)  // 指针
func (s *UserService) Save(u *User) error           // 指针
```

### 构造函数

```go
// ✅ 使用 New 函数
func NewUserService(repo UserRepository) (*UserService, error) {
    if repo == nil {
        return nil, errors.New("repository is required")
    }
    return &UserService{repo: repo}, nil
}

// ✅ 配置选项模式
func NewServer(opts ...Option) *Server {
    s := &Server{
        addr: ":8080",
        timeout: 30 * time.Second,
    }
    for _, opt := range opts {
        opt(s)
    }
    return s
}

type Option func(*Server)

func WithAddr(addr string) Option {
    return func(s *Server) {
        s.addr = addr
    }
}

// 使用
server := NewServer(WithAddr(":9090"))
```

## 测试

### 表驱动测试

```go
func TestValidateEmail(t *testing.T) {
    tests := []struct {
        name    string
        email   string
        wantErr bool
    }{
        {"valid", "user@example.com", false},
        {"no @", "userexample.com", true},
        {"empty", "", true},
        {"multiple @", "user@@example.com", true},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            err := ValidateEmail(tt.email)
            if (err != nil) != tt.wantErr {
                t.Errorf("ValidateEmail(%q) error = %v, wantErr %v",
                    tt.email, err, tt.wantErr)
            }
        })
    }
}
```

### Mock 和依赖注入

```go
// ✅ 使用接口进行测试

type UserRepository interface {
    Get(ctx context.Context, id string) (*User, error)
}

// 生产实现
type SQLUserRepository struct {
    db *sql.DB
}

// Mock 实现
type MockUserRepository struct {
    mock.Mock
}

func (m *MockUserRepository) Get(ctx context.Context, id string) (*User, error) {
    args := m.Called(ctx, id)
    return args.Get(0).(*User), args.Error(1)
}

// 测试
func TestServiceGetUser(t *testing.T) {
    mockRepo := new(MockUserRepository)
    service := NewUserService(mockRepo)

    expected := &User{ID: "1", Name: "John"}
    mockRepo.On("Get", mock.Anything, "1").Return(expected, nil)

    user, err := service.GetUser(context.Background(), "1")
    assert.NoError(t, err)
    assert.Equal(t, expected, user)

    mockRepo.AssertExpectations(t)
}
```

## 文档

### Godoc

```go
// Package user provides user management functionality.
//
// This package handles user registration, authentication,
// and profile management.
package user

// User represents a user in the system.
type User struct {
    ID        string    `json:"id"`
    Email     string    `json:"email"`
    CreatedAt time.Time `json:"created_at"`
}

// GetUserByID retrieves a user by their unique identifier.
//
// If the user is not found, it returns a NotFoundError.
// Returns an error if the database connection fails.
func (s *Service) GetUserByID(ctx context.Context, id string) (*User, error) {
    // ...
}
```

## 工具配置

### .golangci.yml

```yaml
linters:
  enable:
    - gofmt
    - golint
    - govet
    - errcheck
    - staticcheck
    - gosimple
    - ineffassign
    - typecheck
    - unused
    - misspell
    - gosec

linters-settings:
  govet:
    check-shadowing: true
  gocyclo:
    min-complexity: 15
  maligned:
    suggest-new: true

issues:
  exclude-use-default: false
```
