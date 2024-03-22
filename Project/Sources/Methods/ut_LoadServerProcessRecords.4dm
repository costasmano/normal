//%attributes = {"invisible":true}
//Method: ut_LoadServerProcessRecords
//Description
// Load server process records on startup if needed
// Parameters
// ----------------------------------------------------
If (False:C215)
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 01/12/17, 14:17:48
	//----------------------------------------------------
	Mods_2017_01  // 
	//Modified by: administrator (1/12/17 14:18:02)
	// Modified by: Costas Manousakis-(Designer)-(2/2/17 11:36:48)
	Mods_2017_02
	//  `unload records at the end
	// Modified by: Costas Manousakis-(Designer)-(3/3/17 10:04:29)
	Mods_2017_03
	//  `Use variable ◊DatabaseStructureName_txt defined at beginning of on server startup
End if 
//TRACE  ` does not work compiled anyway
//TRACE
C_BOOLEAN:C305($Process_B)
$Process_B:=True:C214
C_TEXT:C284($Name_txt)
Case of 
	: (<>DatabaseStructureName_txt="MHD BMS")
		$Name_txt:="Boston"
	: (<>DatabaseStructureName_txt="MHD BMS External Server")
		$Name_txt:="External"
	Else 
		$Process_B:=False:C215
End case 

If ($Process_B)
	vtMessage:="Import ServerProcesses records for "+$Name_txt+Char:C90(Carriage return:K15:38)+"There are currently "+String:C10(Records in table:C83([ServerProcesses:87]))+" in the table"
	C_BLOB:C604($File_blb)
	C_TEXT:C284($Path_txt)
	C_LONGINT:C283($Offset_L; $Loop_l)
	$Path_txt:=ut_ReturnServerExportFolder("ServerProcesses")
	ARRAY TEXT:C222(DocumentNames_atxt; 0)
	DOCUMENT LIST:C474($Path_txt; DocumentNames_atxt)
	ARRAY LONGINT:C221(Counts_aL; 0)
	ARRAY DATE:C224(CreatedDates_ad; 0)
	ARRAY TEXT:C222(CreatedTimes_atxt; 0)
	$Offset_L:=Size of array:C274(DocumentNames_atxt)
	ARRAY LONGINT:C221(Counts_aL; $Offset_L)
	ARRAY DATE:C224(CreatedDates_ad; $Offset_L)
	ARRAY TEXT:C222(CreatedTimes_atxt; $Offset_L)
	SORT ARRAY:C229(DocumentNames_atxt; <)
	C_BOOLEAN:C305($Locked_B; $InVisible_B)
	C_DATE:C307($Create_d; $Modified_d)
	C_TIME:C306($Create_tm; $Modified_tm)
	
	If (Size of array:C274(DocumentNames_atxt)>0)
		If (False:C215)
			For ($Loop_l; Size of array:C274(DocumentNames_atxt); 1; -1)
				
				GET DOCUMENT PROPERTIES:C477($Path_txt+<>PL_DirectorySep_s+DocumentNames_atxt{$Loop_L}; $Locked_B; $InVisible_B; $Create_d; $Create_tm; $Modified_d; $Modified_tm)
				If ($InVisible_B)
					DELETE FROM ARRAY:C228(CreatedDates_ad; $Loop_l; 1)
					DELETE FROM ARRAY:C228(Counts_aL; $Loop_l; 1)
					DELETE FROM ARRAY:C228(CreatedTimes_atxt; $Loop_l; 1)
					DELETE FROM ARRAY:C228(DocumentNames_atxt; $Loop_l; 1)
				Else 
					SET BLOB SIZE:C606($File_blb; 0)
					DOCUMENT TO BLOB:C525($Path_txt+<>PL_DirectorySep_s+DocumentNames_atxt{$Loop_L}; $File_blb)
					ARRAY LONGINT:C221($ControlProcessDelay_aL; 0)
					$Offset_L:=0
					BLOB TO VARIABLE:C533($File_blb; $ControlProcessDelay_aL; $Offset_L)
					CreatedDates_ad{$Loop_l}:=$Create_d
					Counts_aL{$Loop_l}:=Size of array:C274($ControlProcessDelay_aL)
					CreatedTimes_atxt{$Loop_l}:=String:C10($Create_tm; HH MM SS:K7:1)
				End if 
			End for 
			
			C_LONGINT:C283($Width_L; $Height_L; $Win_l)
			FORM GET PROPERTIES:C674("ImportServerProcess"; $Width_L; $Height_L)
			$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; "Select Server Process Record File for Import"; "ut_CloseCancel")
			DIALOG:C40("ImportServerProcess")
			CLOSE WINDOW:C154
		Else 
			READ WRITE:C146([ServerProcesses:87])
			TRUNCATE TABLE:C1051([ServerProcesses:87])
			If (OK=1)
				C_BLOB:C604($File_blb)
				C_TEXT:C284($Path_txt)
				$Path_txt:=ut_ReturnServerExportFolder("ServerProcesses")
				DOCUMENT TO BLOB:C525($Path_txt+Folder separator:K24:12+DocumentNames_atxt{1}; $File_blb)
				ARRAY LONGINT:C221($ControlProcessDelay_aL; 0)
				ARRAY TEXT:C222($LastRunTimeStamp_atxt; 0)
				ARRAY TEXT:C222($NextRunTimeStamp_atxt; 0)
				ARRAY TEXT:C222($ProcessName_atxt; 0)
				ARRAY BOOLEAN:C223($ProcessRunning_aB; 0)
				ARRAY TEXT:C222($ProcessRunSchedule_atxt; 0)
				C_LONGINT:C283($Offset_L)
				$Offset_L:=0
				BLOB TO VARIABLE:C533($File_blb; $ControlProcessDelay_aL; $Offset_L)
				BLOB TO VARIABLE:C533($File_blb; $LastRunTimeStamp_atxt; $Offset_L)
				BLOB TO VARIABLE:C533($File_blb; $NextRunTimeStamp_atxt; $Offset_L)
				BLOB TO VARIABLE:C533($File_blb; $ProcessName_atxt; $Offset_L)
				BLOB TO VARIABLE:C533($File_blb; $ProcessRunning_aB; $Offset_L)
				BLOB TO VARIABLE:C533($File_blb; $ProcessRunSchedule_atxt; $Offset_L)
				
				C_LONGINT:C283($Loop_l)
				For ($Loop_L; 1; Size of array:C274($ControlProcessDelay_aL))
					CREATE RECORD:C68([ServerProcesses:87])
					[ServerProcesses:87]ControlProcessDelay_l:6:=$ControlProcessDelay_aL{$Loop_L}
					[ServerProcesses:87]LastRunTimeStamp_s:3:=$LastRunTimeStamp_atxt{$Loop_L}
					[ServerProcesses:87]NextRunTimeStamp_s:4:=$NextRunTimeStamp_atxt{$Loop_L}
					[ServerProcesses:87]ProcessName_s:1:=$ProcessName_atxt{$Loop_L}
					[ServerProcesses:87]ProcessRunning_b:5:=$ProcessRunning_aB{$Loop_L}
					[ServerProcesses:87]ProcessRunSchedule_s:2:=$ProcessRunSchedule_atxt{$Loop_L}
					SAVE RECORD:C53([ServerProcesses:87])
					UNLOAD RECORD:C212([ServerProcesses:87])
				End for 
				
				
			End if 
		End if 
	End if 
	
	UNLOAD RECORD:C212([ServerProcesses:87])
	REDUCE SELECTION:C351([ServerProcesses:87]; 0)
End if 
//End ut_LoadServerProcessRecords