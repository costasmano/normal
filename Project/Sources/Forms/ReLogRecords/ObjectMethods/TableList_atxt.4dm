//Method: Object Method: ReLogRecords.TableList_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/12, 13:52:17
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(10/28/13 15:17:29)
	Mods_2013_10
	//  `added initializing of RelationsFlushList_atxt
	// Modified by: Costas Manousakis-(Designer)-(2/13/14 09:28:32)
	Mods_2014_02_bug
	//  `clear records found var
	// Modified by: Costas Manousakis-(Designer)-(9/27/17 14:39:51)
	Mods_2017_09
	//  `don't mark UUID fields as unique or indexed
	// Modified by: Costas Manousakis-(Designer)-(7/15/21 17:01:50)
	Mods_2021_07
	//  `initialize the new form var "fieldsToLog" and label "LinkToField"
End if 
//
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		ON ERR CALL:C155("")
		C_LONGINT:C283($itemClick_L)
		$itemClick_L:=TableList_atxt
		If ($itemClick_L>0)
			//clear the form variable that holds field info and the link field)
			C_POINTER:C301($fieldobj_ptr)
			$fieldobj_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "fieldsToLog")
			$fieldobj_ptr->:=""
			OBJECT SET TITLE:C194(*; "LinkToField"; "")
			
			RELOG_TBLNum_L:=TableList_aL{$itemClick_L}
			RELOG_KeyField_L:=0
			Sequence_atxt:=0
			ParentTableList_atxt:=0
			ForeignKeyList_atxt:=0
			ARRAY TEXT:C222(ParentKeyList_atxt; 0)  //clear the parent table field list
			ParentKeyList_atxt:=0
			RelationsList_atxt:=0
			RelationsFlushList_atxt:=0
			RELOG_ParentTbl_L:=0
			RELOG_FK_L:=0
			RELOG_PK_L:=0
			RELOG_DELFIRST_L:=0
			RELOG_RecsFound_L:=0
			
			C_LONGINT:C283($numFields_L)
			$numFields_L:=Get last field number:C255(Table:C252(RELOG_TBLNum_L))
			ARRAY TEXT:C222(KeyFieldList_atxt; $numFields_L)
			C_LONGINT:C283($loop_L; $fldType_L; $FldLen_L; $oneTable; $oneField; $parent_L; $parentFld_L; $Foreignkey_L)
			C_BOOLEAN:C305($FldIndx_b; $FldUnique_b; $FldInvis_b)
			For ($loop_L; 1; Size of array:C274(KeyFieldList_atxt))
				If (Is field number valid:C1000(RELOG_TBLNum_L; $loop_L))
					GET FIELD PROPERTIES:C258(RELOG_TBLNum_L; $loop_L; $fldType_L; $FldLen_L; $FldIndx_b; $FldUnique_b; $FldInvis_b)
					GET RELATION PROPERTIES:C686(RELOG_TBLNum_L; $loop_L; $oneTable; $oneField)
					
					KeyFieldList_atxt{$loop_L}:=Field name:C257(RELOG_TBLNum_L; $loop_L)
					If (($fldType_L=Is alpha field:K8:1) & ($FldLen_L=0))
						//UUID field - skip it
						$FldUnique_b:=False:C215
						$FldIndx_b:=False:C215
						
					End if 
					If ($FldUnique_b)
						RELOG_KeyField_L:=$loop_L
						KeyFieldList_atxt{$loop_L}:=KeyFieldList_atxt{$loop_L}+"- U"
					End if 
					If ($FldIndx_b)
						KeyFieldList_atxt{$loop_L}:=KeyFieldList_atxt{$loop_L}+"- I"
					End if 
					If ($oneTable>0)
						//there is a relation from this field to a parent table
						$parent_L:=$oneTable
						$parentFld_L:=$oneField
						$Foreignkey_L:=$loop_L
						KeyFieldList_atxt{$loop_L}:=KeyFieldList_atxt{$loop_L}+"->["+Table name:C256($oneTable)+"]"+Field name:C257($oneTable; $oneField)
					End if 
				End if 
				
				If (RELOG_KeyField_L>0)
					KeyFieldList_atxt:=RELOG_KeyField_L
				End if 
				
			End for 
			
			COPY ARRAY:C226(KeyFieldList_atxt; ForeignKeyList_atxt)
			ForeignKeyList_atxt:=0
			
			If ($parent_L>0)
				RELOG_ParentTbl_L:=$parent_L
				RELOG_FK_L:=$Foreignkey_L
				ParentTableList_atxt:=Find in array:C230(ParentTableList_aL; RELOG_ParentTbl_L)
				ForeignKeyList_atxt:=$Foreignkey_L
				
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
				
				RELOG_PK_L:=$parentFld_L
				
				If (RELOG_PK_L>0)
					ParentKeyList_atxt:=RELOG_PK_L
				End if 
				
			End if 
			
		End if 
		
End case 

//End Object Method: ReLogRecords.TableList_atxt