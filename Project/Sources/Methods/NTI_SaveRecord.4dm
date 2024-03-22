//%attributes = {"invisible":true}
//Method: NTI_SaveRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/14/17, 17:02:03
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
End if 
//
If (Is new record:C668([NTI_ELEM_DEFS:182])) | (Modified record:C314([NTI_ELEM_DEFS:182]))
	ARRAY TEXT:C222($FieldsToSkip_atxt; 0)
	ARRAY TEXT:C222($Fieldstoskip_atxt; 0)
	APPEND TO ARRAY:C911($Fieldstoskip_atxt; Field name:C257(->[NTI_ELEM_DEFS:182]ELEM_KEY:4))
	APPEND TO ARRAY:C911($Fieldstoskip_atxt; Field name:C257(->[NTI_ELEM_DEFS:182]NTI_ELEM_DEFS_UUIDKey_s:20))
	C_BOOLEAN:C305($UseAddToSet_B)
	$UseAddToSet_B:=False:C215
	If (Is new record:C668([NTI_ELEM_DEFS:182]))
		LogNewRecord(->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0; "NTI_ELEM_DEFS")
		$UseAddToSet_B:=True:C214
		
	End if 
	[NTI_ELEM_DEFS:182]MODDATETIME:8:=ISODateTime(Current date:C33; Current time:C178)
	[NTI_ELEM_DEFS:182]MODUSER:9:=Current user:C182
	
	ACT_PushGroupChanges(Table:C252(->[NTI_ELEM_DEFS:182]); 1; ->$Fieldstoskip_atxt)
	FlushGrpChgs(1; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; ->[NTI_ELEM_DEFS:182]ELEM_KEY:4; 0)
	SAVE RECORD:C53([NTI_ELEM_DEFS:182])
	VALIDATE TRANSACTION:C240
	C_LONGINT:C283($key_L)
	$key_L:=[NTI_ELEM_DEFS:182]ELEM_KEY:4
	If ($UseAddToSet_B)
		ADD TO SET:C119([NTI_ELEM_DEFS:182]; "BeforeAdd")
		USE SET:C118("BeforeAdd")
	End if 
	ARRAY LONGINT:C221($allIDS_aL; 0)
	SELECTION TO ARRAY:C260([NTI_ELEM_DEFS:182]ELEM_KEY:4; $allIDS_aL)
	
	LBRow_L:=Find in array:C230($allIDS_aL; $key_L)
	
	
End if 
//End NTI_SaveRecord