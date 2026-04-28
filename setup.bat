@echo off
chcp 65001 >nul
cls

echo ============================================
echo     Open WebUI 一键接入配置向导
echo ============================================
echo.

REM 检查是否已有配置文件
if exist ".env" (
    echo [!] 检测到已有配置文件 .env
    set /p OVERWRITE="是否覆盖重新配置？(y/n): "
    if /i not "%OVERWRITE%"=="y" (
        echo 已取消，保留原配置。
        pause
        exit /b 0
    )
)

echo.
echo 请输入以下信息（直接回车使用默认值）：
echo.

REM 输入中转站地址
set /p API_URL="API 中转站地址 (例: https://xh.v1api.cc/v1): "
if "%API_URL%"=="" set API_URL=https://api.openai.com/v1

REM 输入 API Key
set /p API_KEY="API Key (例: sk-xxxx...): "
if "%API_KEY%"=="" (
    echo [错误] API Key 不能为空！
    pause
    exit /b 1
)

REM 输入默认模型
set /p DEFAULT_MODEL="默认模型名称 (例: gpt-5 / deepseek-v3 / claude-sonnet-4.6): "
if "%DEFAULT_MODEL%"=="" set DEFAULT_MODEL=gpt-5

REM 输入端口
set /p PORT="监听端口 (默认: 8080): "
if "%PORT%"=="" set PORT=8080

REM 是否关闭登录认证
set /p AUTH="是否关闭登录认证，无需注册直接使用？(y/n，默认 y): "
if "%AUTH%"=="" set AUTH=y
if /i "%AUTH%"=="y" (set WEBUI_AUTH=False) else (set WEBUI_AUTH=True)

REM 写入配置文件
(
echo API_URL=%API_URL%
echo API_KEY=%API_KEY%
echo DEFAULT_MODEL=%DEFAULT_MODEL%
echo PORT=%PORT%
echo WEBUI_AUTH=%WEBUI_AUTH%
) > .env

echo.
echo ============================================
echo [OK] 配置已保存到 .env 文件
echo.
echo   中转站: %API_URL%
echo   默认模型: %DEFAULT_MODEL%
echo   端口: %PORT%
echo   登录认证: %WEBUI_AUTH%
echo ============================================
echo.

set /p START_NOW="是否立即启动 Open WebUI？(y/n): "
if /i "%START_NOW%"=="y" (
    call start.bat
) else (
    echo 配置完成！下次直接运行 start.bat 即可启动。
    pause
)
