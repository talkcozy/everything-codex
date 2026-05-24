# Python 编码规则

受 ECC 项目启发，专为 Python 项目的编码准则。

## 代码风格

### 遵循 PEP 8

```python
# ✅ 正确示例
class UserService:
    MAX_RETRIES = 3  # 常量全大写

    def __init__(self, repository: UserRepository) -> None:
        self._repository = repository  # 私有属性前缀 _

    def get_user(self, user_id: str) -> User | None:
        """根据 ID 获取用户。"""
        return self._repository.find_by_id(user_id)

# ❌ 错误示例
class userService:  # 类名应为 PascalCase
    maxRetries = 3  # 常量应全大写

    def GetUser(self, userId):  # 函数名应为 snake_case
        return self.__repo.Find(userId)
```

### 导入排序

```python
# ✅ 标准库
import os
import sys
from typing import Optional

# ✅ 第三方库
import requests
from fastapi import FastAPI

# ✅ 本地模块
from .models import User
from .services import UserService
```

## 类型注解

### 强制使用类型注解

```python
from typing import Optional, List, Dict, Callable

def process_users(
    users: List[User],
    filter_fn: Callable[[User], bool],
    limit: Optional[int] = None
) -> Dict[str, User]:
    """处理用户列表并返回映射。"""
    result: Dict[str, User] = {}
    for user in users:
        if filter_fn(user):
            result[user.id] = user
        if limit and len(result) >= limit:
            break
    return result
```

### 泛型类型

```python
from typing import TypeVar, Generic

T = TypeVar('T')

class Repository(Generic[T]):
    def __init__(self) -> None:
        self._items: Dict[str, T] = {}

    def add(self, item_id: str, item: T) -> None:
        self._items[item_id] = item

    def get(self, item_id: str) -> T | None:
        return self._items.get(item_id)
```

## 函数和类

### 函数设计

```python
from dataclasses import dataclass

@dataclass
class CreateUserInput:
    name: str
    email: str
    age: int | None = None

def create_user(input_data: CreateUserInput) -> User:
    """创建新用户。

    Args:
        input_data: 用户创建输入数据

    Returns:
        创建的用户对象

    Raises:
        ValidationError: 当输入数据无效时
        DuplicateError: 当邮箱已存在时
    """
    if not validate_email(input_data.email):
        raise ValidationError(f"Invalid email: {input_data.email}")

    # 实现...
```

### 类设计

```python
from abc import ABC, abstractmethod

class NotificationService(ABC):
    """通知服务抽象基类。"""

    @abstractmethod
    def send(self, message: str, recipient: str) -> None:
        """发送通知。"""
        pass

class EmailNotificationService(NotificationService):
    def __init__(self, smtp_host: str, smtp_port: int = 587) -> None:
        self._smtp_host = smtp_host
        self._smtp_port = smtp_port

    def send(self, message: str, recipient: str) -> None:
        # 实现邮件发送
        pass
```

## 错误处理

### 自定义异常

```python
class AppError(Exception):
    """应用基础异常。"""
    def __init__(self, message: str, code: str) -> None:
        super().__init__(message)
        self.code = code
        self.message = message

class ValidationError(AppError):
    """验证错误。"""
    def __init__(self, message: str) -> None:
        super().__init__(message, code="VALIDATION_ERROR")

class NotFoundError(AppError):
    """资源不存在错误。"""
    def __init__(self, resource: str, identifier: str) -> None:
        message = f"{resource} with id '{identifier}' not found"
        super().__init__(message, code="NOT_FOUND")
```

### 异常处理

```python
def fetch_user(user_id: str) -> User:
    try:
        response = requests.get(f"/api/users/{user_id}")
        response.raise_for_status()
        return User(**response.json())
    except requests.HTTPError as e:
        if e.response.status_code == 404:
            raise NotFoundError("User", user_id)
        raise AppError(f"Failed to fetch user: {e}", "HTTP_ERROR")
    except requests.RequestException as e:
        raise AppError(f"Network error: {e}", "NETWORK_ERROR")
```

## 异步代码

### async/await

```python
import asyncio
from aiohttp import ClientSession

async def fetch_users(session: ClientSession) -> List[User]:
    """异步获取用户列表。"""
    async with session.get("/api/users") as response:
        data = await response.json()
        return [User(**item) for item in data]

async def main():
    async with ClientSession() as session:
        users = await fetch_users(session)
        tasks = [process_user(session, user) for user in users]
        await asyncio.gather(*tasks)

# 运行
asyncio.run(main())
```

## FastAPI 特定规则

### 路由定义

```python
from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

router = APIRouter(prefix="/users", tags=["users"])

class CreateUserRequest(BaseModel):
    name: str
    email: str

    class Config:
        json_schema_extra = {
            "example": {
                "name": "John Doe",
                "email": "john@example.com"
            }
        }

@router.post("", response_model=UserResponse, status_code=201)
async def create_user(
    request: CreateUserRequest,
    service: UserService = Depends(get_user_service)
) -> User:
    """创建新用户。"""
    try:
        return await service.create(request)
    except DuplicateError as e:
        raise HTTPException(status_code=409, detail=str(e))
```

### 依赖注入

```python
from typing import Annotated
from fastapi import Depends

async def get_current_user(
    token: Annotated[str, Depends(oauth2_scheme)]
) -> User:
    """获取当前认证用户。"""
    user = await verify_token(token)
    if not user:
        raise HTTPException(status_code=401, detail="Invalid token")
    return user

@router.get("/me")
async def get_me(
    current_user: Annotated[User, Depends(get_current_user)]
) -> User:
    """获取当前登录用户信息。"""
    return current_user
```

## 测试

### pytest

```python
import pytest
from unittest.mock import Mock, patch

@pytest.fixture
def user_repository():
    return Mock(spec=UserRepository)

@pytest.fixture
def user_service(user_repository):
    return UserService(user_repository)

class TestUserService:
    def test_get_user_exists(self, user_service, user_repository):
        # Arrange
        expected_user = User(id="1", name="John")
        user_repository.find_by_id.return_value = expected_user

        # Act
        result = user_service.get_user("1")

        # Assert
        assert result == expected_user
        user_repository.find_by_id.assert_called_once_with("1")

    def test_get_user_not_found(self, user_service, user_repository):
        user_repository.find_by_id.return_value = None

        with pytest.raises(NotFoundError):
            user_service.get_user("999")
```

## 项目结构

```
project/
├── app/
│   ├── __init__.py
│   ├── main.py              # FastAPI 应用入口
│   ├── api/
│   │   ├── __init__.py
│   │   ├── deps.py          # 依赖注入
│   │   └── v1/
│   │       ├── __init__.py
│   │       └── users.py     # 路由
│   ├── core/
│   │   ├── config.py        # 配置
│   │   └── exceptions.py    # 异常定义
│   ├── models/
│   │   └── user.py          # 数据模型
│   ├── schemas/
│   │   └── user.py          # Pydantic 模型
│   ├── services/
│   │   └── user.py          # 业务逻辑
│   └── db/
│       └── repository.py    # 数据访问
├── tests/
│   ├── conftest.py          # pytest 配置
│   └── test_users.py
├── pyproject.toml
└── requirements.txt
```

## 工具配置

### pyproject.toml

```toml
[tool.black]
line-length = 88
target-version = ['py311']

[tool.isort]
profile = "black"
multi_line_output = 3

[tool.mypy]
python_version = "3.11"
strict = true
warn_return_any = true
warn_unused_configs = true

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
addopts = "-v --tb=short"
```
