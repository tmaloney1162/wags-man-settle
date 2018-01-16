echo off
if "%1"=="" goto usage
if "%2"=="" goto usage
if "%3"=="" goto usage

REM set the classpath to include the POI files (to read Excel files)
rem set CLASSPATH=.;C:\GP\jakarta-poi-1.5.1-final-bin\build\jakarta-poi-1.5.1-final-20020615.jar

set CLASSPATH=.;C:\GP\poi-3.16\poi-3.16.jar;C:\GP\poi-3.16\poi-ooxml-3.16.jar;
set CLASSPATH=%CLASSPATH%;C:\GP\poi-3.16\ooxml-lib\xmlbeans-2.6.0.jar;C:\GP\poi-3.16\lib\commons-collections4-4.1.jar;C:\GP\poi-3.16\poi-ooxml-schemas-3.16.jar


set JAVA_HOME=C:\GP\jre7\bin
set RUN_DATE=%2%1
set FILE_NAME=%3
set FO_FILE=C:\GP\wags-man-settle\%RUN_DATE%\fo\%FILE_NAME%.fo
set STEP_2=C:\GP\wags-man-settle\%RUN_DATE%\step2.xml

REM goto step2

REM goto create_fo
rem goto fo

rem 1 - run day and month (MMDD)
rem 2 - run year (YYYY)
rem 3 - Excel File name (no extension)

REM Convert Excel to XML

echo %JAVA_HOME%\java -Xms1024M -Xmx1024M ApachePOIExcelReadWagsManSettle C:\GP\bin\wags-man-settle.properties "C:\GP\wags-man-settle\%RUN_DATE%\%3.xlsx" "C:\GP\wags-man-settle\%RUN_DATE%\%3.xml" %4
%JAVA_HOME%\java -Xms1024M -Xmx1024M ApachePOIExcelReadWagsManSettle C:\GP\bin\wags-man-settle.properties "C:\GP\wags-man-settle\%RUN_DATE%\%3.xlsx" "C:\GP\wags-man-settle\%RUN_DATE%\%3.xml" %4

echo.
echo Step 2
:step2
echo %JAVA_HOME%\java -Xms1024M -Xmx1024M transformXSLT C:\GP\wags-man-settle\%RUN_DATE%\%3.xml C:\GP\xsl\step2-wags-man-settle.xsl %STEP_2% %1 %2
%JAVA_HOME%\java -Xms1024M -Xmx1024M transformXSLT C:\GP\wags-man-settle\%RUN_DATE%\%3.xml C:\GP\xsl\step2-wags-man-settle.xsl %STEP_2% %1 %2

:create_fo

REM convert XML to FO (using XSLT)

echo %JAVA_HOME%\java -Xms128M -Xmx128M transformXSLT C:\GP\wags-man-settle\%RUN_DATE%\%3.xml C:\GP\xsl\wk.xsl %FO_FILE% %1 %2
%JAVA_HOME%\java -Xms128M -Xmx128M transformXSLT C:\GP\wags-man-settle\%RUN_DATE%\step2.xml C:\GP\xsl\wags-man-settle.xsl %FO_FILE% %1 %2



:fo
REM Generate the PDF file
cd C:\GP\XEP

echo xep -fo %FO_FILE% C:\GP\wags-man-settle\%RUN_DATE%\output\%3.pdf

call xep -fo %FO_FILE% C:\GP\wags-man-settle\%RUN_DATE%\output\%3.pdf
rem call xep -fo C:\GP\wags-man-settle\20170420\fo\test.fo C:\GP\wags-man-settle\%RUN_DATE%\output\%3.pdf

REM Back to the bin directory
cd C:\GP\bin



echo off
goto end



:end

