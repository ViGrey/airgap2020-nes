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

ResetScroll:
  ; Scroll X position
  lda xscroll
  sta PPU_SCROLL
  ; Scroll Y position
  lda yscroll
  sta PPU_SCROLL
  jsr EnableNMI
  rts


Draw:
  lda #%00011110
  ora emphasis
  sta PPU_MASK
  rts


DisableNMI:
  lda #$00
  sta PPU_CTRL
  rts


EnableNMI:
  lda #%10000000
  ora nametable
  ora patterns
  sta PPU_CTRL
  rts


Blank:
  lda #%00000110
  ora emphasis
  sta PPU_MASK
  jsr DisableNMI
  rts


SetTwitchChatPalette:
  lda PPU_STATUS
  lda #$3F
  sta PPU_ADDR
  lda #$00
  sta PPU_ADDR
  ldx #$08
SetTwitchChatPaletteLoop:
  lda #$0F
  sta PPU_DATA
  sta PPU_DATA
  lda #$29
  sta PPU_DATA
  lda #$30
  sta PPU_DATA
  dex
  bne SetTwitchChatPaletteLoop
    rts


SetBlackPalette:
  lda #$3F
  sta PPU_ADDR
  lda #$00
  sta PPU_ADDR
  ldx #$08
  lda #$0F
SetBlackPaletteLoop:
  sta PPU_DATA
  sta PPU_DATA
  sta PPU_DATA
  sta PPU_DATA
  dex
  bne SetBlackPaletteLoop
    rts


ClearPPURAM:
  lda #$20
  sta PPU_ADDR
  lda #$00
  sta PPU_ADDR
  ldy #$10
  ldx #$00
  txa
ClearPPURAMLoop:
  sta PPU_DATA
  dex
  bne ClearPPURAMLoop
    ldx #$00
    dey
    bne ClearPPURAMLoop
      rts


ClearScreen:
  ldx #$00
  lda #$20
  sta addr
  jmp ClearScreenStartNametableLoop
ClearScreenLoop:
  lda addr
  clc
  adc #$04
  sta addr
ClearScreenStartNametableLoop:
  lda PPU_STATUS
  lda addr
  sta PPU_ADDR
  lda #$00
  sta PPU_ADDR
  ldx #$1E
  ldy #$20
  lda #$00
ClearScreenNametableLoop:
  sta PPU_DATA
  dex
  bne ClearScreenNametableLoop
    ldx #$1E
    dey
    bne ClearScreenNametableLoop
      lda addr
      cmp #$2C
      bne ClearScreenLoop
        rts


DrawChatByte:
  lda chatByte
  cmp #$20
  bcc DrawChatByteNotPrintable
    jsr DrawPrintableChatByte
    lda (ppuAddr + 1)
    and #$1F
    cmp #$1D
    bne DrawChatBytePrintableContinue
      jsr IncPPUAddrOneLine
      jsr IncPPUAddr
      jsr IncPPUAddr
      ldy drawBufferOffset
      lda #$8E
      sta (drawBuffer), Y
      iny
      lda ppuAddr
      sta (drawBuffer), Y
      iny
      lda (ppuAddr + 1)
      sta (drawBuffer), Y
      iny
      sty drawBufferOffset
      inc newLine
      jsr AdjustYScrollNametable
      rts
DrawChatBytePrintableContinue:
  jsr IncPPUAddr
  rts
DrawChatByteNotPrintable:
  cmp #$0A
  bne DrawChatByteDone
    jsr IncPPUAddrOneLine
    jsr IncPPUAddr
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda ppuAddr
    sta (drawBuffer), Y
    iny
    lda (ppuAddr + 1)
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset
    inc newLine
    jsr AdjustYScrollNametable
DrawChatByteDone:
  rts


DrawPrintableChatByte:
  ldy drawBufferOffset
  lda chatByte
  sta (drawBuffer), Y
  iny
  sty drawBufferOffset
  rts


ClearLines:
  lda newLine
  beq ClearLinesDone
    lda ppuAddr
    sta ppuAddrTmp
    lda (ppuAddr + 1)
    sta (ppuAddrTmp + 1)

    lda #$03
    sbc newLine
    tay
ClearLinesIncPPUAddrTmpLoop:
  jsr IncPPUAddrOneLine
  dey
  bne ClearLinesIncPPUAddrTmpLoop
    jsr IncPPUAddrOneLine
    jsr IncPPUAddrOneLine
    jsr IncPPUAddrOneLine
    jsr IncPPUAddrOneLine
    jsr IncPPUAddrOneLine

    jsr DrawClearLines

    lda ppuAddrTmp
    sta ppuAddr
    lda (ppuAddrTmp + 1)
    sta (ppuAddr + 1)
ClearLinesDone:
  rts


DrawClearLines:
  lda newLine
  sta tmp
DrawClearLinesLoop:
  jsr IncPPUAddrOneLine
  jsr IncPPUAddr 
  ldy drawBufferOffset
  lda #$8E
  sta (drawBuffer), Y
  iny
  lda ppuAddr
  sta (drawBuffer), Y
  iny
  lda (ppuAddr + 1)
  sta (drawBuffer), Y
  iny
  sty drawBufferOffset
  lda newLine
  cmp #$01
  bne DrawClearLinesLoopNotLastLoop
    ; is last line to clear
    lda tmp
    cmp #$03
    bne DrawClearLinesLoopNotLastLoop
      jsr Draw3Spaces
      rts
DrawClearLinesLoopNotLastLoop:
  jsr Draw29Spaces
  dec newLine
  bne DrawClearLinesLoop
    rts


Draw29Spaces:
  ldx #29
  ldy drawBufferOffset
  lda #$20
Draw29SpacesLoop:
  sta (drawBuffer), Y
  iny
  dex
  bne Draw29SpacesLoop
    sty drawBufferOffset
    rts
  

Draw3Spaces:
  ldx #03
  ldy drawBufferOffset
  lda #$20
Draw3SpacesLoop:
  sta (drawBuffer), Y
  iny
  dex
  bne Draw3SpacesLoop
    sty drawBufferOffset
    rts
  

IncPPUAddr:
  lda (ppuAddr + 1)
  clc
  adc #$01
  sta (ppuAddr + 1)
  lda ppuAddr
  adc #$00
  sta ppuAddr
  jsr AdjustPPUAddr
  rts


IncPPUAddrOneLine:
  lda (ppuAddr + 1)
  clc
  adc #$20
  sta (ppuAddr + 1)
  lda ppuAddr
  adc #$00
  sta ppuAddr
  jsr AdjustPPUAddr
  lda (ppuAddr + 1)
  and #%11100000
  sta (ppuAddr + 1)
  rts


AdjustYScrollNametable:
  lda (ppuAddr + 1)
  and #%11100000
  rol
  sta ppuAddrRow
  lda ppuAddr
  and #%00000011
  ora ppuAddrRow
  rol
  rol
  rol
  sta ppuAddrRow
  lda enableYScroll
  bne AdjustYScrollNametableGetBaseNametable
    lda ppuAddrRow
    cmp #CHAT_LINE_BEFORE_Y_SCROLL
    bcc AdjustYScrollNametableDone
      inc enableYScroll
AdjustYScrollNametableGetBaseNametable:
  lda ppuAddr
  cmp #$28
  bcc AdjustYScrollNametableNotNametable3
    ; Nametable is 3
    lda ppuAddrRow
    clc
    adc #30
    sta ppuAddrRow
AdjustYScrollNametableNotNametable3:

  lda ppuAddrRow
  adc #$01
  sec
  sbc #CHAT_LINE_BEFORE_Y_SCROLL
  bcs AdjustNametableFromPPUAddrRow
    adc #60
AdjustNametableFromPPUAddrRow:
  sta ppuAddrRow
  lda #$00
  sta nametable
  lda ppuAddrRow
  cmp #30
  bcc AdjustYScrollFromPPUAddrRow
    sec
    sbc #30
    sta ppuAddrRow
    lda #$02
    sta nametable
AdjustYScrollFromPPUAddrRow:
  lda ppuAddrRow
  asl
  asl
  asl
  sta yscroll
AdjustYScrollNametableDone:
  rts


AdjustPPUAddr:
  lda ppuAddr
  cmp #$28
  bcs AdjustPPUAddrNametable3
    ; PPU Addr within first Nametable ($2000)
    lda ppuAddr
    cmp #$23
    bcc AdjustPPUAddrDone
      bne AdjustPPUAddrAdd440
        ; PPU Addr is $23XX
        lda (ppuAddr + 1)
        cmp #$C0
        bcc AdjustPPUAddrDone
AdjustPPUAddrAdd440:
  lda (ppuAddr + 1)
  clc
  adc #$40
  sta (ppuAddr + 1)
  lda ppuAddr
  adc #$04
  sta ppuAddr
  rts
AdjustPPUAddrNametable3:
  ; PPU Addr within third Nametable ($2800)
  lda ppuAddr
  cmp #$2B
  bcc AdjustPPUAddrDone
    ; ppuAddr GTE $2BXX
    bne AdjustPPUAddrSubBC0
      ; PPU Addr is $2BXX
      lda (ppuAddr + 1)
      cmp #$C0
      bcc AdjustPPUAddrDone
AdjustPPUAddrSubBC0:
  lda (ppuAddr + 1)
  sec
  sbc #$C0
  sta (ppuAddr + 1)
  lda ppuAddr
  sbc #$0B
  sta ppuAddr
AdjustPPUAddrDone:
  rts


DrawPreviousFrame:
  ldy #$00
DrawPreviousFrameLoop:
  lda PPU_STATUS
  lda (drawBuffer), Y
  iny
  cmp #$8F
  beq DrawPreviousFrameDone
    cmp #$8E
    beq DrawPreviousFrameLoop
      sta PPU_ADDR
      lda (drawBuffer), Y
      iny
      sta PPU_ADDR
DrawPreviousFrameLoopContentLoop:
  lda (drawBuffer), Y
  iny
  cmp #$8E
  beq DrawPreviousFrameLoop
    ; Not #$8E
    cmp #$8F
    beq DrawPreviousFrameDone
      ; Not #$8F
      sta PPU_DATA
      jmp DrawPreviousFrameLoopContentLoop
DrawPreviousFrameDone:
  jsr InitializeDrawBuffer
  rts


InitializeDrawBuffer:
  ldy #$00
  sty drawBufferOffset
  lda #$8F
  sta (drawBuffer), Y
  rts


ClearAttributes:
  lda PPU_STATUS
  lda #$23
  sta PPU_ADDR
  lda #$C0
  sta PPU_ADDR
  jsr ClearAttributesDraw
  lda PPU_STATUS
  lda #$27
  sta PPU_ADDR
  lda #$C0
  sta PPU_ADDR
  jsr ClearAttributesDraw
  lda PPU_STATUS
  lda #$2B
  sta PPU_ADDR
  lda #$C0
  sta PPU_ADDR
  jsr ClearAttributesDraw
  lda PPU_STATUS
  lda #$2F
  sta PPU_ADDR
  lda #$C0
  sta PPU_ADDR
  jsr ClearAttributesDraw
  rts


ClearAttributesDraw:
  ldy #$08
  ldx #15
  lda #$00
ClearAttributesDrawLoop:
  sta PPU_DATA
  dex
  bne ClearAttributesDrawLoop
    ldx #15
    dey
    bne ClearAttributesDrawLoop
      rts


EndDrawBuffer:
  ldy drawBufferOffset
  lda #$8F
  sta (drawBuffer), Y
  iny
  sty drawBufferOffset
  rts
