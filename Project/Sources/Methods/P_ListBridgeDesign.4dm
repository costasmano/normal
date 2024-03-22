//%attributes = {"invisible":true}
If (False:C215)
	Mods_2005_CM12
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 


C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255

InitProcessVar
pFile:=->[Bridge Design:75]
SHORT_MESSAGE("Retrieving data. Please wait…")
READ ONLY:C145(*)
READ WRITE:C146([Bridge Design:75])
READ WRITE:C146([Activity Log:59])
READ WRITE:C146([Sequences:28])
READ WRITE:C146([Owners of Data:62])

MainTitle:="Bridge Design Reports"
ALL RECORDS:C47([Bridge Design:75])
ORDER BY:C49([Bridge Design:75]; [Bridge MHD NBIS:1]BDEPT:1; >)

CLOSE WINDOW:C154  //close message window
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="View Bridge Design_LB"
Else 
	$Form_txt:="View Bridge Design"
End if 
FORM SET INPUT:C55([Bridge Design:75]; "Bridge Design In")
FORM SET OUTPUT:C54([Bridge Design:75]; $Form_txt)
C_LONGINT:C283($Width_L; $Height_L)
FORM GET PROPERTIES:C674([Bridge Design:75]; $Form_txt; $Width_L; $Height_L)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Bridge Design:75]))
COPY NAMED SELECTION:C331([Bridge Design:75]; "UserRegionA")  //save the selection
C_LONGINT:C283($Win_L)
$Win_L:=ut_OpenNewWindow($Width_L+10; 550; 2; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
//NewWindow (720;550;1;Plain window)
//SET WINDOW RECT(16;44;16+$Width_L;44+550)
//SET WINDOW RECT(
SET MENU BAR:C67(3)
UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
If ($useLB_B)
	DIALOG:C40([Bridge Design:75]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Bridge Design:75]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154