@echo off
cd /d "%~dp0"
echo Starting GLB site from %CD% > "%~dp0start-site.log"

:: Kill any process running on port 4175 to avoid EADDRINUSE errors
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :4175') do taskkill /f /pid %%a >nul 2>&1

:: Start a parallel process to wait 4 seconds and then open the browser automatically
start /b cmd /c "timeout /t 4 >nul && start http://localhost:4175"

call "C:\Program Files\nodejs\npm.cmd" run build >> "%~dp0start-site.log" 2>&1
"C:\Program Files\nodejs\node.exe" "%~dp0server.js" >> "%~dp0start-site.log" 2>&1
echo Exit code %ERRORLEVEL% >> "%~dp0start-site.log"
pause
