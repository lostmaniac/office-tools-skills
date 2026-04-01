#!/bin/bash
# Office Tools - 独立安装脚本
# 支持技能独立部署到任何环境

set -e

echo "=================================================="
echo "Office Tools 技能 - 独立安装"
echo "=================================================="

# 获取脚本所在目录（技能目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "安装目录: $SCRIPT_DIR"
echo ""

# 检测操作系统
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    if command -v apt-get &> /dev/null; then
        PKG_MANAGER="apt-get"
    elif command -v yum &> /dev/null; then
        PKG_MANAGER="yum"
    else
        echo "❌ 不支持的包管理器"
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    if ! command -v brew &> /dev/null; then
        echo "❌ 请先安装 Homebrew: https://brew.sh"
        exit 1
    fi
    PKG_MANAGER="brew"
else
    echo "❌ 不支持的操作系统: $OSTYPE"
    exit 1
fi

echo "检测到操作系统: $OS ($PKG_MANAGER)"
echo ""

# 步骤 1: 安装系统工具
echo "=================================================="
echo "步骤 1/3: 安装系统工具"
echo "=================================================="

if [ "$PKG_MANAGER" = "apt-get" ]; then
    echo "更新软件包列表..."
    sudo apt-get update -q

    echo "安装 LibreOffice..."
    sudo apt-get install -y libreoffice-writer-nogui

    echo "安装 antiword（可选）..."
    sudo apt-get install -y antiword
elif [ "$PKG_MANAGER" = "yum" ]; then
    echo "安装 LibreOffice..."
    sudo yum install -y libreoffice-writer

    echo "安装 antiword（可选）..."
    sudo yum install -y antiword
elif [ "$PKG_MANAGER" = "brew" ]; then
    echo "安装 LibreOffice..."
    brew install libreoffice

    echo "安装 antiword（可选）..."
    brew install antiword
fi

echo "✓ 系统工具安装完成"
echo ""

# 步骤 2: 安装 uv
echo "=================================================="
echo "步骤 2/3: 安装 uv 包管理器"
echo "=================================================="

if ! command -v uv &> /dev/null; then
    echo "安装 uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"
else
    echo "✓ uv 已安装: $(uv --version)"
fi

echo ""

# 步骤 3: 安装 Python 依赖
echo "=================================================="
echo "步骤 3/3: 安装 Python 依赖"
echo "=================================================="

# 使用技能目录内的 pyproject.toml
if [ -f "pyproject.toml" ]; then
    echo "从 pyproject.toml 安装依赖..."
    uv sync
    echo "✓ Python 依赖安装完成"
else
    echo "❌ 未找到 pyproject.toml"
    exit 1
fi

echo ""

# 验证安装
echo "=================================================="
echo "验证安装"
echo "=================================================="

if [ -f "check_env.py" ]; then
    uv run python check_env.py
else
    echo "⚠️  环境检查脚本不存在"
fi

echo ""
echo "=================================================="
echo "✅ 安装完成！"
echo "=================================================="
echo ""
echo "技能已安装到: $SCRIPT_DIR"
echo ""
echo "使用方式："
echo ""
echo "  # 在技能目录内运行"
echo "  cd $SCRIPT_DIR"
echo "  uv run python replace_tool.py <文件或目录> --replace \"旧=新\""
echo ""
echo "  # 或从任何地方运行"
echo "  uv run python $SCRIPT_DIR/replace_tool.py <文件或目录> --replace \"旧=新\""
echo ""
echo "查看帮助："
echo "  uv run python replace_tool.py --help"
echo ""
