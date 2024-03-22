//%attributes = {"invisible":true}
// SR_ProcessQuarterly
// Description
// This method will process and print the report for all records passed in 
// Parameters
//$1 pointer to record number array
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): charlesmiller
	// Date and time: 11/24/09, 12:01:23
	// ----------------------------------------------------
	Mods_2009_11  // r003 CJ Miller`11/24/09, 12:01:48     `Quarterly status report
	Mods_2009_12  // r001 CJ Miller`12/10/09, 17:07:20     `Integrate new status report
	Mods_2009_12  // r001 CJ Miller`12/17/09, 14:31:21        `Make changes to new status report
	//Add Legacy status report
	Mods_2010_02  //r001 CJ Miller`02/11/10, 15:25:05      `Add new server processing of monthly reports
	Mods_2011_04  //r002 CJ Miller`04/12/11, 11:59:39      `Change from
	//Get indexed string to substring of date;5 to get 3 character month
	Mods_2011_05  //r002 CJ Miller`05/20/11, 11:27:48       `Change directory where reports are stored to the users documents folder
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(9/3/20 10:22:20)
	Mods_2020_09_bug
	//  `change the message folder name to include the server IP and port number
End if 

C_POINTER:C301($1; $RecordArray_aptr)
$RecordArray_aptr:=$1
vsDate:=String:C10(Current date:C33(*); 7)
C_LONGINT:C283($Loop_l)
C_TEXT:C284($ReportToProcess_txt)
REDUCE SELECTION:C351([Status Report:69]; 0)
C_BOOLEAN:C305($Processreport_b)
$Processreport_b:=True:C214
C_TEXT:C284($LegacyFormName_txt; $DOTFormName_txt; $FormName_txt; $FileName_txt)
$LegacyFormName_txt:="LegacyStatusReport"
$DOTFormName_txt:="QuarterlyStatusReport"

C_BOOLEAN:C305($PrintRecord_b)

For ($Loop_l; 1; Size of array:C274($RecordArray_aptr->))
	$PrintRecord_b:=True:C214
	Compiler_SR
	GOTO RECORD:C242([Status Report:69]; $RecordArray_aptr->{$Loop_l})
	Case of 
		: (Position:C15("Legacy"; [Status Report:69]Comments:135)>0)
			$FormName_txt:=$LegacyFormName_txt
			$FileName_txt:="Quarterly Status (MHD)_"
		: (Position:C15("Report"; [Status Report:69]Comments:135)>0)
			$FormName_txt:=$DOTFormName_txt
			$FileName_txt:="Quarterly Status_"
		Else 
			$PrintRecord_b:=False:C215
	End case 
	If ($PrintRecord_b)
		SRQ_SetUpPrint($FormName_txt)
		
		SET PRINT OPTION:C733(Orientation option:K47:2; 2)
		If (Application type:C494=4D Server:K5:6)
			C_TEXT:C284($FileName_txt; $Date_txt; $Path_txt; $ReportMonth_txt)
			$ReportMonth_txt:=Substring:C12(String:C10([Status Report:69]Date_Created:1; Internal date long:K1:5); 1; 3)
			C_OBJECT:C1216($serverinfo_o)
			$serverinfo_o:=SYSUTIL_GetServerInfo
			C_TEXT:C284($messageDir_txt)
			$messageDir_txt:="Monthly_Reports_"+Replace string:C233(OB Get:C1224($serverinfo_o; "ServerIP"; Is text:K8:3); "."; "_")+"_"+OB Get:C1224($serverinfo_o; "ServerPort"; Is text:K8:3)
			
			$Path_txt:=ut_ReturnUserDocFolder($messageDir_txt)
			GOTO RECORD:C242([Status Report:69]; $RecordArray_aptr->{1})
			$Date_txt:=String:C10(Day of:C23([Status Report:69]Date_Created:1); "00")+"-"+$ReportMonth_txt+"-"+String:C10(Year of:C25([Status Report:69]Date_Created:1))
			
			$FileName_txt:=$FileName_txt+$Date_txt+"_"+String:C10($Loop_l)
			$FileName_txt:=$Path_txt+$FileName_txt+".pdf"
			//TRACE
			SET PRINT OPTION:C733(Destination option:K47:7; 3; $FileName_txt)
			Print form:C5([Status Report:69]; $FormName_txt)
			PAGE BREAK:C6
			APPEND TO ARRAY:C911(MAILAttachments_atxt; $FileName_txt)
		Else 
			
			If ($Loop_l=1)
				PRINT SETTINGS:C106
			End if 
			Print form:C5([Status Report:69]; $FormName_txt)
			If ($Loop_l<Size of array:C274($RecordArray_aptr->))
				PAGE BREAK:C6(>)
			End if 
		End if 
	End if 
End for 

If (Application type:C494#4D Server:K5:6)
	PAGE BREAK:C6
End if 

UNLOAD RECORD:C212([Status Report:69])
//End SR_ProcessQuarterly