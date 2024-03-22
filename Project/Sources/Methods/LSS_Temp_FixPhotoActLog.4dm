//%attributes = {"invisible":true}
//Method: LSS_Temp_FixPhotoActLog
//Description
// fix errors in activity log of entries for LSS_photos
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/16, 15:54:09
	// ----------------------------------------------------
	//Created : 
	Mods_2016_02_bug
End if 
//

If (User in group:C338(Current user:C182; "Design Access Group"))
	QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0; *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[LSS_Photos:166]); *)
	QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15#"")
	C_LONGINT:C283($numLogRecs_L; $maxRef_L; $minRef_L)
	C_DATE:C307($startDate_d; $lastDate_d)
	$numLogRecs_L:=Records in selection:C76([Activity Log:59])
	ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28)
	FIRST RECORD:C50([Activity Log:59])
	$minRef_L:=[Activity Log:59]RefID:28
	$startDate_d:=[Activity Log:59]dDate:5
	LAST RECORD:C200([Activity Log:59])
	$maxRef_L:=[Activity Log:59]RefID:28
	$startDate_d:=[Activity Log:59]dDate:5
	C_TEXT:C284($msg_txt)
	$msg_txt:="Found "+String:C10($numLogRecs_L)+" Act Log records; Starting RefD "+String:C10($minRef_L)+"on "+String:C10($startDate_d)+" Ending Ref ID "+String:C10($maxRef_L)+" on "+String:C10($startDate_d)
	ALERT:C41($msg_txt)
	C_LONGINT:C283($limitRefID_L)
	C_TEXT:C284($LimRequest_txt)
	$limitRefID_L:=($minRef_L+$maxRef_L)/2  // start with id half way between two
	$LimRequest_txt:=Request:C163("Limit RefID to "+String:C10($limitRefID_L); String:C10($limitRefID_L))
	If (OK=1)
		If ((Num:C11($LimRequest_txt)>=$minRef_L) & (Num:C11($LimRequest_txt)<=$maxRef_L))
			QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]RefID:28<=Num:C11($LimRequest_txt))
			$numLogRecs_L:=Records in selection:C76([Activity Log:59])
			ORDER BY:C49([Activity Log:59]; [Activity Log:59]RefID:28)
			FIRST RECORD:C50([Activity Log:59])
			$minRef_L:=[Activity Log:59]RefID:28
			$startDate_d:=[Activity Log:59]dDate:5
			LAST RECORD:C200([Activity Log:59])
			$maxRef_L:=[Activity Log:59]RefID:28
			$startDate_d:=[Activity Log:59]dDate:5
			C_TEXT:C284($msg_txt)
			$msg_txt:="Found "+String:C10($numLogRecs_L)+" Act Log records; Starting RefD "+String:C10($minRef_L)+"on "+String:C10($startDate_d)+" Ending Ref ID "+String:C10($maxRef_L)+" on "+String:C10($startDate_d)
			CONFIRM:C162($msg_txt+"! Proceed?")
			If (OK=1)
				ARRAY TEXT:C222($photoIDs_atxt; 0)
				DISTINCT VALUES:C339([Activity Log:59]Local ID:15; $photoIDs_atxt)
				C_LONGINT:C283($loop_L)
				C_BOOLEAN:C305($skipThis_b; $Relog_b)
				If (Type:C295(ptr_Changes)#Array 2D:K8:24)
					ARRAY POINTER:C280(ptr_Changes; 0; 0)
				End if 
				C_POINTER:C301($KeyField_ptr)
				C_LONGINT:C283($TableNum_L; $NumFields_L; $i; $KeyFieldNum_L)
				$KeyField_ptr:=->[LSS_Photos:166]LSS_PhotoId_s:1
				$KeyFieldNum_L:=Field:C253(->[LSS_Photos:166]LSS_PhotoId_s:1)
				$TableNum_L:=Table:C252(->[LSS_Photos:166])
				$NumFields_L:=Get last field number:C255(Table:C252($TableNum_L))
				ARRAY LONGINT:C221($FieldNumbers_aL; 0)
				For ($i; 1; $NumFields_L)
					If (Is field number valid:C1000($TableNum_L; $i))
						APPEND TO ARRAY:C911($FieldNumbers_aL; $i)
					End if 
				End for 
				$NumFields_L:=Size of array:C274($FieldNumbers_aL)
				
				READ WRITE:C146([Activity Log:59])
				For ($loop_L; 1; Size of array:C274($photoIDs_atxt))
					QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=0; *)
					QUERY:C277([Activity Log:59];  & ; [Activity Log:59]FileID Local:24=Table:C252(->[LSS_Photos:166]); *)
					QUERY:C277([Activity Log:59];  & ; [Activity Log:59]Local ID:15=$photoIDs_atxt{$loop_L})
					$skipThis_b:=False:C215
					$Relog_b:=True:C214
					Repeat 
						
						APPLY TO SELECTION:C70([Activity Log:59]; [Activity Log:59]Status:9:=-980)  // code for this fix
						If (Records in set:C195("LockedSet")#0)
							USE SET:C118("LockedSet")
							CONFIRM:C162("Trying ACT LOG Status = -980 again for Photo ID "+$photoIDs_atxt{$loop_L}; "Keep trying"; "Skip")
							If (OK=0)
								$skipThis_b:=True:C214
							End if 
						End if 
					Until ((Records in set:C195("LockedSet")=0) | $skipThis_b)
					//if we skip see if we want to re_log
					If ($skipThis_b)
						CONFIRM:C162("Re Log photo record "+$photoIDs_atxt{$loop_L}+" ?"; "Re Log"; "Later")
						$Relog_b:=(OK=1)
					End if 
					If ($Relog_b)
						READ WRITE:C146([LSS_Photos:166])
						QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoId_s:1=$photoIDs_atxt{$loop_L})
						
						If (Records in selection:C76([LSS_Photos:166])=1)
							If (ut_LoadRecordInteractive(->[LSS_Photos:166]))
								//loading it to prevent 
								LogNewRecord($KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0; "LSS_PhotoId_s")
								InitChangeStack(1)
								For ($i; 1; $NumFields_L)
									If ($FieldNumbers_aL{$i}#$KeyFieldNum_L)
										PushChange(1; Field:C253($TableNum_L; $FieldNumbers_aL{$i}))
									End if 
								End for 
								FlushGrpChgs(1; $KeyField_ptr; $KeyField_ptr; $KeyField_ptr; 0)
								UNLOAD RECORD:C212([LSS_Photos:166])
							End if 
							
						End if 
						READ ONLY:C145([LSS_Photos:166])
						
					End if 
					
				End for 
				
			End if 
			
		End if 
		
	End if 
	
End if 
//End LSS_Temp_FixPhotoActLog