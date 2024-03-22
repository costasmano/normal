//Method: "ReLogRecords".ForeignKeyList_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/04/17, 17:29:46
	// ----------------------------------------------------
	//Created : 
	Mods_2017_10
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($itemClick_L; $oneTable; $oneField; $numFields_L)
		$itemClick_L:=ForeignKeyList_atxt
		
		If ($itemClick_L>0)
			RELOG_FK_L:=ForeignKeyList_atxt
			GET RELATION PROPERTIES:C686(RELOG_TBLNum_L; RELOG_FK_L; $oneTable; $oneField)
			If ($oneTable>0)
				RELOG_ParentTbl_L:=$oneTable
				ParentTableList_atxt:=Find in array:C230(ParentTableList_aL; RELOG_ParentTbl_L)
				
				//need to build the array for the fields of the parent table
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
						ParentKeyList_atxt{$loop_L}:=ParentKeyList_atxt{$loop_L}+"- U"
					End if 
					If ($FldIndx_b)
						ParentKeyList_atxt{$loop_L}:=ParentKeyList_atxt{$loop_L}+"- I"
					End if 
					
				End for 
				
				RELOG_PK_L:=$oneField
				
				If (RELOG_PK_L>0)
					ParentKeyList_atxt:=RELOG_PK_L
				End if 
				
			Else 
				ALERT:C41("Selected Field does not have a relation to another table!!!")
				RELOG_PK_L:=0
				RELOG_ParentTbl_L:=0
				ParentTableList_atxt:=0
				ARRAY TEXT:C222(ParentKeyList_atxt; 0)
			End if 
		End if 
		
End case 

//End ReLogRecords.ForeignKeyList_atxt