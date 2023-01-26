@echo off
setlocal EnableDelayedExpansion

REM Settings

rem Automatically clears the console after every command! Great for script development.
rem Defaults to false
set autoCls=false

rem Skips the Microsoft watermark, etc.
rem Defaults to false
set cleanStart=false

rem Acceptable options can be found by running the color command in cmd: Ex. 'color ok' will error and show you a list of options
rem Defaults to 07
color 07

rem Skips the warning about ctrl-c, as well as the information that you can edit these settings! (Ignored if cleanStart == true)
rem Defaults to false
set skipCustomWarning=false

REM End Settings

title Command Prompt ^| Batch Edition ^| Made by Kaede^! ^| ^<3
if %cleanStart% == true (goto cmdLoop)
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
echo.
:cmdLoop
set /p v=%CD%^> 
if %autoCls% == true (cls)
call !v!
set v=
goto cmdLoop
