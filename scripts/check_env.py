#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
关键词替换工具环境检查脚本
"""

import sys
import subprocess
from pathlib import Path


def print_header(text):
    print("\n" + "=" * 50)
    print(text)
    print("=" * 50)


def check_pass(msg):
    print(f"✓ {msg}")


def check_warn(msg):
    print(f"⚠ {msg}")


def check_fail(msg):
    print(f"✗ {msg}")


def check_python():
    """检查 Python 环境"""
    print("\n1. 检查 Python 环境")
    version = sys.version_info
    if version.major >= 3 and version.minor >= 8:
        check_pass(f"Python 版本: {sys.version.split()[0]}")
        return True
    else:
        check_fail(f"Python 版本过低: {sys.version.split()[0]}")
        print("   需要 Python 3.8+")
        return False


def check_uv():
    """检查 uv 是否安装"""
    print("\n2. 检查 uv 包管理器")
    try:
        result = subprocess.run(
            ["uv", "--version"],
            capture_output=True,
            text=True,
            timeout=5
        )
        if result.returncode == 0:
            check_pass(f"uv 已安装: {result.stdout.strip()}")
            return True
        else:
            check_warn("uv 未安装")
            print("   推荐安装: curl -LsSf https://astral.sh/uv/install.sh | sh")
            return False
    except (FileNotFoundError, subprocess.TimeoutExpired):
        check_warn("uv 未安装")
        print("   推荐安装: curl -LsSf https://astral.sh/uv/install.sh | sh")
        return False


def check_project():
    """检查项目是否初始化"""
    print("\n3. 检查项目配置")
    cwd = Path.cwd()
    pyproject = cwd / "pyproject.toml"

    if pyproject.exists():
        check_pass("项目已初始化 (pyproject.toml 存在)")
        return True
    else:
        check_fail("项目未初始化")
        print("   运行: uv init --no-workspace")
        return False


def check_dependencies():
    """检查 Python 依赖"""
    print("\n4. 检查 Python 依赖")
    all_ok = True

    # 检查 python-docx
    try:
        import docx
        try:
            version = docx.__version__
        except AttributeError:
            version = "已安装"
        check_pass(f"python-docx: {version}")
    except ImportError:
        check_fail("python-docx 未安装")
        print("   运行: uv add python-docx")
        all_ok = False

    # 检查 openpyxl
    try:
        import openpyxl
        try:
            version = openpyxl.__version__
        except AttributeError:
            version = "已安装"
        check_pass(f"openpyxl: {version}")
    except ImportError:
        check_fail("openpyxl 未安装")
        print("   运行: uv add openpyxl")
        all_ok = False

    # 检查 xlrd（可选）
    try:
        import xlrd
        try:
            version = xlrd.__VERSION__
        except AttributeError:
            version = "已安装"
        check_pass(f"xlrd: {version} (用于 .xls 文件转换)")
    except ImportError:
        check_warn("xlrd 未安装 (可选，用于处理 .xls 文件)")
        print("   安装: uv add xlrd")

    return all_ok


def check_system_tools():
    """检查系统工具"""
    print("\n5. 检查系统工具")

    # 检查 LibreOffice（推荐）
    soffice_found = False
    try:
        result = subprocess.run(
            ["which", "soffice"],
            capture_output=True,
            timeout=5
        )
        if result.returncode == 0:
            # 获取版本
            version_result = subprocess.run(
                ["soffice", "--version"],
                capture_output=True,
                text=True,
                timeout=5
            )
            version = version_result.stdout.strip().split('\n')[0] if version_result.returncode == 0 else ""
            check_pass(f"LibreOffice 已安装 ({version}) (用于 .doc 文件转换)")
            soffice_found = True
            return True
    except (FileNotFoundError, subprocess.TimeoutExpired):
        pass

    # 检查 libreoffice 命令
    try:
        result = subprocess.run(
            ["which", "libreoffice"],
            capture_output=True,
            timeout=5
        )
        if result.returncode == 0:
            check_pass("LibreOffice 已安装 (用于 .doc 文件转换)")
            return True
    except (FileNotFoundError, subprocess.TimeoutExpired):
        pass

    if not soffice_found:
        check_warn("LibreOffice 未安装 (推荐，用于高质量 .doc 转换)")
        print("   Ubuntu/Debian: sudo apt-get install libreoffice-writer-nogui")
        print("   CentOS/RHEL: sudo yum install libreoffice-writer")
        print("   macOS: brew install libreoffice")
        return False


def check_tool_script():
    """检查工具脚本"""
    print("\n6. 检查工具脚本")
    script_dir = Path(__file__).parent
    tool_path = script_dir / "replace_keywords.py"

    if tool_path.exists():
        check_pass(f"工具脚本存在: {tool_path}")
        return True
    else:
        check_fail(f"工具脚本不存在: {tool_path}")
        return False


def main():
    """主函数"""
    print_header("关键词替换工具 - 环境检查")

    all_ok = True

    # 运行所有检查
    all_ok &= check_python()
    uv_available = check_uv()
    all_ok &= check_project()
    all_ok &= check_dependencies()
    check_system_tools()  # 可选工具，不影响整体结果
    all_ok &= check_tool_script()

    # 总结
    print_header("检查结果")

    if all_ok:
        print("\n✅ 环境检查通过！")
        script_dir = Path(__file__).parent
        tool_path = script_dir / "replace_keywords.py"
        print(f"\n可以开始使用关键词替换工具：")
        if uv_available:
            print(f"  uv run python {tool_path} --help")
        else:
            print(f"  python3 {tool_path} --help")
        print()
        return 0
    else:
        print("\n❌ 环境检查失败")
        print("\n请按照上述提示安装缺失的依赖\n")
        return 1


if __name__ == "__main__":
    sys.exit(main())
