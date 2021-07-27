:: Mirek Sikora
:: 2021-07-27
:: Get list of installed software on local PC

@echo off
Setlocal
SETLOCAL EnableDelayedExpansion

:: Get PC Serial #
:: ---------------
for /f "skip=1 delims=" %%J in ('wmic bios get serialnumber') do (
	set pcserial=!pcserial! %%J
)

:: Get PC Model #
:: --------------
for /f "skip=1 delims=" %%J in ('wmic csproduct get name') do (
	set pcmodel=!pcmodel! %%J
)

:: Get current date and time
:: --------------------------
set YYYYMMDD=%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%
::echo Output date in YYYYMMDD format: %YYYYMMDD%
set hh=%time:~0,2%
set mm=%time:~3,2%

:: Generate software list
:: ----------------------
echo Please wait...
echo.
set OutfileName=InstallList_%YYYYMMDD%_%hh%%mm%.txt
echo Generating output at: %CD%\%OutfileName%
set tempf=Temp%random%.txt
wmic /output:"%CD%\%tempf%" product get name,version

type "%CD%\%tempf%"   > "%CD%\%OutfileName%"
echo.  >> "%CD%\%OutfileName%"
echo PC serial number: %pcserial% >> "%CD%\%OutfileName%"
echo PC model number.: %pcmodel%  >> "%CD%\%OutfileName%"
echo.
if defined %username% (
    echo List generated by user: %username%   >> "%CD%\%OutfileName%"
)
echo List generated on this date (yyyy-mm-dd): %DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%    >> "%CD%\%OutfileName%"

del /Q %tempf%
echo Script ended.
echo.

Endlocal
pause

