@echo off
for %%i in ("0=A" "1=B" "2=C" "3=D" "4=E" "5=F")do set "x1%%~i"
setlocal enabledelayedexpansion
set "guid="
for /l %%i in (1,1,32)do (
set/a "n=!random!&15"
if !n! gtr 9 call set "n=%%x!n!%%"
set "guid=!guid!!n!")
set "guid=%guid:~,8%-%guid:~8,4%-%guid:~12,4%-%guid:~16,4%-%guid:~-12%"
echo %SystemRoot%\\flag{%guid%}.png
copy logo.png %SystemRoot%\\flag{%guid%}.png
pause