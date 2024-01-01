@Echo off
@Echo trader Start
set x=0
set max=700

call "%HOMEPATH%\Anaconda3\Scripts\activate.bat" py37_32
@taskkill /f /im python.exe 2> NUL

:repeat
@tasklist | find "python.exe" /c > NUL
IF %ErrorLevel%==1 goto start_trader
IF NOT %ErrorLevel%==1 goto check_count

:check_count
set /a x=%x%+1
echo x : %x%
IF %x% geq %max% (
    @taskkill /f /im "python.exe"
    goto check_time
)
goto repeat

:start_trader
set x=0
start python "%~dp0/../trader.py"
timeout 5 > NUL
goto repeat

:check_time
for /F "tokens=1-2 delims=:" %%a in ("%TIME%") do (
    set /A "hours=%%a" & set /A "minutes=%%b"
)

if %hours% lss 15 goto repeat
if %hours%==15 if %minutes% lss 30 goto repeat

:: 15시 30분 이후면 스크립트 종료 및 collector.bat 실행
echo It's after 15:30. Ending the script and starting collector.bat
call "%~dp0\collector_v2.bat"
goto end

:end
@Echo trader End
