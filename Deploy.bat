:: Hide Command and Set Scope
@echo off
setlocal EnableExtensions

:: Customize Window
title Fixinator 9000

::UI Customize
color 03

:: Menu Options
:: Specify as many as you want, but they must be sequential from 1 with no gaps
:: Step 1. List the Application Names
set "App[1]=Network Test"
set "App[2]=Operating System Repair"
set "App[3]=Hardware Diagnostics"
set "App[4]=Verify Licenses"
set "App[5]=Driver Scan"
set "App[6]=Task List"
set "App[7]=Secure File Cipher"
set "App[8]=Power Core Test"
set "App[9]=All Apps"
set "App[10]=Exit"

:: Display the Menu
set "Message="
:Menu
cls
echo.%Message%
echo.
echo.  Deployment Options
echo.
set "x=0"
:MenuLoop
set /a "x+=1"
if defined App[%x%] (
    call echo   %x%. %%App[%x%]%%
    goto MenuLoop
)
echo.

:: Prompt User for Choice
:Prompt
set "Input="
set /p "Input=Select what app:"

:: Validate Input [Remove Special Characters]
if not defined Input goto Prompt
set "Input=%Input:"=%"
set "Input=%Input:^=%"
set "Input=%Input:<=%"
set "Input=%Input:>=%"
set "Input=%Input:&=%"
set "Input=%Input:|=%"
set "Input=%Input:(=%"
set "Input=%Input:)=%"
:: Equals are not allowed in variable names
set "Input=%Input:^==%"
call :Validate %Input%

:: Process Input
call :Process %Input%
goto End


:Validate
set "Next=%2"
if not defined App[%1] (
    set "Message=Invalid Input: %1"
    goto Menu
)
if defined Next shift & goto Validate
goto :eof


:Process
set "Next=%2"
call set "App=%%App[%1]%%"

:: Run Installations
:: Specify all of the installations for each app.
:: Step 2. Match on the application names and perform the installation for each
if "%App%" EQU "Network Test" start cmd /K "title Connection Stability Test - Working & color B4 & ping -w 5 -n 25 www.google.com & echo Continue to reset network configuration? (Connection will be reset) & PAUSE & ipconfig /flushdns & echo ------ & echo Renewing DHCP License, please wait... & ipconfig /renew & echo DNS Test... & nslookup www.google.com & echo OPERATION COMPLETED SUCCESSFULLY! & color B2 & title Connection Stability Test - COMPLETE"
if "%App%" EQU "Operating System Repair" start cmd /K "color C1 & title Operating System Repair - Working &  & echo Run DISM: & DISM /Online /Cleanup-Image /RestoreHealth & echo Begin System Intergrity Scan: & sfc /scannow & chkdsk /f C: & echo Disk Check Complete! & color C2 & echo OPERATION COMPLETED SUCCESSFULLY & title Operating System Repair - COMPLETE"
if "%App%" EQU "Hardware Diagnostics" start cmd /K "color 06 & title Hardware Diagnostics - Running... & echo Please close all other windows prior to testing. & PAUSE & perfmon /report & color 02 & echo OPERATION COMPLETED SUCCESSFULLY & title Hardware Diagnostics - COMPLETE"
if "%App%" EQU "Verify Licenses" start sigverif
if "%App%" EQU "Driver Scan" start cmd /K "title Driver Scan & color 05 & echo Begin Driver Scan Utility? & PAUSE & driverquery -si & color 02 & echo OPERATION COMPLETED SUCCESSFULLY & title Driver Scan - COMPLETE"
if "%App%" EQU "Task List" start cmd /K "title Running Tasks - Scanning... & color 06 & tasklist -svc & echo OPERATION COMPLETED SUCCESSFULLY & color 02 & title Running Tasks - COMPLETE"
if "%App%" EQU "Secure File Cipher" start cmd /K "title Secure File Cipher - Working & color E4 & echo ARE YOU SURE YOU WANT TO OVERWRITE ALL BLANK ON THIS DRIVE? & PAUSE & cipher /w:C & echo Verifying... & color E2 & echo OPERATION COMPLETED SUCCESSFULLY & title Secure File Cipher - COMPLETE"
if "%App%" EQU "Power Core Test" start cmd /K "color 1F & title Power Core Test - Working & echo Searching for last sleep interruption... & echo Last Wake: & Powercfg /lastwake & echo -REPORT END- & echo Continue with power consumption diagnostics? & PAUSE & Powercfg /energy & echo -REPORT END- & echo ############# & echo Generate Battery Report? & Powercfg /batteryreport & echo -REPORT END- & echo ############### & echo OPERATION COMPLETED SUCCESSFULLY & color 12 & title Power Core Test - COMPLETE"
if "%App%" EQU "Exit" color 74 & echo Are you sure you want to end the repair process? & PAUSE & exit

if "%App%" EQU "All Apps" (

start cmd /K "title Connection Stability Test - Working & color B4 & ping -w 5 -n 25 www.google.com & echo Continue to reset network configuration? (Connection will be reset) & PAUSE & ipconfig /flushdns & echo ------ & echo Renewing DHCP License, please wait... & ipconfig /renew & echo DNS Test... & nslookup www.google.com & echo OPERATION COMPLETED SUCCESSFULLY! & color B2 & title Connection Stability Test - COMPLETE"
start cmd /K "color C1 & title Operating System Repair - Working & echo Begin System Intergrity Scan? & PAUSE & sfc /scannow & echo Continue and run DISM? & PAUSE & DISM /Online /Cleanup-Image /RestoreHealth & chkdsk /f C: & echo Disk Check Complete! & color C2 & echo OPERATION COMPLETED SUCCESSFULLY & title Operating System Repair - COMPLETE"
start sigverif
start cmd /K "title Driver Scan & color 05 & echo Begin Driver Scan Utility? & PAUSE & driverquery -si & color 02 & echo OPERATION COMPLETED SUCCESSFULLY & title Driver Scan - COMPLETE"
start cmd /K "title Running Tasks - Scanning... & color 06 & tasklist -svc & echo OPERATION COMPLETED SUCCESSFULLY & color 02 & title Running Tasks - COMPLETE"
start cmd /K "title Secure File Cipher - Working & color E4 & echo ARE YOU SURE YOU WANT TO OVERWRITE ALL BLANK ON THIS DRIVE? & PAUSE & cipher /w:C & echo Verifying... & color E2 & echo OPERATION COMPLETED SUCCESSFULLY & title Secure File Cipher - COMPLETE"
start cmd /K "color 1F & title Power Core Test - Working & echo Searching for last sleep interruption... & echo Last Wake: & Powercfg /lastwake & echo -REPORT END- & echo Continue with power consumption diagnostics? & PAUSE & Powercfg /energy & echo -REPORT END- & echo ############# & echo Generate Battery Report? & Powercfg /batteryreport & echo -REPORT END- & echo ############### & echo OPERATION COMPLETED SUCCESSFULLY & color 12 & title Power Core Test - COMPLETE"
start cmd /K "color 06 & title Hardware Diagnostics - Running... & echo Please close all other windows prior to testing. & PAUSE & perfmon /report & color 02 & echo OPERATION COMPLETED SUCCESSFULLY & title Hardware Diagnostics - COMPLETE"
start notepad
start msconfig
start msinfo32

)

goto :Prompt

:: Prevent the command from being processed twice if listed twice.
set "App[%1]="
if defined Next shift & goto Process
goto :eof


:End
endlocal
pause >nul
