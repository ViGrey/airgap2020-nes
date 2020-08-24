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


RESET:
  sei
  cld
  ldx #$40
  stx APU_FRAME_COUNTER
  ldx #$FF
  txs
  inx
  lda #%00000110
  sta PPU_MASK
  stx PPU_CTRL
  stx APU_DMC

  stx chatBank
  jsr SetMMC1PRGBank

InitialVWait:
  lda regionTmp
  sta region
  ldy #$00
  lda PPU_STATUS
  bpl InitialVWait
InitialVWait2:
  inx
  bne InitialVWait2NotIncY
    iny
InitialVWait2NotIncY:
  lda PPU_STATUS
  bpl InitialVWait2
    ldx #$00
    cpy #$09
    bne NotNTSC
      lda #60
      inx
      jmp InitialVWaitDone
NotNTSC:
  lda #50
  cpy #$0A
  bne NotPAL
    jmp InitialVWaitDone
NotPAL:
  cpy #$0B
  bne NotDendy
    ldx #$02
    jmp InitialVWaitDone
NotDendy:
  ldx #$03
InitialVWaitDone:
  sta fps
  stx regionTmp
  cpx region
  bne InitialVWait


InitializeRAM:
  ldx #$00
InitializeRAMLoop:
  lda #$00
  cpx #fps
  beq InitializeRAMSkipZeroPage
    cpx #region
    beq InitializeRAMSkipZeroPage
      sta $0000, x
InitializeRAMSkipZeroPage:
  sta $0100, x
  sta $0300, x
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  lda #$FE
  sta $0200, x
  inx
  bne InitializeRAMLoop

  lda #(SCREEN_TITLE)
  sta screen
  ora #%1110000
  sta screen

  lda #(BUTTON_A + BUTTON_B + BUTTON_START + BUTTON_SELECT)
  sta controller1D0
  sta controller1D0LastFrame

  jsr InitializeScreen


Forever:
  jmp Forever


NMI:
  lda #$00
  sta PPU_OAM_ADDR
  lda #$02
  sta OAM_DMA
  lda PPU_STATUS
  jsr HandleScheduleChange
  jsr DrawPreviousFrame
  jsr Draw
  jsr ResetScroll
  jsr InitializeScreen
  lda allowUpdate
  beq NMIDone
    jsr Update
    jsr UpdateScheduleChange
NMIDone:
  jsr EndDrawBuffer
  rti


Update:
  jsr PollController
  jsr CheckABStartSelect
  lda screen
  and #%00000111
  cmp #SCREEN_TWITCH_CHAT
  bne UpdateNotTwitchChat
    ; Screen IS Twitch Chat
    jsr UpdateTwitchChat
    rts
UpdateNotTwitchChat:
  cmp #SCREEN_SCHEDULE
  bne UpdateNotSchedule
    ; Screen IS schedule
    jsr UpdateSchedule
    rts
UpdateNotSchedule:
UpdateCatchallTitle:
  ; Screen is Catchall, so show Title
  jsr UpdateTitle
  rts


UpdateTitle:
  jsr CheckStartTitle
  jsr CheckATitle
  jsr CheckDownTitle
  jsr CheckUpTitle
  jsr CheckSelectTitle
  rts


UpdateTwitchChat:
  inc frames
  lda frames
  and #$01
  beq UpdateTwitchChatHandleClearFrame
    jsr HandleChatFrame
    rts
UpdateTwitchChatHandleClearFrame:
  jsr ClearLines
  rts

UpdateSchedule:
  inc frames
  jsr DrawArrowSprites
  jsr CheckASchedule
  jsr CheckBSchedule
  jsr CheckRightSchedule
  jsr CheckLeftSchedule
  jsr CheckUpSchedule
  jsr CheckDownSchedule
  rts
