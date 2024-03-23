@echo off
setlocal EnableDelayedExpansion

::::::::::::::::::::::::::::::::::::::::::::
:: Elevate.cmd - Version 4
:: Automatically check & get admin rights
:: See "https://stackoverflow.com/a/12264592/1016343" for description
::::::::::::::::::::::::::::::::::::::::::::
:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
  setlocal & cd /d %~dp0
  if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::::::::::::::::::::::::::::::::::::::::::::
:: End of Elevation
::::::::::::::::::::::::::::::::::::::::::::

:: Get the current epoch timestamp
for /f %%i in ('powershell Get-Date -UFormat %%s') do set "epoch=%%i"
set "hostname=%COMPUTERNAME%"
set "outputFolder=%COMPUTERNAME%-DFIR_OUTPUT-%epoch%"
if not exist "!outputFolder!" mkdir "!outputFolder!"

echo This extraction was made with: >> "!outputFolder!\README.txt"
echo ============================= >> "!outputFolder!\README.txt"
echo SimpleDFIR V.0.0.1 >> "!outputFolder!\README.txt"
echo ============================= >> "!outputFolder!\README.txt"
echo. >> "!outputFolder!\README.txt"
echo For more information: https://github.com/Apacalpa
echo For any questions: me@apacalpa.com >> "!outputFolder!\README.txt"
echo. >> "!outputFolder!\README.txt"
echo. >> "!outputFolder!\README.txt"
echo DETAILS: >> "!outputFolder!\README.txt"
echo ----------------------------- >> "!outputFolder!\README.txt"
:: Get begin time in human-readable format
set "beginTime=%date% %time%"
echo Begin Time: !beginTime! >> "!outputFolder!\README.txt"

echo =============================
echo SimpleDFIR V.0.0.1
echo =============================
echo For any questions: me@apacalpa.com
echo RUN_LOCATION = %~dp0

:: Define an array of commands with corresponding themes
set "commands[1]=ver#General_Info"
set "commands[2]=systeminfo#General_Info"
set "commands[3]=Quser#Users"
set "commands[4]=Date /t#System_DateTime"
set "commands[5]=time /t#System_DateTime"
set "commands[6]=Whoami#Users"
set "commands[7]=Netstat -ano#Network"
set "commands[8]=Netstat -anb#Network"
set "commands[9]=Ipconfig /all#Network"
set "commands[10]=Ipconfig /displaydns#Network"
set "commands[11]=Net user#Users"
set "commands[12]=Arp -a#Network"
set "commands[13]=route print#Network"
set "commands[14]=Nbtstat -S#Network"
set "commands[15]=Net sessions#Network"
set "commands[16]=net view \\127.0.0.1#Network"
set "commands[17]=Tasklist#Tasks"
set "commands[18]=Tasklist -v#Tasks"
set "commands[19]=schtasks#Tasks"
set "commands[20]=manage-bde -status#Bitlocker"
set "commands[21]=manage-bde -protectors C: -get#Bitlocker"
set "commands[22]=set#System_Config"
set "commands[23]=vssadmin list shadows#System_Config"
set "commands[24]=wevtutil qe System /c:1 /rd:true /f:text#Event_Logs"
set "commands[25]=wevtutil qe Security /c:1 /rd:true /f:text#Event_Logs"
set "commands[26]=wevtutil qe Application /c:1 /rd:true /f:text#Event_Logs"
set "commands[27]=reg export HKLM\Software registry_export_software.reg#Registry_Export"
set "commands[28]=reg export HKLM\System registry_export_system.reg#Registry_Export"
set "commands[29]=wmic product get name,version#Programs"
set "commands[30]=driverquery#Drivers"
set "commands[31]=sc query#Services"
set "commands[32]=dir C:\ /s#Directory_Listing"
set "commands[33]=netsh advfirewall firewall show rule name=all#Firewall_Rules"
set "commands[34]=net start#Running_Services"
set "commands[35]=netstat -abno#Network_Statistics"
set "commands[36]=handle#Open_Handles"
set "commands[37]=quser#Users"
set "commands[38]=nltest /dclist:domain.com#Domain_Controller_List"
set "commands[39]=net share#System_Config"
set "commands[40]=cmdkey /list#Stored_Credentials"
set "commands[41]=wmic path win32_pnpsigneddriver get deviceid,description,driverversion#Signed_Drivers"
set "commands[42]=wmic printer list status#Running_Services"
set "commands[43]=wmic startup list full#Programs"
set "commands[44]=wmic useraccount list full#Users"
set "commands[45]=whoami /groups#Users"
set "commands[46]=gpresult /Scope Computer /v#Users"
set "commands[47]=wmic qfe get HotFixID,InstalledOn#General_Info"
set "commands[48]=wmic /namespace:\\root\default path SystemRestore get * /value#General_Info"
set "commands[49]=logman query providers#Performance_Providers"
set "commands[50]=ipconfig /displaydns#Network"
set "commands[51]=sfc /scannow#System_File_Check"
set "commands[52]=powercfg /query#General_Info"
set "commands[53]=fltmc#Filter_Manager"
set "commands[54]=tasklist /m#Tasks"
set "commands[55]=wmic memorychip get#General_Info"

:: Loop through the array and execute the commands
for /L %%i in (1,1,55) do (
    for /f "tokens=1,* delims=#" %%a in ("!commands[%%i]!") do (
        set "commandName=%%a"
        set "themeName=%%b"
        set "themeFolder=!outputFolder!\!themeName!"
        if not exist "!themeFolder!" mkdir "!themeFolder!"

        :: Sanitize commandName for a valid filename
        set "sanitizedCommandName=!commandName: =_!"
        set "sanitizedCommandName=!sanitizedCommandName:/=_!"
        set "sanitizedCommandName=!sanitizedCommandName:\=_!"
        set "sanitizedCommandName=!sanitizedCommandName::=_!"
        set "sanitizedCommandName=!sanitizedCommandName:,=_!"

        set "outputFile=!themeFolder!\!hostname!_!themeName!_!sanitizedCommandName!.txt"

        echo RAN COMMAND: !commandName! >>"!outputFile!"
        echo ----- >>"!outputFile!"
        echo RESULT: >>"!outputFile!"
        echo ================================ >>"!outputFile!"

        echo Executing Command: !commandName!
        call !commandName! >>"!outputFile!"

        echo ================================ >>"!outputFile!"

        :: Move exported registry files to the appropriate folder
        if /I "!commandName:~0,3!" equ "reg" (
            move "registry_export_*.reg" "!themeFolder!\" > nul 2>&1
        )
    )
)

set "endTime=%date% %time%"
echo End Time: !endTime! >> "!outputFolder!\README.txt"
echo Executed as user: !USERNAME! >> "!outputFolder!\README.txt"
echo. >> "!outputFolder!\README.txt"
echo Directory Structure: >> "!outputFolder!\README.txt"
echo ------------------- >> "!outputFolder!\README.txt"
tree /a /f "%outputFolder%" >> "!outputFolder!\README.txt"

pause
endlocal
exit /b