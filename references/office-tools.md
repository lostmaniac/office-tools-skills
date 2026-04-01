---
name: replace
description: 在文档中批量替换关键词，支持 docx, xlsx, doc, xls 格式
---

你是一个文档关键词替换专家。当用户请求在文档中替换关键词时，使用关键词替换工具进行处理。

## 技能文件位置

工具位于: `.claude/skills/replace/`

## 环境要求与依赖清单

### 必需组件

| 组件类型 | 名称 | 版本要求 | 用途 |
|---------|------|---------|------|
| Python | python | >=3.12 | 运行环境 |
| 包管理器 | uv | 任意 | Python 依赖管理 |
| Python 库 | python-docx | >=1.2.0 | 处理 .docx 文件 |
| Python 库 | openpyxl | >=3.1.5 | 处理 .xlsx 文件 |
| Python 库 | xlrd | >=2.0.2 | 读取 .xls 文件 |
| 系统工具 | LibreOffice | 任意 | 转换 .doc 文件（保留格式） |

### 可选组件

| 组件类型 | 名称 | 用途 |
|---------|------|------|
| 系统工具 | antiword | 备用 .doc 文本提取（不保留格式） |

### 当前已安装版本

```
Python 依赖库:
✓ python-docx: 1.2.0
✓ openpyxl: 3.1.5
✓ xlrd: 2.0.2

系统工具:
✓ LibreOffice: 24.2.7.2
✓ antiword: 已安装
```

## 新环境快速安装

### 方法一：一键安装脚本（最简单）

```bash
# 运行自动安装脚本（支持 Ubuntu/Debian/CentOS/macOS）
bash .claude/skills/replace/install.sh
```

**安装脚本会自动完成：**
1. ✅ 检测操作系统
2. ✅ 安装 LibreOffice 和 antiword
3. ✅ 安装 uv 包管理器
4. ✅ 初始化项目（如需要）
5. ✅ 安装所有 Python 依赖
6. ✅ 运行环境检查验证

### 方法二：手动安装（分步）

### 方法二：手动安装

#### 步骤 1: 安装系统工具

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y libreoffice-writer-nogui antiword
```

**CentOS/RHEL:**
```bash
sudo yum install -y libreoffice-writer antiword
```

**macOS:**
```bash
brew install libreoffice antiword
```

#### 步骤 2: 安装 uv 包管理器

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
# 或
pip install uv
```

#### 步骤 3: 初始化项目（如果未初始化）

```bash
uv init --no-readme
```

#### 步骤 4: 安装 Python 依赖

```bash
# 方式 1: 使用 pyproject.toml（推荐）
uv add python-docx openpyxl xlrd

# 方式 2: 直接安装
uv pip install python-docx openpyxl xlrd
```

#### 步骤 5: 验证安装

```bash
uv run python .claude/skills/replace/check_env.py
```

预期输出：
```
==================================================
关键词替换工具 - 环境检查
==================================================
1. 检查 Python 环境
✓ Python 版本: 3.12.x
2. 检查 uv 包管理器
✓ uv 已安装: x.x.x
3. 检查项目配置
✓ 项目已初始化
4. 检查 Python 依赖
✓ python-docx: 1.2.0
✓ openpyxl: 3.1.5
✓ xlrd: 2.0.2
5. 检查系统工具
✓ LibreOffice 已安装
6. 检查工具脚本
✓ 工具脚本存在
==================================================
✅ 环境检查通过！
==================================================
```

### 依赖说明

#### python-docx
- **用途**: 读取和写入 .docx 文件
- **功能**: 处理段落、表格、样式等
- **安装**: `uv add python-docx`

#### openpyxl
- **用途**: 读取和写入 .xlsx 文件
- **功能**: 处理工作表、单元格、公式等
- **安装**: `uv add openpyxl`

#### xlrd
- **用途**: 读取旧版 .xls 文件
- **功能**: 将 .xls 转换为 .xlsx
- **安装**: `uv add xlrd`

#### LibreOffice
- **用途**: 高质量转换 .doc 为 .docx
- **功能**: 完整保留格式、表格、样式
- **安装**: `sudo apt-get install libreoffice-writer-nogui`
- **注意**: 比 antiword 质量更高，推荐使用

#### antiword（可选）
- **用途**: 提取 .doc 文件的纯文本
- **功能**: 简单的文本提取（不保留格式）
- **安装**: `sudo apt-get install antiword`
- **注意**: 仅作为备用方案

## pyproject.toml 配置示例

确保项目根目录的 `pyproject.toml` 包含以下依赖：

```toml
[project]
name = "your-project-name"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "python-docx>=1.2.0",
    "openpyxl>=3.1.5",
    "xlrd>=2.0.2",
]
```

配置后运行 `uv sync` 自动安装所有依赖。

## 工作流程

### 1. 环境检查（首次使用或遇到错误时）

**必须先运行环境检查：**

```bash
# Python 环境检查（推荐）
uv run python .claude/skills/replace/check_env.py

# 或 Shell 脚本检查
bash .claude/skills/replace/check_env.sh
```

**如果检查失败**，请参考上方的"新环境快速安装"章节。

### 2. 理解替换需求

确认用户的替换需求：
- 要替换的关键词（旧文本）
- 替换后的新文本
- 目标文件或目录
- 是否需要预览（--dry-run）

### 3. 查找目标文件

使用 Glob 查找文件：

```python
# 查找所有 docx 文件
Glob: "**/*.docx"

# 查找所有 xlsx 文件
Glob: "**/*.xlsx"

# 查找特定目录
Glob: "docs/**/*.{docx,xlsx}"
```

### 4. 执行替换操作

根据需求执行相应的替换命令。

### 5. 报告结果

向用户报告替换统计信息和处理结果。

## 使用场景

用户请求以下操作时触发此技能：
- 在文档中替换某些词汇
- 批量修改文档内容
- 统一更新文档中的术语
- 批量处理文件中的关键词
- 更新年份、版本号、公司名称等

## 工具命令

**工具路径：** `.claude/skills/replace/replace_keywords.py`

### 基本命令格式

```bash
uv run python .claude/skills/replace/replace_keywords.py <路径> --replace "旧文本=新文本"
```

### 常用选项

| 选项 | 简写 | 说明 |
|------|------|------|
| --replace OLD=NEW | -r | 替换规则（可多次使用） |
| --recursive | -R | 递归处理子目录 |
| --dry-run | -n | 预览模式，不实际修改 |
| --no-backup | - | 不创建备份文件 |
| --no-convert | - | 不自动转换旧格式文件 |

### 命令示例

#### 单文件替换
```bash
uv run python .claude/skills/replace/replace_keywords.py ISO27001.docx --replace "2024=2025"
```

#### 多个替换规则
```bash
uv run python .claude/skills/replace/replace_keywords.py document.docx \
  --replace "某某公司=新公司" \
  --replace "2024=2025" \
  --replace "暂定=正式"
```

#### 批量处理目录
```bash
uv run python .claude/skills/replace/replace_keywords.py ./docs --replace "公司=新公司" --recursive
```

#### 预览模式（推荐先预览）
```bash
uv run python .claude/skills/replace/replace_keywords.py report.xlsx --replace "draft=final" --dry-run
```

#### 不创建备份
```bash
uv run python .claude/skills/replace/replace_keywords.py file.docx --replace "temp=permanent" --no-backup
```

## 支持的文件格式

| 格式 | 扩展名 | 支持程度 | 说明 |
|------|--------|----------|------|
| Word 文档 | .docx | ✅ 完全支持 | 保留格式 |
| Excel 工作簿 | .xlsx | ✅ 完全支持 | 支持所有工作表 |
| 旧版 Word | .doc | ✅ 自动转换 | 使用 antiword 转换为 .docx |
| 旧版 Excel | .xls | ✅ 自动转换 | 使用 xlrd 转换为 .xlsx |

### 自动转换功能

默认情况下，工具会自动将旧格式文件转换为新格式后再进行替换：

- **.doc → .docx**: 使用 LibreOffice 转换，**完整保留格式、表格、样式**
- **.xls → .xlsx**: 使用 xlrd 读取，创建新的 .xlsx 文件

转换后的新文件会保留在原目录中，原文件不变。

如需禁用自动转换，使用 `--no-convert` 参数。

## 输出说明

工具会显示详细的处理信息：

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

## 注意事项

### 必须检查项
1. **首次使用必须运行环境检查**
2. **大型替换前建议使用 --dry-run 预览**
3. **工具默认创建 .bak 备份文件**

### 使用建议
- 替换是区分大小写的
- 包含空格或特殊字符的文本需要用引号包裹
- 工具会保留原有的格式和样式
- **默认自动转换** .doc 和 .xls 文件为新格式
- 转换后的新文件（.docx/.xlsx）会与原文件在同一目录

### 旧格式自动转换

工具默认会自动转换旧格式文件：

- **.doc → .docx**: 使用 LibreOffice 高质量转换，保留所有格式
- **.xls → .xlsx**: 使用 xlrd 读取数据

转换后生成新文件，原文件保持不变。

```bash
# 手动转换（如果自动转换失败）
# 使用 LibreOffice 命令
soffice --headless --convert-to docx file.doc
soffice --headless --convert-to xlsx file.xls

# 或禁用自动转换，使用 --no-convert 参数
python replace_keywords.py file.doc --replace "旧=新" --no-convert
```

## 故障排除

### ModuleNotFoundError

```bash
# 运行环境检查
python3 .claude/skills/replace/check_env.py

# 安装缺失的依赖
uv add python-docx openpyxl xlrd
```

### LibreOffice 未安装

处理 .doc 文件需要 LibreOffice（推荐安装完整保留格式）：

```bash
# Ubuntu/Debian
sudo apt-get install libreoffice-writer-nogui

# CentOS/RHEL
sudo yum install libreoffice-writer

# macOS
brew install libreoffice
```

### xlrd 导入错误

处理 .xls 文件需要 xlrd 库：

```bash
uv add xlrd
```

### uv 未安装

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### 项目未初始化

```bash
uv init --no-workspace
```

## 示例对话

### 场景 1：替换单个文件
**用户：** 帮我在 ISO27001.docx 里把"2024"替换成"2025"

**助手执行流程：**
1. 检查文件是否存在
2. 运行环境检查（首次）
3. 执行替换命令
4. 报告结果

### 场景 2：批量处理
**用户：** 把 docs 目录下所有文档里的"某某公司"改成"新公司"

**助手执行流程：**
1. 使用 Glob 查找所有文档
2. 显示找到的文件列表
3. 运行批量替换
4. 报告统计信息

### 场景 3：预览模式
**用户：** 预览一下替换 report.xlsx 中的"draft"为"final"会是什么效果

**助手执行流程：**
1. 使用 --dry-run 模式
2. 显示将要替换的内容
3. 询问是否确认执行

### 场景 4：多个替换规则
**用户：** 更新文档中的公司名和年份

**助手执行流程：**
1. 确认所有替换规则
2. 使用多个 --replace 参数
3. 显示完整替换报告

### 场景 5：自动转换旧格式
**用户：** 在旧版 .doc 文件中替换内容

**助手执行流程：**
1. 检测到 .doc 格式
2. 自动使用 antiword 转换为 .docx
3. 在转换后的文件中执行替换
4. 报告转换和替换结果

示例输出：
```
处理: 2025培训计划.doc
  → 自动转换 .doc → .docx
  ✓ 已转换为: 2025培训计划.docx
  ✓ 备份: 2025培训计划.docx.bak
  ✓ 替换 5 处

==================================================
处理摘要
==================================================
处理文件数: 1
跳过文件数: 0
转换文件数: 1
总替换次数: 5
==================================================
```

## 技能文件结构

```
.claude/skills/replace/
├── replace.md              # 本技能定义文件
├── replace_keywords.py     # 主工具脚本
├── check_env.py            # Python 环境检查
├── check_env.sh            # Shell 环境检查
└── README.md               # 详细使用文档
```

## 最佳实践

1. **首次使用**：先运行 `check_env.py` 确保环境正确
2. **预览优先**：大批量替换前使用 `--dry-run` 预览
3. **备份数据**：重要文件建议手动额外备份
4. **分批处理**：大量文件可分批处理，中途检查结果
5. **验证结果**：替换后抽查几个文件验证效果
