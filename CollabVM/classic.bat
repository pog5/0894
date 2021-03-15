@echo off
FOR /F "delims=^T" %%G IN ('Handle ThemeSection') do set output=%%G
FOR /F "tokens=6" %%G IN ('echo %output%') DO set handleid=%%G
FOR /F "tokens=3" %%G IN ('echo %output%') DO set pid=%%G
echo %handleid%
echo %pid%
Handle -c %handleid% -p %pid% -y
