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
set /p userCommand="ОСТОРОЖНО! команда: "

timeout /nobreak /t 1 >nul

echo.
echo =======================================
echo Остановка службы TrustedInstaller...
echo.
sc.exe stop TrustedInstaller
echo =======================================
echo.

echo.
echo =======================================
echo Вставка команды...
echo.
sc.exe config TrustedInstaller binpath= "%userCommand%"
echo =======================================
echo.

echo.
echo =======================================
echo Выполнение команды...
echo.
sc.exe start TrustedInstaller
echo =======================================
echo.

echo.
echo =======================================
echo Остановка службы TrustedInstaller...
echo.
sc.exe stop TrustedInstaller
echo =======================================
echo.

echo.
echo =======================================
echo Восстановление исходной конфигурации...
echo.
sc.exe config TrustedInstaller binpath= "C:\Windows\servicing\TrustedInstaller.exe"
echo =======================================
echo.

echo.
echo =======================================
echo Запуск службы TrustedInstaller...
echo.
sc.exe start TrustedInstaller
echo =======================================
echo.

timeout /nobreak /t 1 >nul

echo.
echo =======================================
echo Команда: %userCommand% выполнена!
echo =======================================
echo.

pause >nul
goto :menu