Last week I broke my head over an essential question:
KIM-1 Microsoft Basic has no GET command, because you can not scan the serial line like a keyboard.
But without this command you are not able to program a game other than puzzles or adventures, because you have no direct input.

What if we could use the hex pad on the KIM-1 like a joystick for input? This would require an somewhere hidden assembler routine to scan for button pushes.

There is a BASIC command for doing so called USR (user sub routine) 
Problem: the first Basic manual propably written by Billy himself is *unusable* . The explanaition is not very precise to be exact.

**BUT**
Here are the 3(+1) steps you may want to follow to ger USR working:

1. poke in where the Subroutine is located. Poke this address lowbyte / highbyte to $2040 and $2041

2. Send Akkumulator and Y-register to your subroutine with the argument given in the brackets of USR():
  
    2.1 A is the Highbyte, Y is the lowbyte <br>
       Example: you want to send A $23 and Y $FF -> $23FF = 9215 -> USR(9215)
  
    2.2 jsr to a subroutine (in your subroutine) to transfer the USR() argument to A and Y (thanks Billy). The address for this subroutine is *hidden* in zeropage adresses 06 and 07     

3. receive A and Y

  3.1 jsr to a subroutine (in your subroutine) to transfer  A and Y back to BASIC . The address for this subroutine is *hidden* in zeropage adresses 08 and 09     

  3.2 set your USR() equal to another variable. X=USR(arg)

  3.3 again A is the Highbyte of the received X value and Y the lowbyte.

4. calculate what you need:

  4.1 Example: you recieve X=64019

  4.2 64019=$FA13 -> A is $FA , Y is $13

X=A * 256+Y in decimal or X=A * $FF+Y in hex notation

And yes, this is really weird, but it seems to work.
With this one could also control the segment display on your KIM/PAL

You do not have to load your assembler routine addtionally, you can also poke it in. See this example:

     5 GOSUB 200
    10 POKE 8256,0 :REM set the adress for the sub
    20 POKE 8257,3
    30 X=USR(0) :REM jsr
    40 X=X/256 : REM whats A, the Keypad value?
    45 X=INT(X) 
    50 PRINT X
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

Another mystery solved,  <br>
Have Fun, <br>
Webdoktor<br>

  [1]: https://netzherpes.de:443/content/images/20230419085250-kb9_usr1.png
  [2]: https://netzherpes.de:443/content/images/20230419085259-kb9_usr2.png
