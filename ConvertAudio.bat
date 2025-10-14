@echo off
setlocal enabledelayedexpansion

:: ================= HEADER =================
echo ==================================================
echo               Audio Batch Converter
echo ==================================================
echo.

:: Set folder paths
set "BASE_DIR=%~dp0"
set "INPUT_DIR=%BASE_DIR%DecodedAudio"
set "OUTPUT_DIR=%BASE_DIR%ConvertedAudio"
set "FLAC_DIR=%OUTPUT_DIR%\FLAC"
set "M4A_DIR=%OUTPUT_DIR%\M4A"

:: Check if input folder exists and has WAV files
if not exist "%INPUT_DIR%" (
    echo =================================================================
    echo  ERROR: "DecodedAudio" folder not found.
    echo  Please make sure it exists inside the EALayer3Decoder directory.
    echo =================================================================
    pause
    exit
)

set WAV_COUNT=0
for %%f in ("%INPUT_DIR%\*.wav") do (
    set /a WAV_COUNT+=1
)

if %WAV_COUNT%==0 (
    echo ===================================================
    echo  No audio files found in "DecodedAudio" folder.
    echo  Please place your .wav files there before running.
    echo ===================================================
    timeout /t 5 >nul
    exit
)

:FORMAT_CHOICE
:: Prompt user for conversion choice
echo Choose audio conversion format:
echo.
echo   [1] FLAC (Lossless)
echo   [2] M4A  (AAC, 320 kbps)
echo   [3] Both FLAC + M4A
echo   [Q] Quit
echo.

choice /c 123Q /n /m "Press 1-3 or Q to quit: "
set "CHOICE=%errorlevel%"

:: Map choice to actual values
if %CHOICE%==1 set CHOICE=1
if %CHOICE%==2 set CHOICE=2
if %CHOICE%==3 set CHOICE=3
if %CHOICE%==4 set CHOICE=Q

:: Handle quit option
if /i "%CHOICE%"=="Q" exit

:: Create output folders if they don't exist
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"
if "%CHOICE%"=="1" if not exist "%FLAC_DIR%" mkdir "%FLAC_DIR%"
if "%CHOICE%"=="2" if not exist "%M4A_DIR%" mkdir "%M4A_DIR%"
if "%CHOICE%"=="3" (
    if not exist "%FLAC_DIR%" mkdir "%FLAC_DIR%"
    if not exist "%M4A_DIR%" mkdir "%M4A_DIR%"
)

:: ================= START CONVERSION =================
echo.
echo  Converting files...

for %%f in ("%INPUT_DIR%\*.wav") do (
    set "FILENAME=%%~nf"
    set "SKIPPED=0"

    echo ==================================================
    echo  Converting "%%~nxf"...
    echo ==================================================

    if "%CHOICE%"=="1" (
        if exist "%FLAC_DIR%\!FILENAME!.flac" (
            set "SKIPPED=1"
        ) else (
            ffmpeg -hide_banner -stats -i "%%f" "%FLAC_DIR%\!FILENAME!.flac"
        )
    ) else if "%CHOICE%"=="2" (
        if exist "%M4A_DIR%\!FILENAME!.m4a" (
            set "SKIPPED=1"
        ) else (
            ffmpeg -hide_banner -stats -i "%%f" -c:a aac -b:a 320k "%M4A_DIR%\!FILENAME!.m4a"
        )
    ) else if "%CHOICE%"=="3" (
        set "ALLSKIPPED=1"
        if not exist "%FLAC_DIR%\!FILENAME!.flac" (
            ffmpeg -hide_banner -stats -i "%%f" "%FLAC_DIR%\!FILENAME!.flac"
            set "ALLSKIPPED=0"
        )
        if not exist "%M4A_DIR%\!FILENAME!.m4a" (
            ffmpeg -hide_banner -stats -i "%%f" -c:a aac -b:a 320k "%M4A_DIR%\!FILENAME!.m4a"
            set "ALLSKIPPED=0"
        )
        if "!ALLSKIPPED!"=="1" set "SKIPPED=1"
    )

    if "!SKIPPED!"=="0" (
        echo ==================================================
        echo  Finished converting "%%~nxf".
        echo ==================================================
    ) else (
        echo  Skipped "%%~nxf", already exists.
    )
)

:: ================= ENDING MESSAGE =================
echo ========================================
if "%CHOICE%"=="1" (
    set "OPEN_DIR=%FLAC_DIR%"
    set "DISPLAY_PATH="..\ConvertedAudio\FLAC\""
) else if "%CHOICE%"=="2" (
    set "OPEN_DIR=%M4A_DIR%"
    set "DISPLAY_PATH="..\ConvertedAudio\M4A\""
) else (
    set "OPEN_DIR=%OUTPUT_DIR%"
    set "DISPLAY_PATH="..\ConvertedAudio\""
)

echo  Audio conversion completed.
echo  Audio saved to %DISPLAY_PATH%
echo ========================================
echo.

:: Prompt to open folder using single key
choice /c YN /n /m "Press Y to open the folder or N to exit: "
if %errorlevel%==1 start "" "%OPEN_DIR%"

exit
