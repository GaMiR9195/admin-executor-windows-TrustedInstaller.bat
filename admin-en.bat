@echo off
:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Требуются права администратора. Перезапуск...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:menu
chcp 65001
cls

echo.                                                                                 
echo ​  ^_^_^_^_^_^_^_^_^_  ^_^_^_^_^_^_^_^_  ^_^_^_^_^_^_^_^_  ^_^_^_          
echo ​ ^|^\^_^_^_   ^_^_^_^\^\   ^_^_  ^\^|^\   ^_^_  ^\^|^\  ^\         
echo ​ ^\^|^_^_^_ ^\  ^\^_^\ ^\  ^\^|^\  ^\ ^\  ^\^|^\  ^\ ^\  ^\        
echo ​      ^\ ^\  ^\ ^\ ^\  ^\^\^\  ^\ ^\  ^\^\^\  ^\ ^\  ^\       
echo ​       ^\ ^\  ^\ ^\ ^\  ^\^\^\  ^\ ^\  ^\^\^\  ^\ ^\  ^\^_^_^_^_  
echo ​        ^\ ^\^_^_^\ ^\ ^\^_^_^_^_^_^_^_^\ ^\^_^_^_^_^_^_^_^\ ^\^_^_^_^_^_^_^_^\
echo ​         ^\^|^_^_^|  ^\^|^_^_^_^_^_^_^_^|^\^|^_^_^_^_^_^_^_^|^\^|^_^_^_^_^_^_^_^|
echo.
echo.

echo.
set /p userCommand="Please be careful! execute> "

timeout /nobreak /t 1 >nul

echo.
echo =======================================
echo Stopping TrustedInstaller...
echo.
sc.exe stop TrustedInstaller
echo =======================================
echo.

echo.
echo =======================================
echo Pasting command...
echo.
sc.exe config TrustedInstaller binpath= "%userCommand%"
echo =======================================
echo.

echo.
echo =======================================
echo Executing command...
echo.
sc.exe start TrustedInstaller
echo =======================================
echo.

echo.
echo =======================================
echo Stopping TrustedInstaller...
echo.
sc.exe stop TrustedInstaller
echo =======================================
echo.

echo.
echo =======================================
echo TrustedInstaller to default config...
echo.
sc.exe config TrustedInstaller binpath= "C:\Windows\servicing\TrustedInstaller.exe"
echo =======================================
echo.

echo.
echo =======================================
echo Starting TrustedInstaller...
echo.
sc.exe start TrustedInstaller
echo =======================================
echo.

timeout /nobreak /t 1 >nul

echo.
echo =======================================
echo Command: %userCommand% success!
echo =======================================
echo.

pause >nul
goto :menu