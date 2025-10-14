EA Layer 3 Audio Decoder & Converter
====================================

This project provides simple batch scripts for decoding EA Layer 3 audio files
(used in games like The Sims 4, The Sims 3, and The Sims Medieval + The Sims & The Sims 2) into WAV format,
and converting them to FLAC (lossless) or M4A (AAC, 320 kbps).

------------------------------------
CONTENTS
------------------------------------
1. Features
2. How to Extract Game Audio
   2.1 Install Tools
   2.2 Locate and Extract _AUD Files
   2.3 Decode .SNS Files
   2.4 Convert Decoded Audio
   2.5 Add Metadata
3. Usage Summary
4. Requirements
5. Notes

------------------------------------
1. FEATURES
------------------------------------
- Batch decoding of .sns files
- Converts WAV files to FLAC or M4A
- Skips existing files to avoid overwriting
- Automatically creates output folders
- Shows clean, clear progress messages

------------------------------------
2. HOW TO EXTRACT GAME AUDIO
------------------------------------

2.1 INSTALL TOOLS
Download and install:
- S4PE for The Sims 4
- S3PE for The Sims 3 and Medieval
- SimPE for The Sims 2

2.2 LOCATE AND EXTRACT _AUD FILES
For The Sims 4:
Open s4pe.exe, then File > Open.
Look in:
  ..\The Sims 4\Data\Client\
  ..\The Sims 4\EP(SP)XX\
Filter by tag "_AUD", sort by size, and export .sns files.
Save them into the "Work" folder.

For The Sims 3 / Medieval:
Open s3pe.exe, then File > Open.
Look in:
  ..\The Sims 3\GameData\Shared\Packages\
  ..\The Sims 3\EPX(SP)XX\GameData\Shared\Packages\
Export .sns files to the "Work" folder.

For The Sims / The Sims 2:
See a proper documentation online, I don't completely understand how to use that tool.

2.3 DECODE .SNS FILES
Place all .sns files in the "Work" folder.
Run DecodeAudio.bat.
After decoding, WAV files will appear in "DecodedAudio".
Press Y to open the folder, or N to exit.

2.4 CONVERT DECODED AUDIO
Run ConvertAudio.bat.
Choose FLAC, M4A, or both.
Converted files are saved in:
  ..\ConvertedAudio\FLAC\
  ..\ConvertedAudio\M4A\
Existing files are skipped automatically.

2.5 ADD METADATA
Decoded audio has no tags.
Use a tag editor such as Mp3tag to add metadata
(Title, Artist, Album, etc.).

------------------------------------
3. USAGE SUMMARY
------------------------------------
1. Put your .sns, .snr, or .vid files into "Work".
2. Run DecodeAudio.bat to decode them.
3. Run ConvertAudio.bat to convert to FLAC or M4A.
4. Converted files appear in "ConvertedAudio" subfolders.

------------------------------------
4. REQUIREMENTS
------------------------------------
- Windows operating system
- FFmpeg executable (included or use your own)
- No installation needed; just run the batch files

------------------------------------
5. NOTES
------------------------------------
- Extracted audio does not include metadata
- For personal use only with legally owned games
- Scripts will not overwrite existing files

------------------------------------

------------------------------------
