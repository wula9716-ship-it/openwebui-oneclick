# Open WebUI 一键接入工具

> 输入你的 API Key 和中转站地址，一键启动本地 Open WebUI，支持 ChatGPT、Claude、DeepSeek 等所有兼容 OpenAI 格式的模型。

## ✨ 功能特点

- **一键配置**：交互式向导，只需输入 API Key 和中转站地址
- **自动安装**：自动检测 conda 环境并安装 open-webui
- **多模型支持**：支持所有兼容 OpenAI `/v1/chat/completions` 格式的模型
- **本地私有**：所有数据存储在本地，聊天记录不上云
- **无需注册**：可配置跳过登录认证，直接使用
- **知识库支持**：可上传文件让 AI 读取分析

## 📋 系统要求

- Windows 10/11
- [Anaconda](https://www.anaconda.com/download) 或 [Miniconda](https://docs.conda.io/en/latest/miniconda.html)
- 网络连接（用于安装依赖和调用 API）

## 🚀 快速开始

### 第一次使用

```
1. 双击 install.bat  →  自动安装环境
2. 双击 setup.bat    →  填写 API 信息
3. 双击 start.bat    →  启动服务
```

### 后续使用

```
双击 start.bat 即可
```

## 📖 详细说明

### 1. install.bat —— 安装环境

首次使用必须先运行此脚本：

- 自动检测 Anaconda/Miniconda 路径（支持 C 盘、D 盘、用户目录）
- 创建独立 Python 3.11 conda 环境（命名为 `open-webui`）
- 自动安装 `open-webui` 包

### 2. setup.bat —— 配置向导

交互式配置，按提示填写：

| 配置项 | 说明 | 示例 |
|--------|------|------|
| API 中转站地址 | 兼容 OpenAI 格式的 API 地址 | `https://xh.v1api.cc/v1` |
| API Key | 你的 API 密钥 | `sk-xxxx...` |
| 默认模型名称 | 启动后默认使用的模型 | `gpt-5` / `deepseek-v3` |
| 监听端口 | 本地服务端口（默认 8080） | `8080` |
| 是否关闭登录 | 关闭后无需注册直接使用 | `y` |

配置会保存到 `.env` 文件，下次启动直接读取，无需重复填写。

### 3. start.bat —— 一键启动

- 自动读取 `.env` 配置
- 激活 conda 环境
- 启动 Open WebUI 服务
- 自动打开浏览器访问 `http://127.0.0.1:8080`

## 🔧 支持的模型中转站

任何兼容 OpenAI API 格式的中转站都可以使用，例如：

| 中转站 | 支持模型 |
|--------|----------|
| `https://api.openai.com/v1` | GPT-4o, GPT-5 等官方模型 |
| `https://api.deepseek.com/v1` | DeepSeek-V3, DeepSeek-R1 |
| `https://api.siliconflow.cn/v1` | DeepSeek, Qwen, Llama 等 |
| 自定义中转站 | Claude, GPT, DeepSeek 等 |

## 📁 项目结构

```
openwebui-oneclick/
├── install.bat     # 安装环境（首次使用）
├── setup.bat       # 配置向导（填写 API 信息）
├── start.bat       # 一键启动服务
├── .env            # 配置文件（运行 setup.bat 自动生成）
├── .gitignore      # Git 忽略规则
└── README.md       # 使用说明
```

## ⚠️ 注意事项

1. **`.env` 文件包含你的 API Key，请勿上传到 GitHub！**（`.gitignore` 已自动忽略）
2. 关闭命令行窗口会停止 Open WebUI 服务
3. 首次启动较慢（需要初始化数据库），等待 30-60 秒后刷新浏览器
4. 如遇 429 错误（请求过多），等待 1-2 分钟后重试

## 🐛 常见问题

**Q: 双击 start.bat 提示找不到 conda？**  
A: 请先运行 `install.bat`，确保 Anaconda 已安装。

**Q: 启动后浏览器打开是空白/转圈？**  
A: 服务还在初始化中，等待约 30 秒后手动刷新页面。

**Q: 提示 API 调用失败？**  
A: 检查 `.env` 中的 `API_URL` 和 `API_KEY` 是否正确，可重新运行 `setup.bat` 修改。

**Q: 端口 8080 被占用？**  
A: 重新运行 `setup.bat`，将端口改为其他数字（如 8081、8888）。

## 📄 License

MIT License
