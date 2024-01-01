@Echo off
@Echo real estimate subscripton Start
set x=0
call "C:\Python\anaconda3\Scripts\activate.bat" py39_64

:repeat

start python "%~dp0/../real_estimate_subscription.py"
timeout 10 > NUL
goto repeat
