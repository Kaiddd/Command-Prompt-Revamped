@echo off
setlocal EnableDelayedExpansion
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do (if %%i==Version (set w=%%j.%%k.%%l.%%m) else (set w=%%i.%%j.%%k.%%l))
echo Microsoft Windows [Version %w%]
echo (c) Microsoft Corporation. All rights reserved.
echo.
echo Warning: CTRL-C is a bit broken, but still somewhat works. Respond N to the prompt as much as possible.
echo Pressing CTRL-C again will skip the warning, but sometimes will close CMD.
title Command Prompt ^| Batch Edition ^| Made by Kaede^! ^| ^<3
echo.
:a
set /p v=%CD%^> 
call !v!
set v=
goto a
