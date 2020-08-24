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


SCHEDULE_MAINFRAME  = $06
SCHEDULE_LAST       = $12


DrawScheduleScreen:
  jsr ClearPPURAM
  lda PPU_STATUS
  lda #$3F
  sta PPU_ADDR
  lda #$10
  sta PPU_ADDR
  lda #$0F
  sta PPU_DATA
  lda #$30
  sta PPU_DATA
  sta PPU_DATA
  sta PPU_DATA
  lda #$00
  sta yscroll
  lda schedule
  tax 
  lda (ScheduleMMC1CHRBank), X
  jsr SetMMC1CHRBank
  lda #$0A
  jsr SetMMC1CHRBank2
  txa
  asl
  tax
  lda (ScheduleStartOffsets), X
  sta addr
  inx
  lda (ScheduleStartOffsets), X
  sta (addr + 1)
  dex
  lda (ScheduleEndOffsets), X
  sta addrEnd
  inx
  lda (ScheduleEndOffsets), X
  sta (addrEnd + 1)
  jsr DecompressAddr
  lda #$00
  sta scheduleChange
  rts

HandleScheduleChange:
  lda scheduleChange
  cmp #$01
  bne HandleScheduleChangeDone
    lda PPU_STATUS
    lda #$3F
    sta PPU_ADDR
    lda #$00
    sta PPU_ADDR
    lda #$0F
    ldx #$20
HandleScheduleChangeLoop:
  sta PPU_DATA
  dex
  bne HandleScheduleChangeLoop
    lda #$02
    sta scheduleChange
HandleScheduleChangeDone:
  rts

UpdateScheduleChange:
  lda scheduleChange
  cmp #$02
  bne UpdateScheduleChangeDone
    sta scheduleChange
    jsr Blank
    jsr DrawScheduleScreen
    jsr ResetScroll
UpdateScheduleChangeDone:
  rts

DrawArrowSprites:
  lda #$6F
  sta $204
  lda #%00000000
  sta $206
  lda #$77
  sta $208
  lda #%10000000
  sta $20A
  lda #$6F
  sta $20C
  lda #%01000000
  sta $20E
  lda #$77
  sta $210
  lda #%11000000
  sta $212
  ldx #$01
  lda schedule
  beq DrawLeftArrowContinue
    ldx #$00
DrawLeftArrowContinue:
  stx $205
  stx $209
  ldx #$01
  cmp #SCHEDULE_LAST
  beq DrawRightArrowContinue
    ldx #$00
DrawRightArrowContinue:
  stx $20D
  stx $211
  lda frames
  ror
  ror
  sta tmp
  and #%00000100
  bne DrawArrowMoveIn
    lda tmp
    and #%00000011
    eor #%00000011
    jmp DrawArrowMoveContinue
DrawArrowMoveIn:
  lda tmp
  and #%00000011
DrawArrowMoveContinue:
  sta tmp
  lda #$05
  sec
  sbc tmp
  sta $207
  sta $20B
  lda #$F3
  clc
  adc tmp
  sta $20F
  sta $213
DrawArrowSpritesDone:
  rts
