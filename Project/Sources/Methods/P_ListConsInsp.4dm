//%attributes = {"invisible":true}
If (False:C215)
	//P_ListConsInsp 
	//Look at Consultant Inspection Reports
	//
	//Modified 
	Mods_2005_CM12  //
	Mods_2020_06
	//Modified by: CJ (6/18/20 14:07:25)
	//Move code from single user to this to upgrade to use list boxes
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-04T00:00:00 20:14:37)
	Mods_2021_10
	//  `unload record after sorting
End if 
Compiler_LB
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255

InitProcessVar
pFile:=->[Cons Inspection:64]
SHORT_MESSAGE("Retrieving data. Please wait…")
READ ONLY:C145(*)
READ WRITE:C146([Cons Inspection:64])
READ WRITE:C146([Cons Inspection Cost:76])
READ WRITE:C146([Activity Log:59])
READ WRITE:C146([Sequences:28])
READ WRITE:C146([Owners of Data:62])

MainTitle:="Consultant Inspection Reports"
ALL RECORDS:C47([Cons Inspection:64])
ORDER BY:C49([Cons Inspection:64]; [Cons Inspection:64]RequestConDate:2; >)
UNLOAD RECORD:C212([Cons Inspection:64])
CLOSE WINDOW:C154  //close message window

FORM SET INPUT:C55([Cons Inspection:64]; "Cslt Insp In")

C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Cons Inspection:64]))
COPY NAMED SELECTION:C331([Cons Inspection:64]; "UserRegionA")  //save the selection
SET MENU BAR:C67(3)
C_BOOLEAN:C305($UseListBox_B)
$UseListBox_B:=ut_UseListBox(Current method name:C684)
C_LONGINT:C283($winWidth; $winHt)
If ($UseListBox_B)
	FORM SET OUTPUT:C54([Cons Inspection:64]; "View Cslt Insp_LB")
	FORM GET PROPERTIES:C674([Cons Inspection:64]; "View Cslt Insp_LB"; $winWidth; $winHt)
Else 
	FORM SET OUTPUT:C54([Cons Inspection:64]; "View Cslt Insp")
	FORM GET PROPERTIES:C674([Cons Inspection:64]; "View Cslt Insp"; $winWidth; $winHt)
End if 
C_LONGINT:C283($win_L)
$win_L:=ut_OpenNewWindow($winWidth; 550; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow ($winWidth;550;1;Plain window)
SET WINDOW RECT:C444(16; 44; 16+$winWidth; 44+550)

UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
If ($UseListBox_B)
	DIALOG:C40([Cons Inspection:64]; "View Cslt Insp_LB")
Else 
	MODIFY SELECTION:C204([Cons Inspection:64]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154