echo on
rem if %1 == tron ECHO ON
rem if %1 == tron shift
rem if %1 == TRON ECHO ON
rem if %1 == TRON shift
rem exec execute 390 load module
if exist %1.log erase %1.log
if exist %1.err erase %1.err
if exist %1.sta erase %1.sta
if exist %1.tr* erase %1.tr*
echo "%~dps0ez390 %1 %2 %3 %4 %5 %6 %7 %8 %9"
call %~dps0ez390 %1 %2 %3 %4 %5 %6 %7 %8 %9
if errorlevel 5 goto ezerr
goto end
:ezerr
echo see errors on ez390 generated log file and console
:end
