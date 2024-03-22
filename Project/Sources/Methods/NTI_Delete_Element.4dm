//%attributes = {"invisible":true}
//Method: NTI_Delete_Element
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 10:50:21
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	//C_POINTER(NTI_Delete_Element ;$1)
	
End if 
//
//C_POINTER($1)

C_POINTER:C301($InspID_ptr; $Forkey_ptr; $LocaID_ptr; $Notes_ptr; $ParentID_ptr; $ModDate_ptr; $ModUsr_ptr; $Tbl_ptr)
$Tbl_ptr:=Current form table:C627

Case of 
		
	: ($Tbl_ptr=(->[NTI_ELEM_BIN_INSP:183]))
		$InspID_ptr:=->[Inspections:27]InspID:2
		$Forkey_ptr:=->[NTI_ELEM_BIN_INSP:183]INSPID:1
		$LocaID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEMID:2
		$ParentID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8
	: ($Tbl_ptr=(->[NTI_ELEM_TIN_INSP:185]))
		$InspID_ptr:=->[TIN_Inspections:184]InspectionID:2
		$Forkey_ptr:=->[NTI_ELEM_TIN_INSP:185]InspectionID:1
		$LocaID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEMID:2
		$ParentID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8
		
End case 

C_TEXT:C284($msg_txt)
C_LONGINT:C283($DefectCount_L; $ProtsysCount_L)
C_LONGINT:C283($myinspID_L; $myElemID_L)
$myinspID_L:=$Forkey_ptr->
$myElemID_L:=$LocaID_ptr->
//find if  element has defects  or protective systems
SET QUERY DESTINATION:C396(Into set:K19:2; "$ChildDefects")
QUERY:C277($Tbl_ptr->; $Forkey_ptr->=$myinspID_L; *)
QUERY:C277($Tbl_ptr->;  & ; $ParentID_ptr->=$myElemID_L; *)
QUERY:C277($Tbl_ptr->;  & ; [NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
SET QUERY DESTINATION:C396(Into set:K19:2; "$Alldescendants2")
QUERY:C277($Tbl_ptr->; $Forkey_ptr->=$myinspID_L; *)
QUERY:C277($Tbl_ptr->;  & ; $ParentID_ptr->=$myElemID_L)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$DefectCount_L:=Records in set:C195("$ChildDefects")
$msg_txt:=""

If ($DefectCount_L>0)
	$msg_txt:=String:C10($DefectCount_L)+" Defect(s)"
End if 

If ($msg_txt="")
	$msg_txt:="Are you sure you want to delete this Element?"
Else 
	$msg_txt:="Are you sure you want to delete this Element?  It has "+$msg_txt
End if 

CONFIRM:C162($msg_txt; "Delete"; "Cancel")

If (OK=1)
	
	LogDeletion($InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2)
	DELETE RECORD:C58($Tbl_ptr->)
	// now delete defects'
	If (Records in set:C195("$Alldescendants2")>0)
		USE SET:C118("$Alldescendants2")
		InitGrpDelete
		FIRST RECORD:C50($Tbl_ptr->)
		While (Not:C34(End selection:C36($Tbl_ptr->)))
			PushGrpDelete($LocaID_ptr)
			NEXT RECORD:C51($Tbl_ptr->)
		End while 
		FlushGrpDeletions($InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2)
		DELETE SELECTION:C66($Tbl_ptr->)
	End if 
	CANCEL:C270
	// must run update list  --- this done from on double click event of parent listbox
End if 

CLEAR SET:C117("$Alldescendants2")
CLEAR SET:C117("$ChildDefects")

//End NTI_Delete_Element