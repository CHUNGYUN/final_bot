@Echo off
@Echo collector Start
set x=0
set max=5000

call "%HOMEPATH%\Anaconda3\Scripts\activate.bat" py37_32
@taskkill /f /im python.exe 2> NUL

:repeat
@tasklist | find "python.exe" /c > NUL
IF %ErrorLevel%==1 goto start_collector
IF NOT %ErrorLevel%==1 goto check_counter

:check_counter
set /a x=%x%+1
echo x : %x%
IF %x% geq %max% (
    @taskkill /f /im "python.exe"
    goto end_script
)
goto repeat

:start_collector
set x=0
start python "%~dp0/../collector_v3.py"
timeout 5 > NUL
goto repeat

:end_script
for /F "tokens=1-2 delims=:" %%a in ("%TIME%") do (
    set /A "hours=%%a" & set /A "minutes=%%b"
)
if %hours% lss 23 goto repeat
if %hours%==23 if %minutes% lss 45 goto repeat

@Echo It's after 23:45, stopping the script.
goto end

:end
@Echo collector End
