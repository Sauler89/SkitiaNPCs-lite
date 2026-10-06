// Make sure the P dialogues/normal dialogues don't fire if the scry scene just happened.


CHAIN IF ~Global("X3VieSummoned","GLOBAL",1) !Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25 b1 
@13 
DO ~SetGlobal("X3VieSummoned","GLOBAL",2)~
END 
IF ~IsValidForPartyDialogue("X3Emi")~ EXTERN X3Emi25J b1a   

IF ~!IsValidForPartyDialogue("X3Emi")~ EXTERN X3Vie25 b2

CHAIN X3Emi25J b1a
@15
EXTERN X3Vie25 b2 

CHAIN X3Vie25 b2  
@16
END 
++ @17 DO ~SetGlobal("X3VieSummoned","GLOBAL",2)~ + b3a
++ @18 DO ~SetGlobal("X3VieSummoned","GLOBAL",2)~ + b3b


CHAIN X3Vie25 b3a 
@19 
EXTERN X3Vie25 b4

CHAIN X3Vie25 b3b 
@20 
EXTERN X3Vie25 b4

CHAIN X3Vie25 b4
@21
END 
++ @22 + b5
++ @23 + b6


CHAIN X3Vie25 b5
@24
DO ~JoinParty()~ EXIT

CHAIN X3Vie25 b6
@25
DO ~MoveToPointNoInterrupt([2599.1344]) Face(0)~ EXIT

CHAIN IF ~Global("X3VieSummoned","GLOBAL",1)Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25 r1 
@26 
== X3Vie25 @27 
DO ~SetGlobal("X3VieSummoned","GLOBAL",2)~
END 
++ @28 + r2.1
++ @29 + r2.2
++ @30 DO ~IncrementGlobal("X3VieApp","GLOBAL",-2)DisplayStringNoNameDlg(Player1,@500503)~ + r3 

CHAIN X3Vie25 r2.1 
@31
EXTERN X3Vie25 r4 

CHAIN X3Vie25 r2.2 
@32
EXTERN X3Vie25 r4

CHAIN X3Vie25 r3  
@33
END 
++ @34 + r5 
++ @35 + r6 
++ @36 DO ~SetGlobal("X3VieRomanceActive","GLOBAL",3)~ + rb 

CHAIN X3Vie25 rb 
@37
DO ~MoveToPointNoInterrupt([2599.1344]) Face(0)~ EXIT

CHAIN X3Vie25 r4  
@38
END 
++ @39 + r5
++ @40 + r6

CHAIN X3Vie25 r5 
@41
 DO ~JoinParty()~ EXIT
 
CHAIN X3Vie25 r6 
@42
EXIT 
 
// Once Summoned, Approval and reputation is irrelevant for joining, she'll stick around at this point to the bitter end.
CHAIN IF ~Global("X3VieSummoned","GLOBAL",2) !Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25 j1a
@43 
END 
++ @44 + b5
++ @45 + j2


CHAIN IF ~Global("X3VieSummoned","GLOBAL",2) Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25 j1b
@46 
END 
++ @47 + r5
++ @48 + r6
 

CHAIN X3Vie25 j2
@49
EXIT 


CHAIN IF ~Global("X3VieToBKickedOut","GLOBAL",0) !Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25P p1
@50 
END
++ @51 DO ~ActionOverride("X3Vie",JoinParty())~ EXIT
+ ~AreaCheck("AR4500")~ + @52 + p1a
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200")~ + @52 + p1b
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200") GlobalLT("X3VieApp","GLOBAL",44)~ + @53 + p1c
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200") GlobalGT("X3VieApp","GLOBAL",44)~ + @53 + p1d


CHAIN X3Vie25P p1a 
@54 
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1) MoveToPointNoInterrupt([2599.1344]) Face(0)~
EXIT 

CHAIN X3Vie25P p1b 
@55
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1)~
EXIT 

CHAIN X3Vie25P p1c 
@56
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1)CreateVisualEffectObject("spdimndr",Myself)
Wait(2)
MoveBetweenAreas("AR4500",[2599.1344],0)~ EXIT

CHAIN X3Vie25P p1d 
@57
 DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1)CreateVisualEffectObject("spdimndr",Myself)
Wait(2)
MoveBetweenAreas("AR4500",[2599.1344],0)~ EXIT


CHAIN IF ~Global("X3VieToBKickedOut","GLOBAL",0)Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25P rp1
@58 
END
++ @59 DO ~ActionOverride("X3Vie",JoinParty())~ EXIT
+ ~AreaCheck("AR4500")~ + @60 + rp1a
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200")~ + @60 + rp1b
+ ~!AreaCheck("AR4500") !AreaCheck("AR4000") !AreaCheck("AR6200")~ + @61 + rp1c


CHAIN X3Vie25P rp1a 
@62
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1) MoveToPointNoInterrupt([2599.1344]) Face(0)~
EXIT 

CHAIN X3Vie25P rp1b 
@62
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1)~
EXIT 

CHAIN X3Vie25P rp1c 
@63
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",1)CreateVisualEffectObject("spdimndr",Myself)
Wait(2)
MoveBetweenAreas("AR4500",[2599.1344],0)~ EXIT

// Rep doesn't matter here in ToB. Emily will rejoin even at -90 approval. She'll stomach a -1 rep and endure the rest of the way.
CHAIN IF ~Global("X3VieToBKickedOut","GLOBAL",1) !Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25P p2
@64 
END 
++ @65 + p2.1


++ @68 + p3 

CHAIN X3Vie25P p3 
@69
EXIT 


CHAIN X3Vie25P p2.1
@70
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",0) JoinParty()~ EXIT


CHAIN IF ~Global("X3VieToBKickedOut","GLOBAL",1)Global("X3VieRomanceActive","GLOBAL",2)~ THEN X3Vie25P rp2
@71  
END
++ @72 + pr.1


++ @73 + p3 

CHAIN X3Vie25P pr.1
@74
DO ~SetGlobal("X3VieToBKickedOut","GLOBAL",0) JoinParty()~ EXIT


////
