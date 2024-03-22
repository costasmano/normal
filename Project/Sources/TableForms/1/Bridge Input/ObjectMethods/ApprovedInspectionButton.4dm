//Method: [Bridge MHD NBIS];"Bridge Input".ApprovedInspectionButton
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 08/11/20, 12:39:54
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08  //Complete work on moving signed PDF inspection reports like we do with ratings
	//Modified by: CJ (8/11/20 12:41:29)
	
End if 
//

C_LONGINT:C283($MouseX_L; $mouseY_L; $MouseBtn_L)
GET MOUSE:C468($MouseX_L; $mouseY_L; $MouseBtn_L)

ARRAY TEXT:C222($Documents_atxt; 0)  //Lets use inspection UUID array for just doc Name
ARRAY TEXT:C222($Documents_atxt; Size of array:C274(v_1_230_atxt))
C_LONGINT:C283($Loop_L)
ARRAY TEXT:C222($MenuSelected_atxt; 0)
ARRAY TEXT:C222($MenuSelected_atxt; Size of array:C274(v_1_230_atxt))
SORT ARRAY:C229(v_1_230_atxt; <)
For ($Loop_L; 1; Size of array:C274(v_1_230_atxt))
	ARRAY TEXT:C222($parts_atxt; 0)
	ut_NewTextToArray(v_1_230_atxt{$Loop_L}; ->$parts_atxt; Folder separator:K24:12)
	$Documents_atxt{$Loop_L}:=$parts_atxt{Size of array:C274($parts_atxt)}
	$MenuSelected_atxt{$Loop_L}:=String:C10($Loop_L)
End for 
C_TEXT:C284($popupMenu_txt)
$popupMenu_txt:=MENU_BuildMenuFromArrays(->$Documents_atxt; ->$MenuSelected_atxt; "\\")
C_TEXT:C284($filepicked_txt)
$filepicked_txt:=Dynamic pop up menu:C1006($popupMenu_txt; ""; $MouseX_L; $mouseY_L)
RELEASE MENU:C978($popupMenu_txt)
C_TEXT:C284($SelectedDocument_txt)

If (Num:C11($filepicked_txt)#0)
	v_1_230_atxt:=Num:C11($filepicked_txt)
	INSP_ViewApprvedInspection
End if 



//End Method: [Bridge MHD NBIS].Bridge Input.ApprovedInspectionButton
