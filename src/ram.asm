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

.enum $0000
Variables:
  fps                 dsb 1
  region              dsb 1
  regionTmp           dsb 1
  screen              dsb 1
  allowUpdate         dsb 1
  addr                dsb 2
  addrEnd             dsb 2
  chatData            dsb 32

  chatBank            dsb 1
  zeroFrames          dsb 3

  chatAddr            dsb 2
  tmp                 dsb 1

  ppuAddr             dsb 2
  ppuAddrTmp          dsb 2
  ppuAddrRow          dsb 1
  enableYScroll       dsb 1
  yscroll             dsb 1
  xscroll             dsb 1
  nametable           dsb 1
  yscrollSlice        dsb 1
  xscrollSlice        dsb 1
  nametableSlice      dsb 1
  patterns            dsb 1
  mirroring           dsb 1
  chrSwitchSize       dsb 1
  emphasis            dsb 1
  newLine             dsb 1
  enableYScrollTitle  dsb 1
  schedule            dsb 1
  scheduleChange      dsb 1
.ende

.enum $0300
DrawBufferVariables:
  drawBufferOffset      dsb 1
  drawBufferOffsetTmp   dsb 1
  drawBuffer            dsb 200
  draw                  dsb 1
.ende

.enum $0600
  frames  dsb 2
.ende
