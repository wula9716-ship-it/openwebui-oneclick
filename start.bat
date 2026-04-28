@echo off
chcp 65001 >nul
cls

echo ============================================
echo         Open WebUI 启动中...
echo ============================================
echo.

REM 检查配置文件
if not exist ".env" (
    echo [错误] 未找到配置文件 .env
    echo 请先运行 setup.bat 进行配置！
    pause
    exit /b 1
)

REM 读取 .env 配置
for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
    set %%A=%%B
)

REM 校验关键参数
if "%API_KEY%"=="" (
    echo [错误] .env 中缺少 API_KEY，请重新运行 setup.bat
    pause
    exit /b 1
)
if "%API_URL%"=="" (
    echo [错误] .env 中缺少 API_URL，请重新运行 setup.bat
    pause
    exit /b 1
)

REM 检测 conda
set CONDA_PATH=
if exist "D:\anaconda\condabin\conda.bat" set CONDA_PATH=D:\anaconda\condabin\conda.bat
if exist "C:\anaconda\condabin\conda.bat" set CONDA_PATH=C:\anaconda\condabin\conda.bat
if exist "%USERPROFILE%\anaconda3\condabin\conda.bat" set CONDA_PATH=%USERPROFILE%\anaconda3\condabin\conda.bat
if exist "%USERPROFILE%\miniconda3\condabin\conda.bat" set CONDA_PATH=%USERPROFILE%\miniconda3\condabin\conda.bat

if "%CONDA_PATH%"=="" (
    echo [错误] 未找到 Anaconda/Miniconda，请先运行 install.bat 安装依赖！
    pause
    exit /b 1
)

REM 检查 open-webui 环境是否存在
call "%CONDA_PATH%" activate open-webui 2>nul
if errorlevel 1 (
    echo [错误] conda 环境 open-webui 不存在
    echo 请先运行 install.bat 安装依赖！
    pause
    exit /b 1
)

REM 设置环境变量
set ENABLE_OPENAI_API=True
set OPENAI_API_BASE_URL=%API_URL%
set OPENAI_API_BASE_URLS=%API_URL%
set OPENAI_API_KEY=%API_KEY%
set OPENAI_API_KEYS=%API_KEY%
set DEFAULT_MODELS=%DEFAULT_MODEL%
set DEFAULT_PROMPT_SUGGESTIONS=[]
set WEBUI_AUTH=%WEBUI_AUTH%
set HOST=127.0.0.1
set PORT=%PORT%

echo [1/3] 配置已加载
echo   中转站: %API_URL%
echo   默认模型: %DEFAULT_MODEL%
echo   端口: %PORT%
echo   认证: %WEBUI_AUTH%
echo.
echo [2/3] 正在启动 Open WebUI（首次启动较慢，请等待）...
start "" http://127.0.0.1:%PORT%
echo [3/3] 浏览器已打开 http://127.0.0.1:%PORT%
echo.
echo 请等待服务完全启动后刷新浏览器页面...
echo 关闭此窗口将停止服务！
echo.

open-webui serve --host 127.0.0.1 --port %PORT%
