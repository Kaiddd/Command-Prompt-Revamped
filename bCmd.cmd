@echo off
setlocal EnableDelayedExpansion

REM Settings

rem Automatically clears the console after every command! Great for script development.
rem Defaults to false
set autoCls=false

rem Skips the Microsoft watermark, etc.
rem Defaults to false
set cleanStart=false

rem Skips the warning about ctrl-c, as well as the information that you can edit these settings! (Ignored if cleanStart == true)
rem Defaults to false
set skipCustomWarning=false

rem Acceptable options can be found by running the color command in cmd: Ex. 'color ok' will error and show you a list of options
rem Defaults to 07
color 07
rem TIP! Values f0 will give you a decent light theme if you're into that.
rem TIP2! Values 0f will give you a higher contrast between the text and the background, whilst still maintaining the look of CMD!

REM THE INSTALLATION OF CURL IS MANDATORY
REM IF YOU DO NOT ALREADY HAVE CURL IT WILL BE DOWNLOADED
REM IF YOU REALLY DO NOT WANT CURL, DISABLE EVERY PROGRAMMING LANGUAGE DOWLOAD SETTING, AND THEN REMOVE THE CODE THAT GETS CURL LATER IN THE SCRIPT.

rem Install the chocolatey package manager.
rem Defaults to noadmin | Options: noadmin/admin/none | noadmin only has packages here => https://community.chocolatey.org/packages?q=id%3Aportable
set installChocolatey="noadmin"
rem If you change the above setting after already running this script, delete the C:\ProgramData\choco4bCmd folder (nonadmin) or the %SystemRoot%\choco4bCmd folder (admin)

rem Install the latest version of git from winget.
rem Defaults to true
set installGit=true

REM Included Programming Languages
rem Disable these if you want to use an already installed version of these languages.

rem Downloads a local version of Python
rem Defaults to false, true
rem If unembed is set to true, will attempt to make features such as pip and other missing features from python embedded work
rem Not Recommended, downloads embedded python, is not as good as a normal python install, but if you are missing admin, this works great so long as unembed is enabled.
::todo set python=false
::todo set unembed=true

rem Downloads a local version of NodeJS
rem Defaults to false
rem Not Recommended, will not run the additional install tools as they require administrator. Only recommended if you need NodeJS and do not have administrator
::todo set nodejs=false

rem Downloads a local version of latest Lua or Lua 5.1, works great.
rem Defaults to true, false
::todo set lua=true
::todo set lua51 = false

rem Downloads a local version of LuaU, works great.
rem Defaults to true
::todo set luau=true

REM End Settings

set ChocoInstallDir=C:\ProgramData\choco4bCmd
set ChocoInstallDirA=%SystemRoot%\choco4bCmd
set path=%path%;%ChocoInstallDir%\bin;%ChocoInstallDirA%\bin;%localappdata%\Programs\Git\cmd;

where winget >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo Could not find winget command, please update your Windows version to run bCmd, alternatively, download bCmd minimal, that does not include any additional software or settings.
	pause
	exit
)

where git >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	if %installGit% == true (
		echo Installing Git
		winget install --id Git.Git -e --source winget
	)
)
where choco >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	if %installChocolatey% == "admin" (
		::::::::::::::::::::::::::::::::::::::::::::
		:: Elevate.cmd - Version 4
		:: Automatically check & get admin rights
		:: see "https://stackoverflow.com/a/12264592/1016343" for description
		::::::::::::::::::::::::::::::::::::::::::::
		CLS
		ECHO.
		ECHO =============================
		ECHO Running Admin shell
		ECHO =============================
		:init
		setlocal DisableDelayedExpansion
		set cmdInvoke=1
		set winSysFolder=System32
		set "batchPath=%~0"
		for %%k in (%0) do set batchName=%%~nk
		set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
		setlocal EnableDelayedExpansion
		:checkPrivileges
		NET FILE 1>NUL 2>NUL
		if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

		:getPrivileges
		if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
		ECHO.
		ECHO **************************************
		ECHO Invoking UAC for Privilege Escalation
		ECHO **************************************

		ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
		ECHO args = "ELEV " >> "%vbsGetPrivileges%"
		ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
		ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
		ECHO Next >> "%vbsGetPrivileges%"

		if '%cmdInvoke%'=='1' goto InvokeCmd 

		ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
		goto ExecElevation

		:InvokeCmd
		ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
		ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

		:ExecElevation
		"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
		exit /B

		:gotPrivileges
		setlocal & cd /d %~dp0
		if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
	)
	if not exist "%ChocoInstallDir%" (
		echo Installing Chocolatey
		if %installChocolatey% == "noadmin" (
			mkdir %ChocoInstallDir%
			set ChocolateyInstall=%ChocoInstallDir%
			@powershell -NoProfile -ExecutionPolicy Bypass -Command "(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))) >$null 2>&1"
		)
	)
	if not exist "%ChocoInstallDirA%" (
		if %installChocolatey% == "admin" (
			mkdir %ChocoInstallDirA%
			setx ChocolateyInstall %ChocoInstallDirA%
			@powershell -NoProfile -ExecutionPolicy Bypass -Command "(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))) >$null 2>&1"
		)
	)
)
where curl >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo Curl was missing on your system, proceed to install curl
	echo The install will fail if you did not install chocolatey in the previous step.
	echo Curl is NEEDED if you are going to install any of the programming languages in the settings at the top of this batch script.
	echo Only proceed if you have chocolatey installed!
	echo.
	pause
	call choco install curl -y
)
cls
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
