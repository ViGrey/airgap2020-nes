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


MIRRORING_V = $02
MIRRORING_H = $03

;; Expects A to be the CHR ROM Bank
SetMMC1CHRBank:
  sta $A000
  lsr
  sta $A000
  lsr
  sta $A000
  lsr
  sta $A000
  lsr
  sta $A000
  rts

SetMMC1CHRBank2:
  sta $C000
  lsr
  sta $C000
  lsr
  sta $C000
  lsr
  sta $C000
  lsr
  sta $C000
  rts


SetMMC1PRGBank:
  lda chatBank
  sta $E000
  lsr
  sta $E000
  lsr
  sta $E000
  lsr
  sta $E000
  lsr
  sta $E000
  rts


MMC1Initialize:
  lda chrSwitchSize
  and #%00000001
  asl
  asl
  asl
  asl
  ora #%00001100
  ora mirroring
  sta $8000
  lsr
  sta $8000
  lsr
  sta $8000
  lsr
  sta $8000
  lsr
  sta $8000
  rts
