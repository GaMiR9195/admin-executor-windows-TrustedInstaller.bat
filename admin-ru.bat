@echo off
chcp 65001
cls
:: Проверка прав администратора
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo Требуются права администратора. Перезапуск...
    echo.
    timeout /nobreak /t 3 >nul
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:menu
cls
echo.                                                                                 
echo    ^_^_^_^_^_^_^_^_   ^_^_^_   ^_^_^_^_^_^_^_^_   ^_^_^_^_^_^_^_^_   ^_^_^_^_^_^_^_^_ 
echo   ^|^\   ^_^_  ^\ ^|^\  ^\ ^|^\   ^_^_^_ ^\ ^|^\   ^_^_  ^\ ^|^\   ^_^_  ^\  
echo   ^\ ^\  ^\^|^\  ^\^\ ^\  ^\^\ ^\  ^\^_^|^\ ^\^\ ^\  ^\^|^\  ^\^\ ^\  ^\^|^\  ^\  
echo    ^\ ^\   ^_^_^_^_^\^\ ^\  ^\^\ ^\  ^\ ^\^\ ^\^\ ^\  ^\^\^\  ^\^\ ^\   ^_  ^_^\  
echo     ^\ ^\  ^\^_^_^_^| ^\ ^\  ^\^\ ^\  ^\^_^\^\ ^\^\ ^\  ^\^\^\  ^\^\ ^\  ^\^\  ^\^| 
echo      ^\ ^\^_^_^\     ^\ ^\^_^_^\^\ ^\^_^_^_^_^_^_^_^\^\ ^\^_^_^_^_^_^_^_^\^\ ^\^_^_^\^\ ^_^\ 
echo       ^\^|^_^_^|      ^\^|^_^_^| ^\^|^_^_^_^_^_^_^_^| ^\^|^_^_^_^_^_^_^_^| ^\^|^_^_^|^\^|^_^_^|
echo.
echo.

echo.
set /p userCommand="!НЕ СЛОМАЙТЕ СИСТЕМУ НАХУЙ! команда: "

timeout /nobreak /t 1 >nul

echo.
echo =======================================
sc.exe stop TrustedInstaller
sc.exe config TrustedInstaller binpath= "cmd /c %userCommand%"
sc.exe start TrustedInstaller
sc.exe stop TrustedInstaller
sc.exe config TrustedInstaller binpath= "C:\Windows\servicing\TrustedInstaller.exe"
sc.exe start TrustedInstaller
echo =======================================
echo.

timeout /nobreak /t 1 >nul

echo.
echo Команда: %userCommand% выполнена!
echo.

pause >nul
goto :menu