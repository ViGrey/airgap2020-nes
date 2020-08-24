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

SCREEN_TITLE        = $00
SCREEN_TWITCH_CHAT  = $01
SCREEN_SCHEDULE     = $02
SCREEN_EXTRA        = $03


;;;;
;
; screen
; 7  bit  0
; ---- ----
; |||  ||||
; |||  |+++- Current Screen
; |||  |
; |||  +---- TransitionFlag
; |||
; +++------- Last Screen
;
;;;;;


InitializeScreen:
  lda #$01
  sta allowUpdate
  lda screen
  and #%00000111
  sta tmp
  lda screen
  lsr
  lsr
  lsr
  lsr
  lsr
  cmp tmp
  bne InitializeScreenContinue
    rts
InitializeScreenContinue: 
  lda screen
  and #%00001000
  beq InitializeScreenNotTransition
    jsr TransitionScreen
    dec allowUpdate
    rts
InitializeScreenNotTransition:
  dec allowUpdate
  jsr Blank
  jsr ClearPPURAM
  jsr ClearScreen
  lda screen
  and #%00000111
  cmp #SCREEN_TWITCH_CHAT
  bne InitializeScreenNotTwitchChat
    ; Screen IS Twitch Chat
    lda #$00
    sta nametable
    lda #MIRRORING_H
    sta mirroring
    lda #$00
    sta chrSwitchSize
    jsr MMC1Initialize
    jsr InitializeTwitchChatScreen
    lda #SCREEN_TWITCH_CHAT
    jmp InitializeScreenDone
InitializeScreenNotTwitchChat:
  cmp #SCREEN_SCHEDULE
  bne InitializeScreenNotSchedule
    ; Screen IS Schedule
    lda #$00
    sta nametable
    lda #MIRRORING_H
    sta mirroring
    lda #$01
    sta chrSwitchSize
    jsr MMC1Initialize
    jsr InitializeScheduleScreen
    lda #$00
    sta schedule
    lda #SCREEN_SCHEDULE
    jmp InitializeScreenDone
InitializeScreenNotSchedule:
  cmp #SCREEN_EXTRA
  bne InitializeScreenNotExtra
    ; Screen IS Extra
    lda #$00
    sta nametable
    lda #$00
    sta chrSwitchSize
    jsr MMC1Initialize
    lda #SCREEN_EXTRA
    jmp InitializeScreenDone
InitializeScreenNotExtra:
InitializeScreenCatchallTitle:
  ; Screen is Catchall, so show Title
  lda #MIRRORING_V
  sta mirroring
  lda #$00
  sta chrSwitchSize
  jsr MMC1Initialize
  jsr InitializeTitleScreen
  lda #SCREEN_TITLE
InitializeScreenDone:
  inc allowUpdate
  and #%00000111
  sta screen
  asl screen
  asl screen
  asl screen
  asl screen
  asl screen
  ora screen
  sta screen
  jsr InitializeDrawBuffer
  jsr ResetScroll
  rts


TransitionScreen:
  lda screen
  and #%00000111
  cmp #SCREEN_TWITCH_CHAT
  bne TransitionScreenNotTwitchChat
    jsr TransitionTwitchChatScreen
    rts
TransitionScreenNotTwitchChat:
  cmp #SCREEN_SCHEDULE
  bne TransitionScreenNotSchedule
    jsr TransitionScheduleScreen
    rts
TransitionScreenNotSchedule:
  cmp #SCREEN_EXTRA
  bne TransitionScreenNotExtra:
    jsr TransitionExtraScreen
    rts
TransitionScreenNotExtra:
  rts


TransitionTwitchChatScreen:
  lda $200
  cmp #$EF
  bcc TransitionTwitchChatScreenNotInitialize
    lda #$EE
    sta $200
    rts
TransitionTwitchChatScreenNotInitialize:
  sec
  sbc #$08
  bcs TransitionTwitchChatDone
    ; Start Screen ; Toggle transition to false
    jsr SetBlackPalette
    lda #$00
    sta nametable
    lda screen
    and #%00000111
    sta screen
    jsr ClearSprites
    rts
TransitionTwitchChatDone:
  sta $200
  jsr TransitionTwitchChatSprite0Hit
  rts


TransitionScheduleScreen:
  lda $200
  cmp #$EF
  bcc TransitionScheduleScreenNotInitialize
    lda #$00
    sta $200
    rts
TransitionScheduleScreenNotInitialize:
  adc #$08
  cmp #$EF
  bcc TransitionScheduleDone
    ; Start Screen ; Toggle transition to false
    jsr SetBlackPalette
    lda #$00
    sta nametable
    lda screen
    and #%00000111
    sta screen
    jsr ClearSprites
    rts
TransitionScheduleDone:
  sta $200
  lda #$01
  sta nametable
  jsr TransitionScheduleSprite0Hit
  rts


TransitionExtraScreen:
  lda #$01
  sta nametable
  lda #%10000001
  sta PPU_CTRL
  lda xscroll
  sec
  sbc #$04
  sta xscroll
  cmp #$FF
  bne TransitionExtraScreenContinue:
    jsr SetBlackPalette
    lda #$00
    sta xscroll
    sta xscrollSlice
    lda #$01
    sta nametable
    lda screen
    and #%00000111
    sta screen
    jsr ClearSprites
    rts
TransitionExtraScreenContinue:
  lda #$01
  sta nametable
  lda xscrollSlice
  clc
  adc #$04
  sta xscrollSlice
  jsr TransitionExtraSprite0Hit
  rts


TransitionTwitchChatSprite0Hit:
TransitionTwitchChatSprite0ClearWait:
  bit $2002
  bvs TransitionTwitchChatSprite0ClearWait
TransitionTwitchChatSprite0HitWait:
  bit $2002
  bvc TransitionTwitchChatSprite0HitWait:
    lda #$00
    sta xscrollSlice
    lda #$01
    sta nametableSlice
    lda $200
    clc
    adc #$06
    sta yscrollSlice
    jsr SplitScroll
    rts


TransitionScheduleSprite0Hit:
TransitionScheduleSprite0ClearWait:
  bit $2002
  bvs TransitionScheduleSprite0ClearWait
TransitionScheduleSprite0HitWait:
  bit $2002
  bvc TransitionScheduleSprite0HitWait:
    lda #$00
    sta xscrollSlice
    lda #$00
    sta nametableSlice
    lda $200
    sec
    sbc #$06
    sta yscrollSlice
    jsr SplitScroll
    rts


TransitionExtraSprite0Hit:
TransitionExtraSprite0ClearWait:
  bit $2002
  bvs TransitionExtraSprite0ClearWait
TransitionExtraSprite0HitWait:
  bit $2002
  bvc TransitionExtraSprite0HitWait:
    lda #$00
    sta nametable
    lda xscroll
    sta tmp
    lda xscrollSlice
    sta xscroll

    lda #%10001000
    sta PPU_CTRL
    lda xscroll
    sta PPU_SCROLL
    lda yscroll
    sta PPU_SCROLL

    lda tmp
    sta xscroll
    rts


InitializeTitleScreen:
  lda #$00
  jsr SetMMC1CHRBank
  lda #%01000000
  sta emphasis
  lda #%00001000
  sta patterns
  jsr SetTitlePalette
  jsr ClearAttributes
  jsr SetTitleScreenAttributes
  lda #$00
  sta xscroll
  jsr DrawTitleScreen
  rts


InitializeTwitchChatScreen:
  lda #$02
  jsr SetMMC1CHRBank
  lda #%00000000
  sta emphasis
  lda #%00011000
  sta patterns
  jsr SetChatAddrStart
  jsr SetTwitchChatPalette
  jsr InitializeDrawBuffer
  rts


SetChatAddrStart:
  lda fps
  cmp #60
  beq SetChatAddrStartNotPAL
    lda #PAL_START_ADDR_0
    sta chatAddr
    lda #PAL_START_ADDR_1
    sta (chatAddr + 1)
    lda #PAL_START_BANK
    sta chatBank
    jmp SetChatAddrStartDone
SetChatAddrStartNotPAL:
  lda #NTSC_START_ADDR_0
  sta chatAddr
  lda #NTSC_START_ADDR_1
  sta (chatAddr + 1)
  lda #NTSC_START_BANK
  sta chatBank
SetChatAddrStartDone:
  jsr SetMMC1PRGBank
  lda #$20
  sta ppuAddr
  lda #$61
  sta (ppuAddr + 1)
  rts


InitializeScheduleScreen:
  lda #%00000000
  sta emphasis
  jsr DrawScheduleScreen
  rts
