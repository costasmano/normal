//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// P_ListConsAddress
	// User name (OS): cjmiller
	// Date and time: 02/15/07, 13:41:58
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//October 2, 2003
	Mods_2006_CJMv2  //added code to fill drop down of unique [Conslt Address]ConsltName
	//ConsultantNames_atxt
	Mods_2006_CJMv2  //02/15/07, 11:52:17`Make use of new consultant name table
	// Modified by: costasmanousakis-(Designer)-(9/18/2007 12:28:29)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(11/9/07 16:53:57)
	Mods_2007_CM12_5302
	// Modified by: Costas Manousakis-(Designer)-(4/15/20 12:44:02)
	Mods_2020_04
	//  `switched back to old output form
	Mods_2020_07  //Change continue replace of old output forms with list boxes
	//Modified by: CJ (7/9/20 22:22:45)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	// Modified by: Costas Manousakis-(Designer)-(2022-12-27 16:54:05)
	Mods_2022_12_bug
	//  `change write access from "Bridge Insp engineer" 4D group to CSLTAddressManage Personnel group
	
End if 
C_TEXT:C284(MainTitle)  // **Replaced old C_STRING length 255
Compiler_LB
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="View Conslt Address_LB"
Else 
	$Form_txt:="View Conslt Address"
End if 

InitProcessVar
pFile:=->[Conslt Address:77]
SHORT_MESSAGE("Retrieving data. Please wait…")

MainTitle:="Consultant Address List"
READ ONLY:C145([Conslt Address:77])
Case of 
	: (GRP_UserInGroup("CSLTAddressManage")=1)
		READ WRITE:C146([Conslt Address:77])
	: (User in group:C338(Current user:C182; "Design Access Group"))
		READ WRITE:C146([Conslt Address:77])
End case 

ALL RECORDS:C47([Conslt Address:77])
ORDER BY:C49([Conslt Address:77]; [Conslt Address:77]ConsltName:2; >; [Conslt Address:77]ContactLName:4; >)
FORM SET INPUT:C55([Conslt Address:77]; "Conslt Address In")
FORM SET OUTPUT:C54([Conslt Address:77]; "View Conslt Address")
C_TEXT:C284($RecSel)  // **Replaced old C_STRING length 10
$RecSel:=String:C10(Records in selection:C76([Conslt Address:77]))
COPY NAMED SELECTION:C331([Conslt Address:77]; "UserRegionA")  //save the selection
CLOSE WINDOW:C154  //close message window

//ControlMenuBar (2)
C_LONGINT:C283($FmW; $FmHt; $Win_L)
FORM GET PROPERTIES:C674([Conslt Address:77]; $Form_txt; $FmW; $FmHt)
SET MENU BAR:C67("Blankmenu")
$Win_L:=ut_OpenNewWindow($FmW; 550; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")

//NewWindow ($FmW;550;1;Plain window)
SET WINDOW RECT:C444(16; 44; 16+$FmW; 44+550)

UpdatWindArray(""; Current process:C322)
//SET WINDOW TITLE(MainTitle+" ["+$RecSel+"]")
If ($useLB_B)
	DIALOG:C40([Conslt Address:77]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Conslt Address:77]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
ControlMenuBar(1)
//End P_ListConsAddress