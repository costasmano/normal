//%attributes = {"invisible":true}
// ----------------------------------------------------
// P_ListMissingConsNames
// User name (OS): cjmiller
// Date and time: 02/15/07, 12:03:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2020_07  //change Continue to replace current user=Designer to select Listbox or not
	//Modified by: CJ (7/2/20 13:55:42)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
End if 
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
Compiler_LB
InitProcessVar
pFile:=->[Conslt Address:77]
SHORT_MESSAGE("Retrieving data. Please wait…")

MainTitle:="Consultant Address List"
If (User in group:C338(Current user:C182; "Inspection Engineers"))
	READ ONLY:C145([Conslt Address:77])
Else 
	READ WRITE:C146([Conslt Address:77])
End if 
ALL RECORDS:C47([Conslt_Name:127])
ORDER BY:C49([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2; >)
DISTINCT VALUES:C339([Conslt_Name:127]ConsultantName_s:2; ConsultantNames_atxt)
INSERT IN ARRAY:C227(ConsultantNames_atxt; 1; 1)
ConsultantNames_atxt{1}:="New"
SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY:C277([Conslt Address:77]; [Conslt_Name:127]SQL_VendorID_l:3=0)
CLOSE WINDOW:C154  //close message window
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="match_LB"
Else 
	$Form_txt:="match.o"
End if 
FORM SET INPUT:C55([Conslt Address:77]; "match.i")
FORM SET OUTPUT:C54([Conslt Address:77]; $Form_txt)
C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
$RecSel:=String:C10(Records in selection:C76([Conslt Address:77]))
COPY NAMED SELECTION:C331([Conslt Address:77]; "UserRegionA")  //save the selection
//ControlMenuBar (2)
C_LONGINT:C283($Width_l; $length_L)
FORM GET PROPERTIES:C674([Conslt Address:77]; $Form_txt; $Width_l; $length_L)
C_LONGINT:C283($Win_L)
$Win_L:=ut_OpenNewWindow($Width_L+10; 550; 2; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")


SET WINDOW RECT:C444(16; 44; 16+$Width_L; 44+700)

UpdatWindArray(""; Current process:C322)
SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
If ($useLB_B)
	DIALOG:C40([Conslt Address:77]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Conslt Address:77]; *)  //Display output form even for one record
End if 
CLEAR NAMED SELECTION:C333("UserRegionA")
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
ControlMenuBar(1)
//End P_ListMissingConsNames