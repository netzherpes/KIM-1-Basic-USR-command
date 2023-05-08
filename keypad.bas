
5 GOSUB 200:REM load the assembler routine
10 POKE 8256,0 :REM set the adress for the subroutine
20 POKE 8257,3 :REM to $0300
30 X=USR(0) :REM jsr
40 X=X/256 : REM whats A, the Keypad value?
45 X=INT(X) :REM discard Y
50 PRINT X :REM 15 is nothing
60 GOTO 30 
199 REM POKE A LITTLE PRG to $0300
200 FOR I=1 TO 10 :REM
205 REM ten numbers:
206 REM jsr read AY
207 REM jsr getkey
208 REM jsr return AY
209 REM rts 
210 READ A
220 POKE 767+I,A
230 NEXT I
240 DATA 32,194,47,32,106,31,32 
250 DATA 149,49,96
260 RETURN
