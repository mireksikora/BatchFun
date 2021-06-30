@echo off
rem Mirek Sikora
rem 2021-05-21
rem Find installed MS Office version and 
rem last 5 characters of installed product key

mode con: cols=90 lines=35
Title MS Office script
echo Searching for MS Office installed version:
echo.
C: 
CD \ 
DIR OSPP.vbs /s /b > %userprofile%\MSOscript.temp 
SET /p MSOvba=< %userprofile%\MSOscript.temp 

echo Host name:  >          %userprofile%\MSOfficeVersion.txt
hostname >>                 %userprofile%\MSOfficeVersion.txt
echo User name: >>          %userprofile%\MSOfficeVersion.txt
echo %username% >>          %userprofile%\MSOfficeVersion.txt
echo Script name: >>        %userprofile%\MSOfficeVersion.txt
echo %MSOvba% >>            %userprofile%\MSOfficeVersion.txt       
echo MS Office details: >>  %userprofile%\MSOfficeVersion.txt
cscript "%msovba%" /dstatus >> %userprofile%\MSOfficeVersion.txt

del %userprofile%\MSOscript.temp 
echo Script result is saved in %userprofile%\MSOfficeVersion.txt
echo.
type %userprofile%\MSOfficeVersion.txt

timeout /T 30 /NOBREAK