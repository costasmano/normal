//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_CreateMonthlyData
// User name (OS): cjmiller
// Date and time: 10/05/04, 13:16:21
// ----------------------------------------------------
// Description
// This method query [Bridge MHD NBIS] where struct defect is true and
//1 create sd_history records
//2 create export file
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	Mods_2005_CJM01  //10/12/04, 12:11:10
	Mods_2009_12  // r004 CJ Miller`12/29/09, 12:41:15      `Add [Bridge MHD NBIS]LegacyOwner
	// Modified by: costasmanousakis-(Designer)-(12/30/09 10:58:27)
	Mods_2009_12
	//  `Save the  YYYY_MM.txt file to and "Exports" folder next to the structure file
	Mods_2011_06  // CJ Miller`06/14/11, 10:48:48      ` Type all local variables for v11
End if 
C_TEXT:C284($Month_txt; $Year_txt)

C_DATE:C307($Todays_d)
C_TEXT:C284($Eol_txt; $Month_txt; $Year_txt; $DocumentNme_txt)
C_LONGINT:C283($Loop_l)

$Todays_d:=Current date:C33(*)
$Month_txt:=String:C10(Month of:C24($Todays_d); "00")
$Year_txt:=String:C10(Year of:C25($Todays_d))

READ WRITE:C146([SD_History:89])

QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]StructDef:103=True:C214)
READ ONLY:C145([Bridge MHD NBIS:1])
//_O_PLATFORM PROPERTIES($Platform_l)// MassDOT_PS - conversion v19R7
//If ($Platform_l=3)// MassDOT_PS - conversion
If (Is Windows:C1573)
	$Eol_txt:=Char:C90(13)+Char:C90(10)
Else 
	$Eol_txt:=Char:C90(13)
End if 

ARRAY TEXT:C222($Text_atxt; 1)
For ($Loop_l; 1; Records in selection:C76([Bridge MHD NBIS:1]))
	GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Loop_l)
	CREATE RECORD:C68([SD_History:89])
	[SD_History:89]AASHTO:13:=[Bridge MHD NBIS:1]AASHTO:5
	[SD_History:89]BDEPT:4:=[Bridge MHD NBIS:1]BDEPT:1
	[SD_History:89]Bin:1:=[Bridge MHD NBIS:1]BIN:3
	[SD_History:89]Item2:12:=[Bridge MHD NBIS:1]Item2:60
	[SD_History:89]Item21:14:=[Bridge MHD NBIS:1]Item21:127
	[SD_History:89]Item41:15:=[Bridge MHD NBIS:1]Item41:141
	[SD_History:89]Item58:9:=[Bridge MHD NBIS:1]Item58:130
	[SD_History:89]Item59:10:=[Bridge MHD NBIS:1]Item59:131
	[SD_History:89]Item60:11:=[Bridge MHD NBIS:1]Item60:132
	[SD_History:89]Item6A:8:=[Bridge MHD NBIS:1]Item6A:63
	[SD_History:89]Item7:7:=[Bridge MHD NBIS:1]Item7:65
	[SD_History:89]Item8:6:=[Bridge MHD NBIS:1]Item8:206
	[SD_History:89]SD_DefectAddRemoveStatus_s:16:=""
	[SD_History:89]SD_Month:3:=$Month_txt
	[SD_History:89]SD_Owner_s:17:=Substring:C12([Bridge MHD NBIS:1]Item8:206; 10; 3)
	[SD_History:89]SD_PreviousOwner_s:19:=[Bridge MHD NBIS:1]LegacyOwner:226
	[SD_History:89]SD_PostedAddRemoveStatus_s:18:=""
	[SD_History:89]SD_Year:2:=$Year_txt
	[SD_History:89]Town Name:5:=[Bridge MHD NBIS:1]Town Name:175
	If (Length:C16($Text_atxt{1})>25000)
		INSERT IN ARRAY:C227($Text_atxt; 1; 1)
	End if 
	$Text_atxt{1}:=$Text_atxt{1}+[SD_History:89]BDEPT:4+Char:C90(9)+[SD_History:89]Town Name:5+Char:C90(9)+"'"+[SD_History:89]Bin:1+Char:C90(9)+"'"+[SD_History:89]Item8:6+Char:C90(9)+"'"+[SD_History:89]Item7:7+Char:C90(9)+"'"+[SD_History:89]Item6A:8+Char:C90(9)+"'"+[SD_History:89]Item58:9+"'"+Char:C90(9)+"'"+[SD_History:89]Item59:10+Char:C90(9)+"'"+[SD_History:89]Item60:11+Char:C90(9)+"'"+[SD_History:89]Item2:12+Char:C90(9)+String:C10([SD_History:89]AASHTO:13)+Char:C90(9)+"'"+[SD_History:89]Item21:14+Char:C90(9)+"'"+[SD_History:89]Item41:15+$Eol_txt
	SAVE RECORD:C53([SD_History:89])
	UNLOAD RECORD:C212([SD_History:89])
End for 

SD_SetAddRemoveStatus($Year_txt; $Month_txt)
C_TEXT:C284($path)
C_LONGINT:C283($err)

Startup_PL
$path:=ut_ReturnUserDocFolder("Exports")
C_TIME:C306($DOC)
$DOC:=Create document:C266($path+$Year_txt+"_"+$Month_txt+".txt ")
If (OK=1)
	SEND PACKET:C103($doc; "BDEPT"+Char:C90(9)+"Town Name"+Char:C90(9)+"Bin"+Char:C90(9)+"Item8"+Char:C90(9)+"Item7"+Char:C90(9)+"Item6A"+Char:C90(9)+"Item58"+Char:C90(9)+"Item59"+Char:C90(9)+"Item60"+Char:C90(9)+"Item2"+Char:C90(9)+"AASHTO"+Char:C90(9)+"Item21"+Char:C90(9)+"Item41"+$Eol_txt)
	
	For ($Loop_l; Size of array:C274($Text_atxt); 1; -1)
		SEND PACKET:C103($Doc; $Text_atxt{$Loop_l})
	End for 
End if 
$DocumentNme_txt:=Document
CLOSE DOCUMENT:C267($doc)
UNLOAD RECORD:C212([SD_History:89])
READ ONLY:C145([SD_History:89])
If (Is Windows:C1573)
Else 
	//_ O _SET DOCUMENT TYPE($DocumentNme_txt;"TEXT")
End if 
//End SD_CreateMonthlyData 