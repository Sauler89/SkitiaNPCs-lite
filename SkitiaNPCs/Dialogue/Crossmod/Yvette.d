/*Yvette*/

//Yvette-Emily #1
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Emi")
See("YxYve")
Global("X3EmiYxYve","GLOBAL",0)~ THEN BX3Emi X3EmiYvette1
@0
DO ~SetGlobal("X3EmiYxYve","GLOBAL",1)~
== YxYveB @1
== BX3Emi @2
== YxYveB @3
== BX3Emi @4
== YxYveB IF ~GlobalLT("YvetteRomanceTalk","GLOBAL",21)~ THEN @5
== YxYveB IF ~!GlobalLT("YvetteRomanceTalk","GLOBAL",21)~ THEN @6
== BX3Emi @7
EXIT 

//Yvette-Emily #2
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Emi")
See("YxYve")
Global("X3EmiYxYve","GLOBAL",1)~ THEN BX3Emi X3EmiYvette2
@8
DO ~SetGlobal("X3EmiYxYve","GLOBAL",2)~
== YxYveB @9
== BX3Emi @10
== YxYveB @11
== BX3Emi @12
== YxYveB @13
== BX3Emi @14
== YxYveB @15
== BX3Emi @16
== YxYveB @17
== BX3Emi @18
EXIT 

//Yvette-Emily #3
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Emi")
See("YxYve")
Global("X3EmiYxYve","GLOBAL",1)~ THEN BX3Emi X3EmiYvette2
@19
DO ~SetGlobal("X3EmiYxYve","GLOBAL",2)~
== YxYveB @20
== BX3Emi @21
== BX3Emi IF ~InParty("X3Reb")~ THEN @22
== BX3Emi IF ~InParty("L3Petsy")~ THEN @25
== BX3Emi IF ~InParty("X3Vie")~ THEN @26
== BX3Vie IF ~IsValidForPartyDialogue("X3Vie")~ THEN @27
== YxYveB @28
== BX3Emi @29
== YxYveB @30
== BX3Emi @31
== YxYveB @32
== BX3Emi @33
== YxYveB @34
== Bx3Emi @35
EXIT 


//Yvette-Emily Special
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Emi")
See("YxYve")
Global("X3EmiYxYve","LOCALS",0)Global("X3EmiRomanceActive","GLOBAL",1)~ THEN Bx3Emi X3EmiYvetteSpecial
@36
DO ~SetGlobal("X3EmiYxYve","LOCALS",1)~
== YxYveB @37
== BX3Emi @38
== YxYveB @39
== BX3Emi @40
== YxYveB @41
== BX3Emi @42
== YxYveB @43
== BX3Emi @44
EXIT

//Yvette-Emily ToB 
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Reb")
See("YxYve")
Global("X3RebYxYve","GLOBAL",0)~ THEN BX3Reb X3RebYvette1
@154
DO ~SetGlobal("X3RebYxYve","GLOBAL",1)~
== YxYveB @155
== BX3Reb @156
== BX3Reb @157
== YxYveB @158
== BX3Reb @159
== YxYveB @160
== BX3Reb @161
EXIT 

//Yvette-Recorder #2 
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Reb")
See("X3Reb")
Global("X3RebYxYve","GLOBAL",1)~ THEN YxYveB X3RebYvette2
@162
DO ~SetGlobal("X3RebYxYve","GLOBAL",2)~
== BX3Reb @163
== YxYveB @164
== BX3Reb @165
== YxYveB @166
== BX3Reb @167
== YxYveB @168
== BX3Reb @169
EXIT 
//Yvette-Recorder #3
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Reb")
See("X3Reb")
Global("X3RebYxYve","GLOBAL",2)~ THEN YxYveB X3RebYvette3
@170
DO ~SetGlobal("X3RebYxYve","GLOBAL",3)~
== BX3Reb @171
== YxYveB @172
== BX3Reb @173
== BX3Reb @174
== YxYveB @175
== BX3Reb @176
== YxYveB @177
EXIT 

//Yvette-Recorder Special 
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Reb")
See("YxYve")
GlobalGT("X3RebTalk","LOCALS",10)
Global("X3RebYxYve","LOCALS",0)~ THEN BX3Reb X3RebYvetteSpecial
@178
DO ~SetGlobal("X3RebYxYve","LOCALS",1)~
== YxYveB @179
== BX3Reb @180
== YxYveB @181
== BX3Reb @182
== YxYveB @183
== Bx3Reb @184
== YxYveB @185
== BX3Reb @186
EXIT 

//Yvette-Recorder ToB 
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Reb")
See("YxYve")
Global("X3RebYxYveToB","GLOBAL",0)~ THEN BX3Reb25 X3RebYvetteToB
@187
DO ~SetGlobal("X3RebYxYve","GLOBAL",1)~
== YxYv25B @188
== YxYv25B @189
== BX3Reb25 @190
== YxYv25B @191
== BX3Reb25 @192
EXIT 

//Yvette-Recorder Special 
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Reb")
Global("X3RebRomanceActive","GLOBAL",2)
See("YxYve")
Global("X3RebYxYveToB","GLOBAL",0)~ THEN BX3Reb25 X3RebYvetteToB
@193
DO ~SetGlobal("X3RebYxYveToB","GLOBAL",1)~
== YxYv25B @194
== BX3Reb25 @195
== YxYv25B @196
== BX3Reb25 @197
== YxYv25B @198
== BX3Reb25 @199
== YxYv25B @200
== BX3Reb25 @201
EXIT 

//Yvette-Vienxay #1
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Vie")
See("YxYve")
Global("X3VieYxYve","GLOBAL",0)~ THEN BX3Vie X3VieYvette1
@202
DO ~SetGlobal("X3VieYxYve","GLOBAL",1)~
== YxYveB @203
== BX3Vie @204
== YxYveB @205
== BX3Vie @206
== YxYveB @207
== BX3Vie @208
EXIT 

//Yvette-Vienxay #2
CHAIN
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Vie")
See("YxYve")
Global("X3VieYxYve","GLOBAL",1)~ THEN BX3Vie X3VieYvette2
@209
DO ~SetGlobal("X3VieYxYve","GLOBAL",2)~
== YxYveB @210
== BX3Vie @211
== YxYveB @212
== BX3Vie @213
== BX3Vie @214
EXIT 

//Yvette-Vienxay #3 
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Vie")
See("X3Vie")
Global("X3VieYxYve","GLOBAL",2)~ THEN YxYveB X3VieYvette3
@215
DO ~SetGlobal("X3VieYxYve","GLOBAL",3)~
== BX3Vie @216
== YxYveB @217
== BX3Vie @218
== YxYveB @219
== BX3Vie @220
== YxYveB @221
== BX3Vie @222
== YxYveB @223
== BX3Vie @224 
EXIT 

//Yvette-Vienxay Special 
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Vie")
See("YxYve")
Global("YvetteRomanceActive","GLOBAL",1)
Global("X3VieRomanceActive","GLOBAL",1)
Global("X3VieYxYve","LOCALS",0)~ THEN BX3Vie X3VieYvetteSpecial
@225
DO ~SetGlobal("X3VieYxYve","LOCALS",1)~
== YxYveB @226
== BX3Vie @227
== YxYveB @228
== BX3Vie @229
EXIT 

//Yvette-Vienxay ToB 
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Vie")
See("YxYve")
Global("X3VieYxYveToB","LOCALS",0)~ THEN YxYv25B X3VieYvetteSpecial
@230
DO ~SetGlobal("X3VieYxYveToB","LOCALS",1)~
== BX3Vie25 @231
== YxYv25B @232
== BX3Vie25 @233
== YxYv25B @234
== BX3Vie25 @235
EXIT 

//Yvette-Vienxay ToB Special 
CHAIN 
IF ~IsValidForPartyDialogue("YxYve")
IsValidForPartyDialogue("X3Vie")
See("YxYve")
Global("X3VieRomanceActive","GLOBAL",1)
Global("X3VieYxYveToB","LOCALS",1)~ THEN YxYv25B X3VieYvetteSpecial
@236
DO ~SetGlobal("X3VieYxYveToB","LOCALS",2)~
== BX3Vie25 @237
== YxYv25B @238
== BX3Vie25 @239
== YxYv25B @240
== BX3Vie25 @241
EXIT 