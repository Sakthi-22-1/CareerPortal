@echo off
echo ==========================================
echo Starting Smart Career Assessment Portal...
echo ==========================================
set "JAVA_HOME=C:\Program Files\Java\jdk-26.0.1"
set "CATALINA_HOME=C:\apache-tomcat-9.0.118"

echo.
echo ----------------------------------------------------
echo SERVER IS STARTING...
echo In VS Code, you can Ctrl+Click the link below to open:
echo http://localhost:8080/SmartCareerPortal/
echo ----------------------------------------------------
echo.

call "%CATALINA_HOME%\bin\catalina.bat" run
pause
