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

CONTROLLER1              = $4016
CONTROLLER2              = $4017
CONTROLLER_NONE          = 0
CONTROLLER_STANDARD      = 1
CONTROLLER_SNES_MOUSE    = 2
CONTROLLER_USB_KEYBOARD  = 3

CONTROLLER_BASIC_KEYBOARD_USED   = 1 << 0
CONTROLLER_FOUR_SCORE_USED       = 1 << 1
CONTROLLER_MOUSE_USED            = 1 << 2
CONTROLLER_MOUSE_READY           = 1 << 3

FOUR_SCORE_1_SIGNATURE           = 1 << 4
FOUR_SCORE_2_SIGNATURE           = 1 << 5

CONTROLLER_POLL_LENGTH  = 4

.enum $0700
  ; Controller Data
  ; Controller 1 Data
  controller1D0           dsb CONTROLLER_POLL_LENGTH
  controller1D1           dsb CONTROLLER_POLL_LENGTH
  controller1D2           dsb CONTROLLER_POLL_LENGTH
  controller1D3           dsb CONTROLLER_POLL_LENGTH
  controller1D4           dsb CONTROLLER_POLL_LENGTH
  controller1D0LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller1D1LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller1D2LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller1D3LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller1D4LastFrame  dsb CONTROLLER_POLL_LENGTH

  ; Controller 2 Data
  controller2D0           dsb CONTROLLER_POLL_LENGTH
  controller2D1           dsb CONTROLLER_POLL_LENGTH
  controller2D2           dsb CONTROLLER_POLL_LENGTH
  controller2D3           dsb CONTROLLER_POLL_LENGTH
  controller2D4           dsb CONTROLLER_POLL_LENGTH
  controller2D0LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller2D1LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller2D2LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller2D3LastFrame  dsb CONTROLLER_POLL_LENGTH
  controller2D4LastFrame  dsb CONTROLLER_POLL_LENGTH

  fourScoreDegradeCounter dsb 1
  controller1Type         dsb 1
  controller2Type         dsb 1
  controller3Type         dsb 1
  controller4Type         dsb 1
  controllerTmp           dsb 1
  controllerMouse         dsb 1

  ; Mouse Data
  mouseSensitivity        dsb 1

  ; Keyboard Data
  keyboardTmp             dsb 1
  basicKeyboard           dsb 10

  keyboardCounter         dsb 1
  keyboardASLTmp          dsb 1
  keyboardASLCounter      dsb 1
  keyboardFlags           dsb 1

  keyboardKeys                dsb 4
  keyboardKeysLastFrame       dsb 4
  keyboardKeysTmp             dsb 4
  keyboardGlyph               dsb 1
  keyboardGlyphHeldLastFrame  dsb 1
.ende


; controllerGlobalFlags
; 7  bit  0
; ---- ----
; ||   ||||
; ||   |||+- Famicom BASIC Keyboard Detected Flag
; ||   ||+-- Four Score Detected Flag
; ||   |+--- SNES Mouse Detected Flag
; ||   +---- SNES Mouse Ready Flag
; ||
; ||
; |+-------- USB Keyboard Detected Flag
; +--------- USB Mouse Detected Flag


PollController:
  ldx #$00
PollControllerSetLastFrameLoop:
  lda controller1D0, X
  sta controller1D0LastFrame, X
  lda controller1D1, X
  sta controller1D1LastFrame, X
  lda controller1D2, X
  sta controller1D2LastFrame, X
  lda controller1D3, X
  sta controller1D3LastFrame, X
  lda controller1D4, X
  sta controller1D4LastFrame, X
  lda controller2D0, X
  sta controller2D0LastFrame, X
  lda controller2D1, X
  sta controller2D1LastFrame, X
  lda controller2D2, X
  sta controller2D2LastFrame, X
  lda controller2D3, X
  sta controller2D3LastFrame, X
  lda controller2D4, X
  sta controller2D4LastFrame, X
  lda keyboardKeys, X
  sta keyboardKeysLastFrame, X
  inx
  cpx #CONTROLLER_POLL_LENGTH
  bne PollControllerSetLastFrameLoop
    lda #$05
    ; Write 5 to $4016 (For Famicom BASIC Keyboard)
    sta CONTROLLER1


    ; Cycle Mouse Sensitivity Here
    ldx #$00
    ldy #$00
PollControllerLoop:
  ; Skip to PollControllerLoopSkipKeyPoll if after first 20 Polls (last is X=2, Y=3)
  cpx #$03
  bcs PollControllerLoopSkipKeyboardPoll
    ; (X<2 within 20 Polls)
    cpx #$02
    bcc PollControllerLoopKeyboardPoll
      ; (X=2, Y>=4 is outside 20 Polls)
      cpy #$04
      bcs PollControllerLoopSkipKeyboardPoll
PollControllerLoopKeyboardPoll:
  tya
  and #$01
  clc
  asl
  adc #$04
  ; Write 4 to $4016 on Y=even otherwise write 6 to $4016 on Y=odd (For Famicom BASIC Keyboard)
  sta CONTROLLER1
PollControllerLoopSkipKeyboardPoll:
  ; $4017 Read (Player 1 and 3)
  lda CONTROLLER1 ; 2
  lsr
  rol controller1D0, X
  lsr
  rol controller1D1, X
  lsr
  rol controller1D2, X
  lsr
  rol controller1D3, X
  lsr
  rol controller1D4, X
  ; $4017 Read (Player 2, 4, and Famicom BASIC Keyboard)
  lda CONTROLLER2
  sta keyboardTmp
  lsr
  rol controller2D0, X
  lsr
  rol controller2D1, X
  lsr
  rol controller2D2, X
  lsr
  rol controller2D3, X
  lsr
  rol controller2D4, X
PollControllerEnd:
  iny
  cpy #$08
  bne PollControllerLoop
    ldy #$00
    inx
    cpx #CONTROLLER_POLL_LENGTH
    bne PollControllerLoop
      lda controller1D0
      rts


;;;;;;;;;;
;;
;; NES Standard Controller
;;
;;;;;;;;;;

CheckUpTitle:
  lda controller1D0
  and #BUTTON_UP
  beq CheckUpTitleDone
    lda controller1D0LastFrame
    and #(BUTTON_SELECT + BUTTON_UP + BUTTON_DOWN)
    bne CheckUpTitleDone
      lda $204
      cmp #$B7
      beq CheckUpTitleDone
        sec
        sbc #$10
        sta $204
CheckUpTitleDone:
  rts


CheckDownTitle:
  lda controller1D0
  and #BUTTON_DOWN
  beq CheckDownTitleDone
    lda controller1D0LastFrame
    and #(BUTTON_SELECT + BUTTON_UP + BUTTON_DOWN)
    bne CheckDownTitleDone
      lda $204
      cmp #$C7
      bcs CheckDownTitleDone
        clc
        adc #$10
        sta $204
CheckDownTitleDone:
  rts


CheckSelectTitle:
  lda controller1D0
  and #BUTTON_SELECT
  beq CheckSelectTitleDone
    lda controller1D0LastFrame
    and #(BUTTON_SELECT + BUTTON_UP + BUTTON_DOWN)
    bne CheckSelectTitleDone
      lda $204
      cmp #$B7
      beq CheckSelectNotDownDone
        sec
        sbc #$10
        sta $204
        jmp CheckSelectTitleDone
CheckSelectNotDownDone:
  cmp #$C7
  bcs CheckSelectTitleDone
    clc
    adc #$10
    sta $204
CheckSelectTitleDone:
  rts

CheckStartTitle:
  lda controller1D0LastFrame
  and #BUTTON_START
  beq CheckStartTitleContinue
    rts
CheckStartTitleContinue:
  lda controller1D0
  and #BUTTON_START
  bne CheckStartTitleContinueStartPressed
    rts
CheckStartTitleContinueStartPressed:
  lda $204
  sec
  sbc #$A8
  lsr
  lsr
  lsr
  lsr
  cmp #$01
  bne CheckStartTitleNotTwitchChat
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda #$23
    sta (drawBuffer), Y
    iny
    lda #$2F
    sta (drawBuffer), Y
    iny
    lda #$01
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset

    jsr ClearSprites
    jsr SetSwipePixelBottom

    ; Option is Twitch Chat and START press
    ; Scroll is top left $2000
    lda #$00
    sta nametable
    lda screen
    and #%11100000
    ora #SCREEN_TWITCH_CHAT
    ora #%00001000
    sta screen
    rts
CheckStartTitleNotTwitchChat:
  cmp #$00
  bne CheckStartTitleNotSchedule
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda #$22
    sta (drawBuffer), Y
    iny
    lda #$EF
    sta (drawBuffer), Y
    iny
    lda #$01
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset

    jsr ClearSprites
    jsr SetSwipePixelTop

    lda #$00
    sta nametable
    lda screen
    and #%11100000
    ora #SCREEN_SCHEDULE
    ora #%00001000
    sta screen
    rts
CheckStartTitleNotSchedule:
	;TODO
	rts
	;TODO
  cmp #$02
  bne CheckStartTitleNotExtra
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda #$23
    sta (drawBuffer), Y
    iny
    lda #$4F
    sta (drawBuffer), Y
    iny
    lda #$01
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset
  
    jsr ClearSprites
  
    jsr SetSwipePixelMiddle
    lda #$01
    sta nametable
    lda #$FF
    sta xscroll
    lda #$00
    sta xscrollSlice
    lda screen
    and #%11100000
    ora #SCREEN_EXTRA
    ora #%00001000
    sta screen
    rts
CheckStartTitleNotExtra:
CheckStartTitleDone:
  rts

CheckATitle:
  lda controller1D0LastFrame
  and #BUTTON_A
  beq CheckATitleContinue
    rts
CheckATitleContinue:
  lda controller1D0
  and #BUTTON_A
  bne CheckATitleContinueAPressed
    rts
CheckATitleContinueAPressed:
  lda $204
  sec
  sbc #$A8
  lsr
  lsr
  lsr
  lsr
  cmp #$01
  bne CheckATitleNotTwitchChat
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda #$23
    sta (drawBuffer), Y
    iny
    lda #$2F
    sta (drawBuffer), Y
    iny
    lda #$01
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset

    jsr ClearSprites
    jsr SetSwipePixelBottom

    ; Option is Twitch Chat and A press
    ; Scroll is top left $2000
    lda #$00
    sta nametable
    lda screen
    and #%11100000
    ora #SCREEN_TWITCH_CHAT
    ora #%00001000
    sta screen
    rts
CheckATitleNotTwitchChat:
  cmp #$00
  bne CheckATitleNotSchedule
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda #$22
    sta (drawBuffer), Y
    iny
    lda #$EF
    sta (drawBuffer), Y
    iny
    lda #$01
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset

    jsr ClearSprites
    jsr SetSwipePixelTop

    lda #$00
    sta nametable
    lda screen
    and #%11100000
    ora #SCREEN_SCHEDULE
    ora #%00001000
    sta screen
    rts
CheckATitleNotSchedule:
	;TODO
	rts
	;TODO
  cmp #$02
  bne CheckATitleNotExtra
    ldy drawBufferOffset
    lda #$8E
    sta (drawBuffer), Y
    iny
    lda #$23
    sta (drawBuffer), Y
    iny
    lda #$4F
    sta (drawBuffer), Y
    iny
    lda #$01
    sta (drawBuffer), Y
    iny
    sty drawBufferOffset
  
    jsr ClearSprites
  
    jsr SetSwipePixelMiddle
    lda #$01
    sta nametable
    lda #$FF
    sta xscroll
    lda #$00
    sta xscrollSlice
    lda screen
    and #%11100000
    ora #SCREEN_EXTRA
    ora #%00001000
    sta screen
    rts
CheckATitleNotExtra:
CheckATitleDone:
  rts

CheckRightSchedule:
  lda controller1D0
  and #BUTTON_RIGHT
  beq CheckRightScheduleDone
    lda controller1D0LastFrame
    and #(BUTTON_RIGHT + BUTTON_A + BUTTON_LEFT + BUTTON_B)
    bne CheckRightScheduleDone
      lda schedule
      cmp #SCHEDULE_LAST
      beq CheckRightScheduleDone
        bcc CheckRightScheduleContinue
          lda #SCHEDULE_LAST
          sta schedule
          jmp CheckRightScheduleDone
CheckRightScheduleContinue:
  inc schedule
  lda #$01
  sta scheduleChange
CheckRightScheduleDone:
  rts

CheckLeftSchedule:
  lda controller1D0
  and #BUTTON_LEFT
  beq CheckLeftScheduleDone
    lda controller1D0LastFrame
    and #(BUTTON_RIGHT + BUTTON_A + BUTTON_LEFT + BUTTON_B)
    bne CheckLeftScheduleDone
      lda schedule
      beq CheckLeftScheduleDone
        bpl CheckLeftScheduleContinue
          lda #$00
          sta schedule
          jmp CheckLeftScheduleDone
CheckLeftScheduleContinue:
  dec schedule
  lda #$01
  sta scheduleChange
CheckLeftScheduleDone:
  rts

CheckASchedule:
  lda controller1D0
  and #BUTTON_A
  beq CheckAScheduleDone
    lda controller1D0LastFrame
    and #(BUTTON_RIGHT + BUTTON_A + BUTTON_LEFT + BUTTON_B)
    bne CheckAScheduleDone
      lda schedule
      cmp #SCHEDULE_LAST
      beq CheckAScheduleDone
        bcc CheckAScheduleContinue
          lda #SCHEDULE_LAST
          sta schedule
          jmp CheckAScheduleDone
CheckAScheduleContinue:
  inc schedule
  lda #$01
  sta scheduleChange
CheckAScheduleDone:
  rts

CheckBSchedule:
  lda controller1D0
  and #BUTTON_B
  beq CheckBScheduleDone
    lda controller1D0LastFrame
    and #(BUTTON_RIGHT + BUTTON_A + BUTTON_LEFT + BUTTON_B)
    bne CheckBScheduleDone
      lda schedule
      beq CheckBScheduleDone
        bpl CheckBScheduleContinue
          lda #$00
          sta schedule
          jmp CheckBScheduleDone
CheckBScheduleContinue:
  dec schedule
  lda #$01
  sta scheduleChange
CheckBScheduleDone:
  rts

CheckUpSchedule:
  lda controller1D0
  and #BUTTON_UP
  beq CheckDownScheduleDone
    lda schedule
    cmp #SCHEDULE_MAINFRAME
    bne CheckUpScheduleDone
      lda yscroll
      beq CheckUpScheduleDone
        dec yscroll
        dec yscroll
CheckUpScheduleDone:
  rts

CheckDownSchedule:
  lda controller1D0
  and #BUTTON_DOWN
  beq CheckDownScheduleDone
    lda schedule
    cmp #SCHEDULE_MAINFRAME
    bne CheckDownScheduleDone
      lda yscroll
      cmp #$70
      bcs CheckDownScheduleDone
        inc yscroll
        inc yscroll
CheckDownScheduleDone:
  rts

CheckABStartSelect:
  lda controller1D0
  cmp #(BUTTON_A + BUTTON_B + BUTTON_START + BUTTON_SELECT)
  bne CheckABStartSelectDone
    lda controller1D0LastFrame
    and #(BUTTON_A + BUTTON_B + BUTTON_START + BUTTON_SELECT)
    cmp #(BUTTON_A + BUTTON_B + BUTTON_START + BUTTON_SELECT)
    beq CheckABStartSelectDone
      jmp RESET
CheckABStartSelectDone:
  rts
