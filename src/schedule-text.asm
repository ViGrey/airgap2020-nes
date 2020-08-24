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

ScheduleStartOffsets:
  .byte #<(PresentationsStart), #>(PresentationsStart)
  .byte #<(Ch0pp3dStart), #>(Ch0pp3dStart)
  .byte #<(Twitch2ShStart), #>(Twitch2ShStart)
  .byte #<(StartStart), #>(StartStart)
  .byte #<(IncubationStart), #>(IncubationStart)
  .byte #<(LuigibloodStart), #>(LuigibloodStart)
  .byte #<(MainframeStart), #>(MainframeStart)
  .byte #<(ReidStart), #>(ReidStart)
  .byte #<(NahamsecStart), #>(NahamsecStart)
  .byte #<(IlyaStart), #>(IlyaStart)
  .byte #<(MGStart), #>(MGStart)
  .byte #<(Twitch2ShellStart), #>(Twitch2ShellStart)
  .byte #<(NetspookyStart), #>(NetspookyStart)
  .byte #<(CaseyStart), #>(CaseyStart)
  .byte #<(SilvioStart), #>(SilvioStart)
  .byte #<(SyedStart), #>(SyedStart)
  .byte #<(SnyffStart), #>(SnyffStart)
  .byte #<(OutbreakStart), #>(OutbreakStart)
  .byte #<(YTCrackerStart), #>(YTCrackerStart)

ScheduleEndOffsets:
  .byte #<(PresentationsEnd), #>(PresentationsEnd)
  .byte #<(Ch0pp3dEnd), #>(Ch0pp3dEnd)
  .byte #<(Twitch2ShEnd), #>(Twitch2ShEnd)
  .byte #<(StartEnd), #>(StartEnd)
  .byte #<(IncubationEnd), #>(IncubationEnd)
  .byte #<(LuigibloodEnd), #>(LuigibloodEnd)
  .byte #<(MainframeEnd), #>(MainframeEnd)
  .byte #<(ReidEnd), #>(ReidEnd)
  .byte #<(NahamsecEnd), #>(NahamsecEnd)
  .byte #<(IlyaEnd), #>(IlyaEnd)
  .byte #<(MGEnd), #>(MGEnd)
  .byte #<(Twitch2ShellEnd), #>(Twitch2ShellEnd)
  .byte #<(NetspookyEnd), #>(NetspookyEnd)
  .byte #<(CaseyEnd), #>(CaseyEnd)
  .byte #<(SilvioEnd), #>(SilvioEnd)
  .byte #<(SyedEnd), #>(SyedEnd)
  .byte #<(SnyffEnd), #>(SnyffEnd)
  .byte #<(OutbreakEnd), #>(OutbreakEnd)
  .byte #<(YTCrackerEnd), #>(YTCrackerEnd)

ScheduleMMC1CHRBank:
  .byte $04, $04, $04
  .byte $04, $04, $04
  .byte $05
  .byte $06, $06, $06
  .byte $07, $07, $07
  .byte $08, $08, $08
  .byte $09, $09, $09

StartStart:
  .byte $23, $C8
  .byte %01000100, %01000101, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
  .byte %00000100, %00000100, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, $02
  .byte $3F, $00
  .byte $0F, $08, $18, $30
  .byte $0F, $08, $1C, $2C, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $80, $81, $82, $83, $84, $85, $08, $01
  .byte $07, $86, $87, $88, $89, $8A, $8B, $08, $01
  .byte $07, $8C, $8D, $8E, $8F, $90, $91, $08, $01
  .byte $07, $92, $93, $94, $95, $96, $97, $08, $01
  .byte $07, $98, $99, $9A, $9B, $9C, $9D, $08, $01
  .byte $07, $9E, $9F, $A0, $A1, $A2, $A3, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "11:30-12:00", $02
  .byte $21, $62
  .byte "THE GAP IS CROSSED", $01, $01
  .byte "THE STREAM WILL START AT", $01
  .byte "11:30AM. THE TEXT CHAT WILL", $01 
  .byte "BE SPICY AND THE EVENTS WILL", $01
  .byte "BEGIN."
StartEnd:

IncubationStart:
  .byte $23, $C8
  .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
  .byte %00000000, %00000101, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, $02
  .byte $3F, $00
  .byte $0F, $16, $27, $30
  .byte $0F, $30, $11, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $A4, $A5, $A6, $A7, $A8, $A9, $08, $01
  .byte $07, $AA, $AB, $AC, $AD, $AE, $AF, $08, $01
  .byte $07, $B0, $B1, $B2, $B3, $B4, $B5, $08, $01
  .byte $07, $B6, $B7, $B8, $B9, $BA, $BB, $08, $01
  .byte $07, $BC, $BD, $BE, $BF, $C0, $C1, $08, $01
  .byte $07, $C2, $C3, $C4, $C5, $C6, $C7, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "12:00-12:30", $02
  .byte $21, $62
  .byte "INCUBATION PERIOD", $01, $01
  .byte "GUESTS WILL BE GR33TZ'D WITH", $01
  .byte "A GENERAL CHECKUP. ALL THE", $01
  .byte "USUAL DISCLAIMERS AND A FEW", $01
  .byte "WORDS FROM THE THUGCROWD", $01
  .byte "HOSTS."
IncubationEnd:

LuigibloodStart:
  .byte $3F, $00
  .byte $0F, $11, $28, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $C8, $C9, $CA, $CB, $CC, $CD, $08, $01
  .byte $07, $CE, $CF, $D0, $D1, $D2, $D3, $08, $01
  .byte $07, $D4, $D5, $D6, $D7, $D8, $D9, $08, $01
  .byte $07, $DA, $DB, $DC, $DD, $DE, $DF, $08, $01
  .byte $07, $E0, $E1, $E2, $E3, $E4, $E5, $08, $01
  .byte $07, $E6, $E7, $E8, $E9, $EA, $EB, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "12:30-13:00", $02
  .byte $21, $62
  .byte "LUIGIBLOOD", $01, $01
  .byte "SATELLAVIEW REVERSE", $01
  .byte "ENGINEERING", $01, $01
  .byte "COME HEAR THE TALE OF", $01
  .byte "REVERSE ENGINEERING THE", $01
  .byte "SATELLAVIEW, A SATELLITE", $01
  .byte "ADD-ON FOR THE SUPER FAMICOM", $01
  .byte "TO DOWNLOAD GAMES. YOU MAY", $01
  .byte "HAVE NEVER HEARD OF IT, BUT", $01
  .byte "COME SEE HOW IT WORKS!"
LuigibloodEnd:

MainframeStart:
  .byte $23, $F0
  .byte %10000000, %10100000, %10000000, %10100000, %11000000, %11110000, %00000000, %00000000
  .byte %00001000, %00001010, %00001000, %00001010, %00001100, %00001111, %00000000, %00000000, $02
  .byte $2B, $C0
  .byte %00001000, %00001010, %00001000, %00001010, %00001100, %00001111, %00000000, %00000000
  .byte %01000100, %01010101, %00000000, %00000000, %11001100, %11111111, %00000000, %00000000
  .byte %00000100, %00000101, %00000000, %00000000, %00001100, %00001111, %00000000, %00000000, $02
  .byte $3F, $00
  .byte $0F, $2A, $16, $30
  .byte $0F, $11, $27, $30
  .byte $0F, $0A, $1A, $2A
  .byte $0F, $08, $27, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $00, $00, $00, $00, $00, $00, $08, $01
  .byte $07, $00, $00, $00, $00, $00, $00, $08, $01
  .byte $07, $50, $00, $51, $52, $00, $53, $08, $01
  .byte $07, $00, $00, $00, $00, $00, $54, $08, $01
  .byte $07, $55, $00, $56, $57, $00, $58, $08, $01
  .byte $07, $59, $00, $5A, $5B, $00, $5C, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte $21, $23, $2A, $20, $20, $1D, $21, $24, $2A, $20, $20, $02
  .byte $21, $62
  .byte $3D, $31, $39, $3E, $36, $42, $31, $3D, $35, $10, $38, $31, $33, $3B, $35, $42, $10, $43, $3F, $33, $39, $35, $44, $49, $01
  .byte $40, $31, $3E, $35, $3C, $01, $01
  .byte $3A, $3F, $39, $3E, $10, $44, $38, $35, $10, $3D, $31, $39, $3E, $36, $42, $31, $3D, $35, $10, $43, $3F, $33, $39, $35, $44, $49, $01
  .byte $40, $42, $35, $46, $39, $3F, $45, $43, $3C, $49, $10, $3F, $40, $35, $42, $31, $44, $39, $3E, $37, $10, $39, $3E, $01
  .byte $43, $35, $33, $42, $35, $44, $10, $44, $3F, $10, $36, $45, $42, $44, $38, $35, $42, $10, $44, $38, $35, $10, $43, $44, $45, $34, $49, $01
  .byte $31, $3E, $34, $10, $31, $34, $46, $31, $3E, $33, $35, $3D, $35, $3E, $44, $10, $3F, $36, $10, $3D, $31, $39, $3E, $36, $42, $31, $3D, $35, $01
  .byte $43, $35, $33, $45, $42, $39, $44, $49, $10, $31, $42, $3F, $45, $3E, $34, $10, $44, $38, $35, $10, $47, $3F, $42, $3C, $34, $11, $01, $01
  .byte $30, $3D, $31, $39, $3E, $36, $42, $31, $3D, $35, $34, $27, $26, $27, $10, $10, $10, $30, $3E, $3F, $37, $3F, $3E, $3F, $43, $31, $01
  .byte $30, $32, $39, $37, $35, $3E, $34, $39, $31, $3E, $43, $3D, $31, $3C, $3C, $43, $01
  .byte $30, $47, $39, $4A, $31, $42, $34, $3F, $36, $4A, $3F, $43, $10, $10, $10, $10, $10, $30, $4A, $32, $39, $44, $23, $21, $01
  .byte $30, $33, $38, $21, $3B, $40, $35, $35, $02
  .byte $23, $21
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $04, $05, $05, $05, $05, $05, $05, $06, $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $5D, $5E, $5F, $60, $61, $62, $08, $07, $00, $00, $00, $00, $00, $00, $08, $07, $0F, $0F, $0F, $95, $96, $0F, $08, $01
  .byte $07, $63, $64, $65, $66, $67, $68, $08, $07, $00, $81, $82, $83, $84, $00, $08, $07, $0F, $0F, $97, $0E, $0E, $98, $08, $01
  .byte $07, $69, $6A, $6B, $6C, $6D, $6E, $08, $07, $85, $86, $87, $88, $89, $8A, $08, $07, $0F, $99, $9A, $9B, $9C, $9D, $08, $01
  .byte $07, $6F, $70, $71, $72, $73, $74, $08, $07, $8B, $8C, $8D, $8E, $8F, $90, $08, $07, $0F, $9E, $9F, $A0, $A1, $A2, $08, $02
  .byte $28, $01
  .byte $07, $75, $76, $77, $78, $79, $7A, $08, $07, $00, $91, $92, $93, $94, $00, $08, $07, $A3, $A4, $A5, $A6, $A7, $A8, $08, $01
  .byte $07, $7B, $7C, $7D, $7E, $7F, $80, $08, $07, $00, $00, $00, $00, $00, $00, $08, $07, $00, $00, $A9, $AA, $AB, $AC, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $01
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $04, $05, $05, $05, $05, $05, $05, $06, $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $0F, $0F, $0F, $AD, $AE, $0F, $08, $07, $C5, $C6, $C7, $C8, $C9, $CA, $08, $07, $0F, $E3, $E4, $E5, $0F, $0F, $08, $01
  .byte $07, $0F, $AF, $B0, $B1, $B2, $B3, $08, $07, $CB, $CC, $CD, $CE, $CF, $D0, $08, $07, $0F, $E6, $E7, $E8, $E9, $0F, $08, $01
  .byte $07, $B4, $B5, $B6, $B7, $B8, $B9, $08, $07, $D1, $D2, $D3, $D4, $D5, $D6, $08, $07, $0F, $EA, $EB, $EC, $ED, $0F, $08, $01
  .byte $07, $0F, $BA, $BB, $BC, $BD, $BE, $08, $07, $00, $D7, $D8, $D9, $DA, $00, $08, $07, $0F, $EE, $EF, $F0, $F1, $0F, $08, $01
  .byte $07, $0F, $0F, $BF, $C0, $C1, $0F, $08, $07, $DB, $DC, $DD, $DE, $DF, $00, $08, $07, $F2, $F3, $F4, $F5, $F6, $F7, $08, $01
  .byte $07, $0F, $0F, $C2, $C3, $C4, $0F, $08, $07, $00, $E0, $E1, $00, $E2, $00, $08, $07, $0D, $F8, $0F, $0F, $F9, $FA, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B
MainframeEnd:

ReidStart:
  .byte $3F, $00
  .byte $0F, $08, $27, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $80, $81, $82, $83, $84, $85, $08, $01
  .byte $07, $86, $87, $88, $89, $8A, $8B, $08, $01
  .byte $07, $8C, $8D, $8E, $8F, $90, $91, $08, $01
  .byte $07, $92, $93, $94, $95, $96, $97, $08, $01
  .byte $07, $98, $99, $9A, $9B, $9C, $9D, $08, $01
  .byte $07, $9E, $9F, $A0, $A1, $A2, $A3, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "14:00-14:30", $02
  .byte $21, $62
  .byte "REID WIGHTMAN", $01, $01
  .byte "SWITCHES GET ROOT CANALS", $01, $01
  .byte "COME EXAMINE A TYPICAL LAYER", $01
  .byte "2 SWITCH, WITHOUT MANY", $01
  .byte "FEATURES, IDENTIFY A 'ROOT'", $01
  .byte "LEVEL VULNERABILITY, AND SEE", $01
  .byte "WHAT WE CAN ACHIEVE. DROP OR", $01
  .byte "EVEN MODIFY PACKETS IN", $01
  .byte "TRANSIT? HIDE MALICIOUS", $01
  .byte "ACTIVITY?"
ReidEnd:

NahamsecStart:
  .byte $3F, $00
  .byte $0F, $1C, $27, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $A4, $A5, $A6, $A7, $A8, $A9, $08, $01
  .byte $07, $AA, $AB, $AC, $AD, $AE, $AF, $08, $01
  .byte $07, $B0, $B1, $B2, $B3, $B4, $B5, $08, $01
  .byte $07, $B6, $B7, $B8, $B9, $BA, $BB, $08, $01
  .byte $07, $BC, $BD, $BE, $BF, $C0, $C1, $08, $01
  .byte $07, $C2, $C3, $C4, $C5, $C6, $C7, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "14:30-15:00", $02
  .byte $21, $62
  .byte "NAHAMSEC", $01, $01
  .byte "OWNING THE CLOUT THROUGH", $01
  .byte "SSRF AND PDF GENERATORS", $01, $01
  .byte "COME AND DISCUSS A NUMBER OF", $01
  .byte "DIFFERENT METHODS TO", $01
  .byte "EXFILTRATE DATA SSRF. WE", $01
  .byte "WERE ABLE TO HACK SOME OF", $01
  .byte "THE MAJOR TRANSPORTATION,", $01
  .byte "HOSPITALITY, AND SOCIAL", $01
  .byte "MEDIA COMPANIES FOR BIG", $01
  .byte "BOUNTIES!"
NahamsecEnd:

IlyaStart:
  .byte $23, $C8
  .byte %01000100, %01010101, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
  .byte %00000100, %00000101, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, $02
  .byte $3F, $00
  .byte $0F, $24, $13, $30
  .byte $0F, $24, $13, $23, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $C8, $C9, $CA, $CB, $CC, $CD, $08, $01
  .byte $07, $CE, $CF, $D0, $D1, $D2, $D3, $08, $01
  .byte $07, $D4, $D5, $D6, $D7, $D8, $D9, $08, $01
  .byte $07, $DA, $DB, $DC, $DD, $DE, $DF, $08, $01
  .byte $07, $E0, $E1, $E2, $E3, $E4, $E5, $08, $01
  .byte $07, $E6, $E7, $E8, $E9, $EA, $EB, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "15:00-16:00", $02
  .byte $21, $62
  .byte "ILYA", $01, $01
  .byte "EMULATING IOT FIRMWARE EN", $01
  .byte "MASSE WITH DOCKER & QEMU", $01, $01
  .byte "COME SEE TECHNIQUES USING", $01
  .byte "CONTAINERS AND QEMU USED TO", $01
  .byte "EMULATE NON-X86 FIRMWARE TO", $01
  .byte "DEMONSTRATE CAPABILITIES AND", $01
  .byte "LIMITATIONS WHEN USED FOR", $01
  .byte "SECURITY RESEARCH (AND", $01
  .byte "TARGET PRACTICE)"
IlyaEnd:

MGStart:
  .byte $3F, $00
  .byte $0F, $2D, $10, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $80, $81, $82, $83, $84, $85, $08, $01
  .byte $07, $86, $87, $88, $89, $8A, $8B, $08, $01
  .byte $07, $8C, $8D, $8E, $8F, $90, $91, $08, $01
  .byte $07, $92, $93, $94, $95, $96, $97, $08, $01
  .byte $07, $98, $99, $9A, $9B, $9C, $9D, $08, $01
  .byte $07, $9E, $9F, $A0, $A1, $A2, $A3, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "16:00-16:30", $02
  .byte $21, $62
	.byte "MG", $01, $01
  .byte "RAPID PROTOTYPING CHAOS", $01, $01
  .byte "COME SEE HOW RAPID", $01
  .byte "PROTOTYPING HAS WORKED FOR", $01
  .byte "PROJECTS THAT RESULTED IN", $01
  .byte "THE DEMONSEED AND O.MG", $01
  .byte "CABLE. MG IS A THUG OF", $01
  .byte "CHAOS, AND THIS PRESENTATION", $01
  .byte "PROMISES TO BE NOTHING LESS!"
MGEnd:

Twitch2ShellStart:
  .byte $3F, $00
  .byte $0F, $2D, $27, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $A4, $A5, $A6, $A7, $A8, $A9, $08, $01
  .byte $07, $AA, $AB, $AC, $AD, $AE, $AF, $08, $01
  .byte $07, $B0, $B1, $B2, $B3, $B4, $B5, $08, $01
  .byte $07, $B6, $B7, $B8, $B9, $BA, $BB, $08, $01
  .byte $07, $BC, $BD, $BE, $BF, $C0, $C1, $08, $01
  .byte $07, $C2, $C3, $C4, $C5, $C6, $C7, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "16:30-17:00", $02
  .byte $21, $62
  .byte "TWITCH2SHELL", $01, $01
  .byte "THE TWITCH2SHELL EVENT WILL", $01
  .byte "BEGIN! YOU CAN INTERACT WITH", $01
  .byte "A REAL SHELL USING TWITCH", $01
  .byte "CHAT COMMANDS. THIS TIME CAN", $01
  .byte "BE USED FOR RIGOROUS SCRUB", $01
  .byte "DOWNS AND MAINTIANING", $01
  .byte "HEALTHY FLUID LEVELS.", $01
Twitch2ShellEnd:

NetspookyStart:
  .byte $3F, $00
  .byte $0F, $3D, $28, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $C8, $C9, $CA, $CB, $CC, $CD, $08, $01
  .byte $07, $CE, $CF, $D0, $D1, $D2, $D3, $08, $01
  .byte $07, $D4, $D5, $D6, $D7, $D8, $D9, $08, $01
  .byte $07, $DA, $DB, $DC, $DD, $DE, $DF, $08, $01
  .byte $07, $E0, $E1, $E2, $E3, $E4, $E5, $08, $01
  .byte $07, $E6, $E7, $E8, $E9, $EA, $EB, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "17:00-17:30", $02
  .byte $21, $62
  .byte "NETSPOOKY", $01, $01
	.byte "ADVENTURES IN BINARY GOLF", $01, $01
  .byte "HIT THE BACK 9 ON AN", $01
  .byte "ADVENTURE OF BINARY MANGLING", $01
  .byte "AND MANIPULATION. LOWER YOUR", $01
  .byte "PAR WITH APPROACH, RATIONALE", $01
  .byte "AND TECHNIQUES FOR ELF AND", $01
  .byte "PE FORMATS. ENJOY TIPS,", $01
  .byte "TRICKS AND POLYGLOT TREATS", $01
  .byte "TO MINIFY YOUR GAME."
NetspookyEnd:

CaseyStart:
  .byte $3F, $00
  .byte $0F, $11, $16, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $80, $81, $82, $83, $84, $85, $08, $01
  .byte $07, $86, $87, $88, $89, $8A, $8B, $08, $01
  .byte $07, $8C, $8D, $8E, $8F, $90, $91, $08, $01
  .byte $07, $92, $93, $94, $95, $96, $97, $08, $01
  .byte $07, $98, $99, $9A, $9B, $9C, $9D, $08, $01
  .byte $07, $9E, $9F, $A0, $A1, $A2, $A3, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "17:30-18:00", $02
  .byte $21, $62
  .byte "CASEY ELLIS", $01, $01
  .byte "VIRAL VULNERABILITY", $01
  .byte "DISCLOSURE", $01, $01
  .byte "WHAT ABOUT DISCLOSURE? DOES", $01
  .byte "HACKING IN A SKIMASK MAKE", $01
  .byte "YOU A BURGLAR? MEET THE", $01
  .byte "GHOSTS OF PAST PRESENT AND", $01
  .byte "FUTURE TO CREATE", $01
  .byte "CONVERSATION BETWEEN", $01
  .byte "BUILDERS AND BREAKERS WITH", $01
  .byte "DISCLOSE.IO"
CaseyEnd:

SilvioStart:
  .byte $3F, $00
  .byte $0F, $08, $27, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $A4, $A5, $A6, $A7, $A8, $A9, $08, $01
  .byte $07, $AA, $AB, $AC, $AD, $AE, $AF, $08, $01
  .byte $07, $B0, $B1, $B2, $B3, $B4, $B5, $08, $01
  .byte $07, $B6, $B7, $B8, $B9, $BA, $BB, $08, $01
  .byte $07, $BC, $BD, $BE, $BF, $C0, $C1, $08, $01
  .byte $07, $C2, $C3, $C4, $C5, $C6, $C7, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "18:00-18:30", $02
  .byte $21, $62
  .byte "DR SILVIO CASARE", $01, $01
  .byte "MODERN LINUX HEAP", $01
  .byte "EXPLOITATION", $01, $01
  .byte "A CLASSIC HEAP OVERFLOW", $01
  .byte "CAN'T LEAD TO CODE", $01
  .byte "EXECUTION! COME SEE HOW WITH", $01
  .byte "SOME GROOMING AND A LITTLE", $01
  .byte "APPLICATION LOGIN HOW YOU", $01
  .byte "CAN DEFEAT ALL CURRENT", $01
  .byte "MITIGATIONS IN LINUX", $01
  .byte "ALLOCATORS SUCH AS PTMALLOC2"
SilvioEnd:

SyedStart:
  .byte $3F, $00
  .byte $0F, $1C, $3B, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $C8, $C9, $CA, $CB, $CC, $CD, $08, $01
  .byte $07, $CE, $CF, $D0, $D1, $D2, $D3, $08, $01
  .byte $07, $D4, $D5, $D6, $D7, $D8, $D9, $08, $01
  .byte $07, $DA, $DB, $DC, $DD, $DE, $DF, $08, $01
  .byte $07, $E0, $E1, $E2, $E3, $E4, $E5, $08, $01
  .byte $07, $E6, $E7, $E8, $E9, $EA, $EB, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "18:30-19:30", $02
  .byte $21, $62
  .byte "SYED FARAZ ABRAR", $01, $01
  .byte "HAHA V8 ENGINE GO BRRRRR", $01, $01
  .byte "V8 IS SO COMPLEX THAT IT HAS", $01
  .byte "ITS OWN BUG CLASSES", $01
  .byte "YOU'LL BE ABLE TO LEARN", $01
  .byte "ABOUT THE GORY INTERNALS OF", $01
  .byte "ONE OF THE MOST USED JS", $01
  .byte "ENGINES IN THE WORLD AND THE", $01
  .byte "BEST APPROACH FOR FINDING JS", $01
  .byte "ENGINE VULNS"
SyedEnd:

SnyffStart:
  .byte $3F, $00
  .byte $0F, $08, $27, $30, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $80, $81, $82, $83, $84, $85, $08, $01
  .byte $07, $86, $87, $88, $89, $8A, $8B, $08, $01
  .byte $07, $8C, $8D, $8E, $8F, $90, $91, $08, $01
  .byte $07, $92, $93, $94, $95, $96, $97, $08, $01
  .byte $07, $98, $99, $9A, $9B, $9C, $9D, $08, $01
  .byte $07, $9E, $9F, $A0, $A1, $A2, $A3, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "19:30-20:00", $02
  .byte $21, $62
  .byte "SNYFF", $01, $01
  .byte "CODE THAT GETS YOU", $01
  .byte "PWN(S['D)", $01, $01
  .byte "FROM REGULAR EXPRESSION", $01
  .byte "MAGIC TO UNICODE JIU-JITSU,", $01
  .byte "WE WILL END MIXING THE TWO", $01
  .byte "TO CREATE SOME", $01
  .byte "UNICODE/REGULAR EXPRESSION", $01
  .byte "KRAV MAGA FOR MAXIMUM DAMAGE", $01
  .byte "IN GOLANG, RUBY, PYTHON, C#"
SnyffEnd:

OutbreakStart:
  .byte $23, $C8
  .byte %01000100, %01000100, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
  .byte %00000100, %00000100, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, $02
  .byte $3F, $00
  .byte $0F, $2D, $37, $30
  .byte $0F, $2D, $08, $14, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $A4, $A5, $A6, $A7, $A8, $A9, $08, $01
  .byte $07, $AA, $AB, $AC, $AD, $AE, $AF, $08, $01
  .byte $07, $B0, $B1, $B2, $B3, $B4, $B5, $08, $01
  .byte $07, $B6, $B7, $B8, $B9, $BA, $BB, $08, $01
  .byte $07, $BC, $BD, $BE, $BF, $C0, $C1, $08, $01
  .byte $07, $C2, $C3, $C4, $C5, $C6, $C7, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "20:00-20:30", $02
  .byte $21, $62
  .byte "OUTBREAK CONTAINMENT", $01, $01
  .byte "A RECAP OF THE DAYS EVENTS", $01
  .byte "WILL BE DISCUSSED. THIS WILL", $01
  .byte "INCLUDE ANNOUNCING THE", $01
  .byte "WINNERS OF THE CTF AND", $01
  .byte "CH0PP3D EVENTS."
OutbreakEnd:

YTCrackerStart:
  .byte $23, $C8
  .byte %11000100, %10001101, %00000000, %00000100, %00000000, %00000000, %00000000, %00000000
  .byte %00000100, %00000100, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, $02
  .byte $3F, $00
  .byte $0F, $2B, $27, $30
  .byte $0F, $11, $27, $30
  .byte $0F, $11, $27, $2B
  .byte $0F, $11, $30, $2B, $02
  .byte $20, $61
  .byte $04, $05, $05, $05, $05, $05, $05, $06, $01
  .byte $07, $C8, $C9, $CA, $CB, $CC, $CD, $08, $01
  .byte $07, $CE, $CF, $D0, $D1, $D2, $D3, $08, $01
  .byte $07, $D4, $D5, $D6, $D7, $D8, $D9, $08, $01
  .byte $07, $DA, $DB, $DC, $DD, $DE, $DF, $08, $01
  .byte $07, $E0, $E1, $E2, $E3, $E4, $E5, $08, $01
  .byte $07, $E6, $E7, $E8, $E9, $EA, $EB, $08, $01
  .byte $09, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $02
  .byte $21, $29
  .byte "20:30-22:35", $02
  .byte $21, $62
  .byte "YTCRACKER", $01, $01
  .byte "PANDEMIC PARTY", $01, $01
  .byte "TIME TO LET YOUR HAIR DOWN", $01
  .byte "WITH COMMUNITY EVENTS AND", $01
  .byte "MUSIC. BOOZE AND CHATTER", $01
  .byte "OPTIONAL WHILE MAINTAINING A", $01
  .byte "SAFE DISTANCE (NOT", $01
  .byte "OPTIONAL)."
YTCrackerEnd:

PresentationsStart:
  .byte $3F, $00
  .byte $0F, $0F, $0F, $30, $02
  .byte $20, $62
  .byte "PRESENTATIONS", $01, $01
  .byte "THE MAIN FOCUS OF THE EVENT", $01
  .byte "IS THE PRESENTATIONS, THESE", $01
  .byte "WILL BE HELD OVER 8 HOURS IN", $01
  .byte "30 AND 60 MINUTE BLOCKS, ", $01
  .byte "WITH A 5 MINUTE Q&A OR BREAK", $01
  .byte "TIME IN BETWEEN.", $01, $01, $01, $01
  .byte "CAPTURE THE FLAG", $01, $01
  .byte "A CTF WILL BE TAKING PLACE", $01
  .byte "FOR THE DURATION OF THE", $01
  .byte "EVENT. IT IS OPEN TO", $01
  .byte "INDIVIDUALS AND TEAMS WITH", $01
  .byte "WINNERS AND PRIZES TO BE", $01
  .byte "ANNOUNCED AT THE END OF THE", $01
  .byte "EVENT."
PresentationsEnd:

Ch0pp3dStart:
  .byte $3F, $00
  .byte $0F, $0F, $0F, $30, $02
  .byte $20, $62
  .byte "CH0PP3D!", $01, $01
  .byte "THE CH0PP3D HACK-A-THON WILL", $01
  .byte "RUN FOR THE DURATION FOR THE", $01
  .byte "EVENT. IT IS OPEN TO", $01
  .byte "INDIVIDUALS AND TEAMS WITH", $01
  .byte "WINNERS AND PRIZES TO BE", $01
  .byte "ANNOUNCED AT THE END OF THE", $01
  .byte "EVENT.", $01, $01, $01, $01
  .byte "MAINFRAME PANEL", $01, $01
  .byte "A BIG-IRON SECURITY PANEL,", $01
  .byte "FEATURING PROMINENT", $01
  .byte "MAINFRAME SECURITY EXPERTS", $01
  .byte "FROM AROUND THE WORLD (THERE", $01
  .byte "ISN'T THAT MANY OF THEM)."
Ch0pp3dEnd:

Twitch2ShStart:
  .byte $3F, $00
  .byte $0F, $0F, $0F, $30, $02
  .byte $20, $62
  .BYTE "TWITCH2SHELL", $01, $01
  .byte "THE INFAMOUS THUGCROWD", $01
  .byte "TWITCH2SHELL EVENT WILL", $01
  .byte "RETURN AT AIRGAP2020.", $01
  .byte "PARTCIPANTS OF THE TWITCH", $01
  .byte "CHAT CAN INTERACT WITH A", $01
  .byte "SHELL. THE ONLY PROBLEM IS", $01
  .byte "EVERYONE HAS TO SHARE!", $01, $01, $01, $01
  .byte "PANDEMIC PARTY", $01, $01
  .BYTE "STAY AROUND AFTER TO CHAT", $01
  .byte "WITH SPEAKERS AND GUESTS,", $01
  .byte "DISCUSS SOLUTIONS TO CH0PP3D", $01
  .byte "AND THE CTF, AND ENJOY A", $01
  .byte "LIVE DJ SET FROM YTCRACKER!"
Twitch2ShEnd:
