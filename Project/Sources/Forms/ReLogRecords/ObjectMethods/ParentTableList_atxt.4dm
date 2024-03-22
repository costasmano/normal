//Method: Object Method: ReLogRecords.ParentTableList_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/12, 14:17:18
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/27/17 14:39:51)
	Mods_2017_09
	//  `don't mark UUID fields as unique or indexed
	
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($itemClick_L)
		$itemClick_L:=ParentTableList_atxt
		
		If ($itemClick_L>0)
			RELOG_ParentTbl_L:=ParentTableList_aL{$itemClick_L}
			C_LONGINT:C283($numFields_L)
			$numFields_L:=Get last field number:C255(Table:C252(RELOG_ParentTbl_L))
			ARRAY TEXT:C222(ParentKeyList_atxt; $numFields_L)
			C_LONGINT:C283($loop_L; $fldType_L; $FldLen_L)
			C_BOOLEAN:C305($FldIndx_b; $FldUnique_b; $FldInvis_b)
			For ($loop_L; 1; Size of array:C274(ParentKeyList_atxt))
				GET FIELD PROPERTIES:C258(RELOG_ParentTbl_L; $loop_L; $fldType_L; $FldLen_L; $FldIndx_b; $FldUnique_b; $FldInvis_b)
				ParentKeyList_atxt{$loop_L}:=Field name:C257(RELOG_ParentTbl_L; $loop_L)
				If (($fldType_L=Is alpha field:K8:1) & ($FldLen_L=0))
					//UUID field - skip it
					$FldUnique_b:=False:C215
					$FldIndx_b:=False:C215
				End if 
				If ($FldUnique_b)
					RELOG_PK_L:=$loop_L
					ParentKeyList_atxt{$loop_L}:=ParentKeyList_atxt{$loop_L}+"- U"
				End if 
				If ($FldIndx_b)
					ParentKeyList_atxt{$loop_L}:=ParentKeyList_atxt{$loop_L}+"- I"
				End if 
				
			End for 
			
			If (RELOG_PK_L>0)
				ParentKeyList_atxt:=RELOG_PK_L
			End if 
			
			//COPY ARRAY(KeyFieldList_atxt;ForeignKeyList_atxt)
			//ForeignKeyList_atxt:=0
			
		End if 
		
End case 

//End Object Method: ReLogRecords.ParentTableList_atxt