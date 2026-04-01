# 独立部署指南

本技能可以完全独立部署到任何环境，无需依赖外部项目配置。

## 部署方式

### 方式一：直接复制（推荐）

```bash
# 1. 复制整个技能目录到目标位置
cp -r .claude/skills/replace /path/to/destination/

# 2. 进入技能目录
cd /path/to/destination/replace

# 3. 运行安装脚本
bash install.sh

# 4. 开始使用
uv run python replace_keywords.py --help
```

### 方式二：Git 克隆

```bash
# 1. 克隆整个项目
git clone <repository-url> project-temp
cd project-temp/.claude/skills/replace

# 2. 只复制技能目录
cp -r replace /path/to/destination/
cd /path/to/destination/replace

# 3. 运行安装脚本
bash install.sh
```

### 方式三：打包分发

```bash
# 1. 打包技能目录
tar czf replace-skill.tar.gz .claude/skills/replace/

# 2. 传输到目标服务器
scp replace-skill.tar.gz user@server:/path/to/destination/

# 3. 在目标服务器上解压
ssh user@server
cd /path/to/destination/
tar xzf replace-skill.tar.gz
cd replace

# 4. 运行安装
bash install.sh
```

## 技能目录结构

独立部署后的完整目录结构：

```
replace/                          # 技能根目录
├── pyproject.toml               # ✅ Python 项目配置（包含依赖）
├── uv.lock                      # ✅ 依赖锁定文件
├── install.sh                   # ✅ 一键安装脚本
├── replace.md                   # 技能文档
├── README.md                    # 快速参考
├── DEPLOY.md                    # 本文件（部署指南）
├── replace_keywords.py          # 主工具
├── check_env.py                 # 环境检查
├── check_env.sh                 # Shell 检查
└── replace                      # 快速启动脚本
```

## 系统要求

### 必需组件

| 组件 | 版本 | 说明 |
|------|------|------|
| Python | >=3.9 | 运行环境 |
| uv | 最新 | 包管理器 |
| LibreOffice | 任意 | 转换 .doc 文件 |

### Python 依赖（自动安装）

- python-docx >= 1.2.0
- openpyxl >= 3.1.5
- xlrd >= 2.0.2

## 使用方式

### 在技能目录内使用

```bash
cd /path/to/replace

# 替换单个文件
uv run python replace_keywords.py document.docx --replace "旧=新"

# 批量处理
uv run python replace_keywords.py ./docs --replace "旧=新" --recursive
```

### 从任何地方使用

```bash
# 使用绝对路径
uv run python /path/to/replace/replace_keywords.py file.docx --replace "旧=新"

# 或添加到 PATH
export PATH="/path/to/replace:$PATH"
uv run python replace_keywords.py file.docx --replace "旧=新"
```

### 创建全局快捷命令

```bash
# 方式 1: 创建 wrapper 脚本
cat > ~/bin/replace << 'EOF'
#!/bin/bash
uv run python /path/to/replace/replace_keywords.py "$@"
EOF
chmod +x ~/bin/replace

# 现在可以直接使用
replace file.docx --replace "旧=新"

# 方式 2: 使用软链接
ln -s /path/to/replace/replace ~/bin/replace
~/bin/replace file.docx --replace "旧=新"
```

## 依赖说明

技能目录包含完整的依赖配置：

### pyproject.toml

```toml
[project]
name = "replace-skill"
version = "1.0.0"
requires-python = ">=3.9"
dependencies = [
    "python-docx>=1.2.0",
    "openpyxl>=3.1.5",
    "xlrd>=2.0.2",
]
```

### uv.lock

包含精确的依赖版本和哈希值，确保在不同环境中安装完全相同的版本。

运行 `uv sync` 时会自动使用 `uv.lock` 锁定版本。

## 验证安装

```bash
cd /path/to/replace

# 运行环境检查
uv run python check_env.py
```

预期输出：

```
==================================================
关键词替换工具 - 环境检查
==================================================
1. 检查 Python 环境
✓ Python 版本: 3.9+
2. 检查 uv 包管理器
✓ uv 已安装
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

## 故障排除

### 问题：uv 命令未找到

```bash
# 安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh
# 重新加载 shell 配置
source ~/.bashrc  # 或 source ~/.zshrc
```

### 问题：LibreOffice 未安装

```bash
# Ubuntu/Debian
sudo apt-get install libreoffice-writer-nogui

# CentOS/RHEL
sudo yum install libreoffice-writer

# macOS
brew install libreoffice
```

### 问题：Python 版本过低

```bash
# 安装 Python 3.9+
sudo apt-get install python3.9  # Ubuntu/Debian
# 或使用 pyenv 管理多版本 Python
```

### 问题：依赖安装失败

```bash
# 清理缓存重新安装
cd /path/to/replace
rm -rf .venv uv.lock
uv sync
```

## 与项目集成

如果想将此技能集成到现有项目中：

```bash
# 1. 复制技能到项目的 .claude/skills/ 目录
cp -r replace /path/to/project/.claude/skills/

# 2. 在项目根目录使用
cd /path/to/project
uv run python .claude/skills/replace/replace_keywords.py file.docx --replace "旧=新"
```

## 更新技能

```bash
cd /path/to/replace

# 更新依赖（如果 pyproject.toml 有变化）
uv sync --upgrade

# 或重新生成 lock 文件
uv lock --upgrade
```

## 卸载

```bash
# 直接删除技能目录
rm -rf /path/to/replace

# 如果创建了全局命令
rm ~/bin/replace
```

## 多用户共享

### 共享目录安装

```bash
# 1. 安装到共享目录
sudo cp -r replace /opt/replace-skill
cd /opt/replace-skill
sudo bash install.sh

# 2. 设置权限
sudo chmod -R 755 /opt/replace-skill

# 3. 用户使用
uv run python /opt/replace-skill/replace_keywords.py file.docx --replace "旧=新"
```

### Docker 部署

创建 `Dockerfile`:

```dockerfile
FROM python:3.12-slim

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y libreoffice-writer-nogui antiword && \
    rm -rf /var/lib/apt/lists/*

# 安装 uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# 复制技能
COPY replace/ /app/replace/
WORKDIR /app/replace

# 安装 Python 依赖
RUN uv sync

# 设置入口点
ENTRYPOINT ["uv", "run", "python", "replace_keywords.py"]
CMD ["--help"]
```

构建和运行：

```bash
docker build -t replace-skill .
docker run -v $(pwd):/workspace replace-skill /workspace/file.docx --replace "旧=新"
```

## 注意事项

1. **独立性**: 技能目录包含所有必要文件，可独立运行
2. **可移植性**: 可复制到任何支持 Python 3.9+ 的环境
3. **版本锁定**: uv.lock 确保依赖版本一致性
4. **无网络依赖**: 安装后可离线使用（除 LibreOffice 系统调用）
5. **系统工具**: LibreOffice 需要系统级安装，无法通过 Python 安装
