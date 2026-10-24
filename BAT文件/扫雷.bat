@echo off
color 0A
mode con cols=20 lines=20
title 扫雷

:: 初始化全部格子 = 未翻开 #
set g11=#&set g12=#&set g13=#&set g14=#&set g15=#&set g16=#&set g17=#&set g18=#
set g21=#&set g22=#&set g23=#&set g24=#&set g25=#&set g26=#&set g27=#&set g28=#
set g31=#&set g32=#&set g33=#&set g34=#&set g35=#&set g36=#&set g37=#&set g38=#
set g41=#&set g42=#&set g43=#&set g44=#&set g45=#&set g46=#&set g47=#&set g48=#
set g51=#&set g52=#&set g53=#&set g54=#&set g55=#&set g56=#&set g57=#&set g58=#
set g61=#&set g62=#&set g63=#&set g64=#&set g65=#&set g66=#&set g67=#&set g68=#
set g71=#&set g72=#&set g73=#&set g74=#&set g75=#&set g76=#&set g77=#&set g78=#
set g81=#&set g82=#&set g83=#&set g84=#&set g85=#&set g86=#&set g87=#&set g88=#

:: 固定10个地雷坐标
set L1=22
set L2=26
set L3=31
set L4=47
set L5=53
set L6=14
set L7=65
set L8=72
set L9=76
set L10=88

:main
cls
echo     1 2 3 4 5 6 7 8
echo --------------------
echo 1: %g11% %g12% %g13% %g14% %g15% %g16% %g17% %g18%
echo 2: %g21% %g22% %g23% %g24% %g25% %g26% %g27% %g28%
echo 3: %g31% %g32% %g33% %g34% %g35% %g36% %g37% %g38%
echo 4: %g41% %g42% %g43% %g44% %g45% %g46% %g47% %g48%
echo 5: %g51% %g52% %g53% %g54% %g55% %g56% %g57% %g58%
echo 6: %g61% %g62% %g63% %g64% %g65% %g66% %g67% %g68%
echo 7: %g71% %g72% %g73% %g74% %g75% %g76% %g77% %g78%
echo 8: %g81% %g82% %g83% %g84% %g85% %g86% %g87% %g88%
echo.
echo 【操作】
echo 翻开格子：输入 行 列
echo.
set "in="
set /p in=请输入：

:: 插旗判断 q 行 列
if /i "%in:~0,1%"=="q" (
set a=%in:~2,1%
set b=%in:~4,1%
:: 有旗变#，没旗变Q
if "!g%a%%b%!"=="Q" (set g%a%%b%=#) else (set g%a%%b%=Q)
goto main
)

:: 普通翻开
set x=%in:~0,1%
set y=%in:~2,1%
set pos=%x%%y%

:: 有旗子不让翻开
if "!g%x%%y%!"=="Q" (
echo 该格子已插旗，无法翻开！
pause>nul
goto main
)

:: 踩雷判定
if "%pos%"=="%L1%" goto boom
if "%pos%"=="%L2%" goto boom
if "%pos%"=="%L3%" goto boom
if "%pos%"=="%L4%" goto boom
if "%pos%"=="%L5%" goto boom
if "%pos%"=="%L6%" goto boom
if "%pos%"=="%L7%" goto boom
if "%pos%"=="%L8%" goto boom
if "%pos%"=="%L9%" goto boom
if "%pos%"=="%L10%" goto boom

:: 安全格子 显示数字
set g%x%%y%=1
goto main

:boom
cls
echo.
echo       踩到地雷！游戏结束
echo.
pause>nul
exit