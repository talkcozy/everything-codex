#!/bin/bash
# Everything Codex 安装脚本
# 受 ECC 项目启发

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  Everything Codex 安装脚本${NC}"
echo -e "${GREEN}=====================================${NC}"
echo

# 检查 Codex 是否安装
if ! command -v codex &> /dev/null; then
    echo -e "${RED}错误: Codex CLI 未安装${NC}"
    echo "请先安装 Codex: https://github.com/openai/codex"
    exit 1
fi

echo -e "${GREEN}✓ Codex CLI 已安装${NC}"

# 创建配置目录
echo
echo "创建配置目录..."
mkdir -p ~/.codex/agents
mkdir -p ~/.codex/skills

echo -e "${GREEN}✓ 配置目录已创建${NC}"

# 备份现有配置
if [ -f ~/.codex/config.toml ]; then
    echo
    echo "备份现有配置..."
    cp ~/.codex/config.toml ~/.codex/config.toml.backup.$(date +%Y%m%d_%H%M%S)
    echo -e "${GREEN}✓ 现有配置已备份${NC}"
fi

# 复制配置文件
echo
echo "安装配置文件..."
cp .codex/config.toml ~/.codex/config.toml
cp -r .codex/agents/* ~/.codex/agents/

echo -e "${GREEN}✓ 配置文件已安装${NC}"

# 可选：复制技能
read -p "是否安装技能模块? (y/N): " install_skills
if [[ $install_skills =~ ^[Yy]$ ]]; then
    cp -r skills/* ~/.codex/skills/ 2>/dev/null || true
    echo -e "${GREEN}✓ 技能模块已安装${NC}"
fi

# 验证安装
echo
echo "验证安装..."
if codex config > /dev/null 2>&1; then
    echo -e "${GREEN}✓ 配置验证成功${NC}"
else
    echo -e "${YELLOW}⚠ 配置验证失败，请检查配置文件${NC}"
fi

# 列出可用智能体
echo
echo -e "${GREEN}可用智能体:${NC}"
ls ~/.codex/agents/*.toml 2>/dev/null | xargs -n1 basename -s .toml | sed 's/^/  - /'

# 完成
echo
echo -e "${GREEN}=====================================${NC}"
echo -e "${GREEN}  安装完成!${NC}"
echo -e "${GREEN}=====================================${NC}"
echo
echo "快速开始:"
echo "  codex --agent explorer '分析代码库'"
echo "  codex --agent reviewer '审查代码'"
echo
echo "查看完整文档: https://github.com/talkcozy/everything-codex"
