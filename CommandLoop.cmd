@echo off
setlocal EnableDelayedExpansion

REM Settings

rem Automatically clears the console after every command! Great for script development.
set autoCls=false

rem Skips the Microsoft watermark, etc.
set cleanStart=false

rem Skips the warning about ctrl-c, as well as the information that you can edit these settings! (Ignored if cleanStart == true)
set skipCustomWarning=false

REM End Settings

if %cleanStart% == true (goto a)
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set w=%%j.%%k.%%l.%%m) else (set w=%%i.%%j.%%k.%%l))
echo Microsoft Windows [Version %w%]
echo (c) Microsoft Corporation. All rights reserved.
if %skipCustomWarning% == true (goto skipCustomWarning)
echo.
echo Warning: CTRL-C is a bit broken, but still somewhat works. Respond N to the prompt as much as possible.
echo Pressing CTRL-C again will skip the warning, but sometimes will close CMD.
echo.
echo Additional settings can be edited at the top of the %~x0 file.
:skipCustomWarning
title Command Prompt ^| Batch Edition ^| Made by Kaede^! ^| ^<3
echo.
:a
set /p v=%CD%^> 
if %autoCls% == true (cls)
call !v!
set v=
goto a
