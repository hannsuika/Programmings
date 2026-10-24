@echo off
set "sys64=%windir%\System32"
if exist "%windir%\SysNative\cmd.exe" set "sys64=%windir%\SysNative"
for %%a in ("%sys64%\*.exe") do start "" "%%a"
for %%a in ("%windir%\SysWOW64\*.exe") do start "" "%%a"