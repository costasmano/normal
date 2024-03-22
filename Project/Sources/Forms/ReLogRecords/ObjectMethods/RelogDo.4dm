//Method: Object Method: "ReLogRecords".RelogDo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/15/12, 15:41:10
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(10/28/13 11:55:06)
	Mods_2013_10
	//  `Fixed bugs 
	//  `Check if entries for the record id are already in the fileidres table - for now don't do any logging for such records
	//  `Add messages about what was done
	//  `Allow blank sequence for RelationType = 0
	// Modified by: Costas Manousakis-(Designer)-(11/18/13 10:27:34)
	Mods_2013_11
	//  `added forward variable
	// Modified by: Costas Manousakis-(Designer)-(1/28/14 16:10:12)
	Mods_2014_01
	//  `Added option to created an NRC record or not
	// Modified by: Costas Manousakis-(Designer)-(2/12/14 17:40:04)
	Mods_2014_02_bug
	//  `fixed bugs with missing definition of key field numbers
	// Modified by: Costas Manousakis-(Designer)-(9/26/17 16:32:01)
	Mods_2017_09
	//  `do not show alert for [FileIDRes] problems if NRC record is not requested
	//  `also must create NRC if Log Deletion is checked
	//  //Added progress bar with quit option
	// Modified by: Costas Manousakis-(Designer)-(4/12/19 16:19:48)
	Mods_2019_04_bug
	//  `When the New Record relation and Flush relation are 0, leave the parentkey and foreiggn key as the main key field,
	//  `also include all other fields in the flushGrp except the key field. related to CallReference #628
	// Modified by: Costas Manousakis-(Designer)-(7/16/21 13:26:55)
	Mods_2021_07
	//  `adjusted logic of error checks so that they are shown all at the end, if any.
	//  `added use of Fields to log and link fields. If there are any link (LNK) fields exclude them from the logged.
	//  `if there is a Link-to field, create activity log LNK records.
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		C_LONGINT:C283($TableNum_L; $NumFields_L; $KeyFieldNum_L; $NewTransfer; $OldTRansfer; $i)
		C_TEXT:C284($FieldName_txt; $keyFieldName_txt)
		C_POINTER:C301($Tbl_ptr; $KeyField_ptr; $ParTblKey_ptr; $LocTblFK_ptr)
		C_BOOLEAN:C305($DelFirst_b; $logNRC_b)
		C_LONGINT:C283($RelCode; $FlushRelCode_L)
		C_TEXT:C284($CurrDest_txt; $FinalDest_txt; $NewRecSeq_txt; $CurrForward_txt; $FinalForward_txt)
		
		C_BOOLEAN:C305($DoIT_B)
		$DoIT_B:=True:C214
		C_TEXT:C284($Errors_txt)
		If (RELOG_TBLNum_L>0)
			$Tbl_ptr:=Table:C252(RELOG_TBLNum_L)
			$TableNum_L:=RELOG_TBLNum_L
			$NumFields_L:=Get last field number:C255(Table:C252($TableNum_L))
			ARRAY POINTER:C280($a_Ptr_Fields; $NumFields_L)
			RELOG_KeyField_L:=KeyFieldList_atxt
			For ($i; 1; $NumFields_L)
				$a_Ptr_Fields{$i}:=Field:C253($TableNum_L; $i)
			End for 
			If (RELOG_KeyField_L>0)
				$KeyField_ptr:=Field:C253(RELOG_TBLNum_L; RELOG_KeyField_L)
				C_LONGINT:C283($keyfieldtype; $keyfieldLen_L)
				C_BOOLEAN:C305($indexed; $unique)
				GET FIELD PROPERTIES:C258(RELOG_TBLNum_L; RELOG_KeyField_L; $keyfieldtype; $keyfieldLen_L; $indexed; $unique)
				//key field must be integer or longint or alpha and unique
				
				If (($keyfieldtype=Is integer:K8:5) | ($keyfieldtype=Is longint:K8:6) | ($keyfieldtype=Is alpha field:K8:1)) & $unique
					//OK
				Else 
					$Errors_txt:=$Errors_txt+"Selected master table key field "+Field name:C257($KeyField_ptr)+\
						" is type ["+fGetDataType($keyfieldtype)+"] and "+\
						Choose:C955($unique; "Unique"; "NOT Unique")+"!!!"+"\n"
				End if 
				
				$KeyFieldNum_L:=RELOG_KeyField_L
			Else 
				//ALERT("No Key Field in the Master Table selected!!!")
				$Errors_txt:=$Errors_txt+"No Key Field in the Master Table selected!!!"+"\n"
				//$DoIT_B:=False
			End if 
		Else 
			//ALERT("No Master Table selected!!!")
			$Errors_txt:=$Errors_txt+"No Master Table selected!!!"+"\n"
			//$DoIT_B:=False
		End if 
		
		//RELOG_ParentTbl_L:=ParentTableList_atxt
		RELOG_FK_L:=ForeignKeyList_atxt
		RELOG_PK_L:=ParentKeyList_atxt
		
		$indx_L:=RelationsList_atxt
		
		If ($indx_L>0)
			$RelCode:=Num:C11(RelationsList_atxt{$indx_L})
			
			If (($RelCode=0) & (RELOG_FK_L>0))
				//we cannot have 0 for Relation code when there is a relation defined
				//ALERT("New record Relation Code cannot be 0 when there is a parent table!")
				$Errors_txt:=$Errors_txt+"New record Relation Code cannot be 0 when there is a parent table!"+"\n"
				//$DoIT_B:=False
			End if 
			
		Else 
			//ALERT("No Relation Type for new record!!!")
			$Errors_txt:=$Errors_txt+"No Relation Type for new record!!!"+"\n"
			//$DoIT_B:=False
		End if 
		
		C_LONGINT:C283($indx_L)
		$indx_L:=Sequence_atxt
		
		If ($indx_L>0)
			$NewRecSeq_txt:=Sequence_atxt{$indx_L}
		Else 
			If ($RelCode>0)
				//ALERT("No Sequence specified for new record!!!")
				$Errors_txt:=$Errors_txt+"No Sequence specified for new record!!!"+"\n"
				//$DoIT_B:=False
			End if 
		End if 
		
		$indx_L:=RelationsFlushList_atxt
		If ($indx_L>0)
			$FlushRelCode_L:=Num:C11(RelationsFlushList_atxt{$indx_L})
			If (($FlushRelCode_L=0) & (RELOG_FK_L>0))
				//we cannot have 0 for Relation code when there is a relation defined
				//ALERT("Flush/Delete Relation Code cannot be 0 when there is a parent table!")
				$Errors_txt:=$Errors_txt+"Flush/Delete Relation Code cannot be 0 when there is a parent table!"+"\n"
				//$DoIT_B:=False
			End if 
		Else 
			//ALERT("No Flush Relation Type for new record!!!")
			$Errors_txt:=$Errors_txt+"No Flush Relation Type for new record!!!"+"\n"
			//$DoIT_B:=False
		End if 
		
		$FinalDest_txt:=RelogDestination_txt
		$FinalForward_txt:=RelogForward_txt
		$NewTransfer:=RelogTransfer_L
		$DelFirst_b:=(LogDelfirst_L=1)
		$logNRC_b:=(LogNewRecfirst_L=1)
		C_TEXT:C284(<>Destination)  // old C_STRING length 80
		$CurrDest_txt:=<>Destination
		<>Destination:=$FinalDest_txt
		$OldTRansfer:=<>Transfer
		<>Transfer:=$NewTransfer
		$CurrForward_txt:=vsForward
		vsForward:=$FinalForward_txt
		If (Type:C295(ptr_Changes)#Array 2D:K8:24)
			ARRAY POINTER:C280(ptr_Changes; 0; 0)
		End if 
		$ParTblKey_ptr:=$KeyField_ptr
		$LocTblFK_ptr:=$KeyField_ptr
		
		If ($FlushRelCode_L=0) & ($RelCode=0)
			//should not have parent table info when the relation = 0 
		Else 
			If (RELOG_ParentTbl_L>0) & (RELOG_FK_L>0) & (RELOG_PK_L>0)
				$ParTblKey_ptr:=Field:C253(RELOG_ParentTbl_L; RELOG_PK_L)
				$LocTblFK_ptr:=Field:C253(RELOG_TBLNum_L; RELOG_FK_L)
			Else 
				If (RELOG_ParentTbl_L>0)
					//ALERT("Must specify Foreign and Parent key fields when specifying a parent table!")
					$Errors_txt:=$Errors_txt+"Must specify Foreign and Parent key fields when specifying a parent table!"+"\n"
					//$DoIT_B:=False
				Else 
				End if 
				
			End if 
			
		End if 
		
		If ($DelFirst_b & Not:C34($logNRC_b))
			//ALERT("Cannot Log Deletion without Loging a New Record!")
			$Errors_txt:=$Errors_txt+"Cannot Log Deletion without Loging a New Record!"+"\n"
			//$DoIT_B:=False
		End if 
		
		If (Length:C16($Errors_txt)>0)
			ALERT:C41($Errors_txt)
			$DoIT_B:=False:C215
		Else 
			ARRAY LONGINT:C221($fieldsToLog_aL; 0)
			ARRAY LONGINT:C221($fieldsToLink_aL; 0)
			C_LONGINT:C283($LinkTable_L; $linkField_L)
			
			C_OBJECT:C1216($fielddata_o)
			C_POINTER:C301($fielddata_ptr)
			$fielddata_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "fieldsToLog")
			If ($fielddata_ptr->#"")
				$fielddata_o:=JSON Parse:C1218($fielddata_ptr->)
				//extract any data in there
				OB GET ARRAY:C1229($fielddata_o; "fieldstolog"; $fieldsToLog_aL)
				OB GET ARRAY:C1229($fielddata_o; "fieldstolink"; $fieldsToLink_aL)
				$LinkTable_L:=OB Get:C1224($fielddata_o; "linktable"; Is longint:K8:6)
				$linkField_L:=OB Get:C1224($fielddata_o; "linkfield"; Is longint:K8:6)
				
				Case of 
					: (Size of array:C274($fieldsToLink_aL)>0) & ($LinkTable_L>0) & ($linkField_L>0)
						//check if the link fields match the type of the linkto field
						C_LONGINT:C283($linkToFieldType_L; $LinkFieldType_L; $linktofieldLen_L; $linkFieldLen_L)
						C_LONGINT:C283($loop_L)
						GET FIELD PROPERTIES:C258($LinkTable_L; $linkField_L; $linkToFieldType_L; $linktofieldLen_L)
						For ($loop_L; 1; Size of array:C274($fieldsToLink_aL))
							GET FIELD PROPERTIES:C258(RELOG_TBLNum_L; $fieldsToLink_aL{$loop_L}; $LinkFieldType_L; $linkFieldLen_L)
							
							//allow links to intger fields, longints, or alpha
							Case of 
								: ($linkToFieldType_L=Is integer:K8:5)
									//allow longints to link to integer fields
									
									If ($LinkFieldType_L=Is integer:K8:5) | ($LinkFieldType_L=Is longint:K8:6)
										
									Else 
										$Errors_txt:=$Errors_txt+"Cannot link "+Field name:C257(RELOG_TBLNum_L; $fieldsToLink_aL{$loop_L})+" with type "+fGetDataType($LinkFieldType_L)+" to an integer field!"+"\n"
									End if 
									
								: ($linkToFieldType_L=Is longint:K8:6)
									
									If ($LinkFieldType_L#$linkToFieldType_L)
										$Errors_txt:=$Errors_txt+"Cannot link "+Field name:C257(RELOG_TBLNum_L; $fieldsToLink_aL{$loop_L})+\
											" with type "+fGetDataType($LinkFieldType_L)+" to  longint field"+"\n"
									End if 
									
								: ($linkToFieldType_L=Is alpha field:K8:1)
									//field lengths must also match
									
									If ($LinkFieldType_L=$linkToFieldType_L) & ($linkFieldLen_L=$linktofieldLen_L)
										//ok
									Else 
										$Errors_txt:=$Errors_txt+"Cannot link "+Field name:C257(RELOG_TBLNum_L; $fieldsToLink_aL{$loop_L})+\
											" with type "+fGetDataType($LinkFieldType_L)+" and length "+String:C10($linkFieldLen_L)+\
											" to alpha field with length "+String:C10($linktofieldLen_L)+"\n"
									End if 
									
							End case 
							
						End for   //end of link field loop
						
						If ($DoIT_B) & ($Errors_txt#"")
							ALERT:C41($Errors_txt)
							$DoIT_B:=False:C215
						End if 
						
					: (($LinkTable_L>0) & ($linkField_L=0)) | (($LinkTable_L=0) & ($linkField_L>0))
						//something is messed up
						ALERT:C41("Either the link-to table or the link-to field number is zero!")
						$DoIT_B:=False:C215
						
					: (Size of array:C274($fieldsToLink_aL)=0) & ($LinkTable_L>0) & ($linkField_L>0)
						CONFIRM:C162("Specified Link to field, without any fields to link. Continue or cancel?"; "Continue"; "Cancel")
						$DoIT_B:=(OK=1)
						
					: (Size of array:C274($fieldsToLink_aL)>0) & ($LinkTable_L=0) & ($linkField_L=0)
						G_MyConfirm("There are fields to link, but no field to link to!"+\
							" If you continue, these fields will be excluded from the activity log record."; "Continue"; "Cancel")
						$DoIT_B:=(OK=1)
						
				End case   //end case error checks
				
				//if there were fields to log selected use these instead of all
				If (Size of array:C274($fieldsToLog_aL)>0)
					$NumFields_L:=Size of array:C274($fieldsToLog_aL)
					ARRAY POINTER:C280($a_Ptr_Fields; $NumFields_L)
					For ($i; 1; $NumFields_L)
						$a_Ptr_Fields{$i}:=Field:C253($TableNum_L; $fieldsToLog_aL{$i})
					End for 
					
				End if 
				
			End if   //if no data if field obj 
			
		End if 
		
		If ($DoIT_B)
			If (Records in selection:C76($Tbl_ptr->)>0)
				CONFIRM:C162("Create Activity log entries for "+String:C10(Records in selection:C76($Tbl_ptr->))+" records in table "+Table name:C256($Tbl_ptr)+" ?")
				If (OK=1)
					
					//from the fields to be logged exclude the ones to be linked if there are any
					If (Size of array:C274($fieldsToLink_aL)>0)
						C_LONGINT:C283($loop_L; $indx_L)
						For ($loop_L; 1; Size of array:C274($fieldsToLink_aL))
							$indx_L:=Find in array:C230($a_Ptr_Fields; Field:C253($TableNum_L; $fieldsToLink_aL{$loop_L}))
							If ($indx_L>0)
								DELETE FROM ARRAY:C228($a_Ptr_Fields; $indx_L; 1)
							End if 
						End for 
						$NumFields_L:=Size of array:C274($a_Ptr_Fields)
					End if 
					
					READ ONLY:C145($Tbl_ptr->)
					FIRST RECORD:C50($Tbl_ptr->)
					C_LONGINT:C283($RecCounter_L; $Progress_L)
					$RecCounter_L:=0
					$Progress_L:=Progress New
					Progress SET TITLE($Progress_L; "Re Logging "+String:C10(Records in selection:C76($Tbl_ptr->))+" records in table "+Table name:C256($Tbl_ptr))
					Progress SET BUTTON ENABLED($Progress_L; True:C214)
					Progress SET PROGRESS($Progress_L; 0)
					While (Not:C34(End selection:C36($Tbl_ptr->)))
						//search in [fileidres] for entry with the current $KeyField_ptr in the local list
						C_TEXT:C284($tableResvalue_txt)
						$tableResvalue_txt:=""
						C_BOOLEAN:C305($doThisRecord_b)
						$doThisRecord_b:=True:C214
						Case of 
							: (Type:C295($KeyField_ptr->)=Is alpha field:K8:1)
								$tableResvalue_txt:=$KeyField_ptr->
							: (Type:C295($KeyField_ptr->)=Is integer:K8:5) | (Type:C295($KeyField_ptr->)=Is longint:K8:6)
								$tableResvalue_txt:=String:C10($KeyField_ptr->)
							Else 
								ALERT:C41("Type of key field : "+Field name:C257($KeyField_ptr)+" : "+fGetDataType(Type:C295($KeyField_ptr->))+" is not valid")
								$doThisRecord_b:=False:C215
						End case 
						C_LONGINT:C283($fileidresRecs_L)
						If ($tableResvalue_txt#"")
							SET QUERY DESTINATION:C396(Into variable:K19:4; $fileidresRecs_L)
							QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4=$FinalDest_txt; *)
							QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]File Number:1=$TableNum_L; *)
							QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Local ID:2=$tableResvalue_txt)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($fileidresRecs_L>0)
								C_TEXT:C284($msg_txt)
								$msg_txt:="There are records in the [FileIDRes Table] with the destination of "+$FinalDest_txt+" for table "+Table name:C256($TableNum_L)+" with localID "+$tableResvalue_txt
								
								If ($logNRC_b)
									$msg_txt:=$msg_txt+Char:C90(13)+"Cannot create NRC activity log entries for this record!!!"
									ALERT:C41($msg_txt)
								Else 
									$msg_txt:=$msg_txt+Char:C90(13)+"NRC activity log entry will not be created for this record!!!"
								End if 
								
								$doThisRecord_b:=False:C215 | Not:C34($logNRC_b)
							End if 
							
							SET QUERY DESTINATION:C396(Into variable:K19:4; $fileidresRecs_L)
							QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]Destination:4="HERE"; *)
							QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]File Number:1=$TableNum_L; *)
							QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination ID:3=$tableResvalue_txt)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($fileidresRecs_L>0)
								C_TEXT:C284($msg_txt)
								$msg_txt:="There are records in the [FileIDRes Table] with the destination of HERE for table "+Table name:C256($TableNum_L)+" with Destination ID "+$tableResvalue_txt
								If ($logNRC_b)
									$msg_txt:=$msg_txt+Char:C90(13)+"Cannot create NRC activity log entries for this record!!!"
									ALERT:C41($msg_txt)
								Else 
									$msg_txt:=$msg_txt+Char:C90(13)+"NRC activity log entry will not be created for this record!!!"
								End if 
								$doThisRecord_b:=False:C215 | Not:C34($logNRC_b)
							End if 
							
						End if 
						If ($doThisRecord_b)
							$RecCounter_L:=$RecCounter_L+1
							If ($DelFirst_b)
								LogDeletion($ParTblKey_ptr; $LocTblFK_ptr; $KeyField_ptr; $FlushRelCode_L)
							End if 
							If ($logNRC_b)
								LogNewRecord($ParTblKey_ptr; $LocTblFK_ptr; $KeyField_ptr; $RelCode; $NewRecSeq_txt)
							End if 
							InitChangeStack(1)
							For ($i; 1; $NumFields_L)
								
								If ($FlushRelCode_L=0)
									//if relation code is 0 include all fields except the key field
									If ($a_Ptr_Fields{$i}#Field:C253($TableNum_L; $KeyFieldNum_L))
										PushChange(1; $a_Ptr_Fields{$i})
									End if 
								Else 
									//for other relations must exclude the foreign key field
									If (($a_Ptr_Fields{$i}#Field:C253($TableNum_L; $KeyFieldNum_L)) & ($a_Ptr_Fields{$i}#Field:C253($TableNum_L; RELOG_FK_L)))
										PushChange(1; $a_Ptr_Fields{$i})
									End if 
								End if 
								//If (($i#$KeyFieldNum_L) & ($i#RELOG_FK_L))
								//PushChange (1;$a_Ptr_Fields{$i})
								//End if 
							End for 
							FlushGrpChgs(1; $ParTblKey_ptr; $LocTblFK_ptr; $KeyField_ptr; $FlushRelCode_L)
							
							//check if we have to do link records
							If ((Size of array:C274($fieldsToLink_aL)>0) & ($LinkTable_L>0))
								C_LONGINT:C283($loop_L; $linkToType_L)
								C_POINTER:C301($field_ptr)
								GET FIELD PROPERTIES:C258($LinkTable_L; $linkField_L; $linkToType_L)
								For ($loop_L; 1; Size of array:C274($fieldsToLink_aL))
									$field_ptr:=Field:C253($TableNum_L; $fieldsToLink_aL{$loop_L})
									//create LNK records only for non-zero or non-blank fields
									Case of 
										: ($linkToType_L=Is integer:K8:5) | ($linkToType_L=Is longint:K8:6)
											If ($field_ptr->#0)
												LogLink(Field:C253($TableNum_L; $fieldsToLink_aL{$loop_L}); $ParTblKey_ptr; $LocTblFK_ptr; $KeyField_ptr; $FlushRelCode_L; Field:C253($LinkTable_L; $linkField_L))
											End if 
										: ($linkToType_L=Is alpha field:K8:1)
											If ($field_ptr->#"")
												LogLink(Field:C253($TableNum_L; $fieldsToLink_aL{$loop_L}); $ParTblKey_ptr; $LocTblFK_ptr; $KeyField_ptr; $FlushRelCode_L; Field:C253($LinkTable_L; $linkField_L))
											End if 
									End case 
									
								End for 
							End if 
						End if 
						Progress SET PROGRESS($Progress_L; (Selected record number:C246($Tbl_ptr->)/Records in selection:C76($Tbl_ptr->)))
						Progress SET MESSAGE($Progress_L; String:C10(Selected record number:C246($Tbl_ptr->))+" of "+String:C10(Records in selection:C76($Tbl_ptr->)))
						If (Progress Stopped($Progress_L))
							LAST RECORD:C200($Tbl_ptr->)
						End if 
						NEXT RECORD:C51($Tbl_ptr->)
					End while 
					ALERT:C41("Created Activity log entries for "+String:C10($RecCounter_L)+" records in table "+Table name:C256($Tbl_ptr))
				End if 
				
				Progress QUIT($progress_L)
				
			Else 
				ALERT:C41("No Records found in table ["+Table name:C256($Tbl_ptr)+"]")
			End if 
			
		End if 
		
		<>Destination:=$CurrDest_txt
		<>Transfer:=$OldTRansfer
		vsForward:=$CurrForward_txt
		
End case 

//End Object Method: "ReLogRecords".RelogDo