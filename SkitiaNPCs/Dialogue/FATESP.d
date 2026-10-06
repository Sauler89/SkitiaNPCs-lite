EXTEND_BOTTOM FATESP 6 #9
+~!Dead("X3Emi")!Dead("X3mily")!InMyArea("X3Emi")Global("X3EmiSummoned","GLOBAL",0)GlobalGT("X3EmiApp","GLOBAL",-89)ReputationGT(Player1,7)~+ @0
DO ~CreateVisualEffect("SPPORTAL",[1999.1228])
Wait(2) 
CreateCreature("X3Emi25",[1999.1228],0) 
SetGlobal("X3EmiSummoned","GLOBAL",1)~ GOTO 8
+ ~!Dead("X3Emi")!Dead("X3mily")!InMyArea("X3Emi")Global("X3EmiSummoned","GLOBAL",0)!Global("X3EmiRomanceActive","GLOBAL",3)Gender(Player1,MALE)!Global("X3RebRomanceActive","GLOBAL",2)!Global("X3VieRomanceActive","GLOBAL",2)GlobalGT("X3EmiApp","GLOBAL",-89)ReputationGT(Player1,7)Gender(Player1,MALE)~ + @1
DO ~CreateVisualEffect("SPPORTAL",[1999.1228])
Wait(2)
SetGlobal("X3EmiRomanceActive","GLOBAL",2)
CreateCreature("X3Emi25",[1999.1228],0) 
SetGlobal("X3EmiSummoned","GLOBAL",1)~ GOTO 8
END


EXTEND_BOTTOM FATESP 6 #9
+~!Dead("X3Reb")!Dead("X3Rec")!InMyArea("X3Reb")Global("X3RebSummoned","GLOBAL",0)GlobalGT("X3RebApp","GLOBAL",-89)ReputationGT(Player1,7)~+ @5
DO ~CreateVisualEffect("SPPORTAL",[1999.1228])
Wait(2) 
CreateCreature("X3Reb25",[1999.1228],0) 
SetGlobal("X3RebSummoned","GLOBAL",1)~ GOTO 8
+ ~!Global("X3EmiRomanceActive","GLOBAL",2)!Global("X3RebRomanceActive","GLOBAL",3)!Global("X3VieRomanceActive","GLOBAL",2)!Dead("X3Reb")!Dead("X3Rec")!InMyArea("X3Reb")Global("X3RebSummoned","GLOBAL",0)GlobalGT("X3RebApp","GLOBAL",-89)ReputationGT(Player1,7)~ + @6
DO ~CreateVisualEffect("SPPORTAL",[1999.1228])
Wait(2)
SetGlobal("X3RebRomanceActive","GLOBAL",2)
CreateCreature("X3Reb25",[1999.1228],0) 
SetGlobal("X3RebSummoned","GLOBAL",1)~ GOTO 8
END
EXTEND_BOTTOM FATESP 6 #9
+~!Dead("X3Vie")!Dead("X3Vien")!InMyArea("X3Vie")Global("X3VieSummoned","GLOBAL",0)GlobalGT("X3VieApp","GLOBAL",-89)~+ @7
DO ~CreateVisualEffect("SPPORTAL",[1999.1228])
Wait(2) 
CreateCreature("X3Vie25",[1999.1228],0) 
SetGlobal("X3VieSummoned","GLOBAL",1)~ GOTO 8
+ ~!Global("X3EmiRomanceActive","GLOBAL",2)!Global("X3RebRomanceActive","GLOBAL",2)!Global("X3VieRomanceActive","GLOBAL",3)!Dead("X3Vie")!Dead("X3Vien")!InMyArea("X3Vie")Global("X3VieSummoned","GLOBAL",0)GlobalGT("X3VieApp","GLOBAL",-89)ReputationGT(Player1,7)~ + @8
DO ~CreateVisualEffect("SPPORTAL",[1999.1228])
Wait(2)
SetGlobal("X3VieRomanceActive","GLOBAL",2)
CreateCreature("X3Vie25",[1999.1228],0) 
SetGlobal("X3VieSummoned","GLOBAL",1)~ GOTO 8
END
