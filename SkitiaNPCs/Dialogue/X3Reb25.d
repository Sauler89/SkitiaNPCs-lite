// Remember to block P's and normal if Scry is just finished.


CHAIN IF ~Global("X3RebSummoned","GLOBAL",1) !Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25 b1 
@13 
DO ~SetGlobal("X3RebSummoned","GLOBAL",2)~
END 
IF ~IsValidForPartyDialogue("X3Emi")~ EXTERN X3Emi25J b1a   

IF ~!IsValidForPartyDialogue("X3Emi")~ EXTERN X3Reb25 b2

CHAIN X3Emi25J b1a 
@14
== X3Reb25 @15
EXTERN X3Reb25 b2 

CHAIN X3Reb25 b2  
@17
END 
++ @18 DO ~SetGlobal("X3RebSummoned","GLOBAL",2)~ + b3a
++ @19 DO ~SetGlobal("X3RebSummoned","GLOBAL",2)~ + b3b


CHAIN X3Reb25 b3a 
@20 
EXTERN X3Reb25 b4

CHAIN X3Reb25 b3b 
@21 
EXTERN X3Reb25 b4

CHAIN X3Reb25 b4
@22
END 
++ @23 + b5
++ @24 + b6


CHAIN X3Reb25 b5
@25
DO ~JoinParty()~ EXIT

CHAIN X3Reb25 b6
@26
DO ~MoveToPointNoInterrupt([1641.1334]) Face(0)~ EXIT

CHAIN IF ~Global("X3RebSummoned","GLOBAL",1)Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25 r1 
@27
== X3Reb @28 
DO ~SetGlobal("X3RebSummoned","GLOBAL",2)~
END 
++ @29 + r2.1
++ @30 + r2.1


CHAIN X3Reb25 r2.1 
@31
== X3Reb25 @32
END 
++ @33 + r5
++ @34 + r6

CHAIN X3Reb25 r5 
@35
 DO ~JoinParty()~ EXIT
 
CHAIN X3Reb25 r6 
@36
EXIT 
 
// Once Summoned, Approval and reputation is irrelevant for joining, she'll stick around at this point to the bitter end.
CHAIN IF ~Global("X3RebSummoned","GLOBAL",2) !Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25 j1a
@37
== X3Reb25 @38
END 
++ @39 + b5
++ @40 + j2


CHAIN IF ~Global("X3RebSummoned","GLOBAL",2) Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25 j1b
@41
END 
++ @42 + r5
++ @43 + r6
 

CHAIN X3Reb25 j2
@44
EXIT 


CHAIN IF ~Global("X3RebToBKickedOut","GLOBAL",0)!Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25P p1
@45
END
++ @46 DO ~ActionOverride("X3Reb",JoinParty())~ EXIT
+ ~AreaCheck("AR4500")~ + @47 + p1a
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200")~ + @47 + p1b
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200") GlobalLT("X3RebApp","GLOBAL",44)~ + @48 + p1c
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200") GlobalGT("X3RebApp","GLOBAL",44)~ + @48 + p1d


CHAIN X3Reb25P p1a 
@49 
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1) MoveToPointNoInterrupt([1641.1334]) Face(0)~
EXIT 

CHAIN X3Reb25P p1b 
@50
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1)~
EXIT 

CHAIN X3Reb25P p1c 
@51
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1)CreateVisualEffectObject("spdimndr",Myself)
Wait(2)
MoveBetweenAreas("AR4500",[1641.1334],0)~ EXIT

CHAIN X3Reb25P p1d 
@52
 DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1)CreateVisualEffectObject("spdimndr",Myself)
Wait(2)
MoveBetweenAreas("AR4500",[1641.1334],0)~ EXIT


CHAIN IF ~Global("X3RebToBKickedOut","GLOBAL",0)Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25P rp1
@53
END
++ @54 DO ~ActionOverride("X3Reb",JoinParty())~ EXIT
+ ~AreaCheck("AR4500")~ + @55 + rp1a
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200")~ + @55 + rp1b
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200")~ + @56 + rp1c


CHAIN X3Reb25P rp1a 
@57
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1) MoveToPointNoInterrupt([1641.1334]) Face(0)~
EXIT 

CHAIN X3Reb25P rp1b 
@57
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1)~
EXIT 

CHAIN X3Reb25P rp1c 
@58
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",1)CreateVisualEffectObject("spdimndr",Myself)
Wait(2)
MoveBetweenAreas("AR4500",[1641.1334],0)~ EXIT


CHAIN IF ~Global("X3RebToBKickedOut","GLOBAL",1) !Global("X3RebRomanceActive","GLOBAL",2)~ THEN  X3Reb25P p2
@59
END 
++ @60 + p2.1


++ @63 EXIT


CHAIN X3Reb25P p2.1
@64
DO ~SetGlobal("X3RebToBKickedOut","GLOBAL",0) JoinParty()~ EXIT


CHAIN IF ~Global("X3RebToBKickedOut","GLOBAL",1) !Global("X3RebRomanceActive","GLOBAL",2)~ THEN X3Reb25P rp2
@65
END
++ @66 + p2.1


++ @63 EXIT
