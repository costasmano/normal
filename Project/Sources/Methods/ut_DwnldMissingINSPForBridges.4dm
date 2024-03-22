//%attributes = {"invisible":true}
//Method: ut_DwnldMissingINSPForBridges
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 12/05/11, 11:16:22
	//----------------------------------------------------
	//Mods_2011_12  `
	//Modified by: Charles Miller (12/5/11 11:16:23)
	Mods_2013_01  //r004 ` 
	//Modified by: Charles Miller (1/24/13 15:33:42)
	Mods_2013_01  //r004 ` Modify to set record limts and add progress bar
	//Modified by: Charles Miller (1/24/13 15:47:22)
	// Modified by: Costas Manousakis-(Designer)-(10/23/15 15:03:57)
	Mods_2015_10_bug
	//  `fixed ending problem in the Repeat..Until loop when checking the Loop_l variable
End if 
C_LONGINT:C283($Size_l)
C_REAL:C285($Interval)

$Size_l:=Records in selection:C76([Bridge MHD NBIS:1])
C_BOOLEAN:C305($Process_b)
$Process_b:=False:C215
C_TEXT:C284($msg_txt)
Case of 
	: ($Size_l=0)
		$msg_txt:="There are no Bridges Listed!! You have to retrieve a list of bridges first!"
		ALERT:C41($msg_txt)
	: ($Size_l<61)
		$Process_b:=True:C214
	Else 
		$msg_txt:="You are not allowed to search for Missing Inspections for more than 60 bridges at a time!"
		$msg_txt:=$msg_txt+" Currently there are "+String:C10($Size_l)+" records listed.  Please reduce the selection before proceeding."
		ALERT:C41($msg_txt)
End case 
C_LONGINT:C283($viOnScreen)  //Command Replaced was o_C_INTEGER
$viOnScreen:=3
If ($Process_b)
	
	C_BOOLEAN:C305(INSP_BatchDownload_b)
	ARRAY TEXT:C222($Bins_as; 0)  //Command Replaced was o_ARRAY string length was 3
	C_LONGINT:C283($Error_l; $Loop_l; $Size_l)
	
	ARRAY LONGINT:C221($RecordNumbers_al; 0)
	ARRAY LONGINT:C221($RecordNumbers_al; $Size_l)
	SELECTION RANGE TO ARRAY:C368(1; $Size_l; [Bridge MHD NBIS:1]; $RecordNumbers_al)
	INSP_BatchDownload_b:=True:C214
	C_TEXT:C284($Message_txt)
	If ($Size_l=1)
		GOTO RECORD:C242([Bridge MHD NBIS:1]; $RecordNumbers_al{1})
		$Message_txt:="Are you sure you want to download missing inspections for  BIN "+[Bridge MHD NBIS:1]BIN:3
	Else 
		$Message_txt:="Are you sure you want to download missing inspections for the "+String:C10($Size_l)+" bridge records"
	End if 
	CONFIRM:C162($Message_txt; "Download"; "Cancel")
	If (OK=1)
		<>ProgressPID:=StartProgress("Download Missing"; "Button"; "Downloading Missing Inspections")
		$Interval:=MaxNum(MinNum(Int:C8($Size_l/40); 20); 2)  // get an update interval between 2 and 20
		UpdateProgress(0; $Size_l)  //start it
		
		$Error_l:=1
		ut_SetMessageDir("DataTransfers")
		
		ut_StartMessage(3; "Insp Download Log"; 350; 0; Regular window:K27:1; (6+7))  //log both to file and screen
		
		ut_Message("Connecting to server…"+<>sCR)
		
		C_TEXT:C284($Password)
		
		$Error_l:=ut_SQLMakeConnnection(Current user:C182; $Password; <>DestIP; Current user:C182+", you are about to download data from the central database.")
		Case of 
			: (<>Transfer=0)
				ut_SQLReturnINSPRecordKeys(f_IsDistrictServer; Current user:C182)
			: (<>Transfer=1)
				ut_SQLReturnINSPRecordKeys("ALL"; Current user:C182)
		End case 
		
		
		If ((SQLCount_l=0) & (Not:C34(SQLError_b)))
			$Loop_l:=1
			GOTO RECORD:C242([Bridge MHD NBIS:1]; $RecordNumbers_al{$Loop_l})
			vCurrBIN_s:=[Bridge MHD NBIS:1]BIN:3
			Repeat 
				If (($Loop_l%$Interval=0) | ($Loop_l=$Size_l))  //Don't slow down things just to display
					UpdateProgress($Loop_l; $Size_l)
				End if 
				ut_Message("Processing BIN…"+vCurrBIN_s+<>sCR)
				INSP_DownloadMissing
				$Loop_l:=$Loop_l+1
				If ($Loop_l<=$Size_l)
					GOTO RECORD:C242([Bridge MHD NBIS:1]; $RecordNumbers_al{$Loop_l})
					vCurrBIN_s:=[Bridge MHD NBIS:1]BIN:3
					Case of 
						: (<>Transfer=0)
							ut_SQLReturnINSPRecordKeys(f_IsDistrictServer; Current user:C182)
						: (<>Transfer=1)
							ut_SQLReturnINSPRecordKeys("ALL"; Current user:C182)
					End case 
				End if 
				
			Until ($Loop_l>=$Size_l) | (SQLCount_l>0) | (SQLError_b) | (<>Abort)
			If (SQLCount_l>0)
				ALERT:C41("Count not continue retrieving missing inspections as there are now Inspection related transfer records for current DB. Please execute data"+" transfer first!!")
			End if 
			ut_SQLLogout
			ut_CloseMessage
			CREATE SELECTION FROM ARRAY:C640([Bridge MHD NBIS:1]; $RecordNumbers_al)
			
		Else 
			
			ALERT:C41("There are Inspection related transfer records for current DB. Please execute data"+" transfer first!!")
		End if 
		
		POST OUTSIDE CALL:C329(<>ProgressPID)
		
	End if 
	
	INSP_BatchDownload_b:=False:C215
Else 
	
	//ALERT("No download as no bridge records in selection")
	
End if 
//End ut_DwnldMissingINSPForBridges