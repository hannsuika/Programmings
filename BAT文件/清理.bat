@echo off
chcp 936 >nul
color 0a
title 全盘清理工具

echo.
echo  ======================================
echo            电脑全盘深度清理
echo        C盘系统垃圾 + D/E/F盘垃圾
echo  ======================================
echo  只清垃圾，不删个人文件、视频、游戏
echo.
echo.

echo  ======================================
echo                 清理 C 盘
echo  ======================================

echo 清理用户临时文件...
del /f /s /q "%temp%\*.*" >nul 2>nul

echo 清理系统临时文件...
del /f /s /q "%windir%\Temp\*.*" >nul 2>nul

echo 清理预读取文件...
del /f /s /q "%windir%\Prefetch\*.*" >nul 2>nul

echo 清理系统日志...
del /f /s /q "%windir%\Logs\*.*" >nul 2>nul

echo 清理更新缓存...
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*" >nul 2>nul

echo 清空C盘回收站...
rd /s /q C:\$Recycle.Bin >nul 2>nul
md C:\$Recycle.Bin >nul 2>nul

echo 清理系统更新冗余...
dism /online /cleanup-image /startcomponentcleanup /norestart >nul 2>nul

echo 删除 Windows.old...
if exist "C:\Windows.old" rd /s /q "C:\Windows.old" >nul 2>nul

echo 关闭休眠释放空间...
powercfg -h off >nul 2>nul

echo.
echo  ======================================
echo              清理其他盘
echo  ======================================

for %%d in (D E F G H) do (
    if exist %%d:\ (
        echo.
        echo 正在清理 %%d 盘...
        
        rd /s /q %%d:\$Recycle.Bin >nul 2>nul
        md %%d:\$Recycle.Bin >nul 2>nul
        
        del /f /s /q %%d:\*.tmp >nul 2>nul
        del /f /s /q %%d:\*.log >nul 2>nul
        del /f /s /q %%d:\*.bak >nul 2>nul
        del /f /s /q %%d:\*.cache >nul 2>nul
        del /f /s /q %%d:\~*.* >nul 2>nul
    )
)

echo.
echo  ======================================
echo             全部清理完成！
echo  ======================================
echo  已清理：C盘系统垃圾 + 所有盘回收站
echo  建议重启电脑，空间更充足
echo.
exit