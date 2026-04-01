---
name: office-tools
description: Office 文档批量处理工具集，支持在 Word (.docx, .doc) 和 Excel (.xlsx, .xls) 文档中批量替换关键词。自动转换旧格式文件（.doc → .docx, .xls → .xlsx），保留完整格式和样式。当用户提到"替换文档内容"、"批量替换"、"修改 Word/Excel"、"替换关键词"或"更新文档"时使用。
version: 1.0.0
author: Claude Code Community
tags:
  - office
  - document
  - word
  - excel
  - batch
  - replacement
---

# Office Tools - Office 文档批量处理工具集

## 技能概述

Office Tools 是一个强大的 Office 文档批量处理工具集，专为 Claude Code 设计。

## 核心功能

- ✅ 批量替换关键词
- ✅ 文件列表预览（处理前先显示所有文件，防止遗漏）
- ✅ 格式保留
- ✅ 自动转换
- ✅ 递归处理
- ✅ 预览模式
- ✅ 自动备份

## 支持的文件格式

| 格式 | 扩展名 | 支持 |
|------|--------|------|
| Word | .docx | ✅ 完全 |
| Word | .doc | ✅ 自动转换 |
| Excel | .xlsx | ✅ 完全 |
| Excel | .xls | ✅ 自动转换 |

## 工具脚本

### 主工具：scripts/replace_tool.py

批量替换 Office 文档关键词。

**基本语法：**
\`\`\`bash
python scripts/replace_tool.py <路径> --replace "旧=新" [选项]
\`\`\`

**选项：**
- `--replace OLD=NEW` - 替换规则
- `--recursive` - 递归处理
- `--dry-run` - 预览模式
- `--no-backup` - 不创建备份
- `--no-list` - 不显示文件列表（默认会先显示所有将要处理的文件）

### 环境检查：scripts/check_env.py

检查运行环境。

### 安装：scripts/install.sh

一键安装依赖。

## 引用文档

- [README](references/README.md)
- [部署指南](references/DEPLOY.md)
- [贡献指南](references/CONTRIBUTING.md)
