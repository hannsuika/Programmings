@echo off
chcp 65001 >nul 2>&1
title Windows 一键垃圾清理工具
color 0A

:: ==============================================
:: 1. 管理员权限检测（清理系统目录需要权限）
:: ==============================================
echo.
echo ╔══════════════════════════════════════════════════════╗
echo ║     Windows 系统垃圾一键清理工具 (安全版)           ║
echo ║                                                    ║
echo ║  清理范围：临时文件、日志、缓存、更新残留等        ║
echo ║  请右键选择【以管理员身份运行】以获得最佳效果      ║
echo ╚══════════════════════════════════════════════════════╝
echo.
echo 正在初始化清理程序，请稍候...
ping -n 2 127.0.0.1 >nul
cls

:: ==============================================
:: 2. 开始逐项清理（每一步都有进度提示）
:: ==============================================
echo ==================================================
echo 【1/8】清理用户临时文件 (%TEMP%) ...
del /f /s /q "%TEMP%\*.*" >nul 2>&1
rd /s /q "%TEMP%" >nul 2>&1 && md "%TEMP%"
echo        ✓ 完成

echo 【2/8】清理系统临时文件 (Windows\Temp) ...
del /f /s /q "%windir%\Temp\*.*" >nul 2>&1
rd /s /q "%windir%\Temp" >nul 2>&1 && md "%windir%\Temp"
echo        ✓ 完成

echo 【3/8】清理系统预读缓存 (Prefetch) ...
del /f /s /q "%windir%\Prefetch\*.*" >nul 2>&1
echo        ✓ 完成

echo 【4/8】清理系统各类临时后缀文件 (*.tmp, *.log, *.old 等) ...
:: 清理C盘根目录下的各类临时/日志/备份文件
for %%X in (tmp log old bak chk gid _mp) do (
    del /f /s /q "%systemdrive%\*.%%X" >nul 2>&1
)
:: 清理~开头的临时文件（Office等软件产生的）
del /f /s /q "%systemdrive%\~*.*" >nul 2>&1
echo        ✓ 完成

echo 【5/8】清理缩略图缓存、图标缓存 ...
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo        ✓ 完成

echo 【6/8】清理Windows更新残留文件 ...
:: 调用系统自带的磁盘清理工具，自动清理更新缓存
cleanmgr /sageset:100 >nul 2>&1
cleanmgr /sagerun:100 >nul 2>&1
echo        ✓ 完成

echo 【7/8】清理错误报告、转储文件 ...
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\WER\*.*" >nul 2>&1
echo        ✓ 完成

:: ==============================================
:: 3. 可选：清空回收站（需要你手动确认，避免误删）
:: ==============================================
echo.
set /p "confirm=是否要清空回收站？(Y/N，默认N): "
if /i "%confirm%"=="Y" (
    echo 【8/8】正在清空回收站...
    PowerShell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
    echo        ✓ 完成
) else (
    echo 【8/8】跳过回收站清理
)

:: ==============================================
:: 4. 清理完成
:: ==============================================
cls
echo.
echo ==================================================
echo          ✅  垃圾清理完成！
echo ==================================================
echo.
echo 已为你清理了：
echo  - 用户&系统临时文件
echo  - 系统日志、旧备份文件
echo  - 预读缓存、缩略图缓存
echo  - Windows更新残留
echo  - 错误报告文件
echo.
if /i "%confirm%"=="Y" echo  额外：已清空回收站
echo.
echo 你的C盘已经释放了不少空间啦！
echo.
pause