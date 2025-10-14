EA Layer 3 Stream Extractor/Decoder 0.5.0
Copyright (C) 2010, Ben Moench

What it does:
Decodes .sns, .snr, and .vid files into .wav audio.

Decode.bat – Decodes files from Work into Output
DecodeHere.bat – Decodes files in the current folder.

How to use:
Place your input files in the appropriate folder.
Run the .bat file.
Check the output folder for your .wav files.

Supported File Types
File	Description	     Decoder
.sns	Audio stream	     ealayer3.exe
.snr	Audio stream	     ealayer3.exe
.vid	Video/Audio stream   ffmpeg.exe

Notes
Make sure ealayer3.exe and ffmpeg.exe are in the same folder as the script.
On repeated runs, Decode.bat will skip already decoded files to save time.
If you want to decode new files, just place them in Work — the script will automatically process them.