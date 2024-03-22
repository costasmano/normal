//%attributes = {"invisible":true}
If (False:C215)
	//P_ListConsRating 
	//Look at Consultant Rating Reports
	//
	//Modified 
	//
	Mods_2005_CM03
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(9/19/2007 09:12:23)
	Mods_2007_CM12_5301
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 20:14:37)
	Mods_2021_10
	//  `unload record after sorting
	
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
Compiler_LB
SHORT_MESSAGE("Retrieving data. Please wait…")
InitProcessVar
pFile:=->[Conslt Rating:63]
READ ONLY:C145(*)
READ ONLY:C145([Conslt Rating:63])
READ ONLY:C145([Conslt Rating Cost:74])
READ WRITE:C146([Activity Log:59])
READ WRITE:C146([Sequences:28])
READ WRITE:C146([Owners of Data:62])
If (User in group:C338(Current user:C182; "Conslt Rating - ReadWrite"))
	READ WRITE:C146([Conslt Rating:63])
	READ WRITE:C146([Conslt Rating Cost:74])
End if 

MainTitle:="Consultant Rating Reports"
ALL RECORDS:C47([Conslt Rating:63])
ORDER BY:C49([Conslt Rating:63]; [Bridge MHD NBIS:1]BDEPT:1; >)
UNLOAD RECORD:C212([Conslt Rating:63])

CLOSE WINDOW:C154  //close message window

FORM SET INPUT:C55([Conslt Rating:63]; "Cslt Rating In")

C_BOOLEAN:C305($useLB)
$useLB:=ut_UseListBox(Current method name:C684)
If ($useLB)
	
	FORM SET OUTPUT:C54([Conslt Rating:63]; "View Cslt Rating_LB")
	FORM GET PROPERTIES:C674([Conslt Rating:63]; "View Cslt Rating_LB"; $vwd; $vwh)
Else 
	
	FORM SET OUTPUT:C54([Conslt Rating:63]; "View Cslt Rating")
	FORM GET PROPERTIES:C674([Conslt Rating:63]; "View Cslt Rating"; $vwd; $vwh)
End if 

C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Conslt Rating:63]))
COPY NAMED SELECTION:C331([Conslt Rating:63]; "UserRegionA")  //save the selection
SET MENU BAR:C67(3)
C_LONGINT:C283($vwd; $vwh; $win_L)
$win_L:=ut_OpenNewWindow($vwd; 550; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow ($vwd;550;1;Plain window)
SET WINDOW RECT:C444(16; 44; 16+$vwd; 44+550)

UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")

If ($useLB)
	DIALOG:C40([Conslt Rating:63]; "View Cslt Rating_LB")
Else 
	MODIFY SELECTION:C204([Conslt Rating:63]; *)  //Display output form even for one record
End if 

CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154