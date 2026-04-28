@echo off
chcp 65001 >nul
cls

echo ============================================
echo     Open WebUI 环境安装向导
echo ============================================
echo.
echo 此脚本将自动安装 Open WebUI 及其所需依赖。
echo 需要 Anaconda 或 Miniconda 已安装。
echo.

REM 检测 conda
set CONDA_PATH=
if exist "D:\anaconda\condabin\conda.bat" set CONDA_PATH=D:\anaconda\condabin\conda.bat
if exist "C:\anaconda\condabin\conda.bat" set CONDA_PATH=C:\anaconda\condabin\conda.bat
if exist "%USERPROFILE%\anaconda3\condabin\conda.bat" set CONDA_PATH=%USERPROFILE%\anaconda3\condabin\conda.bat
if exist "%USERPROFILE%\miniconda3\condabin\conda.bat" set CONDA_PATH=%USERPROFILE%\miniconda3\condabin\conda.bat

if "%CONDA_PATH%"=="" (
    echo [错误] 未找到 Anaconda 或 Miniconda！
    echo.
    echo 请先安装 Anaconda: https://www.anaconda.com/download
    echo 或 Miniconda: https://docs.conda.io/en/latest/miniconda.html
    echo.
    pause
    exit /b 1
)

echo [OK] 检测到 conda: %CONDA_PATH%
echo.

REM 检查 open-webui 环境是否已存在
call "%CONDA_PATH%" activate open-webui 2>nul
if not errorlevel 1 (
    echo [!] conda 环境 open-webui 已存在
    set /p REINSTALL="是否重新安装？(y/n，默认 n): "
    if /i not "%REINSTALL%"=="y" (
        echo 跳过安装，环境已就绪。
        goto :CONFIG
    )
    echo 正在删除旧环境...
    call "%CONDA_PATH%" env remove -n open-webui -y
)

echo [1/3] 正在创建 Python 3.11 环境（open-webui）...
call "%CONDA_PATH%" create -n open-webui python=3.11 -y
if errorlevel 1 (
    echo [错误] 创建 conda 环境失败！
    pause
    exit /b 1
)

echo.
echo [2/3] 正在安装 open-webui...
call "%CONDA_PATH%" activate open-webui
pip install open-webui
if errorlevel 1 (
    echo [错误] 安装 open-webui 失败！
    echo 请检查网络连接后重试。
    pause
    exit /b 1
)

echo.
echo [3/3] 安装完成！
echo.

:CONFIG
echo ============================================
echo [OK] 环境安装成功！
echo ============================================
echo.
set /p RUN_SETUP="是否立即运行配置向导？(y/n): "
if /i "%RUN_SETUP%"=="y" (
    call setup.bat
) else (
    echo 安装完成！运行 setup.bat 进行配置，然后 start.bat 启动服务。
    pause
)
