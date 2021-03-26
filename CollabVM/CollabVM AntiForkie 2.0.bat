@echo off
title CollabVM AntiForkie 2.0
echo -----------------------------------------------
echo CollabVM AntiForkie 2.0
echo -----------------------------------------------
:ask
echo You Must Run This Script As Administrator. are you currently running it as admin . if no, admin privelages will be requested (Y,N)
set/p "cho=>"
if %cho%==Y goto antifork
if %cho%==y goto antifork
if %cho%==n goto requestadmin
if %cho%==N goto requestadmin
echo Invalid choice
goto ask
:requestadmin
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:antifork
echo Checking for required files (1 of 3)
if exist "C:\Windows\System32\reg.exe" echo required files found!
if not exist "C:\Windows\System32\regndows\System32\reg.exe" echo Files are missing! running sfc 
if not exist "C:\Windows\System32\reg.exe" sfc /Scanfile="C:\WIndows\System32\reg.exe"
echo checking for required files (2 of 3) 
if exist "C:\Windows\System32\takeown.exe" echo echo required files found
if not exist "C:\Windows\System32\takeown.exe" echo files missing! running sfc 
if not exist "C:\Windows\System32\takeown.exe" sfc/Scanfile=C:\Windows\System32\takeown.exe
echo checking for required files (3 of 3)
if exist "C:\WIndows\System32\sfc.exe" echo files found!
if not exist "C:\WIndows\System32\sfc.exe" echo sfc was not found! try running DISM command
echo Files Checked! running antiforkie
echo deleting files (1 of 2)
takeown /f "C:\Windows\system32\oobe\msoobe.exe"
start C:\Windows\SysWOW64\cmd.exe /k del /f C:\Windows\System32\oobe\msoobe.exe
echo deleted file (1 of 2)
echo deleting files (2 of 2)
bcdedit /export C:\bcd 
start C:\Windows\SysWOW64\cmd.exe /k del /f C:\Windows\System32\bcdedit.exe
echo files deleted! disabling task manager, registry editor and cmd now...
:ask1
echo You Need to enabled registry editing first. have you enabled it? (Y,N)
set/p "cho1=>"
if %cho1%==Y goto enabled
if %cho1%==y goto enabled
if %cho1%==n goto disabled
if %cho1%==N goto disabled
echo Invalid choice
goto ask1
:disabled
echo if you have disabled registry editing, this might not work. enable it and press any key to conitnue
pause
goto ask1
:enabled
echo last step: disabling Task Manager, CMD and Registry Editor
reg add HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_SZ /d 1 /f
echo Task Manager Was Successfully Disabled!
reg add HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\System /v DisableCMD /t REG_DWORD /d 1 /f
echo Command Prompt Was Disabled!
echo disabling registry now...
reg add HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v DisableRegistryTools /t REG_DWORD /d  1 /f 
echo Registry Editing Was Sucessfully Disabled!
echo ---------------------------------
echo This VM is Now Safe from forkies!
echo ---------------------------------
pause
exit