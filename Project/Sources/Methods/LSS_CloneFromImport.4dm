//%attributes = {"invisible":true}
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 11/13/14, 14:27:12
	// ----------------------------------------------------
	// Method: LSS_CloneFromImport
	// Description
	// 
	
	//146.243.135.150:26902
	// Parameters
	// ----------------------------------------------------
	// Modified by: Costas Manousakis-(Designer)-(3/4/16 12:25:59)
	Mods_2016_03_bug
	//  `fix in the SQL to get counts - need to  use  process var
	Mods_2017_11_bug
	//Added code to use new progress and to handle uuid fields
	//Modified by: Chuck Miller (11/2/17 15:07:33)
	
End if 
C_BLOB:C604(BlobHoldUpdates_blb)

ARRAY TEXT:C222(SQL_LimitNames_atxt; 0)
ARRAY LONGINT:C221(SQL_Limits_AL; 0)
C_BOOLEAN:C305($HasPicture_b)
Compiler_clone
Compiler_forSQL
C_LONGINT:C283($Loop_L; Count_L; $Size_L; $Limit_L; $TableNumber_l; $UniqueFldNumber_l; $Interval; $State_L; $Time_L)
C_TEXT:C284($SelectFields_txt; $UpdateFields_txt; $Variable_txt; $Name_txt; $Name1_txt)
C_POINTER:C301($Table_ptr)

ARRAY TEXT:C222(clone_TablesWithUniqueKey_atxt; 0)
ARRAY POINTER:C280(clone_UniqueKeys_aptr; 0)
ARRAY POINTER:C280(clone_Array_aptr; 0)
ARRAY POINTER:C280(clone_Table_aPtr; 0)
ARRAY BOOLEAN:C223($HasPictureOrBlob_ab; 0)

For ($TableNumber_l; 1; Get last table number:C254)
	If (Is table number valid:C999($TableNumber_l))
		$HasPicture_b:=clone_ReturnUniqueKeys($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; True:C214)
		If ($UniqueFldNumber_l>0)
			APPEND TO ARRAY:C911(clone_Table_aPtr; Table:C252($TableNumber_l))
			APPEND TO ARRAY:C911(clone_TablesWithUniqueKey_atxt; Table name:C256($TableNumber_l))
			APPEND TO ARRAY:C911(clone_UniqueKeys_aptr; Field:C253($TableNumber_l; $UniqueFldNumber_l))
			APPEND TO ARRAY:C911(clone_Array_aptr; Get pointer:C304($Variable_txt))
			APPEND TO ARRAY:C911($HasPictureOrBlob_ab; $HasPicture_b)
		End if 
	End if 
End for 


//C_BLOB(BlobHoldUpdates_blb)
//SET BLOB SIZE(BlobHoldUpdates_blb;0)

C_TEXT:C284($IPAddress_txt; $TableName_txt; SQLCount_txt; SQL_txt)
C_BOOLEAN:C305(4DError_b; SQLError_b)
4DError_b:=False:C215
SQLError_b:=False:C215

$IPAddress_txt:=SQL_TestConnection
If ($IPAddress_txt#"")
	ut_SQLConnect("Designer"; "caesar"; $IPAddress_txt)
	If (SQLConnectionMade_b)
		ARRAY TEXT:C222(ProcessTableNames_atxt; 0)
		ARRAY LONGINT:C221(ProcessTableNumber_al; 0)
		ARRAY LONGINT:C221($RecordCount_AL; 0)
		C_POINTER:C301($Table_ptr)
		C_LONGINT:C283($RecordCount_L)
		
		$Size_L:=0
		For ($Loop_L; 1; Get last table number:C254)
			If (Is table number valid:C999($Loop_L))
				If (Position:C15("LSS"; Table name:C256($Loop_L))>0)
					$Table_ptr:=Table:C252($Loop_L)
					$RecordCount_L:=Records in table:C83($Table_ptr->)
					
					Case of 
						: (Table name:C256($Loop_L)="LSS_AccessibilityElement") & ($RecordCount_L>0)
						: (Table name:C256($Loop_L)="LSS_refInspectionType") & ($RecordCount_L>0)
						: (Table name:C256($Loop_L)="LSS_refRouteDirection") & ($RecordCount_L>0)
						: (Table name:C256($Loop_L)="LSS_refStructureCoating") & ($RecordCount_L>0)
						: (Table name:C256($Loop_L)="LSS_refStructureMaterial") & ($RecordCount_L>0)
						: (Table name:C256($Loop_L)="LSS_refStructureTypes") & ($RecordCount_L>0)
						: (Table name:C256($Loop_L)="LSS_Element") & ($RecordCount_L>0)
						Else 
							$Size_L:=$Size_L+1
							Compiler_FieldVariables($Loop_L)
							APPEND TO ARRAY:C911(ProcessTableNames_atxt; Table name:C256($Loop_L))
							APPEND TO ARRAY:C911(ProcessTableNumber_al; $Loop_L)
							SQLCount_txt:="SELECT Count(*) FROM ["+ProcessTableNames_atxt{$Size_L}+"] INTO :Count_L; "+Char:C90(Carriage return:K15:38)
							Begin SQL
								EXECUTE IMMEDIATE :SQLCount_txt;
							End SQL
							APPEND TO ARRAY:C911(SQL_LimitNames_atxt; ProcessTableNames_atxt{$Size_L})
							
							APPEND TO ARRAY:C911($RecordCount_AL; Count_L)
							
							If (Count_L<5000)
								APPEND TO ARRAY:C911(SQL_Limits_AL; Count_L)
							Else 
								$Limit_L:=Round:C94((Count_L/3); 0)
								
								If ($Limit_L<1000)
									$Limit_L:=1000
								End if 
								APPEND TO ARRAY:C911(SQL_Limits_AL; $Limit_L)
							End if 
							
							
					End case 
				End if 
			End if 
		End for 
		C_LONGINT:C283($TeamMemberLoop_L; $Position_L; $TmMem_L; $InspectionLoop_L)
		ARRAY TEXT:C222($LocalTeamMemberIDs_atxt; 0)
		ARRAY TEXT:C222($RemoteTeamMemberIDs_atxt; 0)
		$TeamMemberLoop_L:=Table:C252(->[Personnel:42])
		C_BLOB:C604($TeamMemberErrors_blb)
		SET BLOB SIZE:C606($TeamMemberErrors_blb; 0)
		
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TeamMemberLoop_L; *)
		QUERY:C277([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="here")
		SELECTION RANGE TO ARRAY:C368(1; Records in selection:C76([FileIDRes Table:60]); [FileIDRes Table:60]Destination ID:3; $LocalTeamMemberIDs_atxt; [FileIDRes Table:60]Local ID:2; $RemoteTeamMemberIDs_atxt)
		ARRAY TEXT:C222($InspectionsToUpdate_atxt; 0)
		C_LONGINT:C283($Progress_L)
		
		$Progress_L:=Progress New
		
		
		For ($loop_l; 1; Size of array:C274(ProcessTableNames_atxt))
			Progress SET TITLE($Progress_L; "Retrieving records for table "+ProcessTableNames_atxt{$Loop_L})
			
			Progress SET PROGRESS($Progress_L; $loop_l/Size of array:C274(ProcessTableNames_atxt))
			ON ERR CALL:C155("4D_Errors")
			LSS_CloneSetUpSelectInto(ProcessTableNumber_al{$Loop_L}; ->$SelectFields_txt; ->$UpdateFields_txt; True:C214)
			//SQL_SetSelectInto ($TableNumber_l;->$SelectFields_txt;->$UpdateFields_txt)
			$UpdateFields_txt:=$UpdateFields_txt+";"
			
			Offset_l:=0
			SQL_txt:="SELECT "+$SelectFields_txt+" FROM ["+ProcessTableNames_atxt{$Loop_L}+"] LIMIT "+String:C10(SQL_Limit_L)+"  OFFSET :Offset_l INTO "+$UpdateFields_txt
			
			Repeat 
				
				clone_ClearFieldVariables(ProcessTableNumber_al{$Loop_L})
				ON ERR CALL:C155("SQL_Error")
				Begin SQL
					EXECUTE IMMEDIATE :SQL_txt;
				End SQL
				If (Not:C34(4DError_b)) & (Not:C34(SQLError_b))
					ON ERR CALL:C155("4D_Errors")
					$Table_ptr:=Table:C252(ProcessTableNumber_al{$Loop_L})
					REDUCE SELECTION:C351($Table_ptr->; 0)
					
					
					If (ProcessTableNames_atxt{$loop_l}="LSS_TeamMembers") & (Records in table:C83([FileIDRes Table:60])#0)  //External server we need to process each record individually
						For ($TeamMemberLoop_L; 1; Size of array:C274(v_173_001_atxt))
							$Position_L:=Find in array:C230($RemoteTeamMemberIDs_atxt; String:C10(v_173_002_aL{$TeamMemberLoop_L}))
							
							If ($Position_L>0)
								$TmMem_L:=Num:C11($LocalTeamMemberIDs_atxt{$Position_L})
							Else 
								$TmMem_L:=v_173_002_aL{$TeamMemberLoop_L}
							End if 
							
							QUERY:C277([LSS_TeamMembers:173]; [LSS_TeamMembers:173]LSS_InspectionId_s:1=v_173_001_atxt{$TeamMemberLoop_L}; *)
							QUERY:C277([LSS_TeamMembers:173];  & ; [LSS_TeamMembers:173]LSS_TeamMemberId_L:2=$TmMem_L)
							
							If (Records in selection:C76([LSS_TeamMembers:173])=0)
								CREATE RECORD:C68([LSS_TeamMembers:173])
								[LSS_TeamMembers:173]LSS_InspectionId_s:1:=v_173_001_atxt{$TeamMemberLoop_L}
								[LSS_TeamMembers:173]LSS_TeamMemberId_L:2:=$TmMem_L
								SAVE RECORD:C53([LSS_TeamMembers:173])
								UNLOAD RECORD:C212([LSS_TeamMembers:173])
							End if 
							
						End for 
						If (Size of array:C274(v_173_001_atxt)#SQL_Limit_L)
							Offset_l:=Count_l
						Else 
							Offset_l:=Offset_l+SQL_Limit_L
						End if 
					Else 
						Clone_ArrayToSelection(ProcessTableNumber_al{$Loop_L})
					End if 
					If (ProcessTableNames_atxt{$loop_l}="LSS_Inspection") & (Records in table:C83([FileIDRes Table:60])#0)  //External server we need to process each record individually
						READ WRITE:C146([LSS_Inspection:164])
						
						For ($InspectionLoop_l; 1; Size of array:C274(v_164_001_atxt))
							QUERY:C277([LSS_Inspection:164]; [LSS_Inspection:164]LSS_InspectionId_s:1=v_164_001_atxt{$InspectionLoop_L})
							$Position_L:=Find in array:C230($RemoteTeamMemberIDs_atxt; String:C10([LSS_Inspection:164]LSS_ProjectManagerId_L:9))
							
							If ($Position_L>0)
								[LSS_Inspection:164]LSS_ProjectManagerId_L:9:=Num:C11($LocalTeamMemberIDs_atxt{$Position_L})
							End if 
							$Position_L:=Find in array:C230($RemoteTeamMemberIDs_atxt; String:C10([LSS_Inspection:164]LSS_TeamLeaderId_L:8))
							If ($Position_L>0)
								[LSS_Inspection:164]LSS_TeamLeaderId_L:8:=Num:C11($LocalTeamMemberIDs_atxt{$Position_L})
							End if 
							
							$Position_L:=Find in array:C230($RemoteTeamMemberIDs_atxt; String:C10([LSS_Inspection:164]LSS_DistHWYEngineerId_L:5))
							
							If ($Position_L>0)
								[LSS_Inspection:164]LSS_DistHWYEngineerId_L:5:=Num:C11($LocalTeamMemberIDs_atxt{$Position_L})
							End if 
							SAVE RECORD:C53([LSS_Inspection:164])
							UNLOAD RECORD:C212([LSS_Inspection:164])
						End for 
					End if 
				End if 
				
				
			Until (Offset_l=Count_l) | (4DError_b) | (SQLError_b)
			
			If (BLOB size:C605(BlobHoldUpdates_blb)>0)
				
				Progress SET TITLE($Progress_L; "Retrieving Blobs for "+ProcessTableNames_atxt{$Loop_L})
				
				clone_ProcessBlobs(ProcessTableNumber_al{$Loop_L}; $Progress_L)
				
				SET BLOB SIZE:C606(BlobHoldUpdates_blb; 0)
				
			End if 
			
		End for 
		
		LSS_CreateRoles($IPAddress_txt)
		
		ut_SQLLogout
		Progress QUIT($Progress_L)
		ALERT:C41("Import completed")
	End if 
End if 