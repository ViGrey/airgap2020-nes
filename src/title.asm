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


SetTitlePalette:
  lda PPU_STATUS
  lda #$3F
  sta PPU_ADDR
  lda #$00
  sta PPU_ADDR
  lda #$27
  sta PPU_DATA
  sta PPU_DATA
  lda #$17
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  lda #$27
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  lda #$17
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  lda #$27
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  lda #$17
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  lda #$27
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  lda #$17
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
SetSpritePalettes:
  lda #$27
  sta PPU_DATA
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  sta PPU_DATA
  lda #$27
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  sta PPU_DATA
  sta PPU_DATA
  lda #$27
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  sta PPU_DATA
  sta PPU_DATA
  lda #$27
  sta PPU_DATA
  lda #$0F
  sta PPU_DATA
  sta PPU_DATA
  sta PPU_DATA
  rts


DrawTitleScreen:
  jsr ClearScreen

  lda #<(TitleBackgroundMap)
  sta addr
  lda #>(TitleBackgroundMap)
  sta (addr + 1)
  lda #<(TitleBackgroundMapEnd)
  sta addrEnd
  lda #>(TitleBackgroundMapEnd)
  sta (addrEnd + 1)
  jsr DecompressAddr

  jsr ClearTitleNametable1Solid01
  jsr DrawCursor
  lda #$00
  sta yscroll
  rts


ClearTitleNametable1Solid01:
  lda PPU_STATUS
  lda #$24
  sta PPU_ADDR
  lda #$00
  sta PPU_ADDR
  lda #$B0
  ldx #240
  ldy #$04
ClearTitleNametable1Solid01Loop:
  sta PPU_DATA
  dex
  bne ClearTitleNametable1Solid01Loop
    ldx #240
    dey
    bne ClearTitleNametable1Solid01Loop
      rts


DrawCursor:
  lda #$B7
  sta $204
  lda #$01
  sta $205
  lda #$01
  sta $206
  lda #$78
  sta $207
  rts


ClearSprites:
  ldx #00
ClearSpritesLoop:
  lda #$FE
  sta $0200, x
  inx
  bne ClearSpritesLoop
    rts


SetSwipePixelMiddle:
  lda #$7F
  sta $200
  lda #$00
  sta $201
  lda #$01
  sta $202
  lda #$00
  sta $203
  rts


SetSwipePixelTop:
  lda #$FF
  sta $200
  lda #$00
  sta $201
  lda #$01
  sta $202
  lda #$00
  sta $203
  rts


SetSwipePixelBottom:
  lda #$EF
  sta $200
  lda #$00
  sta $201
  lda #$00
  sta $202
  lda #$00
  sta $203
  rts


SetTitleScreenAttributes:
  sta PPU_STATUS
  lda #$27
  sta PPU_ADDR
  lda #$C0
  sta PPU_ADDR
  ldy #15
  ldx #$08
  lda #$55
SetTitleScreenAttributesByteLoop:
  sta PPU_DATA
  dex
  bne SetTitleScreenAttributesByteLoop
    ldx #$08
    dey
    bne SetTitleScreenAttributesByteLoop
      rts
