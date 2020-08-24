; Copyright (C) 2020, Vi Grey
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions
; are met:
;
; 1. Redistributions of source code must retain the above copyright
;    notice, this list of conditions and the following disclaimer.
; 2. Redistributions in binary form must reproduce the above copyright
;    notice, this list of conditions and the following disclaimer in the
;    documentation and/or other materials provided with the distribution.
;
; THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
; ARE DISCLAIMED. IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
; OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
; LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
; OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
; SUCH DAMAGE.


; Board Type: MMC1 SLROM 256KB PRG ROM 128KB CHR ROM 

  .db "NES", $1A
  .db $10
  .db $10
  .db %00010000
  .dsb 9, $00

.include "ram.asm"
.include "defs.asm"
  
.base $8000
  .incbin "twitchchat/ntsc.txt"
  .incbin "twitchchat/pal.txt"

.pad $44000, $FF
.base $C000

  .include "prg.asm"
  .include "chat.asm"
  .include "zero.asm"
  .include "draw.asm"
  .include "title.asm"
  .include "schedule.asm"
  .include "decompress.asm"
  .include "controls.asm"
  .include "mmc1.asm"
  .include "screen.asm"
  .include "scroll.asm"
  .include "schedule-text.asm"


.pad CALLBACK, #$FF
  .dw  NMI
  .dw  RESET
  .dw  0

.base $0000
  .incbin "graphics/title-tileset.chr"
  .incbin "graphics/twitch-chat-tileset.chr"
.pad $4000, $00
  .incbin "graphics/bar-top.bin"
.pad $4200, $00
  .incbin "graphics/ascii.bin"
.pad $4800, $00
  .incbin "graphics/schedule/00.bin"
  .incbin "graphics/schedule/01.bin"
  .incbin "graphics/schedule/02.bin"
.pad $5000, $00
  .incbin "graphics/bar-top.bin"
  .incbin "graphics/ascii.bin"
.pad $5500, $00
  .incbin "graphics/schedule/03.bin"
  .incbin "graphics/schedule/04.bin"
  .incbin "graphics/schedule/05.bin"
  .incbin "graphics/schedule/06.bin"
  .incbin "graphics/schedule/07.bin"
  .incbin "graphics/schedule/08.bin"
  .incbin "graphics/schedule/09.bin"
.pad $6000, $00
  .incbin "graphics/bar-top.bin"
.pad $6200, $00
  .incbin "graphics/ascii.bin"
.pad $6800, $00
  .incbin "graphics/schedule/0A.bin"
  .incbin "graphics/schedule/0B.bin"
  .incbin "graphics/schedule/0C.bin"
.pad $7000, $00
  .incbin "graphics/bar-top.bin"
.pad $7200, $00
  .incbin "graphics/ascii.bin"
.pad $7800, $00
  .incbin "graphics/schedule/0D.bin"
  .incbin "graphics/schedule/0E.bin"
  .incbin "graphics/schedule/0F.bin"
.pad $8000, $00
  .incbin "graphics/bar-top.bin"
.pad $8200, $00
  .incbin "graphics/ascii.bin"
.pad $8800, $00
  .incbin "graphics/schedule/10.bin"
  .incbin "graphics/schedule/11.bin"
  .incbin "graphics/schedule/12.bin"
.pad $9000, $00
  .incbin "graphics/bar-top.bin"
.pad $9200, $00
  .incbin "graphics/ascii.bin"
.pad $9800, $00
  .incbin "graphics/schedule/13.bin"
  .incbin "graphics/schedule/14.bin"
  .incbin "graphics/schedule/15.bin"
.pad $A000, $00
  .byte $00, $01, $01, $03, $03, $07, $07, $0F
  .byte $00, $01, $01, $03, $03, $07, $07, $0F
.pad $20000, $00
