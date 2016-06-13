@echo off
set tomcathome=E:\javaServer\tomcat6utf8
call ant.bat clean
call mvn.bat dependency:copy-dependencies -DoutputDirectory=web/WEB-INF/lib
call ant.bat -Dtomcathome=%tomcathome%
xcopy "%tomcathome%\conf" /Y "%cd%\tomcat\conf\"
mkdir tomcat\conf\Catalina\localhost
echo ^<^?xml version="1.0" encoding="UTF-8"^?^> > tomcat/conf/Catalina/localhost/ROOT.xml
echo.^<Context path="" docBase="%cd%\web" /^> >> tomcat/conf/Catalina/localhost/ROOT.xml
set CATALINA_BASE=%cd%\tomcat
set CATALINA_HOME=%tomcathome%
set CATALINA_TMPDIR=%tomcathome%\temp
call %tomcathome%\bin\catalina.bat run
