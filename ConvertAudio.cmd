@echo off
setlocal enabledelayedexpansion

:: ============== FFMPEG CHECKS ==================
:: Check if ffmpeg is available (either locally or system-wide)
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    if not exist "%~dp0ffmpeg.exe" (
        echo ERROR: FFmpeg was not found.
        echo Make sure either:
        echo   1. FFmpeg is installed to your system PATH
        echo   2. 'ffmpeg.exe' is in the same folder as 'ConvertAudio.cmd'
        echo.
        echo You can download FFmpeg here: https://ffmpeg.org/download.html
        echo.
        echo Press any key to exit...
        pause >nul
        exit
    )
)

cls
echo =====================================================
echo                Batch Audio Converter
echo                  Powered by FFmpeg
echo =====================================================
echo.

:: Set folder paths
set "BASE_DIR=%~dp0"
set "INPUT_DIR=%BASE_DIR%DecodedAudio"
set "OUTPUT_DIR=%BASE_DIR%ConvertedAudio"
set "FLAC_DIR=%OUTPUT_DIR%\FLAC"
set "M4A_DIR=%OUTPUT_DIR%\M4A"

:: ================ CHECK INPUT FOLDER ==================
:CHECK_INPUT
if not exist "%INPUT_DIR%" (
    echo The "DecodedAudio" folder was not found.
    goto RUN_DECODE_PROMPT
)

:: Count WAV files
set WAV_COUNT=0
for %%f in ("%INPUT_DIR%\*.wav") do (
    set /a WAV_COUNT+=1
)

if %WAV_COUNT%==0 (
    echo No audio files were found in the "DecodedAudio" folder.
    goto RUN_DECODE_PROMPT
)

goto FORMAT_CHOICE

:: ============= USE TO DECODE SCRIPT =================
:RUN_DECODE_PROMPT
echo.
echo Do you want to run decode audio script to process audio files?
echo.
choice /c YN /n /m "Press Y to run DecodeAudio.cmd or N to exit: "
if %errorlevel%==1 (
    cls
    if exist "%BASE_DIR%DecodeAudio.cmd" (
        echo ================================================
        echo            Running DecodeAudio.cmd...
        echo ================================================
        echo.
        call "%BASE_DIR%DecodeAudio.cmd"
        cls
        goto FRESH_START
    ) else (
        echo ERROR: 'DecodeAudio.cmd' was not found.
        echo.
        echo Make sure it is in the same folder as 'ConvertAudio.cmd'
        echo Or download it from: https://github.com/vroomvroomxcx/ealayer3decoder 
        echo.
        echo Press any key to exit...
        pause >nul
        exit
    )
) else (
    echo Exiting...
    exit
)

:: ============= AUDIO FORMAT CHOICE =================
:FORMAT_CHOICE
echo Choose an audio conversion format:
echo.
echo   [1] FLAC (Lossless)
echo   [2] M4A  (AAC, 320 kbps)
echo   [3] Both FLAC + M4A
echo   [Q] Quit
echo.

choice /c 123Q /n /m "Press 1-3 or Q to quit: "
set "CHOICE=%errorlevel%"

if %CHOICE%==1 set CHOICE=1
if %CHOICE%==2 set CHOICE=2
if %CHOICE%==3 set CHOICE=3
if %CHOICE%==4 set CHOICE=Q
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
echo =====================================================
echo.
echo Converting Audio Files
echo.

:: Initialize counters
set /a CONVERTED_COUNT=0
set /a SKIPPED_COUNT=0
set /a TOTAL_COUNT=0

for %%f in ("%INPUT_DIR%\*.wav") do (
    set /a TOTAL_COUNT+=1
    set "FILENAME=%%~nf"
    set "SKIPPED=0"

    echo ----------------------------------------------------
    echo Processing "%%~nxf"...
    echo ----------------------------------------------------

    if "%CHOICE%"=="1" (
        if exist "%FLAC_DIR%\!FILENAME!.flac" (
            set "SKIPPED=1"
        ) else (
            echo Converting to FLAC...
            ffmpeg -hide_banner -loglevel error -stats -i "%%f" "%FLAC_DIR%\!FILENAME!.flac"
            echo Finished converting to FLAC.
        )
    ) else if "%CHOICE%"=="2" (
        if exist "%M4A_DIR%\!FILENAME!.m4a" (
            set "SKIPPED=1"
        ) else (
            echo Converting to AAC...
            ffmpeg -hide_banner -loglevel error -stats -i "%%f" -c:a aac -b:a 320k "%M4A_DIR%\!FILENAME!.m4a"
            echo Finished converting to AAC.
        )
    ) else if "%CHOICE%"=="3" (
        set "ALLSKIPPED=1"

        if not exist "%FLAC_DIR%\!FILENAME!.flac" (
            echo Converting to FLAC...
            ffmpeg -hide_banner -loglevel error -stats -i "%%f" "%FLAC_DIR%\!FILENAME!.flac"
            echo Finished converting to FLAC.
            set "ALLSKIPPED=0"
        )

        if not exist "%M4A_DIR%\!FILENAME!.m4a" (
            echo Converting to AAC...
            ffmpeg -hide_banner -loglevel error -stats -i "%%f" -c:a aac -b:a 320k "%M4A_DIR%\!FILENAME!.m4a"
            echo Finished converting to AAC.
            set "ALLSKIPPED=0"
        )

        if "!ALLSKIPPED!"=="1" set "SKIPPED=1"
    )

    if "!SKIPPED!"=="0" (
        set /a CONVERTED_COUNT+=1
    ) else (
        set /a SKIPPED_COUNT+=1
        echo Skipped "%%~nxf"; file already exists.
    )
)

:: ================= ENDING MESSAGE =================
echo ----------------------------------------------------
echo.

if %CONVERTED_COUNT% gtr 0 (
    if %SKIPPED_COUNT%==0 (
        echo Conversion Completed. %CONVERTED_COUNT% file^(s^) converted successfully.
    ) else (
        echo Conversion Completed. %CONVERTED_COUNT% converted, %SKIPPED_COUNT% skipped.
    )
) else (
    echo Skipped. No new files were converted.
    echo.
    echo Press any key to exit...
    pause >nul
    exit /b
)

:: Determine output folder text
if "%CHOICE%"=="1" (
    set "OPEN_DIR=%FLAC_DIR%"
    set "DISPLAY_PATH=..\ConvertedAudio\FLAC\"
) else if "%CHOICE%"=="2" (
    set "OPEN_DIR=%M4A_DIR%"
    set "DISPLAY_PATH=..\ConvertedAudio\M4A\"
) else (
    set "OPEN_DIR=%OUTPUT_DIR%"
    set "DISPLAY_PATH=..\ConvertedAudio\"
)

echo Files saved to: "%DISPLAY_PATH%"
echo.
echo =====================================================
echo.

:: Ask to open folder only if at least 1 file converted
choice /c YN /n /m "Press Y to open the folder or N to exit: "
if %errorlevel%==1 start "" "%OPEN_DIR%"
exit /b
