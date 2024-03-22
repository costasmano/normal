
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 01/12/17, 15:11:07
//----------------------------------------------------
//Method: Object Method: ImportServerProcess.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_01  // Add code to auto save and load  [ServerProcesses] records
	//Modified by: administrator (1/12/17 15:43:03)
	
End if 
TRACE:C157

C_LONGINT:C283($Position_l; $Column_l)
LISTBOX GET CELL POSITION:C971(LocalListBox_L; $Column_l; $Position_l)

If ($Position_l>0)
	SET TIMER:C645(180*60)  //set for 3 minutes so we can do all of our work
	CONFIRM:C162("Are you sure you want to replace the "+String:C10(Records in table:C83([ServerProcesses:87]))+" with the "+String:C10(Counts_aL{$Position_l})+" records found in the file named "+DocumentNames_atxt{$Position_l}; "Replace"; "Skip")
	If (OK=1)
		READ WRITE:C146([ServerProcesses:87])
		TRUNCATE TABLE:C1051([ServerProcesses:87])
		If (OK=1)
			C_BLOB:C604($File_blb)
			C_TEXT:C284($Path_txt)
			$Path_txt:=ut_ReturnServerExportFolder("ServerProcesses")
			DOCUMENT TO BLOB:C525($Path_txt+Folder separator:K24:12+DocumentNames_atxt{$Position_l}; $File_blb)
			ARRAY LONGINT:C221($ControlProcessDelay_aL; 0)
			ARRAY TEXT:C222($LastRunTimeStamp_atxt; 0)
			ARRAY TEXT:C222($NextRunTimeStamp_atxt; 0)
			ARRAY TEXT:C222($ProcessName_atxt; 0)
			ARRAY BOOLEAN:C223($ProcessRunning_aB; 0)
			ARRAY TEXT:C222($ProcessRunSchedule_atxt; 0)
			C_LONGINT:C283($Offset_L)
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
			
		Else 
			ALERT:C41("Could not delete all records. No import took place.")
			BEEP:C151
			
		End if 
		CANCEL:C270
		
	End if 
End if 
//End Object Method: ImportServerProcess.Button

