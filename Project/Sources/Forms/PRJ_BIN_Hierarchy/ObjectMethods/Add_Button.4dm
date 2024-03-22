//Method: PRJ_BIN_Hierarchy.Add_Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/10/19, 11:55:33
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller
End if 
//

USE SET:C118("BDEPTset")
ARRAY TEXT:C222($Bins_atxt; 0)
ARRAY TEXT:C222($Item8_atxt; 0)
C_REAL:C285($x_R; $y_R)
C_LONGINT:C283($BUTTON_L; $loop_l)
INSERT IN ARRAY:C227($Bins_atxt; 0; 1)
INSERT IN ARRAY:C227($Item8_atxt; 0; 1)
ARRAY TEXT:C222($menu_atxt; 0)
APPEND TO ARRAY:C911($menu_atxt; "")
C_LONGINT:C283($Pos_L)
GET MOUSE:C468($x_R; $y_R; $BUTTON_L)
C_TEXT:C284($menuref_txt; $selected_txt)
ARRAY TEXT:C222($IncludedBins_atxt; 0)
ARRAY TEXT:C222($IncludedBins_atxt; Size of array:C274(BIN_atxt))
For ($loop_l; 1; Size of array:C274(BIN_atxt))
	$IncludedBins_atxt{$loop_l}:=Substring:C12(BIN_atxt{$loop_l}; 1; 3)
End for 
For ($loop_l; 1; Size of array:C274(v_1_003_atxt))
	
	$Pos_L:=Find in array:C230($IncludedBins_atxt; v_1_003_atxt{$loop_l})
	If ($Pos_L>0)
	Else 
		APPEND TO ARRAY:C911($menu_atxt; v_1_003_atxt{$loop_l}+" - "+v_1_206_atxt{$loop_l})
		APPEND TO ARRAY:C911($Bins_atxt; Substring:C12(v_1_003_atxt{$loop_l}; 1; 3))
	End if 
End for 
$menuref_txt:=MENU_BuildMenuFromArrays(->$menu_atxt; ->$Bins_atxt; "\\")
$selected_txt:=Dynamic pop up menu:C1006($menuref_txt; ""; $x_R; $y_R)
RELEASE MENU:C978($menuref_txt)
If ($selected_txt#"")
	$loop_l:=Find in array:C230(v_1_003_atxt; $selected_txt)
	APPEND TO ARRAY:C911(Group_atxt; "Group 1")
	$pos_l:=Find in array:C230(v_1_003_atxt; $selected_txt)
	APPEND TO ARRAY:C911($IncludedBins_atxt; $selected_txt)
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$selected_txt)
	APPEND TO ARRAY:C911(Bin_atxt; $selected_txt+" - "+f_TrimStr([Bridge MHD NBIS:1]Item7:65; True:C214; True:C214)+" / "+f_TrimStr([Bridge MHD NBIS:1]Item6A:63; True:C214; True:C214))
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	If (Position:C15("DES"; v_1_206_atxt{$loop_l})>0)
		APPEND TO ARRAY:C911(Type_atxt; "Proposed")
	Else 
		APPEND TO ARRAY:C911(Type_atxt; "Existing")
	End if 
	//CREATE RECORD([PRJ_ProjectDetailsIncludedBINS])
	//[PRJ_ProjectDetailsIncludedBINS]PDB_BDEPT_s:=Substring([PRJ_ProjectDetails]PRJ_BridgeNo_s;1;6)
	//[PRJ_ProjectDetailsIncludedBINS]PDB_Date_d:=Current date
	//[PRJ_ProjectDetailsIncludedBINS]PDB_BIN_s:=Bin_atxt{$Loop_L}
	//[PRJ_ProjectDetailsIncludedBINS]PDB_NewBIN_b:=(Type_atxt{$loop_l}="New")
	//[PRJ_ProjectDetailsIncludedBINS]PRJ_ProjectID_l:=[PRJ_ProjectDetails]PRJ_ProjectID_l
	//[PRJ_ProjectDetailsIncludedBINS]PDB_GroupNumber_l:=1
	//SAVE RECORD([PRJ_ProjectDetailsIncludedBINS])
	//UNLOAD RECORD([PRJ_ProjectDetailsIncludedBINS])
	MULTI SORT ARRAY:C718(Group_atxt; >; Type_atxt; >; Bin_atxt; >)
	C_LONGINT:C283($Loop_L; $Pos_L)
	$Loop_L:=1
	Repeat 
		
		$Pos_L:=Find in array:C230($IncludedBins_atxt; v_1_003_atxt{$loop_l})
		$Loop_L:=$Loop_L+1
	Until ($Loop_L>Size of array:C274(v_1_003_atxt)) | ($Pos_L<1)
	
	OBJECT SET ENABLED:C1123(*; "Add_Button"; ($Pos_L<1))
	LISTBOX SELECT ROW:C912(*; "PRJ_BIN_Hierarchy"; 0; 2)
	
	
End if 

//End PRJ_BIN_Hierarchy.Add_Button