//%attributes = {"invisible":true}
//Method: ut_SaveServerProcessRecords
//Description
// Save server process records on server shutdown
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 01/12/17, 13:12:54
	//----------------------------------------------------
	Mods_2017_01  // Add code to auto save and load  [ServerProcesses] records
	//Modified by: administrator (1/12/17 13:12:56)
	// Modified by: Costas Manousakis-(Designer)-(3/3/17 10:04:29)
	Mods_2017_03
	//  `Use variable ◊DatabaseStructureName_txt defined at beginning of on server startup
	
End if 
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
	ARRAY LONGINT:C221($ControlProcessDelay_aL; 0)
	ARRAY TEXT:C222($LastRunTimeStamp_atxt; 0)
	ARRAY TEXT:C222($NextRunTimeStamp_atxt; 0)
	ARRAY TEXT:C222($ProcessName_atxt; 0)
	ARRAY BOOLEAN:C223($ProcessRunning_aB; 0)
	ARRAY TEXT:C222($ProcessRunSchedule_atxt; 0)
	
	Begin SQL
		select
		[ServerProcesses].[ControlProcessDelay_l], 
		[ServerProcesses].[LastRunTimeStamp_s], 
		[ServerProcesses].[NextRunTimeStamp_s], 
		[ServerProcesses].[ProcessName_s], 
		[ServerProcesses].[ProcessRunning_b], 
		[ServerProcesses].[ProcessRunSchedule_s]
		from
		[ServerProcesses]
		into
		:$ControlProcessDelay_aL,
		:$LastRunTimeStamp_atxt,
		:$NextRunTimeStamp_atxt,
		:$ProcessName_atxt,
		:$ProcessRunning_aB,
		:$ProcessRunSchedule_atxt;
		
	End SQL
	If (Size of array:C274($ControlProcessDelay_aL)>0)
		C_BLOB:C604($File_blb)
		SET BLOB SIZE:C606($File_blb; 0)
		C_TEXT:C284($Path_txt)
		VARIABLE TO BLOB:C532($ControlProcessDelay_aL; $File_blb; *)
		VARIABLE TO BLOB:C532($LastRunTimeStamp_atxt; $File_blb; *)
		VARIABLE TO BLOB:C532($NextRunTimeStamp_atxt; $File_blb; *)
		VARIABLE TO BLOB:C532($ProcessName_atxt; $File_blb; *)
		VARIABLE TO BLOB:C532($ProcessRunning_aB; $File_blb; *)
		VARIABLE TO BLOB:C532($ProcessRunSchedule_atxt; $File_blb; *)
		$Path_txt:=ut_ReturnServerExportFolder("ServerProcesses")
		$Path_txt:=$Path_txt+<>PL_DirectorySep_s+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+"_"+$Name_txt+"_ServerProcess"
		BLOB TO DOCUMENT:C526($Path_txt; $File_blb)
		
	End if 
	
	
End if 
//End ut_SaveServerProcessRecords