# 更新日志

本项目的所有重要更改都将记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)，
版本号遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [Unreleased]

### 计划中
- 支持 PowerPoint (.ppt, .pptx) 文件处理
- 批量格式转换工具
- 文档合并功能
- 批量水印添加/删除
- 图形化界面

## [1.0.0] - 2025-04-01

### 新增
- ✨ 首次发布
- ✨ 支持批量替换 Word (.docx) 文档中的关键词
- ✨ 支持批量替换 Excel (.xlsx) 文档中的关键词
- ✨ 自动转换 .doc → .docx（使用 LibreOffice）
- ✨ 自动转换 .xls → .xlsx（使用 xlrd）
- ✨ 递归处理目录
- ✨ 预览模式（--dry-run）
- ✨ 自动创建备份文件
- ✨ 环境检查脚本
- ✨ 一键安装脚本
- ✨ 完整文档

### 支持的文件格式
- ✅ .docx - Word 2007+
- ✅ .doc - Word 97-2003（自动转换）
- ✅ .xlsx - Excel 2007+
- ✅ .xls - Excel 97-2003（自动转换）

### 技术栈
- python-docx >= 1.2.0
- openpyxl >= 3.1.5
- xlrd >= 2.0.2
- LibreOffice（系统依赖）

### 文档
- README.md - 项目介绍
- DEPLOY.md - 部署指南
- CONTRIBUTING.md - 贡献指南
- LICENSE - MIT 许可证
- skill.md - Claude Code 技能定义

## [0.9.0] - 2025-03-XX

### 新增
- ✨ 初始开发版本
- ✨ 基础替换功能
- ✨ .docx 支持
- ✨ .xlsx 支持

---

## 版本说明

### [1.0.0] - 2025-04-01
首个稳定版本，包含所有核心功能。

### [0.9.0] - 2025-03-XX
开发测试版本。

---

## 链接

- [GitHub Releases](https://github.com/your-username/office-tools/releases)
- [问题追踪](https://github.com/your-username/office-tools/issues)
- [里程碑](https://github.com/your-username/office-tools/milestones)
