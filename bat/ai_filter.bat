@Echo off
call "C:\Python\anaconda3\Scripts\activate.bat" py39_64
call python "%~dp0/../ai_filter.py" %1 %2
