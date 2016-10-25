rem ZC390CLG translate CBL to MLC, assemble/link to 390 via z390, and exec
echo off
echo "Cobol project <%1>"
REM @if %1 == tron ECHO ON
REM @if %1 == tron shift
REM @if %1 == TRON ECHO ON
REM @if %1 == TRON shift
if exist %1.CBL goto erase
REM echo on
echo no zcobol program found %1.CBL
goto end
:erase
echo "AA --------------------------------------------------------"
echo "Erase ..."
dir %1.*
if exist %1.MLC erase %1.MLC
if exist %1.390 erase %1.390
if exist %1.BAL erase %1.BAL
if exist %1.LOG erase %1.LOG
if exist %1.ERR erase %1.ERR
if exist %1.LST erase %1.LST
if exist %1.OBJ erase %1.OBJ
if exist %1.PRN erase %1.PRN
if exist %1.STA erase %1.STA
if exist %1.TR? erase %1.TR?
if exist %1.cpp erase %1.cpp
if exist %1.java  erase %1.java
if exist %1.class erase %1.class
echo "Erase OK"
dir %1.*
echo "AA --------------------------------------------------------"
echo "Compile..."
call %~dps0ZC390 %1 SYSCPY(+zcobol+zcobol\z390) %2 %3 %4 %5 %6 %7 %8 %9
if errorlevel 5 goto mzerr
echo "AA --------------------------------------------------------"
echo "Assemble..."
call %~dps0MZ390 %1  @zcobol\z390\ZC390CLG %2 %3 %4 %5 %6 %7 %8 %9
if errorlevel 5 goto mzerr
echo "AA --------------------------------------------------------"
echo "Link..."
call %~dps0LZ390 %1 SYSOBJ(+zcobol\z390) %2 %3 %4 %5 %6 %7 %8 %9
if errorlevel 5 goto lzerr
rem Program execution
rem call %~dps0EZ390 %1 SYS390(+zcobol\z390) %2 %3 %4 %5 %6 %7 %8 %9
rem if errorlevel 1 goto ezerr
echo "Koool !!!!"
goto end
:mzerr
echo see errors on mz390 generated bal file and console
goto end
:lzerr
echo see errors on lz390 generated lst file and console
erase %1.390
goto end
:ezerr
echo see errors on ez390 generated log file and console
:end
