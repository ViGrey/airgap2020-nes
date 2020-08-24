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


GetZeroCount:
  lda #$00
  tay
  sta zeroFrames
  lda chatByte
  cmp #$01
  bne GetZeroCountChatByteNot1
    lda #$00
    sta chatByte
    sta (zeroFrames + 1)
    lda #31
    sta (zeroFrames + 2)
    jsr IncChatAddr
    rts
GetZeroCountChatByteNot1:
  cmp #$02
  bne GetZeroCountChatByteNot2
    ; chatByte is 2
    lda #$00
    sta chatByte
    jsr IncChatAddr
    lda (chatAddr), Y
    sta (zeroFrames + 1)
    jsr IncChatAddr
    lda (chatAddr), Y
    sta (zeroFrames + 2)
    jsr IncChatAddr
    rts
GetZeroCountChatByteNot2:
  ; chatByte is 3
  lda #$00
  sta chatByte
  jsr IncChatAddr
  lda (chatAddr), Y
  sta zeroFrames
  jsr IncChatAddr
  lda (chatAddr), Y
  sta (zeroFrames + 1)
  jsr IncChatAddr
  lda (chatAddr), Y
  sta (zeroFrames + 2)
  jsr IncChatAddr
  rts


DecZeroCount:
  lda (zeroFrames + 2)
  sec
  sbc #$01
  sta (zeroFrames + 2)
  lda (zeroFrames + 1)
  sbc #$00
  sta (zeroFrames + 1)
  lda zeroFrames
  sbc #$00
  sta zeroFrames
  rts


CheckZeroCount:
  lda #$00
  ora zeroFrames
  ora (zeroFrames + 1)
  ora (zeroFrames + 2)
  rts
