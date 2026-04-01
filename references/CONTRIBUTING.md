# 贡献指南

感谢你有兴趣为 Office Tools 做出贡献！我们欢迎所有形式的贡献。

## 如何贡献

### 报告问题

如果你发现了 bug 或有功能建议：

1. 检查 [Issues](https://github.com/your-username/office-tools/issues) 是否已存在相同问题
2. 如果没有，创建一个新的 Issue，包含：
   - 清晰的标题和描述
   - 复现步骤（针对 bug）
   - 预期行为和实际行为
   - 环境信息（操作系统、Python 版本等）
   - 相关的日志或错误信息

### 提交代码

1. **Fork 仓库**
   ```bash
   # 在 GitHub 上点击 Fork 按钮
   git clone https://github.com/your-username/office-tools.git
   cd office-tools
   ```

2. **创建特性分支**
   ```bash
   git checkout -b feature/your-feature-name
   # 或修复 bug
   git checkout -b fix/your-bug-fix
   ```

3. **进行开发**
   ```bash
   # 安装开发依赖
   uv sync

   # 运行测试
   uv run pytest

   # 代码格式化
   black .
   ruff check .
   ```

4. **提交更改**
   ```bash
   git add .
   git commit -m "feat: add some amazing feature"
   ```

   提交信息格式：
   - `feat:` 新功能
   - `fix:` Bug 修复
   - `docs:` 文档更新
   - `style:` 代码格式（不影响功能）
   - `refactor:` 重构
   - `test:` 测试相关
   - `chore:` 构建/工具相关

5. **推送到分支**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **创建 Pull Request**
   - 在 GitHub 上创建 Pull Request
   - 填写 PR 模板
   - 等待代码审查

## 开发指南

### 环境设置

```bash
# 克隆仓库
git clone https://github.com/your-username/office-tools.git
cd office-tools

# 创建虚拟环境
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# 安装依赖
uv sync
```

### 项目结构

```
office-tools/
├── replace_tool.py       # 主工具脚本
├── check_env.py          # 环境检查
├── tests/                # 测试目录
│   ├── test_replace.py
│   └── test_convert.py
└── docs/                 # 文档目录
```

### 代码风格

我们使用以下工具确保代码质量：

- **Black** - 代码格式化
- **Ruff** - 代码检查
- **pytest** - 测试框架

```bash
# 格式化代码
black .

# 检查代码
ruff check .

# 运行测试
pytest
```

### 添加新功能

1. 在 `replace_tool.py` 中添加新方法
2. 添加对应的测试用例
3. 更新文档
4. 更新 `pyproject.toml` 版本号

### 测试

```bash
# 运行所有测试
pytest

# 运行特定测试
pytest tests/test_replace.py

# 生成覆盖率报告
pytest --cov=replace_tool --cov-report=html
```

## 文档贡献

我们欢迎改进文档！

### 文档类型

- **README.md** - 项目主页
- **DEPLOY.md** - 部署指南
- **API.md** - API 文档
- **FAQ.md** - 常见问题

### 文档风格

- 使用清晰的标题结构
- 提供代码示例
- 包含使用场景
- 保持简洁明了

## 发布流程

### 版本号

我们遵循 [语义化版本](https://semver.org/lang/zh-CN/)：

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能新增
- **修订号**：向下兼容的问题修正

### 发布步骤

1. 更新版本号
2. 更新 CHANGELOG.md
3. 创建 Git 标签
4. 推送到 GitHub
5. 创建 GitHub Release

## 社区准则

### 我们的承诺

为了营造开放和友好的环境，我们承诺：
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 关注对社区最有利的事情
- 对其他社区成员表示同理心

### 不可接受的行为

- 使用性别化语言或图像
- 人身攻击或政治攻击
- 公开或私下骚扰
- 未经许可发布他人私人信息
- 其他不道德或不专业的行为

## 获取帮助

如果你有任何问题：

- 查看 [FAQ](docs/FAQ.md)
- 在 [Discussions](https://github.com/your-username/office-tools/discussions) 中提问
- 创建 [Issue](https://github.com/your-username/office-tools/issues)

## 许可证

通过贡献代码，你同意你的贡献将使用 [MIT License](LICENSE) 进行许可。

---

再次感谢你的贡献！🎉
