@echo off
setlocal EnableDelayedExpansion
:a
set /p v=%CD%^> 
call !v!
set v=
goto a