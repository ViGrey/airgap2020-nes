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

NTSC_START_BANK = $00
NTSC_START_ADDR_0 = $00
NTSC_START_ADDR_1 = $80
PAL_START_ADDR_0 = $11
PAL_START_ADDR_1 = $93
PAL_END_ADDR_0 = $00
PAL_END_ADDR_1 = $A6

PAL_START_BANK = $07
PAL_END_BANK = $1E

CHAT_END_BANK = $FF

CHAT_LINE_BEFORE_Y_SCROLL = 28


.enum $0500
  chatByte              dsb 1
  chatByteOffset        dsb 1
  chatCharactersOffset  dsb 1
  chatCharacters        dsb 32
.ende


GetChatByte:
  ldy #$00
  sty chatByte
  jsr ChatLogEnd
  lda chatBank
  cmp #(CHAT_END_BANK)
  beq GetChatByteDone
    lda (chatAddr), Y
    sta chatByte
    cmp #$04
    bcs GetChatByteNotZeroByte
      jsr GetZeroCount
      rts
GetChatByteNotZeroByte:
  jsr IncChatAddr
GetChatByteDone:
  rts


IncChatAddr:
  lda chatAddr
  clc
  adc #$01
  sta chatAddr
  lda (chatAddr + 1)
  adc #$00
  sta (chatAddr + 1)
  cmp #$C0
  bcc IncChatAddrDone
    ; chatAddr is now at least #$C000
    lda #$00
    sta chatAddr
    lda #$80
    sta (chatAddr + 1)
    inc chatBank
    jsr SetMMC1PRGBank
IncChatAddrDone:
  rts


ChatLogEnd:
  lda fps
  cmp #60
  bne ChatLogEndNot60FPS
    ; FPS is 60
    lda (chatAddr + 1)
    cmp #(PAL_START_ADDR_1)
    bcc ChatLogEndDone
      lda chatAddr
      cmp #(PAL_START_ADDR_0)
      bcc ChatLogEndDone
        lda chatBank
        cmp #(PAL_START_BANK)
        bcc ChatLogEndDone
          lda #(CHAT_END_BANK)
          sta chatBank
          rts
ChatLogEndNot60FPS:
  lda (chatAddr + 1)
  cmp #(PAL_END_ADDR_1)
  bcc ChatLogEndDone
    lda chatAddr
    cmp #(PAL_END_ADDR_0)
    bcc ChatLogEndDone
      lda chatBank
      cmp #(PAL_END_BANK)
      bcc ChatLogEndDone
        lda #(CHAT_END_BANK)
        sta chatBank
ChatLogEndDone:
  rts


HandleChatFrame:
  ldy drawBufferOffset
  lda #$8E
  sta (drawBuffer), Y
  iny
  lda ppuAddr
  sta (drawBuffer + 1)
  iny
  lda (ppuAddr + 1)
  sta (drawBuffer), Y
  iny
  sty drawBufferOffset
  ldx #$20
HandleChatFrameLoop:
  jsr CheckZeroCount
  cmp #$00
  bne HandleChatFrameLoopNotZeroCountZero
    jsr GetChatByte
    lda chatByte
    cmp #$00
    beq HandleChatFrameLoopNotZeroCountZero
HandleChatFrameStarted:
  jsr DrawChatByte
  jmp HandleChatFrameLoopDone
HandleChatFrameLoopNotZeroCountZero:
  jsr DecZeroCount
HandleChatFrameLoopDone:
  dex
  bne HandleChatFrameLoop
    rts
