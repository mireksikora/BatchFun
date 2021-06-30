echo createobject("shell.application").shellexecute "BatchFileName_with_RunAsAdminCode.bat",,,"runas",1 > runas.vbs & start /wait runas.vbs
exit