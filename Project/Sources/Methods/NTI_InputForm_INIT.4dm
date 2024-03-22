//%attributes = {"invisible":true}
//Method: NTI_InputForm_INIT
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/16, 11:45:10
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(8/8/16 16:48:00)
	Mods_2016_08_bug
	//  `enabled this for all users
End if 
//

NTI_INIT

If (Type:C295(vTabRoutingPages)=Is undefined:K8:13)
Else 
	APPEND TO ARRAY:C911(vTabRoutingPages; "NTE")
End if 

PON_ChangeStackLvl_L:=2

NTI_ListElements

If (Records in selection:C76([NTI_ELEM_BIN_INSP:183])>0)
	OBJECT SET VISIBLE:C603(*; "PON_CopyNBE"; False:C215)
Else 
	OBJECT SET VISIBLE:C603(*; "PON_CopyNBE"; True:C214)
End if 

//End NTI_InputForm_INIT