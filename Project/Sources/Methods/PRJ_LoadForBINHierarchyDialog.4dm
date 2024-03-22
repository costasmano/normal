//%attributes = {"invisible":true}
//Method: PRJ_LoadForBINHierarchyDialog
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/12/19, 14:43:07
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12  //add code to modify how bin groups are created and maintained for a project
	//by Chuck Miller 
	Mods_2020_05  //Fix bug where when no groups to start of loop make sure v_122_006_L is set correctly
	//Modified by: CJ (5/7/20 14:46:45)
	Mods_2020_09  //Fix bug where if v_1_003_atxt was empty an error occurred
End if 
//
ARRAY TEXT:C222($v_1_065_atxt; 0)
ARRAY TEXT:C222($v_1_063_atxt; 0)

USE SET:C118("BDEPTset")
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; v_1_003_atxt; [Bridge MHD NBIS:1]Item8:206; v_1_206_atxt; \
[Bridge MHD NBIS:1]Item7:65; $v_1_065_atxt; [Bridge MHD NBIS:1]Item6A:63; $v_1_063_atxt)


ARRAY TEXT:C222(Group_atxt; 0)
ARRAY LONGINT:C221($Group_al; 0)
ARRAY TEXT:C222(Type_atxt; 0)
ARRAY TEXT:C222(Bin_atxt; 0)
ARRAY BOOLEAN:C223($New_ab; 0)
C_LONGINT:C283($ProjectID_L)
//6339
$ProjectID_L:=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1
Begin SQL
	
	select
	[PRJ_ProjectDetailsIncludedBINS].[PDB_BIN_s],
	[PRJ_ProjectDetailsIncludedBINS].[PDB_NewBIN_b], 
	[PRJ_ProjectDetailsIncludedBINS].[PDB_GroupNumber_l]
	from
	[PRJ_ProjectDetailsIncludedBINS]
	where
	[PRJ_ProjectDetailsIncludedBINS].[PRJ_ProjectID_l] = :$ProjectID_L 
	into 
	:Bin_atxt,
	:$New_ab,
	:$Group_al;
	
End SQL
ARRAY TEXT:C222(Group_atxt; Size of array:C274(Bin_atxt))
ARRAY TEXT:C222(Type_atxt; Size of array:C274(Bin_atxt))
C_LONGINT:C283($Loop_L; $Pos_L)
$Loop_L:=1
If (Size of array:C274(v_1_003_atxt)>0)
	Repeat 
		
		$Pos_L:=Find in array:C230(BIN_atxt; v_1_003_atxt{$loop_l})
		$Loop_L:=$Loop_L+1
	Until ($Loop_L>Size of array:C274(v_1_003_atxt)) | ($Pos_L<1)
End if 
OBJECT SET ENABLED:C1123(*; "@Button"; False:C215)
OBJECT SET ENABLED:C1123(*; "RevertToSaved_Button"; True:C214)

OBJECT SET ENABLED:C1123(*; "Add_Button"; ($Pos_L<1))

v_122_006_L:=0
C_LONGINT:C283($loop_l)
For ($loop_l; 1; Size of array:C274(Bin_atxt))
	//Moved the following if statement to start to make sure v_122_006_L is set correctly
	If ($Group_al{$loop_l}=0)
		$Group_al{$loop_l}:=1
	End if 
	$Pos_L:=Find in array:C230(v_1_003_atxt; Bin_atxt{$Loop_l})
	
	Bin_atxt{$loop_l}:=BIN_atxt{$loop_L}+" - "+f_TrimStr($v_1_065_atxt{$Pos_L}; True:C214; True:C214)+" / "+f_TrimStr($v_1_063_atxt{$Pos_L}; True:C214; True:C214)
	If ($Group_al{$loop_l}>v_122_006_L)
		v_122_006_L:=$Group_al{$loop_l}
	End if 
	
	Group_atxt{$loop_l}:="Group "+String:C10($Group_al{$loop_l})
	If ($New_ab{$loop_l})
		Type_atxt{$loop_l}:="Proposed"
	Else 
		Type_atxt{$loop_l}:="Existing"
	End if 
End for 

MULTI SORT ARRAY:C718(Group_atxt; >; Type_atxt; >; Bin_atxt; >)

ARRAY POINTER:C280($ArrHierarch; 3)
$ArrHierarch{1}:=->Group_atxt  //First break level
$ArrHierarch{2}:=->Type_atxt  //Second break level
$ArrHierarch{3}:=->Bin_atxt  //Third break level

LISTBOX SET HIERARCHY:C1098(*; "PRJ_BIN_Hierarchy"; True:C214; $ArrHierarch)

OBJECT SET ENABLED:C1123(*; "New_Button"; True:C214)
OBJECT SET ENABLED:C1123(*; "Cancel_Button"; True:C214)
OBJECT SET ENABLED:C1123(*; "Save_Button"; True:C214)

LISTBOX SELECT ROW:C912(*; "PRJ_BIN_Hierarchy"; 0; 2)

//End PRJ_LoadForBINHierarchyDialog