//%attributes = {"invisible":true}
// ----------------------------------------------------
// P_ListConsultantNames
// User name (OS): cjmiller
// Date and time: 02/21/07, 10:28:40
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/15/07, 12:34:00`Modify to use group description
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	Mods_2007_CJM_v5302  //r001 `10/02/07, 11:00:54
	Mods_2020_07  //continue replace of old output forms with list boxes
	//Modified by: CJ (7/6/20 15:20:34)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 
Compiler_LB
UpdatWindArray(""; Current process:C322)
PRJ_FillPersonnelDropDowns(->PRJ_StructPrjMgrID_al; ->PRJ_StructPrjMgr_atxt; "Struct Proj Managers")
InitProcessVar
pFile:=->[Conslt_Name:127]

READ ONLY:C145(*)
READ WRITE:C146([Conslt_Name:127])
READ WRITE:C146([Conslt Address:77])
ALL RECORDS:C47([Conslt_Name:127])
FORM SET INPUT:C55([Conslt_Name:127]; "Conlst_Name.i")
FORM SET OUTPUT:C54([Conslt_Name:127]; "Conslt_Name.o")
C_LONGINT:C283($Width_l; $Height_l; $Width_i_l; $Height_i_l; $Win_L)
C_TEXT:C284($Form_txt)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)

If ($useLB_B)
	$Form_txt:="Conslt_Name_LB"
Else 
	$Form_txt:="Conslt_Name.o"
End if 

FORM GET PROPERTIES:C674([Conslt_Name:127]; "Conlst_Name.i"; $Width_i_l; $Height_i_l)
FORM GET PROPERTIES:C674([Conslt_Name:127]; $Form_txt; $Width_l; $Height_l)
If ($Width_i_l>$Width_l)
	$Width_l:=$Width_i_l
Else 
	$Width_l:=$Width_l+20
End if 
If ($Height_i_l>$Height_i_l)
	$Height_l:=$Height_i_l
End if 
If ($Height_l<600)
	$Height_l:=600
End if 
C_TEXT:C284($RecSel)
$RecSel:=String:C10(Records in selection:C76([Conslt_Name:127]))
$Win_L:=ut_OpenNewWindow($Width_l; $Height_l; 1; Plain form window:K39:10; MainTitle+" ["+$RecSel+"]"; "ut_CloseCancel")
SET MENU BAR:C67(3)
If ($useLB_B)
	DIALOG:C40([Conslt_Name:127]; $Form_txt)
Else 
	MODIFY SELECTION:C204([Conslt_Name:127]; *)
End if 
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154

//End P_ListConsultantNames