@echo off
setlocal EnableDelayedExpansion

title Command Prompt ^| Batch Edition ^| Made by Kaede
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set w=%%j.%%k.%%l.%%m) else (set w=%%i.%%j.%%k.%%l))
echo Microsoft Windows [Version %w%]
echo (c) Microsoft Corporation. All rights reserved.
echo.
:a
set /p v=%CD%^> 
call !v!
set v=
goto a