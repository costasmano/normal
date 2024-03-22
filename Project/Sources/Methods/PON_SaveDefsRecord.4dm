//%attributes = {"invisible":true}
//Method: PON_SaveDefsRecord
//Description
// save a record in [PON_ELEM_DEFS] - called from Validate button on input form
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Sep 28, 2022, 16:35:20
	Mods_2022_09
	// ----------------------------------------------------
	
End if 
//

If (Is new record:C668([PON_ELEM_DEFS:178])) | (Modified record:C314([PON_ELEM_DEFS:178]))
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	ARRAY TEXT:C222($Fieldstoskip_atxt; 0)
	APPEND TO ARRAY:C911($Fieldstoskip_atxt; Field name:C257(->[PON_ELEM_DEFS:178]ELEM_KEY:1))
	APPEND TO ARRAY:C911($Fieldstoskip_atxt; Field name:C257(->[PON_ELEM_DEFS:178]PON_ELEM_DEFS_UUIDKey_s:23))
	C_BOOLEAN:C305($UseAddToSet_B)
	$UseAddToSet_B:=False:C215
	If (Is new record:C668([PON_ELEM_DEFS:178]))
		LogNewRecord(->[PON_ELEM_DEFS:178]ELEM_KEY:1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; 0; "PON_ELEM_DEFS")
		$UseAddToSet_B:=True:C214
		
	End if 
	[PON_ELEM_DEFS:178]ELEM_MODTIME:17:=ISODateTime(Current date:C33; Current time:C178)
	InitChangeStack(1)
	ACT_PushGroupChanges(Table:C252(->[PON_ELEM_DEFS:178]); 1; ->$Fieldstoskip_atxt)
	FlushGrpChgs(1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; ->[PON_ELEM_DEFS:178]ELEM_KEY:1; 0)
	SAVE RECORD:C53([PON_ELEM_DEFS:178])
	VALIDATE TRANSACTION:C240
	C_LONGINT:C283($key_L)
	$key_L:=[PON_ELEM_DEFS:178]ELEM_KEY:1
	If ($UseAddToSet_B)
		ADD TO SET:C119([PON_ELEM_DEFS:178]; "$BeforeAdd")
		USE SET:C118("$BeforeAdd")
	End if 
	
	ARRAY LONGINT:C221($allIDS_aL; 0)
	SELECTION TO ARRAY:C260([PON_ELEM_DEFS:178]ELEM_KEY:1; $allIDS_aL)
	
	LBRow_L:=Find in array:C230($allIDS_aL; $key_L)
	
	
End if 
//End PON_SaveDefsRecord   