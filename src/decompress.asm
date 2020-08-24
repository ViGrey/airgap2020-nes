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


DecompressAddr:
DecompressAddrLoop:
  lda PPU_STATUS
  ldy #$00
  lda (addr), Y
  sta PPU_ADDR
  sta ppuAddr
  jsr IncAddr
  lda (addr), Y
  sta PPU_ADDR
  sta (ppuAddr + 1)
  jsr IncAddr
DecompressAddrGetRowByteLoop:
  jsr CmpAddrAddrEnd
  bne DecompressAddrDone
    ; addr not addrEnd
    lda (addr), Y
    sta tmp
    jsr IncAddr
    lda tmp
    cmp #$01
    beq DecompressAddrGetRowByteLoopIs01
      cmp #$02
      beq DecompressAddrLoop
        sta PPU_DATA
        jmp DecompressAddrGetRowByteLoop
DecompressAddrGetRowByteLoopIs01:
  lda PPU_STATUS
  jsr IncPPUAddrOneLineDecompress
  lda ppuAddr
  sta PPU_ADDR
  lda (ppuAddr + 1)
  sta PPU_ADDR
  jmp DecompressAddrGetRowByteLoop
DecompressAddrDone:
  rts


IncPPUAddrOneLineDecompress:
  lda (ppuAddr + 1)
  clc
  adc #$20
  sta (ppuAddr + 1)
  lda ppuAddr
  adc #$00
  sta ppuAddr
  rts


CmpAddrAddrEnd:
  lda (addr + 1)
  cmp (addrEnd + 1)
  bcc CmpAddrAddrEndLTUpper
    bne CmpAddrAddrEndPositive:
      lda addr
      cmp addrEnd
      bcs CmpAddrAddrEndPositive
CmpAddrAddrEndLTUpper:
    lda #$00
    rts
CmpAddrAddrEndPositive:
  lda #$01
  rts 


IncAddr:
  lda addr
  clc
  adc #$01
  sta addr
  lda (addr + 1)
  adc #$00
  sta (addr + 1)
  rts



TitleBackgroundMap:
  .byte $20, $68
; #AIRGAP2020
  .byte $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $01
  .byte $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22
  .byte $02
  .byte $20, $C7
; Commemorative top
  .byte $23, $24, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $25, $26, $01
; Commemorative middle
  .byte $27, $28, $29, $2A, $2B, $2A, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $36, $37, $01
; Commemorative bottom/NES Cartridge top
  .byte $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49
  .byte $02
  .byte $21, $29
; NES Cartridge middle
  .byte $06, $4A, $4B, $4C, $27, $28, $4D, $4E, $4F, $50, $51, $52, $53, $37, $01
; NES Cartridge bottom
  .byte $54, $55, $56, $00, $57, $55, $58, $59, $58, $5A, $5B, $5C, $5D, $49
  .byte $02
  .byte $21, $6B
; Airgap Logo Image
  .byte $5E, $5F, $5F, $5F, $5F, $5F, $5F, $5F, $5F, $A8, $01
  .byte $60, $61, $62, $62, $62, $62, $62, $62, $63, $64, $01
  .byte $60, $65, $00, $00, $66, $67, $00, $00, $68, $64, $01
  .byte $60, $65, $00, $69, $6A, $6B, $6C, $00, $68, $64, $01
  .byte $60, $6D, $5F, $6E, $6F, $70, $71, $5F, $72, $64, $01
  .byte $60, $73, $74, $75, $76, $76, $77, $78, $79, $64, $01
  .byte $60, $7A, $7B, $7C, $00, $00, $7D, $7E, $7F, $64, $01 
  .byte $60, $80, $00, $00, $00, $00, $00, $00, $81, $64, $01
  .byte $60, $82, $83, $83, $83, $83, $83, $83, $84, $64, $01
  .byte $85, $76, $76, $76, $76, $76, $76, $76, $76, $86
  .byte $02

  .byte $23, $02
  .byte $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $01
  .byte $A0, $A1, $A2, $A3, $A4

  .byte $02
; TALK SCHEDULE
  .byte $22, $F1
  .byte $87, $88, $89, $8A, $00, $8B, $8C, $8D, $8E, $8F, $90, $89, $8E, $01
  .byte $01
; TWITCH CHAT
  .byte $87, $91, $92, $87, $8C, $8D, $00, $8C, $8D, $88, $87, $01
  ;.byte $01
  ;.byte $92, $A5, $8B, $87, $A6, $90, $8C, $87, $92, $A7, $A5, $8B
TitleBackgroundMapEnd:
