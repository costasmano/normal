//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Charles Miller
// Date and time: 11/23/10, 10:00:30
// ----------------------------------------------------
// Method: SQL_CreateNewDB
// Description
// 
//
// Parameters
// ---------------------------------------------------

//$IPAddress_txt:=SQL_TestConnection 
If (False:C215)
	Mods_2020_01  //Moved changed clone code for new data file in to make arrays are used from BF
	//Modified by: CJ (1/14/20 11:46:37)
	
	// Modified by: Costas Manousakis-(Designer)-(2023-04-07 16:19:26)
	Mods_2023_04
	//  `Remove IDLE before delay process
End if 
If (True:C214)
	Compiler_clone
	FillEmptydb_L:=2
	clone_ControlClone
	
	
	FillEmptydb_L:=1
	clone_ControlClone
Else 
	
	C_LONGINT:C283($vl_MaxProcessCount)
	$vl_MaxProcessCount:=3
	C_TEXT:C284($vs_MaxProcessCount)  // Command Replaced was o_C_STRING length was 1
	$vs_MaxProcessCount:="3"
	Repeat 
		$vs_MaxProcessCount:=Request:C163("Enter Max number of processes:"; String:C10($vs_MaxProcessCount))
		$vl_MaxProcessCount:=Num:C11($vs_MaxProcessCount)
	Until ($vl_MaxProcessCount>1) & ($vl_MaxProcessCount<6)
	// Modified by: Charles Miller (11/23/10)
	If (False:C215)
		ARRAY LONGINT:C221($Reprocess_al; 0)
		ARRAY LONGINT:C221($Reprocess_al; 3)
		$Reprocess_al{1}:=122
		$Reprocess_al{2}:=123
		$Reprocess_al{3}:=124
	End if 
	C_BOOLEAN:C305($DataFileEmpty_b)
	$DataFileEmpty_b:=True:C214
	C_TIME:C306($OverAllStart_tm; $OverAllEnd_tm)
	C_BOOLEAN:C305(<>Launched_b)
	C_LONGINT:C283($Loop_l; $LastTableNumber_l; $ArrayPosition_l)
	ARRAY LONGINT:C221(<>NewDBProcesses_al; 0)
	$LastTableNumber_l:=Get last table number:C254
	C_BOOLEAN:C305($Complete_b)
	C_LONGINT:C283($ProcessNumber_l)
	C_TEXT:C284($Message_txt)
	$Message_txt:=""
	C_POINTER:C301($Table_ptr)
	C_TEXT:C284($TableName_txt)
	C_LONGINT:C283($win)
	For ($Loop_l; 1; $LastTableNumber_l)
		If (Is table number valid:C999($Loop_l))
			$TableName_txt:=Table name:C256($Loop_l)
			$Table_ptr:=Table:C252($Loop_l)
			If (Records in table:C83($Table_ptr->)>0)
				$Message_txt:=$Message_txt+$TableName_txt+" "+String:C10(Records in table:C83($Table_ptr->))+Char:C90(13)
				$DataFileEmpty_b:=False:C215
			End if 
			
		End if 
	End for 
	
	If ($DataFileEmpty_b)
		C_TEXT:C284($IPAddress_txt)
		
		$IPAddress_txt:=SQL_TestConnection
		$OverAllStart_tm:=Current time:C178
		If (Application type:C494#4D Server:K5:6)
			$win:=ut_OpenNewWindow(500; 200; 5; 0; "Retrieving data for tables ")
			C_TIME:C306($StartTime_tm; $RemainingTime_tm)
			$StartTime_tm:=Current time:C178
		End if 
		
		For ($Loop_l; 1; $LastTableNumber_l)
			If (Is table number valid:C999($Loop_l))
				$TableName_txt:=Table name:C256($Loop_l)
				If (Application type:C494#4D Server:K5:6)
					GOTO XY:C161(5; 2)
					MESSAGE:C88("Updating "+String:C10($Loop_l)+" out of "+String:C10($LastTableNumber_l))
					GOTO XY:C161(5; 3)
					MESSAGE:C88($TableName_txt)
					GOTO XY:C161(5; 5)
					$RemainingTime_tm:=(($LastTableNumber_l/$Loop_l)-1)*(Current time:C178(*)-$StartTime_tm)
					MESSAGE:C88("Estimated time remaining is "+Time string:C180($RemainingTime_tm))
					GOTO XY:C161(5; 7)
					MESSAGE:C88("Elapsed time is "+Time string:C180(Current time:C178(*)-$StartTime_tm))
				End if 
				$TableName_txt:=Table name:C256($Loop_l)
				Case of 
						
					: ($TableName_txt="Activity Log")
						
					: ($TableName_txt="BridgeMHDNBISArchive")
						
						
					: ($TableName_txt="Cond Units")  //downloaded for each district
					: ($TableName_txt="Dialogs")
					: ($TableName_txt="ElementsSafety")
					: ($TableName_txt="InventoryPhotoInsp")
					: ($TableName_txt="InventoryPhotos")
					: ($TableName_txt="LSS_Accessibility")
					: ($TableName_txt="LSS_AccessibilityElement")
					: ($TableName_txt="LSS_DMeter")
					: ($TableName_txt="LSS_Element")
					: ($TableName_txt="LSS_ElementInspection")
					: ($TableName_txt="LSS_Inspection")
					: ($TableName_txt="LSS_Inventory")
					: ($TableName_txt="LSS_Photos")
					: ($TableName_txt="LSS_refInspectionType")
					: ($TableName_txt="LSS_refRouteDirection")
					: ($TableName_txt="LSS_refStructureCoating")
					: ($TableName_txt="LSS_refStructureMaterial")
					: ($TableName_txt="LSS_refStructureTypes")
					: ($TableName_txt="LSS_SignPanel")
					: ($TableName_txt="LSS_TeamMembers")
					: ($TableName_txt="LSS_TowerDistance")
					: ($TableName_txt="LSS_UT")
					: ($TableName_txt="LSS_UtResult")
					: ($TableName_txt="LSS_VerticalClearance")
					: ($TableName_txt="NBISSecondaryArchive")
					: ($TableName_txt="ONSQLAthenticationErrors")
					: ($TableName_txt="Owners of Data")
					: ($TableName_txt="Pontis_Metric_Data")
					: ($TableName_txt="PON_ELEM_INSP")
					: ($TableName_txt="SD_History")
					: ($TableName_txt="Standard Photos")  //downloaded for each district
						
						
						
						
					Else 
						
						<>Launched_b:=False:C215
						$ProcessNumber_l:=New process:C317("SQL_CreateNewDBTable"; 0; "Import Table "+$TableName_txt; $Loop_l; $IPAddress_txt)
						Repeat 
							//IDLE
							DELAY PROCESS:C323(Current process:C322; (30))
						Until (<>Launched_b)
						
						
				End case 
				
				$Complete_b:=False:C215
				Repeat 
					$ArrayPosition_l:=Find in array:C230(<>NewDBProcesses_al; -999)
					Case of 
						: (Size of array:C274(<>NewDBProcesses_al)<$vl_MaxProcessCount)
							$Complete_b:=True:C214
						: ($ArrayPosition_l>0)
							DELETE FROM ARRAY:C228(<>NewDBProcesses_al; $ArrayPosition_l; 1)
							$Complete_b:=True:C214
							$ArrayPosition_l:=Find in array:C230(<>NewDBProcesses_al; -999)
							If ($ArrayPosition_l>0)
								DELETE FROM ARRAY:C228(<>NewDBProcesses_al; $ArrayPosition_l; 1)
							End if 
						Else 
							DELAY PROCESS:C323(Current process:C322; (120))  //delay for 1 seconds
							
					End case 
					
					
					
					
				Until ($Complete_b)
			End if 
			
		End for 
		CLOSE WINDOW:C154
		
		C_BOOLEAN:C305($Ready_b)
		$Ready_b:=False:C215
		C_LONGINT:C283($ArrayPosition_l)
		Repeat 
			$ArrayPosition_l:=Find in array:C230(<>NewDBProcesses_al; -999)
			If ($ArrayPosition_l>0)
				DELETE FROM ARRAY:C228(<>NewDBProcesses_al; $ArrayPosition_l; 1)
			End if 
			If (Size of array:C274(<>NewDBProcesses_al)=0)
				$Ready_b:=True:C214
			Else 
				DELAY PROCESS:C323(Current process:C322; 120)
			End if 
			
		Until ($Ready_b)
		$OverAllEnd_tm:=Current time:C178
		ALERT:C41("Elapsed time is : "+String:C10($OverAllEnd_tm-$OverAllStart_tm))
		SQL_CountRecords($IPAddress_txt)
		
	Else 
		ut_BigAlert("You can not run this as the following tables have records:"+Char:C90(13)+$Message_txt)
	End if 
	
End if 
//END Method: SQL_CreateNewDB