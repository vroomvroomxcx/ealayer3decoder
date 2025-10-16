---

# EA Layer 3 Audio Decoder & Converter

This repository includes a set of **batch scripts** for decoding EA Layer 3 audio files (used in games such as *The Sims 4*, *The Sims 3*, *The Sims Medieval* and possibly *The Sims* & *The Sims 2*) into **WAV** format and converting them into standard formats like **FLAC (lossless)** or **M4A (AAC, 320 kbps)**.

---

## ✨ Features

* **Batch decoding** – Automatically processes all `.sns`, `.snr`, and `.vid` compressed audio files in a folder.
* **Audio conversion** – Converts decoded `.wav` files to FLAC or M4A formats.
* **Skip existing files** – Prevents overwriting previously converted files.
* **Automatic folder creation** – Organizes output into `FLAC` and `M4A` subfolders.
* **Clean, informative output** – Displays only successful conversions and skipped files.

---

## 📚 Table of Contents

* [✨ Features](#-features)
* [🎵 How to Extract Music from The Sims 4, 3 & Medieval](#-how-to-extract-music-from-the-sims-4-3-and-medieval-and-possibly-the-sims--the-sims-2)

  * [Step 1: Install Tools](#step-1-install-tools)
  * [Step 2: Locate and Extract _AUD Files](#step-2-locate-and-extract-_aud-files)

    * [The Sims 4](#for-the-sims-4)
    * [The Sims 3 & Medieval](#for-the-sims-3--the-sims-medieval)
    * [The Sims & The Sims 2](#for-the-sims--the-sims-2)
  * [Step 3: Decode .SNS Files](#step-3-decode-sns-files)
  * [Step 4: Convert Decoded Audio](#step-4-convert-decoded-audio)
  * [Step 5: Identify and Tag Your Audio](#step-5-identify-and-tag-your-audio)
* [⚙️ Usage Summary](#️-usage-summary)
* [🧩 Requirements](#-requirements)
* [📄 Notes](#-notes)

---

Would you like me to integrate it directly into your cleaned-up README so it’s fully formatted and consistent with the rest of the markdown (so you can copy it all at once)?


## 🎵 How to Extract Music from *The Sims 4*, *3*, and *Medieval* (and possibly The Sims + The Sims 2)

Follow these steps to extract in-game music and soundtracks into `.wav` files, ready for conversion.

---

### Step 1: Install Tools

Download and install **S4PE** and **S3PE**:

* [S4PE (The Sims 4 Package Editor)](https://github.com/s4ptacle/Sims4Tools/releases)
* [S3PE (The Sims 3 Package Editor)](http://sourceforge.net/projects/sims3tools/files/s3pe/14-0222-1852/s3pe_14-0222-1852.7z/download)

---

### Step 2: Locate and Extract `_AUD` Files

#### For *The Sims 4*

1. Open **s4pe.exe** → **File > Open** → select your *The Sims 4* installation folder.
2. Audio files are stored in:

   * Base game: `..\The Sims 4\Data\Client\`
   * Expansion/Stuff packs: `..\The Sims 4\EP(SP)XX\`
   * Common audio packages:
     `ClientFullBuild1`, `ClientFullBuild2`, `ClientFullBuild3`, `ClientFullBuild4`, `ClientFullBuild5`, `ClientDeltaBuild1`, `ClientDeltaBuild2`, `ClientDeltaBuild3`, `ClientDeltaBuild4`, `ClientDeltaBuild5`
3. Filter only audio files:

   * In the filter section, enter `_AUD` in the **Tag** field, check **Tag** and **Filter Active**, then click **Set**.
4. Sort by size:

   * Click the **Memsize** column header **twice** to sort files from largest to smallest.
5. Select `.sns` files (they contain actual audio data).
6. Right-click → **Export > To file…** and extract them into the **Decoder** folder or the **Work** folder (recommended).

---

#### For *The Sims 3* & *The Sims Medieval*

Follow the same extraction steps using **s3pe.exe**.

* Base game files: `..\The Sims 3\GameData\Shared\Packages\`
* Expansions & Stuff Packs: `..\The Sims 3\EPX(SP)XX\GameData\Shared\Packages\`
* Look for files named `FullBuild_XX.package` or `DeltaBuild_XX.package`.

#### For *The Sims* & *The Sims 2*
Not yet tested but I feel like extracted audio's can be converted with the steps below, if not, use [vgstream](https://vgmstream.org/)

---

### Step 3: Decode `.SNS` Files

1. Place all extracted `.sns` files in the **Work** folder.
2. Run `DecodeAudio.bat`.
3. Wait for decoding to complete.
4. Press **Y** to open the decoded audio folder or **N** to close.

Your decoded audio is now in **.WAV** format — note that WAV files are large and may have compatibility issues.

---

### Step 4: Convert Decoded Audio

1. Run `ConvertAudio.bat`.
2. Choose your desired output: **FLAC**, **M4A**, or **both**.
3. Converted files are saved in:

   ```
   ..\ConvertedAudio\FLAC\
   ..\ConvertedAudio\M4A\
   ```
4. Existing files are skipped automatically.

---

### Step 5: Identify and Tag Your Audio

Decoded files do **not** include metadata.
You may need to compare and listem audio with the radio stations inside The Sims (Open Settings → Music → Select Genre & Listen)
You can use a tag editor such as [Mp3tag](https://www.mp3tag.de/en/download.html) to add:

* Title, Artist, Album, Composer, BPM, etc.

After tagging, your audio files will be ready for playback with most media players.

---

## ⚙️ Usage Summary

1. Place your `.sns`, `.snr`, or `.vid` files in the **Work** folder.
2. Run **DecodeAudio.bat** to decode them into **DecodedAudio**.
3. Run **ConvertAudio.bat** to convert `.wav` files to FLAC or M4A.
4. Choose the format when prompted.
5. Find converted files in:

   ```
   ConvertedAudio\FLAC\
   ConvertedAudio\M4A\
   ```

---

## 🧩 Requirements

* **Windows OS**
* **FFmpeg** executable (included or bring your own)
* No installation required – simply download and run the `.bat` scripts.

---

## 📄 Notes

* Extracted audio contains **no metadata**.
* Intended for **personal use** with legally owned game files.
* Scripts are designed to **avoid overwriting existing files**.
