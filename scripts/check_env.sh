#!/bin/bash
# 关键词替换工具环境检查脚本

set -e

echo "================================================"
echo "关键词替换工具 - 环境检查"
echo "================================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 检查函数
check_pass() {
    echo -e "${GREEN}✓${NC} $1"
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
}

# 1. 检查 Python
echo "1. 检查 Python 环境"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    check_pass "Python 已安装: $PYTHON_VERSION"
else
    check_fail "Python 未安装"
    echo "   请安装 Python 3.8+"
    exit 1
fi

# 2. 检查 uv
echo ""
echo "2. 检查 uv 包管理器"
if command -v uv &> /dev/null; then
    UV_VERSION=$(uv --version)
    check_pass "uv 已安装: $UV_VERSION"
    UV_AVAILABLE=true
else
    check_warn "uv 未安装"
    echo "   推荐安装: curl -LsSf https://astral.sh/uv/install.sh | sh"
    UV_AVAILABLE=false
fi

# 3. 检查项目是否初始化
echo ""
echo "3. 检查项目配置"
if [ -f "pyproject.toml" ]; then
    check_pass "项目已初始化 (pyproject.toml 存在)"
else
    check_fail "项目未初始化"
    echo "   运行: uv init --no-workspace"
    exit 1
fi

# 4. 检查依赖
echo ""
echo "4. 检查 Python 依赖"

# 检查 python-docx
if python3 -c "import docx" 2>/dev/null; then
    DOCX_VERSION=$(python3 -c "import docx; print(docx.__version__)" 2>/dev/null || echo "已安装")
    check_pass "python-docx: $DOCX_VERSION"
else
    check_fail "python-docx 未安装"
    echo "   运行: uv add python-docx"
    MISSING_DEPS=true
fi

# 检查 openpyxl
if python3 -c "import openpyxl" 2>/dev/null; then
    OPENPYXL_VERSION=$(python3 -c "import openpyxl; print(openpyxl.__version__)" 2>/dev/null || echo "已安装")
    check_pass "openpyxl: $OPENPYXL_VERSION"
else
    check_fail "openpyxl 未安装"
    echo "   运行: uv add openpyxl"
    MISSING_DEPS=true
fi

# 5. 检查工具脚本
echo ""
echo "5. 检查工具脚本"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOL_PATH="$SCRIPT_DIR/replace_keywords.py"

if [ -f "$TOOL_PATH" ]; then
    check_pass "工具脚本存在: $TOOL_PATH"
    if [ -x "$TOOL_PATH" ]; then
        check_pass "工具脚本可执行"
    else
        check_warn "工具脚本不可执行（不影响使用）"
        echo "   运行: chmod +x $TOOL_PATH"
    fi
else
    check_fail "工具脚本不存在: $TOOL_PATH"
    exit 1
fi

# 6. 总结
echo ""
echo "================================================"
if [ "$MISSING_DEPS" = true ]; then
    echo -e "${RED}环境检查失败${NC}"
    echo ""
    echo "请运行以下命令安装缺失的依赖："
    echo "  uv add python-docx openpyxl"
    echo ""
    exit 1
else
    echo -e "${GREEN}环境检查通过！${NC}"
    echo ""
    echo "可以开始使用关键词替换工具："
    echo "  uv run python $TOOL_PATH --help"
    echo ""
fi
echo "================================================"
