# GitHub 发布检查清单

## 发布前准备

### 1. 代码准备
- [x] 所有功能已完成并测试
- [ ] 所有测试通过
- [ ] 代码已格式化（black, ruff）
- [ ] 文档已更新
- [ ] CHANGELOG.md 已更新
- [ ] 版本号已更新（pyproject.toml）

### 2. 文件清单

**核心文件：**
- [x] `pyproject.toml` - Python 项目配置
- [x] `uv.lock` - 依赖锁定
- [x] `replace_tool.py` - 主工具脚本
- [x] `check_env.py` - 环境检查
- [x] `install.sh` - 安装脚本

**文档文件：**
- [x] `LICENSE` - MIT 许可证
- [x] `README.md` - 快速参考
- [x] `README_GITHUB.md` - GitHub 主页
- [x] `CHANGELOG.md` - 更新日志
- [x] `CONTRIBUTING.md` - 贡献指南
- [x] `ROADMAP.md` - 产品路线图
- [x] `DEPLOY.md` - 部署指南

**Claude Code 技能：**
- [x] `skill.md` - 技能定义
- [x] `office-tools.md` - 技能文档

**GitHub 配置：**
- [x] `.github/workflows/ci.yml` - CI 配置
- [x] `.github/ISSUE_TEMPLATE/bug_report.md` - Bug 模板
- [x] `.github/ISSUE_TEMPLATE/feature_request.md` - 功能请求模板

**其他：**
- [x] `.gitignore` - Git 忽略规则
- [x] `office-tools-launcher` - 快速启动脚本

### 3. 测试检查

**功能测试：**
- [ ] .docx 文件替换测试
- [ ] .xlsx 文件替换测试
- [ ] .doc 转换测试
- [ ] .xls 转换测试
- [ ] 递归目录测试
- [ ] 预览模式测试
- [ ] 备份创建测试

**兼容性测试：**
- [ ] Ubuntu 20.04/22.04
- [ ] macOS 12/13/14
- [ ] Windows 10/11
- [ ] Python 3.9/3.10/3.11/3.12

**环境测试：**
- [ ] 全新安装测试
- [ ] 升级测试
- [ ] 独立部署测试

## 发布步骤

### 1. Git 准备

```bash
# 确保在主分支
git checkout main

# 更新版本号
vim pyproject.toml  # 修改版本号

# 提交更改
git add .
git commit -m "chore: release v1.0.0"

# 创建标签
git tag -a v1.0.0 -m "Release v1.0.0"

# 推送到 GitHub
git push origin main
git push origin v1.0.0
```

### 2. GitHub Release

1. 访问：https://github.com/your-username/office-tools/releases
2. 点击 "Draft a new release"
3. 选择标签：v1.0.0
4. 发布标题：Release v1.0.0
5. 发布内容：

```markdown
## 🎉 Office Tools v1.0.0

首个稳定版本发布！

### ✨ 新功能

- 批量替换 Word (.docx) 文档中的关键词
- 批量替换 Excel (.xlsx) 文档中的关键词
- 自动转换 .doc → .docx
- 自动转换 .xls → .xlsx
- 递归处理目录
- 预览模式
- 自动备份

### 📦 安装

```bash
git clone https://github.com/your-username/office-tools.git
cd office-tools
bash install.sh
```

### 📝 文档

- [README](README.md) - 快速开始
- [DEPLOY.md](DEPLOY.md) - 部署指南
- [CONTRIBUTING.md](CONTRIBUTING.md) - 贡献指南

### 🙏 致谢

感谢所有贡献者和用户的反馈！

完整更新日志：[CHANGELOG.md](CHANGELOG.md)
```

6. 勾选 "Set as the latest release"
7. 点击 "Publish release"

### 3. 发布后检查

- [ ] GitHub Release 页面显示正常
- [ ] CI/CD 通过
- [ ] 下载链接可用
- [ ] 文档链接正确

## Claude Code 技能市场发布

### 1. 准备技能元数据

确保 `skill.md` 包含：
- [ ] name: office-tools
- [ ] description: 清晰描述
- [ ] version: 1.0.0
- [ ] tags: 相关标签
- [ ] repository: GitHub URL

### 2. 提交到技能市场

```bash
# 在 Claude Code 中
/skills publish
```

或手动提交：
- 访问 Claude Code 技能市场
- 填写技能信息
- 上传技能包
- 等待审核

### 3. 技能发布后

- [ ] 技能页面显示正常
- [ ] 安装命令可用
- [ ] 文档链接正确
- [ ] 示例可运行

## 发布后宣传

### 社交媒体

- [ ] Twitter/X 发布
- [ ] Reddit 发布
- [ ] LinkedIn 发布
- [ ] 技术博客文章

### 社区

- [ ] Hacker News 提交
- [ ] Product Hunt 发布
- [ ] 相关论坛/社区分享

## 后续跟进

### 第一周

- [ ] 监控 Issues 和 PRs
- [ ] 回复用户反馈
- [ ] 修复紧急 bug

### 第一个月

- [ ] 收集用户反馈
- [ ] 规划下一版本
- [ ] 更新 ROADMAP

---

**发布日期：** 2025-04-01
**发布版本：** v1.0.0
**发布负责人：** Your Name

## 发布后清理

- [ ] 关闭已完成的 Issues
- [ ] 更新里程碑
- [ ] 归档发布笔记
- [ ] 通知团队成员

## 紧急回滚计划

如果发现严重问题：

```bash
# 删除 GitHub Release
gh release delete v1.0.0 -y

# 删除标签
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0

# 发布修复版本
git checkout main
vim pyproject.toml  # 更新为 v1.0.1
git add .
git commit -m "hotfix: fix critical issue"
git tag -a v1.0.1 -m "Hotfix v1.0.1"
git push origin main --tags
```
