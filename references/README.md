# Office Tools

<div align="center">

**🚀 Office 文档批量处理工具集**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)
[![Claude Code](https://img.shields.io/badge/Claude_Code-Skill-green.svg)](https://claude.com/claude-code)

[功能特性](#功能特性) • [快速开始](#快速开始) • [安装](#安装) • [使用示例](#使用示例) • [API 文档](#api-文档)

</div>

---

## 简介

**Office Tools** 是一个强大的 Office 文档批量处理工具集，专为 Claude Code 设计。它可以轻松处理 Word 和 Excel 文档中的关键词替换，支持新旧格式自动转换。

### 核心功能

- ✅ **批量替换** - 在多个文档中批量替换关键词
- ✅ **格式保留** - 完整保留文档格式、表格、样式
- ✅ **自动转换** - 自动转换 .doc → .docx, .xls → .xlsx
- ✅ **跨平台** - 支持 Windows、macOS、Linux
- ✅ **独立部署** - 可独立运行，无需依赖外部项目
- ✅ **备份保护** - 自动创建 .bak 备份文件

## 功能特性

### 支持的文件格式

| 格式 | 扩展名 | 状态 | 说明 |
|------|--------|------|------|
| Word 文档 | .docx | ✅ 完全支持 | 保留所有格式 |
| Word 旧版 | .doc | ✅ 自动转换 | 使用 LibreOffice 高质量转换 |
| Excel 工作簿 | .xlsx | ✅ 完全支持 | 支持所有工作表 |
| Excel 旧版 | .xls | ✅ 自动转换 | 使用 xlrd 读取并转换 |

### 技术亮点

- 🎯 **高精度转换** - 使用 LibreOffice 确保格式完美保留
- ⚡ **高性能** - 支持批量处理大量文件
- 🔒 **安全可靠** - 自动备份，预览模式
- 📦 **零依赖** - 包含所有依赖配置，开箱即用
- 🛠️ **易扩展** - 模块化设计，易于添加新功能

## 快速开始

### 使用 Claude Code 安装（推荐）

```bash
# 在 Claude Code 中直接运行
/office-tools 安装
```

### 手动安装

```bash
# 1. 克隆仓库
git clone https://github.com/your-username/office-tools.git
cd office-tools

# 2. 运行安装脚本
bash install.sh

# 3. 验证安装
uv run python check_env.py
```

### 基本使用

```bash
# 替换单个文件中的关键词
uv run python replace_tool.py document.docx --replace "旧文本=新文本"

# 批量处理目录
uv run python replace_tool.py ./docs --replace "旧=新" --recursive

# 预览模式（不实际修改）
uv run python replace_tool.py file.xlsx --replace "旧=新" --dry-run
```

## 安装

### 系统要求

| 组件 | 版本要求 | 必需 |
|------|---------|------|
| Python | >= 3.9 | ✅ |
| LibreOffice | 任意 | ✅ |
| uv | 最新 | ✅ |
| antiword | 任意 | ⚠️ 可选 |

### Ubuntu/Debian

```bash
# 安装系统依赖
sudo apt-get update
sudo apt-get install -y libreoffice-writer-nogui antiword

# 安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 克隆并安装
git clone https://github.com/your-username/office-tools.git
cd office-tools
bash install.sh
```

### macOS

```bash
# 安装 Homebrew（如果未安装）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装系统依赖
brew install libreoffice antiword

# 安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 克隆并安装
git clone https://github.com/your-username/office-tools.git
cd office-tools
bash install.sh
```

### Windows

```powershell
# 安装 LibreOffice
# 从 https://www.libreoffice.org/ 下载并安装

# 安装 uv
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"

# 克隆并安装
git clone https://github.com/your-username/office-tools.git
cd office-tools
bash install.sh  # 使用 Git Bash 或 WSL
```

## 使用示例

### 示例 1：替换单个文件

```bash
uv run python replace_tool.py ISO27001.docx --replace "2024=2025"
```

### 示例 2：多个替换规则

```bash
uv run python replace_tool.py document.docx \
  --replace "某某公司=新公司" \
  --replace "2024=2025" \
  --replace "暂定=正式"
```

### 示例 3：批量处理目录

```bash
uv run python replace_tool.py ./documents \
  --replace "旧术语=新术语" \
  --recursive
```

### 示例 4：预览模式

```bash
uv run python replace_tool.py report.xlsx \
  --replace "draft=final" \
  --dry-run
```

### 示例 5：处理旧格式文件

```bash
# 自动转换 .doc 并替换
uv run python replace_tool.py old_document.doc --replace "旧=新"

# 自动转换 .xls 并替换
uv run python replace_tool.py old_sheet.xls --replace "旧=新"
```

## 命令行选项

| 选项 | 简写 | 说明 |
|------|------|------|
| `--replace OLD=NEW` | `-r` | 替换规则（可多次使用） |
| `--recursive` | `-R` | 递归处理子目录 |
| `--dry-run` | `-n` | 预览模式，不实际修改 |
| `--no-backup` | - | 不创建备份文件 |
| `--no-convert` | - | 不自动转换旧格式文件 |

## 在 Claude Code 中使用

### 安装技能

```bash
# 方式 1：从 GitHub 安装
/office-tools 安装 https://github.com/your-username/office-tools

# 方式 2：从本地目录安装
/office-tools 安装 /path/to/office-tools
```

### 使用技能

```bash
# 替换关键词
/office-tools 把 document.docx 里的"2024"替换成"2025"

# 批量替换
/office-tools 把 docs 目录下的"某某公司"改成"新公司"

# 预览替换效果
/office-tools 预览替换 report.xlsx 中的"draft"为"final"
```

## 输出示例

```
替换规则: 2 条
  '某某公司' → '新公司'
  '2024' → '2025'

处理: /path/to/file.doc
  → 自动转换 .doc → .docx
  ✓ 已转换为: /path/to/file.docx
  ✓ 备份: /path/to/file.docx.bak
  ✓ 替换 15 处

==================================================
处理摘要
==================================================
处理文件数: 1
跳过文件数: 0
转换文件数: 1
总替换次数: 15
==================================================
```

## API 文档

### Python API

```python
from office_tools import ReplaceTool

# 创建替换工具
tool = ReplaceTool(dry_run=False, backup=True)

# 替换单个文件
count = tool.replace_in_file('document.docx', {'旧': '新'})

# 批量处理目录
tool.replace_in_directory(
    './docs',
    replacements={'旧': '新'},
    recursive=True
)

# 打印统计
tool.print_summary()
```

详细的 API 文档请参阅 [API.md](docs/API.md)。

## 项目结构

```
office-tools/
├── pyproject.toml           # Python 项目配置
├── uv.lock                  # 依赖版本锁定
├── LICENSE                  # MIT 许可证
├── README.md                # 本文件
├── README.md                # 快速参考
├── DEPLOY.md                # 部署指南
├── office-tools.md          # Claude Code 技能定义
├── install.sh               # 一键安装脚本
├── replace_tool.py          # 主工具脚本
├── check_env.py             # 环境检查
├── check_env.sh             # Shell 环境检查
└── office-tools-launcher    # 快速启动脚本
```

## 贡献指南

我们欢迎所有形式的贡献！

### 如何贡献

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

### 开发指南

```bash
# 1. Fork 并克隆仓库
git clone https://github.com/your-username/office-tools.git
cd office-tools

# 2. 创建虚拟环境
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# 3. 安装开发依赖
uv sync

# 4. 运行测试
uv run pytest

# 5. 代码格式化
black .
ruff check .
```

详细的贡献指南请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 常见问题

### Q: LibreOffice 转换很慢怎么办？

A: LibreOffice 首次启动时较慢，后续会使用缓存。可以增加内存或使用 SSD 加速。

### Q: 能否在 Docker 中使用？

A: 可以！参考 [DEPLOY.md](DEPLOY.md) 中的 Docker 部署方案。

### Q: 如何处理超大文件？

A: 对于超大文件，建议：
1. 使用 `--dry-run` 预览
2. 分批处理
3. 增加系统内存

### Q: 转换后格式有变化？

A: LibreOffice 转换质量很高，但复杂文档可能有细微差异。建议预览后确认。

更多问题请参阅 [FAQ.md](docs/FAQ.md)。

## 路线图

- [ ] v1.1 - 支持 PowerPoint (.ppt, .pptx)
- [ ] v1.2 - 批量格式转换工具
- [ ] v1.3 - 文档合并工具
- [ ] v1.4 - 批量水印添加/删除
- [ ] v2.0 - 图形化界面

查看完整的路线图：[ROADMAP.md](ROADMAP.md)

## 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 致谢

- [python-docx](https://python-docx.readthedocs.io/) - Word 文档处理
- [openpyxl](https://openpyxl.readthedocs.io/) - Excel 文档处理
- [LibreOffice](https://www.libreoffice.org/) - 文档格式转换
- [uv](https://github.com/astral-sh/uv) - 快速 Python 包管理器

## 联系方式

- GitHub Issues: [https://github.com/your-username/office-tools/issues](https://github.com/your-username/office-tools/issues)
- Discussions: [https://github.com/your-username/office-tools/discussions](https://github.com/your-username/office-tools/discussions)

---

<div align="center">

**如果这个项目对你有帮助，请给个 ⭐️ Star！**

Made with ❤️ by Claude Code Community

</div>
