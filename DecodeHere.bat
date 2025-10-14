@echo off
setlocal enabledelayedexpansion

echo ===============================================
echo   EA Layer 3 Stream Extractor/Decoder 0.5.0
echo   (C) 2010, Ben Moench
echo ===============================================
echo.

set "inputDir=%~dp0"
set "outputDir=%~dp0"

set /a total=0
for %%i in ("%inputDir%\*.sns") do set /a total+=1
for %%i in ("%inputDir%\*.snr") do set /a total+=1
for %%i in ("%inputDir%\*.vid") do set /a total+=1

set /a count=0

if %total%==0 (
    echo No .sns, .snr or .vid files found in the main folder.
    pause
    exit /b
)

echo Found %total% files to decode.
echo.

for %%i in ("%inputDir%\*.sns") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
    ) else (
        echo  Skipping, already decoded: %%~nxi
    )
)

for %%i in ("%inputDir%\*.snr") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
    ) else (
        echo  Skipping, already decoded: %%~nxi
    )
)

for %%i in ("%inputDir%\*.vid") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1@echo off
setlocal enabledelayedexpansion

echo ===============================================
echo   EA Layer 3 Stream Extractor/Decoder 0.5.0
echo   (C) 2010, Ben Moench
echo ===============================================
echo.

set "inputDir=%~dp0"
set "outputDir=%~dp0"

set /a total=0
for %%i in ("%inputDir%\*.sns") do set /a total+=1
for %%i in ("%inputDir%\*.snr") do set /a total+=1
for %%i in ("%inputDir%\*.vid") do set /a total+=1

set /a count=0

if %total%==0 (
    echo No .sns, .snr or .vid files found in the main folder.
    pause
    exit /b
)

echo Found %total% files to decode.
echo.

for %%i in ("%inputDir%\*.sns") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
    ) else (
        echo Skipping, already decoded: %%~nxi
    )
)

for %%i in ("%inputDir%\*.snr") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
    ) else (
        echo Skipping, already decoded: %%~nxi
    )
)

for %%i in ("%inputDir%\*.vid") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ffmpeg.exe" -i "%%i" -f wav -y "%outputDir%\%%~ni.wav" >nul 2>&1
    ) else (
        echo Skipping, already decoded: %%~nxi
    )
)

echo.
echo ====================================
echo  Decoding completed. 
echo  Audio files are in the main folder.
echo ====================================

:: Prompt to open folder using single key
choice /c YN /n /m "Do you want to open the main folder? (Press Y or N): "
if %errorlevel%==1 start "" "%outputDir%"

exit

        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ffmpeg.exe" -i "%%i" -f wav -y "%outputDir%\%%~ni.wav" >nul 2>&1
    ) else (
        echo  Skipping, already decoded: %%~nxi
    )
)

echo.
echo ====================================
echo  Decoding completed. 
echo  Audio files are in the main folder.
echo ====================================

:openFolderHere
echo.
set /p openChoice="Do you want to open the main folder? (Press Y or N): "
if /i "%openChoice%"=="Y" start "" "%outputDir%"
exit