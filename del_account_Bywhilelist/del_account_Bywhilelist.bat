@echo off 

setlocal enabledelayedexpansion

if exist alluser.txt del alluser.txt
FOR /F "eol=命 skip=4 tokens=1,2,3" %%a in ('net user') do (
  if NOT "%%a"=="" echo %%a>>alluser.txt
  if NOT "%%b"=="" echo %%b>>alluser.txt
  if NOT "%%c"=="" echo %%c>>alluser.txt 
)
for /f %%i in (alluser.txt) do (
   findstr /x "%%i" user.txt

   if  !errorlevel!==0 echo 用户%%i被删除

   if !errorlevel!==0 echo net user /del %%i

)

pause