
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 04/29/14, 16:51:12
//----------------------------------------------------
//Method: Object Method: [LSS_Photos].Input.LSS_PhotoTypes_atxt 
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 15:47:46)
	// Modified by: Costas Manousakis-(Designer)-(9/14/15 12:29:40)
	Mods_2015_09_bug
	//  `if user click on blank line  reset pulldown to the field value.
End if 

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (LSS_PhotoTypes_atxt>1)
				If (Is new record:C668([LSS_Photos:166]))
					[LSS_Photos:166]LSS_PhotoType_s:3:=LSS_PhotoTypes_atxt{LSS_PhotoTypes_atxt}
					C_TEXT:C284($Type_txt; $Key_s)
					C_LONGINT:C283($Sequence_L)
					//C_STRING(13;$Key_s)
					$Key_s:=[LSS_Inspection:164]LSS_InspectionId_s:1
					$Type_txt:=[LSS_Photos:166]LSS_PhotoType_s:3
					Begin SQL
						select max([LSS_Photos].[LSS_PhotoSequence_L])
						from [LSS_Photos]
						where [LSS_Photos].[LSS_InspectionId_s] = :$Key_s
						and
						[LSS_Photos].[LSS_PhotoType_s]=:$Type_txt
						into :$Sequence_L
					End SQL
					[LSS_Photos:166]LSS_PhotoSequence_L:6:=$Sequence_L+1
				Else 
					If ([LSS_Photos:166]LSS_PhotoType_s:3#LSS_PhotoTypes_atxt{LSS_PhotoTypes_atxt})
						[LSS_Photos:166]LSS_PhotoType_s:3:=LSS_PhotoTypes_atxt{LSS_PhotoTypes_atxt}
						C_LONGINT:C283($Loc_L)
						$Loc_L:=Find in array:C230(v_166_001_atxt; [LSS_Photos:166]LSS_PhotoId_s:1)
						If ($Loc_L>0)
							v_166_003_atxt{$Loc_L}:=[LSS_Photos:166]LSS_PhotoType_s:3
						End if 
						LSS_PhotoUpdateSeq_b:=True:C214
					End if 
					
				End if 
			: (LSS_PhotoTypes_atxt=1)
				//picked blank. --- reset to field value if any
				If ([LSS_Photos:166]LSS_PhotoType_s:3#"")
					LSS_PhotoTypes_atxt:=Find in array:C230(LSS_PhotoTypes_atxt; [LSS_Photos:166]LSS_PhotoType_s:3)
				End if 
			Else 
				
		End case 
End case 
//End Object Method: [LSS_Inventory].New_InventoryItem.LSS_StructureClass_atxt