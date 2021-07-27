:: Mirek Sikora
:: 2021-07-21
:: Get PC serial and model numbers

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

:: Show results
:: ------------
echo.
echo PC serial #..:  %pcserial%
echo PC model #...:  %pcmodel%
echo.

Endlocal
pause

