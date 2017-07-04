; DLDI
; G003DS - Revolution for DS
; DLDI_SIZE_8KB
; FIX_ALL | FIX_GLUE | FIX_GOT | FIX_BSS

; dldiStart:      0xBF800000
; dldiEnd:        0xBF8009D0
; interworkStart: 0xBF800098
; interworkEnd:   0xBF800098
; gotStart:       0xBF8009CC
; gotEnd:         0xBF8009CC
; bssStart:       0xBF8009D0
; bssEnd:         0xBF8009EC

; DISC_INTERFACE_STRUCT {
;     ioType:        G003
;     features:      0x23
;     startup:       0xBF8008BC
;     isInserted:    0xBF8008E4
;     readSectors:   0xBF80090C
;     writeSectors:  0xBF800950
;     clearStatus:   0xBF800994
;     shutdown:      0xBF80099C
; }

; .code 0xBF800080
; .code end 0xBF8009D0

.data:bf800080 0d c0 a0 e1                      mov   r12, sp
.data:bf800084 f8 df 2d e9                      push  {r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr, pc}
.data:bf800088 04 b0 4c e2                      sub   r11, r12, #4
.data:bf80008c 28 d0 4b e2                      sub   sp, r11, #40   ; 0x28
.data:bf800090 f0 6f 9d e8                      ldm   sp, {r4, r5, r6, r7, r8, r9, r10, r11, sp, lr}
.data:bf800094 1e ff 2f e1                      bx lr
.data:bf800098 10 40 2d e9                      push  {r4, lr}
.data:bf80009c 2c 40 9f e5                      ldr   r4, [pc, #44]  ; 0xbf8000d0
.data:bf8000a0 00 30 d4 e5                      ldrb  r3, [r4]
.data:bf8000a4 00 00 53 e3                      cmp   r3, #0
.data:bf8000a8 24 20 9f e5                      ldr   r2, [pc, #36]  ; 0xbf8000d4
.data:bf8000ac 05 00 00 1a                      bne   0xbf8000c8
.data:bf8000b0 00 00 52 e3                      cmp   r2, #0
.data:bf8000b4 1c 00 9f e5                      ldr   r0, [pc, #28]  ; 0xbf8000d8
.data:bf8000b8 0f e0 a0 11                      movne lr, pc
.data:bf8000bc 12 ff 2f 11                      bxne  r2
.data:bf8000c0 01 30 a0 e3                      mov   r3, #1
.data:bf8000c4 00 30 c4 e5                      strb  r3, [r4]
.data:bf8000c8 10 40 bd e8                      pop   {r4, lr}
.data:bf8000cc 1e ff 2f e1                      bx lr
.data:bf8000d0 d0 09 80 bf                      svclt 0x008009d0
.data:bf8000d4 00 00 00 00                      andeq r0, r0, r0
.data:bf8000d8 c4 09 80 bf                      svclt 0x008009c4
.data:bf8000dc 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf8000e0 40 30 9f e5                      ldr   r3, [pc, #64]  ; 0xbf800128
.data:bf8000e4 00 00 53 e3                      cmp   r3, #0
.data:bf8000e8 04 d0 4d e2                      sub   sp, sp, #4
.data:bf8000ec 38 00 9f e5                      ldr   r0, [pc, #56]  ; 0xbf80012c
.data:bf8000f0 38 10 9f e5                      ldr   r1, [pc, #56]  ; 0xbf800130
.data:bf8000f4 0f e0 a0 11                      movne lr, pc
.data:bf8000f8 13 ff 2f 11                      bxne  r3
.data:bf8000fc 30 00 9f e5                      ldr   r0, [pc, #48]  ; 0xbf800134
.data:bf800100 00 30 90 e5                      ldr   r3, [r0]
.data:bf800104 00 00 53 e3                      cmp   r3, #0
.data:bf800108 28 30 9f e5                      ldr   r3, [pc, #40]  ; 0xbf800138
.data:bf80010c 02 00 00 0a                      beq   0xbf80011c
.data:bf800110 00 00 53 e3                      cmp   r3, #0
.data:bf800114 0f e0 a0 11                      movne lr, pc
.data:bf800118 13 ff 2f 11                      bxne  r3
.data:bf80011c 04 d0 8d e2                      add   sp, sp, #4
.data:bf800120 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf800124 1e ff 2f e1                      bx lr
.data:bf800128 00 00 00 00                      andeq r0, r0, r0
.data:bf80012c c4 09 80 bf                      svclt 0x008009c4
.data:bf800130 d4 09 80 bf                      svclt 0x008009d4
.data:bf800134 c8 09 80 bf                      svclt 0x008009c8
.data:bf800138 00 00 00 00                      andeq r0, r0, r0
.data:bf80013c 01 23 a0 e3                      mov   r2, #67108864  ; 0x4000000
.data:bf800140 a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf800144 00 00 53 e3                      cmp   r3, #0
.data:bf800148 fc ff ff ba                      blt   0xbf800140
.data:bf80014c 3f 30 e0 e3                      mvn   r3, #63  ; 0x3f
.data:bf800150 6b 1f a0 e3                      mov   r1, #428 ; 0x1ac
.data:bf800154 a1 31 c2 e5                      strb  r3, [r2, #417] ; 0x1a1
.data:bf800158 c1 13 81 e2                      add   r1, r1, #67108867 ; 0x4000003
.data:bf80015c 00 20 a0 e3                      mov   r2, #0
.data:bf800160 02 30 d0 e7                      ldrb  r3, [r0, r2]
.data:bf800164 01 20 82 e2                      add   r2, r2, #1
.data:bf800168 08 00 52 e3                      cmp   r2, #8
.data:bf80016c 01 30 41 e4                      strb  r3, [r1], #-1
.data:bf800170 fa ff ff 1a                      bne   0xbf800160
.data:bf800174 1e ff 2f e1                      bx lr
.data:bf800178 70 40 2d e9                      push  {r4, r5, r6, lr}
.data:bf80017c 03 40 a0 e1                      mov   r4, r3
.data:bf800180 02 61 81 e0                      add   r6, r1, r2, lsl #2
.data:bf800184 01 50 a0 e1                      mov   r5, r1
.data:bf800188 eb ff ff eb                      bl 0xbf80013c
.data:bf80018c 01 33 a0 e3                      mov   r3, #67108864  ; 0x4000000
.data:bf800190 a4 41 83 e5                      str   r4, [r3, #420] ; 0x1a4
.data:bf800194 03 20 a0 e1                      mov   r2, r3
.data:bf800198 41 16 a0 e3                      mov   r1, #68157440  ; 0x4100000
.data:bf80019c a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf8001a0 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf8001a4 04 00 00 0a                      beq   0xbf8001bc
.data:bf8001a8 00 00 55 e3                      cmp   r5, #0
.data:bf8001ac 06 00 55 11                      cmpne r5, r6
.data:bf8001b0 10 30 91 35                      ldrcc r3, [r1, #16]
.data:bf8001b4 10 30 91 25                      ldrcs r3, [r1, #16]
.data:bf8001b8 04 30 85 34                      strcc r3, [r5], #4
.data:bf8001bc a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf8001c0 00 00 53 e3                      cmp   r3, #0
.data:bf8001c4 f4 ff ff ba                      blt   0xbf80019c
.data:bf8001c8 70 40 bd e8                      pop   {r4, r5, r6, lr}
.data:bf8001cc 1e ff 2f e1                      bx lr
.data:bf8001d0 f0 41 2d e9                      push  {r4, r5, r6, r7, r8, lr}
.data:bf8001d4 00 80 a0 e1                      mov   r8, r0
.data:bf8001d8 01 70 a0 e1                      mov   r7, r1
.data:bf8001dc 00 50 a0 e3                      mov   r5, #0
.data:bf8001e0 01 43 a0 e3                      mov   r4, #67108864  ; 0x4000000
.data:bf8001e4 41 66 a0 e3                      mov   r6, #68157440  ; 0x4100000
.data:bf8001e8 07 00 a0 e1                      mov   r0, r7
.data:bf8001ec d2 ff ff eb                      bl 0xbf80013c
.data:bf8001f0 a4 81 84 e5                      str   r8, [r4, #420] ; 0x1a4
.data:bf8001f4 a4 31 94 e5                      ldr   r3, [r4, #420] ; 0x1a4
.data:bf8001f8 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf8001fc 02 00 00 0a                      beq   0xbf80020c
.data:bf800200 10 30 96 e5                      ldr   r3, [r6, #16]
.data:bf800204 00 00 53 e3                      cmp   r3, #0
.data:bf800208 01 50 a0 03                      moveq r5, #1
.data:bf80020c a4 31 94 e5                      ldr   r3, [r4, #420] ; 0x1a4
.data:bf800210 00 00 53 e3                      cmp   r3, #0
.data:bf800214 f6 ff ff ba                      blt   0xbf8001f4
.data:bf800218 00 00 55 e3                      cmp   r5, #0
.data:bf80021c f1 ff ff 0a                      beq   0xbf8001e8
.data:bf800220 f0 41 bd e8                      pop   {r4, r5, r6, r7, r8, lr}
.data:bf800224 1e ff 2f e1                      bx lr
.data:bf800228 70 40 2d e9                      push  {r4, r5, r6, lr}
.data:bf80022c 00 40 a0 e1                      mov   r4, r0
.data:bf800230 03 00 a0 e1                      mov   r0, r3
.data:bf800234 02 61 81 e0                      add   r6, r1, r2, lsl #2
.data:bf800238 01 50 a0 e1                      mov   r5, r1
.data:bf80023c be ff ff eb                      bl 0xbf80013c
.data:bf800240 01 33 a0 e3                      mov   r3, #67108864  ; 0x4000000
.data:bf800244 a4 41 83 e5                      str   r4, [r3, #420] ; 0x1a4
.data:bf800248 03 20 a0 e1                      mov   r2, r3
.data:bf80024c 41 16 a0 e3                      mov   r1, #68157440  ; 0x4100000
.data:bf800250 a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf800254 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf800258 03 00 00 0a                      beq   0xbf80026c
.data:bf80025c 10 30 91 e5                      ldr   r3, [r1, #16]
.data:bf800260 06 00 55 e1                      cmp   r5, r6
.data:bf800264 00 30 85 35                      strcc r3, [r5]
.data:bf800268 04 50 85 e2                      add   r5, r5, #4
.data:bf80026c a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf800270 00 00 53 e3                      cmp   r3, #0
.data:bf800274 f5 ff ff ba                      blt   0xbf800250
.data:bf800278 70 40 bd e8                      pop   {r4, r5, r6, lr}
.data:bf80027c 1e ff 2f e1                      bx lr
.data:bf800280 70 40 2d e9                      push  {r4, r5, r6, lr}
.data:bf800284 00 40 a0 e1                      mov   r4, r0
.data:bf800288 03 00 a0 e1                      mov   r0, r3
.data:bf80028c 01 50 a0 e1                      mov   r5, r1
.data:bf800290 02 61 81 e0                      add   r6, r1, r2, lsl #2
.data:bf800294 a8 ff ff eb                      bl 0xbf80013c
.data:bf800298 01 33 a0 e3                      mov   r3, #67108864  ; 0x4000000
.data:bf80029c a4 41 83 e5                      str   r4, [r3, #420] ; 0x1a4
.data:bf8002a0 03 c0 a0 e1                      mov   r12, r3
.data:bf8002a4 41 e6 a0 e3                      mov   lr, #68157440  ; 0x4100000
.data:bf8002a8 a4 31 9c e5                      ldr   r3, [r12, #420]   ; 0x1a4
.data:bf8002ac 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf8002b0 09 00 00 0a                      beq   0xbf8002dc
.data:bf8002b4 10 30 9e e5                      ldr   r3, [lr, #16]
.data:bf8002b8 06 00 55 e1                      cmp   r5, r6
.data:bf8002bc 23 0c a0 e1                      lsr   r0, r3, #24
.data:bf8002c0 23 24 a0 e1                      lsr   r2, r3, #8
.data:bf8002c4 23 18 a0 e1                      lsr   r1, r3, #16
.data:bf8002c8 01 20 c5 35                      strbcc   r2, [r5, #1]
.data:bf8002cc 02 10 c5 35                      strbcc   r1, [r5, #2]
.data:bf8002d0 03 00 c5 35                      strbcc   r0, [r5, #3]
.data:bf8002d4 00 30 c5 35                      strbcc   r3, [r5]
.data:bf8002d8 04 50 85 e2                      add   r5, r5, #4
.data:bf8002dc a4 31 9c e5                      ldr   r3, [r12, #420]   ; 0x1a4
.data:bf8002e0 00 00 53 e3                      cmp   r3, #0
.data:bf8002e4 ef ff ff ba                      blt   0xbf8002a8
.data:bf8002e8 70 40 bd e8                      pop   {r4, r5, r6, lr}
.data:bf8002ec 1e ff 2f e1                      bx lr
.data:bf8002f0 f0 40 2d e9                      push  {r4, r5, r6, r7, lr}
.data:bf8002f4 3d 30 e0 e3                      mvn   r3, #61  ; 0x3d
.data:bf8002f8 14 d0 4d e2                      sub   sp, sp, #20
.data:bf8002fc 02 70 a0 e1                      mov   r7, r2
.data:bf800300 00 e0 a0 e3                      mov   lr, #0
.data:bf800304 20 28 a0 e1                      lsr   r2, r0, #16
.data:bf800308 20 c4 a0 e1                      lsr   r12, r0, #8
.data:bf80030c 10 50 8d e2                      add   r5, sp, #16
.data:bf800310 0b 30 cd e5                      strb  r3, [sp, #11]
.data:bf800314 3d 30 83 e2                      add   r3, r3, #61 ; 0x3d
.data:bf800318 20 4c a0 e1                      lsr   r4, r0, #24
.data:bf80031c 09 20 cd e5                      strb  r2, [sp, #9]
.data:bf800320 08 c0 cd e5                      strb  r12, [sp, #8]
.data:bf800324 05 e0 cd e5                      strb  lr, [sp, #5]
.data:bf800328 04 30 25 e5                      str   r3, [r5, #-4]!
.data:bf80032c 0a 70 cd e5                      strb  r7, [sp, #10]
.data:bf800330 07 00 cd e5                      strb  r0, [sp, #7]
.data:bf800334 06 e0 cd e5                      strb  lr, [sp, #6]
.data:bf800338 04 40 cd e5                      strb  r4, [sp, #4]
.data:bf80033c 01 60 a0 e1                      mov   r6, r1
.data:bf800340 04 40 8d e2                      add   r4, sp, #4
.data:bf800344 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf800348 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf80034c 04 30 a0 e1                      mov   r3, r4
.data:bf800350 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf800354 05 10 a0 e1                      mov   r1, r5
.data:bf800358 01 20 a0 e3                      mov   r2, #1
.data:bf80035c b1 ff ff eb                      bl 0xbf800228
.data:bf800360 0c 30 9d e5                      ldr   r3, [sp, #12]
.data:bf800364 00 00 53 e3                      cmp   r3, #0
.data:bf800368 f5 ff ff 1a                      bne   0xbf800344
.data:bf80036c 3d 30 43 e2                      sub   r3, r3, #61 ; 0x3d
.data:bf800370 03 00 16 e3                      tst   r6, #3
.data:bf800374 0b 30 cd e5                      strb  r3, [sp, #11]
.data:bf800378 09 00 00 0a                      beq   0xbf8003a4
.data:bf80037c a1 04 a0 e3                      mov   r0, #-1593835520  ; 0xa1000000
.data:bf800380 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf800384 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf800388 06 10 a0 e1                      mov   r1, r6
.data:bf80038c a7 20 a0 e1                      lsr   r2, r7, #1
.data:bf800390 04 30 a0 e1                      mov   r3, r4
.data:bf800394 b9 ff ff eb                      bl 0xbf800280
.data:bf800398 14 d0 8d e2                      add   sp, sp, #20
.data:bf80039c f0 40 bd e8                      pop   {r4, r5, r6, r7, lr}
.data:bf8003a0 1e ff 2f e1                      bx lr
.data:bf8003a4 a1 04 a0 e3                      mov   r0, #-1593835520  ; 0xa1000000
.data:bf8003a8 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf8003ac 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf8003b0 06 10 a0 e1                      mov   r1, r6
.data:bf8003b4 a7 20 a0 e1                      lsr   r2, r7, #1
.data:bf8003b8 04 30 a0 e1                      mov   r3, r4
.data:bf8003bc 99 ff ff eb                      bl 0xbf800228
.data:bf8003c0 f4 ff ff ea                      b  0xbf800398
.data:bf8003c4 f0 41 2d e9                      push  {r4, r5, r6, r7, r8, lr}
.data:bf8003c8 08 d0 4d e2                      sub   sp, sp, #8
.data:bf8003cc 00 c0 a0 e1                      mov   r12, r0
.data:bf8003d0 20 e4 a0 e1                      lsr   lr, r0, #8
.data:bf8003d4 32 30 e0 e3                      mvn   r3, #50  ; 0x32
.data:bf8003d8 01 70 a0 e1                      mov   r7, r1
.data:bf8003dc 20 6c a0 e1                      lsr   r6, r0, #24
.data:bf8003e0 20 18 a0 e1                      lsr   r1, r0, #16
.data:bf8003e4 00 40 a0 e3                      mov   r4, #0
.data:bf8003e8 0d 00 a0 e1                      mov   r0, sp
.data:bf8003ec a2 50 a0 e1                      lsr   r5, r2, #1
.data:bf8003f0 07 30 cd e5                      strb  r3, [sp, #7]
.data:bf8003f4 06 20 cd e5                      strb  r2, [sp, #6]
.data:bf8003f8 04 e0 cd e5                      strb  lr, [sp, #4]
.data:bf8003fc 03 c0 cd e5                      strb  r12, [sp, #3]
.data:bf800400 05 10 cd e5                      strb  r1, [sp, #5]
.data:bf800404 00 60 cd e5                      strb  r6, [sp]
.data:bf800408 02 40 cd e5                      strb  r4, [sp, #2]
.data:bf80040c 01 40 cd e5                      strb  r4, [sp, #1]
.data:bf800410 49 ff ff eb                      bl 0xbf80013c
.data:bf800414 e1 34 a0 e3                      mov   r3, #-520093696   ; 0xe1000000
.data:bf800418 16 37 83 e2                      add   r3, r3, #5767168  ; 0x580000
.data:bf80041c 01 23 a0 e3                      mov   r2, #67108864  ; 0x4000000
.data:bf800420 06 3a 83 e2                      add   r3, r3, #24576 ; 0x6000
.data:bf800424 a4 31 82 e5                      str   r3, [r2, #420] ; 0x1a4
.data:bf800428 0d 80 a0 e1                      mov   r8, sp
.data:bf80042c 05 51 87 e0                      add   r5, r7, r5, lsl #2
.data:bf800430 02 c0 a0 e1                      mov   r12, r2
.data:bf800434 41 e6 a0 e3                      mov   lr, #68157440  ; 0x4100000
.data:bf800438 a4 31 9c e5                      ldr   r3, [r12, #420]   ; 0x1a4
.data:bf80043c 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf800440 0d 00 00 0a                      beq   0xbf80047c
.data:bf800444 05 00 57 e1                      cmp   r7, r5
.data:bf800448 09 00 00 2a                      bcs   0xbf800474
.data:bf80044c 03 00 17 e3                      tst   r7, #3
.data:bf800450 03 30 d7 15                      ldrbne   r3, [r7, #3]
.data:bf800454 00 20 d7 15                      ldrbne   r2, [r7]
.data:bf800458 01 10 d7 15                      ldrbne   r1, [r7, #1]
.data:bf80045c 02 00 d7 15                      ldrbne   r0, [r7, #2]
.data:bf800460 03 3c a0 11                      lslne r3, r3, #24
.data:bf800464 01 24 82 11                      orrne r2, r2, r1, lsl #8
.data:bf800468 00 38 83 11                      orrne r3, r3, r0, lsl #16
.data:bf80046c 00 40 97 05                      ldreq r4, [r7]
.data:bf800470 03 40 82 11                      orrne r4, r2, r3
.data:bf800474 10 40 8e e5                      str   r4, [lr, #16]
.data:bf800478 04 70 87 e2                      add   r7, r7, #4
.data:bf80047c a4 31 9c e5                      ldr   r3, [r12, #420]   ; 0x1a4
.data:bf800480 00 00 53 e3                      cmp   r3, #0
.data:bf800484 eb ff ff ba                      blt   0xbf800438
.data:bf800488 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf80048c 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf800490 31 30 e0 e3                      mvn   r3, #49  ; 0x31
.data:bf800494 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf800498 0d 10 a0 e1                      mov   r1, sp
.data:bf80049c 07 30 cd e5                      strb  r3, [sp, #7]
.data:bf8004a0 4a ff ff eb                      bl 0xbf8001d0
.data:bf8004a4 08 d0 8d e2                      add   sp, sp, #8
.data:bf8004a8 f0 41 bd e8                      pop   {r4, r5, r6, r7, r8, lr}
.data:bf8004ac 1e ff 2f e1                      bx lr
.data:bf8004b0 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf8004b4 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf8004b8 0c d0 4d e2                      sub   sp, sp, #12
.data:bf8004bc 00 30 a0 e3                      mov   r3, #0
.data:bf8004c0 3c 20 a0 e3                      mov   r2, #60  ; 0x3c
.data:bf8004c4 61 09 80 e2                      add   r0, r0, #1589248  ; 0x184000
.data:bf8004c8 0d 10 a0 e1                      mov   r1, sp
.data:bf8004cc 07 20 cd e5                      strb  r2, [sp, #7]
.data:bf8004d0 00 30 cd e5                      strb  r3, [sp]
.data:bf8004d4 06 30 cd e5                      strb  r3, [sp, #6]
.data:bf8004d8 05 30 cd e5                      strb  r3, [sp, #5]
.data:bf8004dc 04 30 cd e5                      strb  r3, [sp, #4]
.data:bf8004e0 03 30 cd e5                      strb  r3, [sp, #3]
.data:bf8004e4 02 30 cd e5                      strb  r3, [sp, #2]
.data:bf8004e8 01 30 cd e5                      strb  r3, [sp, #1]
.data:bf8004ec 37 ff ff eb                      bl 0xbf8001d0
.data:bf8004f0 0c d0 8d e2                      add   sp, sp, #12
.data:bf8004f4 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf8004f8 1e ff 2f e1                      bx lr
.data:bf8004fc 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf800500 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf800504 0c d0 4d e2                      sub   sp, sp, #12
.data:bf800508 61 09 80 e2                      add   r0, r0, #1589248  ; 0x184000
.data:bf80050c 00 30 a0 e3                      mov   r3, #0
.data:bf800510 6f 20 e0 e3                      mvn   r2, #111 ; 0x6f
.data:bf800514 02 0a 80 e2                      add   r0, r0, #8192  ; 0x2000
.data:bf800518 0d 10 a0 e1                      mov   r1, sp
.data:bf80051c 07 20 cd e5                      strb  r2, [sp, #7]
.data:bf800520 00 30 cd e5                      strb  r3, [sp]
.data:bf800524 06 30 cd e5                      strb  r3, [sp, #6]
.data:bf800528 05 30 cd e5                      strb  r3, [sp, #5]
.data:bf80052c 04 30 cd e5                      strb  r3, [sp, #4]
.data:bf800530 03 30 cd e5                      strb  r3, [sp, #3]
.data:bf800534 02 30 cd e5                      strb  r3, [sp, #2]
.data:bf800538 01 30 cd e5                      strb  r3, [sp, #1]
.data:bf80053c 23 ff ff eb                      bl 0xbf8001d0
.data:bf800540 0c d0 8d e2                      add   sp, sp, #12
.data:bf800544 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf800548 1e ff 2f e1                      bx lr
.data:bf80054c 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf800550 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf800554 0c d0 4d e2                      sub   sp, sp, #12
.data:bf800558 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf80055c 00 30 a0 e3                      mov   r3, #0
.data:bf800560 6f 20 e0 e3                      mvn   r2, #111 ; 0x6f
.data:bf800564 01 09 80 e2                      add   r0, r0, #16384 ; 0x4000
.data:bf800568 0d 10 a0 e1                      mov   r1, sp
.data:bf80056c 07 20 cd e5                      strb  r2, [sp, #7]
.data:bf800570 00 30 cd e5                      strb  r3, [sp]
.data:bf800574 06 30 cd e5                      strb  r3, [sp, #6]
.data:bf800578 05 30 cd e5                      strb  r3, [sp, #5]
.data:bf80057c 04 30 cd e5                      strb  r3, [sp, #4]
.data:bf800580 03 30 cd e5                      strb  r3, [sp, #3]
.data:bf800584 02 30 cd e5                      strb  r3, [sp, #2]
.data:bf800588 01 30 cd e5                      strb  r3, [sp, #1]
.data:bf80058c 0f ff ff eb                      bl 0xbf8001d0
.data:bf800590 0c d0 8d e2                      add   sp, sp, #12
.data:bf800594 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf800598 1e ff 2f e1                      bx lr
.data:bf80059c f0 43 2d e9                      push  {r4, r5, r6, r7, r8, r9, lr}
.data:bf8005a0 00 c0 a0 e1                      mov   r12, r0
.data:bf8005a4 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf8005a8 14 d0 4d e2                      sub   sp, sp, #20
.data:bf8005ac 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf8005b0 01 40 a0 e1                      mov   r4, r1
.data:bf8005b4 2c ec a0 e1                      lsr   lr, r12, #24
.data:bf8005b8 2c 58 a0 e1                      lsr   r5, r12, #16
.data:bf8005bc 2c 64 a0 e1                      lsr   r6, r12, #8
.data:bf8005c0 21 7c a0 e1                      lsr   r7, r1, #24
.data:bf8005c4 21 88 a0 e1                      lsr   r8, r1, #16
.data:bf8005c8 21 94 a0 e1                      lsr   r9, r1, #8
.data:bf8005cc 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf8005d0 0c 10 8d e2                      add   r1, sp, #12
.data:bf8005d4 01 20 a0 e3                      mov   r2, #1
.data:bf8005d8 04 30 8d e2                      add   r3, sp, #4
.data:bf8005dc 0b e0 cd e5                      strb  lr, [sp, #11]
.data:bf8005e0 0a 50 cd e5                      strb  r5, [sp, #10]
.data:bf8005e4 09 60 cd e5                      strb  r6, [sp, #9]
.data:bf8005e8 08 c0 cd e5                      strb  r12, [sp, #8]
.data:bf8005ec 07 70 cd e5                      strb  r7, [sp, #7]
.data:bf8005f0 06 80 cd e5                      strb  r8, [sp, #6]
.data:bf8005f4 05 90 cd e5                      strb  r9, [sp, #5]
.data:bf8005f8 04 40 cd e5                      strb  r4, [sp, #4]
.data:bf8005fc 09 ff ff eb                      bl 0xbf800228
.data:bf800600 0c 00 9d e5                      ldr   r0, [sp, #12]
.data:bf800604 14 d0 8d e2                      add   sp, sp, #20
.data:bf800608 f0 43 bd e8                      pop   {r4, r5, r6, r7, r8, r9, lr}
.data:bf80060c 1e ff 2f e1                      bx lr
.data:bf800610 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf800614 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf800618 14 d0 4d e2                      sub   sp, sp, #20
.data:bf80061c 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf800620 00 c0 a0 e3                      mov   r12, #0
.data:bf800624 4f e0 e0 e3                      mvn   lr, #79  ; 0x4f
.data:bf800628 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf80062c 0c 10 8d e2                      add   r1, sp, #12
.data:bf800630 01 20 a0 e3                      mov   r2, #1
.data:bf800634 04 30 8d e2                      add   r3, sp, #4
.data:bf800638 0b e0 cd e5                      strb  lr, [sp, #11]
.data:bf80063c 04 c0 cd e5                      strb  r12, [sp, #4]
.data:bf800640 0a c0 cd e5                      strb  r12, [sp, #10]
.data:bf800644 09 c0 cd e5                      strb  r12, [sp, #9]
.data:bf800648 08 c0 cd e5                      strb  r12, [sp, #8]
.data:bf80064c 07 c0 cd e5                      strb  r12, [sp, #7]
.data:bf800650 06 c0 cd e5                      strb  r12, [sp, #6]
.data:bf800654 05 c0 cd e5                      strb  r12, [sp, #5]
.data:bf800658 f2 fe ff eb                      bl 0xbf800228
.data:bf80065c 0c 00 9d e5                      ldr   r0, [sp, #12]
.data:bf800660 14 d0 8d e2                      add   sp, sp, #20
.data:bf800664 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf800668 1e ff 2f e1                      bx lr

; func
.data:bf80066c f0 41 2d e9                      push  {r4, r5, r6, r7, r8, lr}
.data:bf800670 00 c0 a0 e1                      mov   r12, r0
.data:bf800674 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf800678 08 d0 4d e2                      sub   sp, sp, #8
.data:bf80067c 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf800680 00 40 a0 e3                      mov   r4, #0
.data:bf800684 ac e7 a0 e1                      lsr   lr, r12, #15
.data:bf800688 ac 53 a0 e1                      lsr   r5, r12, #7
.data:bf80068c 36 30 e0 e3                      mvn   r3, #54  ; 0x36
.data:bf800690 01 70 a0 e1                      mov   r7, r1
.data:bf800694 ac 6b a0 e1                      lsr   r6, r12, #23
.data:bf800698 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf80069c 8c c0 a0 e1                      lsl   r12, r12, #1
.data:bf8006a0 0d 10 a0 e1                      mov   r1, sp
.data:bf8006a4 07 30 cd e5                      strb  r3, [sp, #7]
.data:bf8006a8 05 50 cd e5                      strb  r5, [sp, #5]
.data:bf8006ac 06 e0 cd e5                      strb  lr, [sp, #6]
.data:bf8006b0 04 c0 cd e5                      strb  r12, [sp, #4]
.data:bf8006b4 01 40 cd e5                      strb  r4, [sp, #1]
.data:bf8006b8 00 60 cd e5                      strb  r6, [sp]
.data:bf8006bc 02 50 a0 e1                      mov   r5, r2
.data:bf8006c0 03 40 cd e5                      strb  r4, [sp, #3]
.data:bf8006c4 02 40 cd e5                      strb  r4, [sp, #2]
.data:bf8006c8 c0 fe ff eb                      bl 0xbf8001d0
.data:bf8006cc 35 30 e0 e3                      mvn   r3, #53  ; 0x35
.data:bf8006d0 03 00 17 e3                      tst   r7, #3
.data:bf8006d4 0d 80 a0 e1                      mov   r8, sp
.data:bf8006d8 07 30 cd e5                      strb  r3, [sp, #7]
.data:bf8006dc 17 00 00 1a                      bne   0xbf800740
.data:bf8006e0 09 35 47 e2                      sub   r3, r7, #37748736 ; 0x2400000
.data:bf8006e4 01 05 53 e3                      cmp   r3, #4194304   ; 0x400000
.data:bf8006e8 02 04 57 23                      cmpcs r7, #33554432  ; 0x2000000
.data:bf8006ec 01 00 00 3a                      bcc   0xbf8006f8
.data:bf8006f0 80 00 55 e3                      cmp   r5, #128 ; 0x80
.data:bf8006f4 19 00 00 0a                      beq   0xbf800760
.data:bf8006f8 0d 00 a0 e1                      mov   r0, sp
.data:bf8006fc 8e fe ff eb                      bl 0xbf80013c
.data:bf800700 a1 34 a0 e3                      mov   r3, #-1593835520  ; 0xa1000000
.data:bf800704 16 37 83 e2                      add   r3, r3, #5767168  ; 0x580000
.data:bf800708 06 3a 83 e2                      add   r3, r3, #24576 ; 0x6000
.data:bf80070c 01 23 a0 e3                      mov   r2, #67108864  ; 0x4000000
.data:bf800710 a4 31 82 e5                      str   r3, [r2, #420] ; 0x1a4
.data:bf800714 41 16 a0 e3                      mov   r1, #68157440  ; 0x4100000
.data:bf800718 a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf80071c 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf800720 10 30 91 15                      ldrne r3, [r1, #16]
.data:bf800724 04 30 87 14                      strne r3, [r7], #4
.data:bf800728 a4 31 92 e5                      ldr   r3, [r2, #420] ; 0x1a4
.data:bf80072c 00 00 53 e3                      cmp   r3, #0
.data:bf800730 f8 ff ff ba                      blt   0xbf800718
.data:bf800734 08 d0 8d e2                      add   sp, sp, #8
.data:bf800738 f0 41 bd e8                      pop   {r4, r5, r6, r7, r8, lr}
.data:bf80073c 1e ff 2f e1                      bx lr
.data:bf800740 a1 04 a0 e3                      mov   r0, #-1593835520  ; 0xa1000000
.data:bf800744 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf800748 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf80074c 07 10 a0 e1                      mov   r1, r7
.data:bf800750 05 20 a0 e1                      mov   r2, r5
.data:bf800754 0d 30 a0 e1                      mov   r3, sp
.data:bf800758 c8 fe ff eb                      bl 0xbf800280
.data:bf80075c f4 ff ff ea                      b  0xbf800734
.data:bf800760 a1 04 a0 e3                      mov   r0, #-1593835520  ; 0xa1000000
.data:bf800764 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf800768 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf80076c 07 10 a0 e1                      mov   r1, r7
.data:bf800770 05 20 a0 e1                      mov   r2, r5
.data:bf800774 0d 30 a0 e1                      mov   r3, sp
.data:bf800778 aa fe ff eb                      bl 0xbf800228
.data:bf80077c ec ff ff ea                      b  0xbf800734

; func
.data:bf800780 f0 40 2d e9                      push  {r4, r5, r6, r7, lr}
.data:bf800784 0c d0 4d e2                      sub   sp, sp, #12
.data:bf800788 a0 e7 a0 e1                      lsr   lr, r0, #15
.data:bf80078c 80 c0 a0 e1                      lsl   r12, r0, #1
.data:bf800790 a0 6b a0 e1                      lsr   r6, r0, #23
.data:bf800794 00 40 a0 e3                      mov   r4, #0
.data:bf800798 a0 53 a0 e1                      lsr   r5, r0, #7
.data:bf80079c 3a 30 e0 e3                      mvn   r3, #58  ; 0x3a
.data:bf8007a0 0d 00 a0 e1                      mov   r0, sp
.data:bf8007a4 07 30 cd e5                      strb  r3, [sp, #7]
.data:bf8007a8 06 e0 cd e5                      strb  lr, [sp, #6]
.data:bf8007ac 05 50 cd e5                      strb  r5, [sp, #5]
.data:bf8007b0 04 c0 cd e5                      strb  r12, [sp, #4]
.data:bf8007b4 02 50 a0 e1                      mov   r5, r2
.data:bf8007b8 00 60 cd e5                      strb  r6, [sp]
.data:bf8007bc 03 40 cd e5                      strb  r4, [sp, #3]
.data:bf8007c0 01 60 a0 e1                      mov   r6, r1
.data:bf8007c4 02 40 cd e5                      strb  r4, [sp, #2]
.data:bf8007c8 01 40 cd e5                      strb  r4, [sp, #1]
.data:bf8007cc 5a fe ff eb                      bl 0xbf80013c
.data:bf8007d0 e1 34 a0 e3                      mov   r3, #-520093696   ; 0xe1000000
.data:bf8007d4 16 37 83 e2                      add   r3, r3, #5767168  ; 0x580000
.data:bf8007d8 01 23 a0 e3                      mov   r2, #67108864  ; 0x4000000
.data:bf8007dc 06 3a 83 e2                      add   r3, r3, #24576 ; 0x6000
.data:bf8007e0 a4 31 82 e5                      str   r3, [r2, #420] ; 0x1a4
.data:bf8007e4 05 e1 86 e0                      add   lr, r6, r5, lsl #2
.data:bf8007e8 0d 70 a0 e1                      mov   r7, sp
.data:bf8007ec 02 c0 a0 e1                      mov   r12, r2
.data:bf8007f0 41 56 a0 e3                      mov   r5, #68157440  ; 0x4100000
.data:bf8007f4 a4 31 9c e5                      ldr   r3, [r12, #420]   ; 0x1a4
.data:bf8007f8 02 05 13 e3                      tst   r3, #8388608   ; 0x800000
.data:bf8007fc 0d 00 00 0a                      beq   0xbf800838
.data:bf800800 0e 00 56 e1                      cmp   r6, lr
.data:bf800804 09 00 00 2a                      bcs   0xbf800830
.data:bf800808 03 00 16 e3                      tst   r6, #3
.data:bf80080c 03 30 d6 15                      ldrbne   r3, [r6, #3]
.data:bf800810 00 20 d6 15                      ldrbne   r2, [r6]
.data:bf800814 01 10 d6 15                      ldrbne   r1, [r6, #1]
.data:bf800818 02 00 d6 15                      ldrbne   r0, [r6, #2]
.data:bf80081c 03 3c a0 11                      lslne r3, r3, #24
.data:bf800820 01 24 82 11                      orrne r2, r2, r1, lsl #8
.data:bf800824 00 38 83 11                      orrne r3, r3, r0, lsl #16
.data:bf800828 00 40 96 05                      ldreq r4, [r6]
.data:bf80082c 03 40 82 11                      orrne r4, r2, r3
.data:bf800830 10 40 85 e5                      str   r4, [r5, #16]
.data:bf800834 04 60 86 e2                      add   r6, r6, #4
.data:bf800838 a4 31 9c e5                      ldr   r3, [r12, #420]   ; 0x1a4
.data:bf80083c 00 00 53 e3                      cmp   r3, #0
.data:bf800840 eb ff ff ba                      blt   0xbf8007f4
.data:bf800844 a7 04 a0 e3                      mov   r0, #-1493172224  ; 0xa7000000
.data:bf800848 16 07 80 e2                      add   r0, r0, #5767168  ; 0x580000
.data:bf80084c 39 30 e0 e3                      mvn   r3, #57  ; 0x39
.data:bf800850 06 0a 80 e2                      add   r0, r0, #24576 ; 0x6000
.data:bf800854 0d 10 a0 e1                      mov   r1, sp
.data:bf800858 07 30 cd e5                      strb  r3, [sp, #7]
.data:bf80085c 5b fe ff eb                      bl 0xbf8001d0
.data:bf800860 0c d0 8d e2                      add   sp, sp, #12
.data:bf800864 f0 40 bd e8                      pop   {r4, r5, r6, r7, lr}
.data:bf800868 1e ff 2f e1                      bx lr
.data:bf80086c 30 40 2d e9                      push  {r4, r5, lr}
.data:bf800870 0f 10 01 e2                      and   r1, r1, #15
.data:bf800874 81 12 a0 e1                      lsl   r1, r1, #5
.data:bf800878 a0 3b a0 e1                      lsr   r3, r0, #23
.data:bf80087c 80 14 81 e0                      add   r1, r1, r0, lsl #9
.data:bf800880 0f 20 02 e2                      and   r2, r2, #15
.data:bf800884 ff 30 03 e2                      and   r3, r3, #255   ; 0xff
.data:bf800888 02 3c 83 e1                      orr   r3, r3, r2, lsl #24
.data:bf80088c 21 24 a0 e1                      lsr   r2, r1, #8
.data:bf800890 04 d0 4d e2                      sub   sp, sp, #4
.data:bf800894 01 5c 83 e1                      orr   r5, r3, r1, lsl #24
.data:bf800898 2d 43 82 e3                      orr   r4, r2, #-1275068416 ; 0xb4000000
.data:bf80089c 04 00 a0 e1                      mov   r0, r4
.data:bf8008a0 05 10 a0 e1                      mov   r1, r5
.data:bf8008a4 3c ff ff eb                      bl 0xbf80059c
.data:bf8008a8 00 00 50 e3                      cmp   r0, #0
.data:bf8008ac fa ff ff 1a                      bne   0xbf80089c
.data:bf8008b0 04 d0 8d e2                      add   sp, sp, #4
.data:bf8008b4 30 40 bd e8                      pop   {r4, r5, lr}
.data:bf8008b8 1e ff 2f e1                      bx lr

; bool startup(void)
.data:bf8008bc 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf8008c0 04 d0 4d e2                      sub   sp, sp, #4
.data:bf8008c4 51 ff ff eb                      bl 0xbf800610
.data:bf8008c8 07 00 00 e2                      and   r0, r0, #7
.data:bf8008cc 04 00 50 e3                      cmp   r0, #4
.data:bf8008d0 00 00 a0 13                      movne r0, #0
.data:bf8008d4 01 00 a0 03                      moveq r0, #1
.data:bf8008d8 04 d0 8d e2                      add   sp, sp, #4
.data:bf8008dc 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf8008e0 1e ff 2f e1                      bx lr

; bool isInserted(void)
.data:bf8008e4 04 e0 2d e5                      push  {lr}     ; (str lr, [sp, #-4]!)
.data:bf8008e8 04 d0 4d e2                      sub   sp, sp, #4
.data:bf8008ec 47 ff ff eb                      bl 0xbf800610
.data:bf8008f0 07 00 00 e2                      and   r0, r0, #7
.data:bf8008f4 04 00 50 e3                      cmp   r0, #4
.data:bf8008f8 00 00 a0 13                      movne r0, #0
.data:bf8008fc 01 00 a0 03                      moveq r0, #1
.data:bf800900 04 d0 8d e2                      add   sp, sp, #4
.data:bf800904 04 e0 9d e4                      pop   {lr}     ; (ldr lr, [sp], #4)
.data:bf800908 1e ff 2f e1                      bx lr

; bool readSectors(sec_t sector, sec_t numSectors, void* buffer)
.data:bf80090c 00 30 51 e2                      subs  r3, r1, #0
.data:bf800910 70 40 2d e9                      push  {r4, r5, r6, lr}
.data:bf800914 0a 00 00 0a                      beq   0xbf800944
.data:bf800918 00 40 a0 e1                      mov   r4, r0
.data:bf80091c 02 50 a0 e1                      mov   r5, r2
.data:bf800920 03 60 80 e0                      add   r6, r0, r3
.data:bf800924 04 00 a0 e1                      mov   r0, r4
.data:bf800928 05 10 a0 e1                      mov   r1, r5
.data:bf80092c 01 40 84 e2                      add   r4, r4, #1
.data:bf800930 80 20 a0 e3                      mov   r2, #128 ; 0x80
.data:bf800934 4c ff ff eb                      bl 0xbf80066c
.data:bf800938 04 00 56 e1                      cmp   r6, r4
.data:bf80093c 02 5c 85 e2                      add   r5, r5, #512   ; 0x200
.data:bf800940 f7 ff ff 1a                      bne   0xbf800924
.data:bf800944 01 00 a0 e3                      mov   r0, #1
.data:bf800948 70 40 bd e8                      pop   {r4, r5, r6, lr}
.data:bf80094c 1e ff 2f e1                      bx lr


; bool writeSectors(sec_t sector, sec_t numSectors, const void* buffer)
.data:bf800950 00 30 51 e2                      subs  r3, r1, #0
.data:bf800954 70 40 2d e9                      push  {r4, r5, r6, lr}
.data:bf800958 0a 00 00 0a                      beq   0xbf800988
.data:bf80095c 00 40 a0 e1                      mov   r4, r0
.data:bf800960 02 50 a0 e1                      mov   r5, r2
.data:bf800964 03 60 80 e0                      add   r6, r0, r3
.data:bf800968 04 00 a0 e1                      mov   r0, r4
.data:bf80096c 05 10 a0 e1                      mov   r1, r5
.data:bf800970 01 40 84 e2                      add   r4, r4, #1
.data:bf800974 80 20 a0 e3                      mov   r2, #128 ; 0x80
.data:bf800978 80 ff ff eb                      bl 0xbf800780
.data:bf80097c 04 00 56 e1                      cmp   r6, r4
.data:bf800980 02 5c 85 e2                      add   r5, r5, #512   ; 0x200
.data:bf800984 f7 ff ff 1a                      bne   0xbf800968
.data:bf800988 01 00 a0 e3                      mov   r0, #1
.data:bf80098c 70 40 bd e8                      pop   {r4, r5, r6, lr}
.data:bf800990 1e ff 2f e1                      bx lr

; bool clearStatus(void)
.data:bf800994 01 00 a0 e3                      mov   r0, #1
.data:bf800998 1e ff 2f e1                      bx lr

; bool shutdown(void)
.data:bf80099c 01 00 a0 e3                      mov   r0, #1
.data:bf8009a0 1e ff 2f e1                      bx lr
.data:bf8009a4 0d c0 a0 e1                      mov   r12, sp
.data:bf8009a8 f8 df 2d e9                      push  {r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, lr, pc}
.data:bf8009ac 04 b0 4c e2                      sub   r11, r12, #4
.data:bf8009b0 28 d0 4b e2                      sub   sp, r11, #40   ; 0x28
.data:bf8009b4 f0 6f 9d e8                      ldm   sp, {r4, r5, r6, r7, r8, r9, r10, r11, sp, lr}
.data:bf8009b8 1e ff 2f e1                      bx lr
.data:bf8009bc dc 00 80 bf                      svclt 0x008000dc
.data:bf8009c0 98 00 80 bf                      svclt 0x00800098
.data:bf8009c4 00 00 00 00                      andeq r0, r0, r0
.data:bf8009c8 00 00 00 00                      andeq r0, r0, r0
.data:bf8009cc 00 00 00 00                      andeq r0, r0, r0