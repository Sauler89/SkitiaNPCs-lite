//Emily 1
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Emi")
See("WILSON")
Global("X3EmiWILSON","GLOBAL",0)~ THEN BX3Emi X3EmiWilson1
@0
DO ~SetGlobal("X3EmiWILSON","GLOBAL",1)~
== BWILSON @1
== BX3Emi @2
== BWILSON @3
== BX3Emi @4 
== BWILSON @5
== BX3Emi @6
== BWILSON @7
== BX3Emi @8
EXIT 

//Emily 2
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Emi")
See("WILSON")
Global("X3EmiWILSON","GLOBAL",1)~ THEN BX3Emi X3EmiWilson2
@9
DO ~SetGlobal("X3EmiWILSON","GLOBAL",2)~
== BWILSON @10
== BX3Emi @11
== BWILSON @12
== BX3Reb IF ~IsValidForPartyDialogue("X3Reb")~ THEN @13
== BX3Emi IF ~IsValidForPartyDialogue("X3Reb")~ THEN @14
== BX3Emi @15
== BWILSON @16
== BX3Emi @17
== BWILSON @18
== BX3Emi @19
EXIT 

//Emily ToB
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Emi")
See("X3Emi")
Global("X3EmiWILSON25","LOCALS",0)~ THEN BWILSO25 X3EmiWilson2
@20
DO ~SetGlobal("X3EmiWILSON25","LOCALS",1)~
== BX3Emi25 @21
== BWILSO25 @22
== BX3Emi25 @23
== BWILSO25 @24
== BX3Emi25 @25
== BWILSO25 @26
== BX3Emi25 @27
EXIT 

CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Reb")
See("X3Reb")
Global("X3RebWILSON","GLOBAL",0)~ THEN BWILSON X3RebWilson1
@99
DO ~SetGlobal("X3RebWILSON","GLOBAL",1)~
== BX3Reb @100
== BWILSON @101
== BX3Reb @102
== BWILSON @103
== BX3Reb @104
== BWILSON @105
== BX3Reb @106
EXIT 

//Recorder 2
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Reb")
See("WILSON")
Global("X3RebWILSON","GLOBAL",1)~ THEN BX3Reb X3RebWilson2
@107
DO ~SetGlobal("X3RebWILSON","GLOBAL",2)~
== BWILSON @108
== BX3Reb @109
== BWILSON @110
== BX3Reb @111
== BWILSON @112
== BX3Reb @113
EXIT 

//Recorder ToB
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Reb")
See("WILSON")
Global("X3RebWILSON25","LOCALS",0)~ THEN BX3Reb25 X3RebWilson2
@114
DO ~SetGlobal("X3RebWILSON25","LOCALS",1)~
== BWILSO25 @115
== BX3Reb25 @116
== BWILSO25 @117
== BX3Reb25 @118
== BWILSO25 @119
== BX3Reb25 @120
== BWILSO25 @121
== BX3Reb25 @122
== BWILSO25 @123
== BX3Reb25 @124
EXIT 

//Vienxay 1
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Vie")
See("X3Vie")
Global("X3VieWILSON","GLOBAL",0)~ THEN BWILSON X3VieWilson1
@125
DO ~SetGlobal("X3VieWILSON","GLOBAL",1)~
== BX3Vie @126
== BWILSON @127
== BX3Vie @128
== BWILSON @129
== BX3Vie @130
== BWILSON @131
== BX3Vie @132
EXIT 

//Vienxay 2
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Vie")
See("WILSON")
Global("X3VieWILSON","GLOBAL",1)~ THEN BX3Vie X3VieWilson2
@133
DO ~SetGlobal("X3VieWILSON","GLOBAL",2)~
== BWILSON @134
== BX3Vie @135
== BWILSON @136
== BX3Vie @137
== BWILSON @138
== BX3Vie @139
== BWILSON @140
EXIT 

//Vienxay ToB
CHAIN
IF ~IsValidForPartyDialogue("WILSON")
IsValidForPartyDialogue("X3Vie")
See("WILSON")
Global("X3VieWILSON25","LOCALS",0)~ THEN BX3Vie25 X3VieWilson2
@141
DO ~SetGlobal("X3VieWILSON25","LOCALS",1)~
== BWILSO25 @144
== BX3Vie25 @145
== BWILSO25 @146
== BX3Vie25 @147
== BWILSO25 @148
== BX3Vie25 @149
== BWILSO25 @150
== BX3Vie25 @151
== BWILSO25 @152
EXIT 