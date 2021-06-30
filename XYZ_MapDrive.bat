REM Mirek Sikora
REM 05/25/2021
REM Persistant drive mapping is causing Windows ID to be locked for users (consultants) that do not have company PC.
REM Meaning they have their own consulting company owned PC, but not the XYZ company PC that they work at, thus
REM theirs PC is not part of the XYZ domain. Cached redentials cause account lockout. 
REM This script will test connection to XYZ network and if successfull map network
REM drive with option persistent set to no
REM -------------------------------------------------------------------------------

@echo off
mode con: cols=90 lines=25
Title XYZ network drives
SETLOCAL
SETLOCAL EnableDelayedExpansion
Set XYZlocalhost=HostName.DomainName.com
set domain=DomainName.com\

echo Checking connection to XYZ system
ping -n 1 %XYZlocalhost% > null
if errorlevel 1 (
    color C0
    echo Connection test to %XYZlocalhost% failed
    timeout /T 5 /NOBREAK
    exit
) else (
    echo Connection test to %XYZlocalhost% successful
    echo.
)

@echo.
@echo Mapping shared network drives
@echo -------------------------------

:GetUserID
SET /P XYZuserID=Enter XYZ user ID: 
REM echo id is: %XYZuserID%

if "%XYZuserID%" == "" ( 
    echo User ID cannot be blank
    GOTO GetUserID
)



net use S: \\%XYZlocalhost%\named-shared-folder\SubFolderName /user:%domain%%XYZuserID% * /PERSISTENT:NO

if %errorlevel%== 0 (	
	echo [32mS: drive is now connected[0m
	) else (
		echo [31mUnable to map S:\ drive[0m		
		echo Error level: %errorlevel%
    		echo.
)


net use U: \\%XYZlocalhost%\sharedName-home\users\%XYZuserID% /user:%domain%%XYZuserID%  /PERSISTENT:NO

if %errorlevel% == 0 (
	echo [32mU: drive is now connected[0m
	) else (
		echo [31mUnable to map U:\ drive[0m
    		echo Error level: %errorlevel%
    		echo.	
)

ENDLOCAL
SETLOCAL DisableDelayedExpansion
timeout /T 10 /NOBREAK

REM @echo Listing cached redentials:
REM @echo --------------------------
REM cmdkey /list
REM or
REM type in Windows search box: Credential Manager

REM timeout /T 30 /NOBREAK