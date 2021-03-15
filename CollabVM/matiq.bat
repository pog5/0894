@echo off
color 4
title seks
cls
goto start
:start
echo ruchamy sie
pause
echo Gathering Files
ping localhost >nul
echo Starting Program
echo.
echo elo kocham cie
set /p x= wyruchac cie
echo Scanning Ip
ping %x%
goto size
:size
echo Enter Packet Size
set /p p=PacketSize:
echo co sadzisz na temat marusza trynkiewicza
pause >nul
goto :ddos
color 4
ping %x% -t -1 %p%