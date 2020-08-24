# **AirGap2020 Commemorative NES ROM**

------

### **IMPORTANT DISCLOSURE!!! READ THIS PLEASE!!!**

When selecting **TWITCH CHAT** in the NES ROM, you will see the Twitch chat data appear in 1:1 timing with how twitch chat appeared during the conference.  **This is the entire Twitch chat log of the event and may contain offensive messages, and offensive usernames.**

For the sake of archiving the Twitch chat data in its entirety, I will NOT be editing the Twitch chat data.

Also be aware that messages deleted by moderators in the course of the conference will also appear.

The Twitch chat data in its entirety can be found in `src/twitchchat/ntsc.txt` and `src/twitchchat/pal.txt`.  There is some strange formatting to represent wait time before posting the next message and splits for word/line wrapped text, but the Twitch chat data can be found there.

There is also no guarantee that all of the Twitch chat data.  There is the chance that bot used for logging Twitch chat data may have had networking issues at some point throughout the conference.

------

Commemorative NES ROM for the AirGap2020 conference containing the event schedule and the entire 11 hour Twitch chat log of the event

_**The AirGap2020 Commemorative NES ROM was created by Vi Grey (https://vigrey.com) <vi@vigrey.com> and is licensed under the BSD 2-Clause License.**_

### Description:

This is an MMC1 SLROM (256KB PRG, 128KB CHR) commemorative NES ROM for the AirGap2020 digital conference, which occurred on May 2nd, 2020, that contains the event's talk schedule and the entire 11 hours of Twitch Chat data that plays back in 1:1 time (have fun waiting the entire time for the last message to appear...)

------

## **RUNNING THE NES ROM ON AN EMULATOR**

### Running the NES ROM:
In the main directory of this project, you will find a `bin` directory.  Inside of this directory is a file named `airgap2020-nes-v1_0_0.nes`, which can be opened up in an NES emulator.

------

## **BUILDING THE NES ROM FROM THE SOURCE CODE**

### Build Platforms:
- Linux

### Build Dependencies:
- **asm6** (You'll probably have to build asm6 from source.  Make sure the asm6 binary is named **asm** and that the binary is executable and accessible in your PATH. The source code can be found at http://3dscapture.com/NES/asm6.zip)
- **gmake** (make)

### Build NES ROM:
From a terminal, go to the the main directory of this project (the directory this README.md file exists in).  You can then build the NES ROM with the following command.

```sh
make
```

The resulting NES ROM will be located at `bin/airgap2020-nes.nes` from the main directory.

------

## **LICENSE**
```
Copyright (C) 2020, Vi Grey
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.
```
