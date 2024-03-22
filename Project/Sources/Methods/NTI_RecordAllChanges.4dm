//%attributes = {"invisible":true}
//Method: NTI_RecordAllChanges
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:25:16
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_POINTER:C301(NTI_RecordAllChanges; $1)
	// Modified by: Costas Manousakis-(Designer)-(1/6/17 13:59:03)
	Mods_2017_01
	//  `change sequence name of [NTI_ELEM_TIN_INSP] to "NTI_ELEM_TIN_INSP" from "1NTI_ELEM_TIN_INSP"
	//  `change sequence name of [NTI_ELEM_BIN_INSP] to "NTI_ELEM_BIN_INSP" from "1NTI_ELEM_BIN_INSP"
	// Modified by: Costas Manousakis-(Designer)-(6/24/21 10:03:13)
	Mods_2021_WP
	//  `
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($Tbl_Ptr)
$Tbl_Ptr:=$1
C_POINTER:C301($InspID_ptr; $Forkey_ptr; $LocaID_ptr; $Notes_ptr; $ParentKey_ptr; $ModDate_ptr; $ModUsr_ptr; $ParentID_ptr; $GrandParID_ptr)
C_TEXT:C284($Sequence_txt)

Case of 
		
	: ($1=(->[NTI_ELEM_BIN_INSP:183]))
		$InspID_ptr:=->[Inspections:27]InspID:2
		$Forkey_ptr:=->[NTI_ELEM_BIN_INSP:183]INSPID:1
		$LocaID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEMID:2
		$Sequence_txt:="NTI_ELEM_BIN_INSP"
		$Notes_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_NOTES:9
		$ParentKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		$ModDate_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_MODDATETIME:10
		$ModUsr_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_MODUSER:11
		$ParentID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8
		$GrandParID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_GRANDPARENT_ID:26
		
	: ($1=(->[NTI_ELEM_TIN_INSP:185]))
		$InspID_ptr:=->[TIN_Inspections:184]InspectionID:2
		$Forkey_ptr:=->[NTI_ELEM_TIN_INSP:185]InspectionID:1
		$LocaID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEMID:2
		$Sequence_txt:="NTI_ELEM_TIN_INSP"
		$Notes_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_NOTES:9
		$ParentKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
		$ModDate_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_MODDATETIME:10
		$ModUsr_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_MODUSER:11
		$ParentID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8
		$GrandParID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_ID:26
		
End case 

If (Is new record:C668($Tbl_Ptr->))
	LogNewRecord($InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2; $Sequence_txt)
End if 
//C_LONGINT($viAreaMod)  //Command Replaced was o_C_INTEGER
//C_TEXT($vsStrValue)  // Command Replaced was o_C_STRING length was 2
//WR GET AREA PROPERTY (AreaElmComments;wr modified;$viAreaMod;$vsStrValue)
//If ($viAreaMod=1)
//INSP_4DWRITE_SaveToFld (AreaElmComments;$Notes_ptr;PON_ChangeStackLvl_L)
//End if 

PushAllChanges(PON_ChangeStackLvl_L; $Tbl_Ptr; $ParentID_ptr; $LocaID_ptr; $Forkey_ptr)
If (Size of array:C274(ptr_changes{PON_ChangeStackLvl_L})>0)
	$ModDate_ptr->:=ISODateTime(Current date:C33(*); Current time:C178(*))
	$ModUsr_ptr->:=Current user:C182
	PushChange(PON_ChangeStackLvl_L; $ModDate_ptr)
	PushChange(PON_ChangeStackLvl_L; $ModUsr_ptr)
End if 
FlushGrpChgs(PON_ChangeStackLvl_L; $InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2)

If ($ParentID_ptr->#Old:C35($ParentID_ptr->))
	If (($ParentID_ptr->)>0)
		LogLink($ParentID_ptr; $InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2; $LocaID_ptr)
	Else 
		LogChanges($ParentID_ptr; $InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2)
	End if 
End if 

If ($GrandParID_ptr->#Old:C35($GrandParID_ptr->))
	If (($GrandParID_ptr->)>0)
		LogLink($GrandParID_ptr; $InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2; $LocaID_ptr)
	Else 
		LogChanges($GrandParID_ptr; $InspID_ptr; $Forkey_ptr; $LocaID_ptr; 2)
	End if 
End if 

//End NTI_RecordAllChanges