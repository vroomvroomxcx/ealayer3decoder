@echo off
echo ================================================
echo    EA Layer 3 Stream Extractor/Decoder 0.5.0
echo             (C) 2010, Ben Moench
echo ================================================
echo.

setlocal enabledelayedexpansion

set "inputDir=%~dp0Work"
set "outputDir=%~dp0DecodedAudio"

:: ===== Check Work folder =====
if not exist "%inputDir%" (
    echo "Work" folder not found. Creating one now...
    mkdir "%inputDir%"
    echo.
)

:CHECKFILES
set /a total=0
for %%i in ("%inputDir%\*.sns") do set /a total+=1
for %%i in ("%inputDir%\*.snr") do set /a total+=1
for %%i in ("%inputDir%\*.vid") do set /a total+=1

if %total%==0 (
    echo "Work" folder is empty.
    echo Please place .sns, .snr, or .vid files into that folder.
    echo.
    choice /c YN /n /m "Press Y to add files or N to exit: "
    if errorlevel 2 exit /b
    echo.
    echo Opening the Work folder for you to add files...
    start "" "%inputDir%"
    echo Waiting for you to add files...
    pause
    echo Checking again...
    goto CHECKFILES
)

:: ===== Check output folder =====
if not exist "%outputDir%" mkdir "%outputDir%"

echo Found %total% file(s) to decode.
echo.

set /a decoded=0
set /a skipped=0
set /a processed=0

echo Starting decoding process...
echo.

:: ===== Process .sns files =====
for %%i in ("%inputDir%\*.sns") do (
    set "outfile=%outputDir%\%%~ni.wav"
    if not exist "!outfile!" (
        set /a decoded+=1
        set /a processed+=1
        echo [!processed!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
        copy "%%~dpni.wav" "%outputDir%\" >nul 2>&1
        del "%%~dpni.wav" >nul 2>&1
    ) else (
        set /a skipped+=1
        set /a processed+=1
        echo Skipped. Already decoded: %%~nxi
    )
)

:: ===== Process .snr files =====
for %%i in ("%inputDir%\*.snr") do (
    set "outfile=%outputDir%\%%~ni.wav"
    if not exist "!outfile!" (
        set /a decoded+=1
        set /a processed+=1
        echo [!processed!/%total%] Decoding: %%~nxi
        "%~dp0ealayer3.exe" -mc "%%i"
        copy "%%~dpni.wav" "%outputDir%\" >nul 2>&1
        del "%%~dpni.wav" >nul 2>&1
    ) else (
        set /a skipped+=1
        set /a processed+=1
        echo Skipped. Already decoded: %%~nxi
    )
)

:: ===== Process .vid files =====
for %%i in ("%inputDir%\*.vid") do (
    set "outfile=%outputDir%\%%~ni.wav"
    if not exist "!outfile!" (
        set /a decoded+=1
        set /a processed+=1
        echo [!processed!/%total%] Decoding: %%~nxi
        "%~dp0ffmpeg.exe" -i "%%i" -f wav -y "!outfile!" >nul 2>&1
    ) else (
        set /a skipped+=1
        set /a processed+=1
        echo Skipped. Already decoded: %%~nxi
    )
)

echo.
echo ==================================================
:: ============== Ending message =================
if %decoded%==0 (
    :: All skipped
    echo No files were processed.
    echo =================================================
    echo.
    echo Press any key to exit.
    pause >nul
    exit /b
) else (
    if %skipped% gtr 0 (
        :: Some decoded, some skipped
        if %decoded%==1 (
            echo Decoding complete. 1 file was processed, %skipped% skipped.
        ) else (
            echo Decoding complete. %decoded% of %total% files were processed, %skipped% skipped.
        )
        echo Decoded audio has been saved to "..\DecodedAudio\".
        echo ===================================================
        choice /c YN /n /m "Press Y to open the folder or N to exit: "
        if %errorlevel%==1 start "" "%outputDir%"
        exit /b
    ) else (
        :: All decoded (no skipped)
        if %total%==1 (
            echo Decoding completed. All 1 file was processed.
        ) else (
            echo Decoding completed. All %total% files processed.
        )
        echo Decoded audio has been saved to "..\DecodedAudio\".
        echo ===================================================
        choice /c YN /n /m "Press Y to open the folder or N to exit: "
        if %errorlevel%==1 start "" "%outputDir%"
        exit /b
    )
)
