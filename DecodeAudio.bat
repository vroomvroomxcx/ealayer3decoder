@echo off
echo ==============================================
echo   EA Layer 3 Stream Extractor/Decoder 0.5.0
echo   (C) 2010, Ben Moench
echo ==============================================
echo.

set "inputDir=%~dp0Work"
set "outputDir=%~dp0DecodedAudio"

if not exist "%outputDir%" mkdir "%outputDir%"

setlocal enabledelayedexpansion

:: Count total files
set /a total=0
for %%i in ("%inputDir%\*.sns") do set /a total+=1
for %%i in ("%inputDir%\*.snr") do set /a total+=1
for %%i in ("%inputDir%\*.vid") do set /a total+=1

set /a count=0

if %total%==0 (
    echo No files found in "Work". Make sure you place .sns, .snr and .vid files there.
    pause
    exit /b
)

echo Found %total% files to decode.
echo.

:: Process .sns files
for %%i in ("%inputDir%\*.sns") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
        copy "%%~dpni.wav" "%outputDir%\" >nul 2>&1
        del "%%~dpni.wav" >nul 2>&1
    ) else (
        echo  Skipping, already decoded: %%~nxi
    )
)

:: Process .snr files
for %%i in ("%inputDir%\*.snr") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
        copy "%%~dpni.wav" "%outputDir%\" >nul 2>&1
        del "%%~dpni.wav" >nul 2>&1
    ) else (
        echo  Skipping, already decoded: %%~nxi
    )
)

:: Process .vid files
for %%i in ("%inputDir%\*.vid") do (
    if not exist "%outputDir%\%%~ni.wav" (
        set /a count+=1
        echo [!count!/%total%] Decoding: %%~nxi
        "%~dp0ffmpeg.exe" -i "%%i" -f wav -y "%outputDir%\%%~ni.wav" >nul 2>&1
    ) else (
        echo  Skipping, already decoded: %%~nxi
    )
)

echo.
echo =========================================
echo  Decoding completed.
echo  Audio files saved to "..\DecodedAudio\"
echo =========================================

:: Prompt to open folder using single key
choice /c YN /n /m "Press Y to open the folder or N to exit: "
if %errorlevel%==1 start "" "%outputDir%"

exit
