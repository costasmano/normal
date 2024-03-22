//%attributes = {"invisible":true}
//Method: PON_SetupChildParams
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:41:32
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
//PON_SetupChildParams 
PON_PARENTENV_L:=[PON_ELEM_INSP:179]ENVKEY:5
PON_PARENTSTRUNIT_L:=[PON_ELEM_INSP:179]STRUNITKEY:6
PON_PARENTKEY_L:=[PON_ELEM_INSP:179]ELEM_KEY:3
PON_PARENTID_L:=[PON_ELEM_INSP:179]ELEMID:22
PON_GRANDPARENTKEY_L:=0
PON_GRANDPARENTID_L:=0
PON_ShowQuantity_b:=[PON_ELEM_INSP:179]ELEM_QorP:29
If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)
	PON_GRANDPARENTKEY_L:=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4
	PON_GRANDPARENTID_L:=[PON_ELEM_INSP:179]ELEM_PARENTID:27
End if 

//End PON_SetupChildParams