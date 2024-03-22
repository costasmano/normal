//%attributes = {"invisible":true}
//Method: utl_ImportTOLRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 05/23/13, 16:42:14
	//----------------------------------------------------
	Mods_2013_05  //r003 ` 
	//Modified by: Charles Miller (5/23/13 16:42:39)
	// Modified by: Costas Manousakis-(Designer)-(8/23/13 14:40:48)
	Mods_2013_08
	//  `if list is a new list - add the records and increase the local key sequence ; 
	//  `added transaction and option to cancel the import of a list  if some entries in the import file do not match
	// Modified by: Costas Manousakis-(Designer)-(5/11/16 17:15:55)
	Mods_2016_05_bug
	//  `Added check for OK =- 1 after select folder
	
End if 

vsForward:=<>Forward
C_TEXT:C284($FilePath_txt; $Value_txt; $Sequence_txt; $ListName_txt; $Path_txt)

C_LONGINT:C283($Loop_l; $InnerLoop_L)
$Path_txt:=Select folder:C670("Select import path for [TableOfLists]")

If (OK=1)
	
	ARRAY TEXT:C222($FileNames_atxt; 0)
	
	DOCUMENT LIST:C474($Path_txt; $FileNames_atxt)
	C_BOOLEAN:C305($Complete_b)
	C_TIME:C306($Doc_tm)
	C_LONGINT:C283($Offset_L; $ImportedLists_L)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
	$ImportedLists_L:=0
	C_BLOB:C604($Blob_blb)
	For ($Loop_l; 1; Size of array:C274($FileNames_atxt))
		$ListName_txt:=Replace string:C233($FileNames_atxt{$Loop_l}; ".txt"; "")
		$FilePath_txt:=$FileNames_atxt{$Loop_l}
		
		If ($FilePath_txt[[1]]=".")
		Else 
			SET BLOB SIZE:C606($Blob_blb; 0)
			$Offset_L:=0
			ARRAY LONGINT:C221($ListKeys_al; 0)
			ARRAY LONGINT:C221($ListSequence_al; 0)
			ARRAY TEXT:C222($ListValue_atxt; 0)
			
			DOCUMENT TO BLOB:C525($Path_txt+$FileNames_atxt{$Loop_l}; $Blob_blb)
			BLOB TO VARIABLE:C533($Blob_blb; $ListKeys_al; $Offset_L)
			BLOB TO VARIABLE:C533($Blob_blb; $ListSequence_al; $Offset_L)
			BLOB TO VARIABLE:C533($Blob_blb; $ListValue_atxt; $Offset_L)
			
			C_BOOLEAN:C305($NewList_b; $UpdateList_b; $CompleteUpdate_b)
			$NewList_b:=False:C215
			$UpdateList_b:=False:C215
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=$ListName_txt)
			
			If (Records in selection:C76([TableOfLists:125])=0)
				//New List - keys will be ignored
				CONFIRM:C162("ListName "+$ListName_txt+" not found! New entries will be created ignoring keys in export file!"; "Proceed"; "Cancel import")
				$NewList_b:=(OK=1)
			Else 
				CONFIRM:C162("ListName "+$ListName_txt+" will be updated! Keys in export file will be used for update; If key is not found a new key will be generated!"; "Proceed"; "Cancel import")
				$UpdateList_b:=(OK=1)
			End if 
			If ($NewList_b | $UpdateList_b)
				$CompleteUpdate_b:=True:C214
				START TRANSACTION:C239
				For ($InnerLoop_L; 1; Size of array:C274($ListKeys_al))
					InitChangeStack(1)
					
					If ($NewList_b)
						CREATE RECORD:C68([TableOfLists:125])
						Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
						[TableOfLists:125]ListName_s:1:=$ListName_txt
						LogNewRecord(->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0; "TableOfLists")
						[TableOfLists:125]ListSequence_l:3:=$ListSequence_al{$InnerLoop_L}
						[TableOfLists:125]ListValue_s:2:=$ListValue_atxt{$InnerLoop_L}
						PushChange(1; ->[TableOfLists:125]ListName_s:1)
						PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
						PushChange(1; ->[TableOfLists:125]ListValue_s:2)
						FlushGrpChgs(1; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
						SAVE RECORD:C53([TableOfLists:125])
						
					Else 
						QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListKeyID_L:4=$ListKeys_al{$InnerLoop_L})
						If (Records in selection:C76([TableOfLists:125])=0)
							CREATE RECORD:C68([TableOfLists:125])
							Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
							[TableOfLists:125]ListName_s:1:=$ListName_txt
							LogNewRecord(->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0; "TableOfLists")
							[TableOfLists:125]ListSequence_l:3:=$ListSequence_al{$InnerLoop_L}
							[TableOfLists:125]ListValue_s:2:=$ListValue_atxt{$InnerLoop_L}
							PushChange(1; ->[TableOfLists:125]ListName_s:1)
							PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
							PushChange(1; ->[TableOfLists:125]ListValue_s:2)
							FlushGrpChgs(1; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
							SAVE RECORD:C53([TableOfLists:125])
						Else 
							If (ut_LoadRecord(->[TableOfLists:125]))
								If ([TableOfLists:125]ListName_s:1#$ListName_txt)
									CONFIRM:C162("Import key "+String:C10($ListKeys_al{$InnerLoop_L})+" for list "+$ListName_txt+" [value='"+$ListValue_atxt{$InnerLoop_L}+"'] is part of local list "+[TableOfLists:125]ListName_s:1; "Ignore this key"; "Abort list import")
									//ALERT("You are trying to change from [TableOfLists]ListName_s "+[TableOfLists]ListName_s+" to $ListName_txt "+$ListName_txt)
									
									If (OK#1)
										$CompleteUpdate_b:=False:C215
										$InnerLoop_L:=Size of array:C274($ListKeys_al)+1
									End if 
									
								Else 
									C_BOOLEAN:C305($Flush_b)
									$Flush_b:=False:C215
									If ([TableOfLists:125]ListSequence_l:3#$ListSequence_al{$InnerLoop_L})
										[TableOfLists:125]ListSequence_l:3:=$ListSequence_al{$InnerLoop_L}
										PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
										$Flush_b:=True:C214
									End if 
									If ([TableOfLists:125]ListValue_s:2#$ListValue_atxt{$InnerLoop_L})
										[TableOfLists:125]ListValue_s:2:=$ListValue_atxt{$InnerLoop_L}
										PushChange(1; ->[TableOfLists:125]ListValue_s:2)
										$Flush_b:=True:C214
									End if 
									If ($Flush_b)
										SAVE RECORD:C53([TableOfLists:125])
										FlushGrpChgs(1; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
									End if 
									
								End if 
								
							End if 
							UNLOAD RECORD:C212([TableOfLists:125])
						End if 
					End if 
					
				End for 
				
				If ($CompleteUpdate_b)
					VALIDATE TRANSACTION:C240
					$ImportedLists_L:=$ImportedLists_L+1
				Else 
					CANCEL TRANSACTION:C241
				End if 
				
			End if 
		End if 
	End for 
	
	ALERT:C41("Import Completed! : "+String:C10($ImportedLists_L)+" lists imported!")
End if 

//End utl_ImportTOLRecords