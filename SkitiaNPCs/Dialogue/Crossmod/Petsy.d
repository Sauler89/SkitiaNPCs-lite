/*Petsy  */

//Petsy-Emily #1
CHAIN 
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Emi")
See("L3Petsy")
Global("X3EmiPetsy","GLOBAL",0)~ THEN BX3Emi X3EmiPetsy1
@0
DO ~SetGlobal("X3EmiPetsy","GLOBAL",1)~
== L3PetsyB @1
== BX3Emi @2
== L3PetsyB @3
== BX3Emi @4
== L3PetsyB @5
EXIT 

// Petsy-Emily #2
CHAIN 
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Emi")
See("X3Emi")
Global("X3EmiPetsy","GLOBAL",1)~ THEN L3PetsyB X3EmiPetsy2
@6
DO ~SetGlobal("X3EmiPetsy","GLOBAL",2)~
== BX3Emi @7
== L3PetsyB @8
== BX3Emi @9
== L3PetsyB @10
== BX3Emi @11
== L3PetsyB @12
== BX3Emi @13
== L3PetsyB @14
== BX3Emi @15
EXIT 

//Petsy-Emily #3 
CHAIN 
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Emi")
See("X3Emi")
Global("X3EmiPetsy","GLOBAL",2)~ THEN L3PetsyB X3EmiPetsy3
@16
DO ~SetGlobal("X3EmiPetsy","GLOBAL",3)~
== BX3Emi @17
== L3PetsyB @18
== BX3Emi @19
== L3PetsyB @20
== BX3Emi @21
== BX3Vie IF ~IsValidForPartyDialogue("X3Vie")~ THEN @23
== BX3Emi @25
== L3PetsyB @26
== BX3Emi @27
== L3Petsy @28
== BX3Emi @29
EXIT 

//Petsy-Emily Special 
CHAIN 
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Emi")
See("X3Emi")
GlobalGT("X3EGVJQuest","GLOBAL",0)
Global("X3EmiPetsy","LOCALS",0)~ THEN BX3Emi X3EmiPetsy1
@30
DO ~SetGlobal("X3EmiPetsy","LOCALS",1)~
== L3PetsyB @31
== BX3Emi @32
== L3PetsyB @33
== BX3Emi @34
== L3PetsyB @35
== BX3Emi @36
EXIT 

//Petsy Emily ToB 
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Emi")
See("X3Emi")
Global("X3EmiPetsyToB","GLOBAL",0)~ THEN L3Pet25B X3EmiPetsyToB
@37
DO ~SetGlobal("X3EmiPetsyToB","GLOBAL",1)~
== BX3Emi25 @38
== BX3Emi25 @39
== L3Pet25B @40
== BX3Emi25 @41
EXIT 

//Petsy Emily ToB Special 
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Emi")
See("X3Emi")
Global("TethyrBattleStart","GLOBAL",1)
Global("X3EmiPetsyToB","GLOBAL",1)~ THEN L3Pet25B X3EmiePetsyToBSpecial
@42
DO ~SetGlobal("X3EmiPetsyToB","GLOBAL",2)~
== BX3Emi25 @43
== L3Pet25B @44
== BX3Emi25 @45
== L3Pet25B @46
== BX3Emi25 @47
EXIT 

CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Reb")
See("L3Petsy")
Global("X3RebPetsy","GLOBAL",0)~ THEN BX3Reb X3RebPetsy1
@149
DO ~SetGlobal("X3RebPetsy","GLOBAL",1)~
== L3PetsyB @150
== BX3Reb @151
== L3PetsyB @152
== BX3Reb @153
== L3PetsyB @154
== BX3Reb @155
== L3PetsyB @156
== BX3Reb @157
== L3PetsyB @158
== BX3Reb @159
EXIT 

//Petsy-Recorder #2
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Reb")
See("L3Petsy")
Global("X3RebPetsy","GLOBAL",1)~ THEN BX3Reb X3RebPetsy2
@160
DO ~SetGlobal("X3RebPetsy","GLOBAL",2)~
== L3PetsyB @161
== BX3Reb @162
== L3PetsyB @163
== BX3Reb @164
== L3PetsyB @165
== BX3Reb @166
== L3PetsyB @167
EXIT 

//Petsy-Recorder #3
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Reb")
See("L3Petsy")
Global("X3RebPetsy","GLOBAL",2)~ THEN BX3Reb X3RebPetsy3
@168
DO ~SetGlobal("X3RebPetsy","GLOBAL",3)~
== L3PetsyB @169
== BX3Reb @170
== L3PetsyB @171
== BX3Reb @172
== BX3Reb @173
== L3PetsyB @174
== BX3Reb @175
== L3PetsyB @176
EXIT 

//Petsy-Recorder Special 
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Reb")
See("L3Petsy")
Global("X3RFAIL","GLOBAL",2)
Global("X3RebPetsy","GLOBAL",3)~ THEN BX3Reb X3RebPetsySpecial
@177
DO ~SetGlobal("X3RebPetsy","GLOBAL",4)~
== L3PetsyB @178
== BX3Reb @179
== L3PetsyB @180
== BX3Reb @181
== L3PetsyB @182
== BX3Reb @183
EXIT 

//Petsy Recorder ToB 
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Reb")
See("X3Reb")
Global("X3RebPetsyToB","GLOBAL",0)~ THEN L3Pet25B X3RebPetsySpecial
@184
DO ~SetGlobal("X3RebPetsy","GLOBAL",1)~
== BX3Reb25 @185
== L3Pet25B @186
== BX3Reb25 @187
== L3Pet25B @188
== BX3Reb25 @189
== L3Pet25B @190
== BX3Reb25 @191
EXIT 

CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Reb")
See("L3Petsy")
Global("L3PetsyRomanceActive","GLOBAL",2)
Global("X3RebPetsyToB","GLOBAL",1)~ THEN BX3Reb25 X3RebPetsySpecial
@192
DO ~SetGlobal("X3RebPetsy","GLOBAL",2)~
== L3Pet25B @193
== BX3Reb25 @194
== L3Pet25B @195
== BX3Reb25 @196
== L3Pet25B @197
== BX3Reb25 @198
== L3Pet25B @199
EXIT 

//Petsy-Vienxay #1
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Vie")
See("L3Petsy")
Global("X3ViePetsy","GLOBAL",0)~ THEN BX3Vie X3ViePetsy1
@200
DO ~SetGlobal("X3ViePetsy","GLOBAL",1)~
== L3PetsyB @201
== BX3Vie @202
== BX3Reb IF ~IsValidForPartyDialogue("X3Reb")~ THEN @203
== L3PetsyB @204
== BX3Vie @205
EXIT 

//Petsy-Vienxay #2
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Vie")
See("L3Petsy")
Global("X3ViePetsy","GLOBAL",1)~ THEN BX3Vie X3ViePetsy2
@206
DO ~SetGlobal("X3ViePetsy","GLOBAL",2)~
== L3PetsyB @207
== BX3Vie IF ~IsValidForPartyDialogue("Mazzy")~ THEN @210
== BMAZZY IF ~IsValidForPartyDialogue("Mazzy")~ THEN @211
== BX3Vie IF ~!IsValidForPartyDialogue("Mazzy")~ THEN @212
== L3PetsyB IF ~!IsValidForPartyDialogue("Mazzy")~ THEN @213
== BX3Vie @214
EXIT 

//Petsy-Vienxay #3 
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Vie")
See("X3Vie")
Global("X3ViePetsy","GLOBAL",2)~ THEN L3PetsyB X3ViePetsy3
@215
DO ~SetGlobal("X3ViePetsy","GLOBAL",3)~
== BX3Vie @216
== L3PetsyB @217
== BX3Vie @218
== L3PetsyB @219
== BKORGAN IF ~IsValidForPartyDialogue("Korgan")~ THEN @220
== BX3Vie @221
== L3PetsyB @222
== BX3Vie @223
EXIT 

//Petsy-Vienxay Special 
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Vie")
See("L3Petsy")
Dead("L3Zane")
Global("X3ViePetsy","LOCALS",0)~ THEN BX3Vie X3ViePetsySpecial
@224
DO ~SetGlobal("X3ViePetsy","LOCALS",1)~
== L3PetsyB @225
== BX3Vie @226
== L3PetsyB @227
== BX3Vie @228
== L3PetsyB @229
== BX3Vie @230
== L3PetsyB @231
== BX3Vie @232
EXIT 

//Petsy-Vienxay Throne of Bhaal
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Vie")
See("X3Vie")
Global("X3ViePetsyToB","GLOBAL",0)~ THEN L3Pet25B X3ViePetsyToB
@233
DO ~SetGlobal("X3ViePetsyToB","GLOBAL",1)~
== BX3Vie25 @234
== L3Pet25B @235
== BX3Vie25 @236
== L3Pet25B @237
== BX3Vie25 @238
== L3Pet25B @239
== BX3Vie25 @240
== L3Pet25B @241
EXIT 

//Petsy-Vienxay Special
CHAIN
IF ~IsValidForPartyDialogue("L3Petsy")
IsValidForPartyDialogue("X3Vie")
See("X3Vie")
Global("X3VieEvermeet","GLOBAL",1)
Global("X3ViePetsyToB","GLOBAL",1)~ THEN L3Pet25B X3ViePetsyToBSpecial
@242
DO ~SetGlobal("X3ViePetsyToB","GLOBAL",2)~
== BX3Vie25 @243
== L3Pet25B @244
== BX3Vie25 @245
== L3Pet25B @246
== BX3Vie25 @247
EXIT
