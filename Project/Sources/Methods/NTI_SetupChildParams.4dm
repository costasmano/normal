//%attributes = {"invisible":true}
//Method: NTI_SetupChildParams
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 13:07:20
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_POINTER:C301(NTI_SetupChildParams; $1)
End if 
//
C_POINTER:C301($1)
C_POINTER:C301($ElemKey_ptr; $ElemID_ptr; $elemQorP_ptr; $ParKey_ptr; $ParID_ptr)

Case of 
	: ($1=(->[NTI_ELEM_BIN_INSP:183]))
		$ElemKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
		$ElemID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEMID:2
		$elemQorP_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QorP:16
		$ParKey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		$ParID_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8
	: ($1=(->[NTI_ELEM_TIN_INSP:185]))
		$ElemKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3
		$ElemID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEMID:2
		$elemQorP_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16
		$ParKey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
		$ParID_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_ID:8
End case 

//PON_SetupChildParams 
//PON_PARENTENV_L:=[nti_elem_bin_insp]ENVKEY
//PON_PARENTSTRUNIT_L:=[nti_elem_bin_insp]STRUNITKEY
PON_PARENTKEY_L:=$ElemKey_ptr->
PON_PARENTID_L:=$ElemID_ptr->
PON_GRANDPARENTKEY_L:=0
PON_GRANDPARENTID_L:=0
PON_ShowQuantity_b:=$elemQorP_ptr->
If (($ParKey_ptr->)>0)
	PON_GRANDPARENTKEY_L:=$ParKey_ptr->
	PON_GRANDPARENTID_L:=$ParID_ptr->
End if 

//End NTI_SetupChildParams