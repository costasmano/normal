//%attributes = {"invisible":true}
// Method: INSP_DownloadMissing
// Description
// Download missing inspections/incomplete for current [bridge mhd nbis] record
// Parameters
// $0 : number inspections downloaded
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/13/06, 14:52:17
	// ----------------------------------------------------
	// ----------------------------------------------------
	Mods_2007_CM03
	// Modified by: costasmanousakis-(Designer)-(8/11/08 11:05:39)
	Mods_2008_CM_5404  // ("INSPDWNLD")
	//  `Testing for Designer to use the INSP_UpdateLocalInspFromRemote method instead of
	//  `deleting the local inspection and then downloading the remote inspection.
	//  `Also when testing for pending incoming changes, check only for inspection related records.
	// Modified by: costasmanousakis-(Designer)-(8/20/08 08:15:39)
	Mods_2008_CM_5404
	//  `Use method INSP_UpdateInspList
	// Modified by: costasmanousakis-(Designer)-(6/26/09 16:02:51)
	Mods_2009_06  // Changed vsDialogtxt to TEXT
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 12:21:22)
End if 

Compiler_forSQL
C_LONGINT:C283($0; $NumInspDwld_L)
C_BOOLEAN:C305($1; $CheckRemoteLog_B)
If (Count parameters:C259=1)
	$CheckRemoteLog_B:=$1
Else 
	$CheckRemoteLog_B:=False:C215
End if 

C_TEXT:C284($Password)  // Command Replaced was o_C_STRING length was 80

Case of 
	: (<>Destination#"MHD BMS")
		ALERT:C41("This should only be run for the Boston server!!!")
		
	: ((<>LockUserTx=True:C214) & (<>TxUserName#Current user:C182))  //Verify Tx Lock
		ALERT:C41("Sorry! You are not authorized to send or receive any data!")
		
	: ([Bridge MHD NBIS:1]BIN:3="")
		ALERT:C41("No Current NBI record!!!")
		
	Else 
		
		C_LONGINT:C283($Error_l)
		$Error_l:=1
		ut_SetMessageDir("DataTransfers")
		If (Not:C34(INSP_BatchDownload_b))
			ut_StartMessage(3; "Insp Download Log"; 350; 0; Regular window:K27:1; (6+7))  //log both to file and screen
			
			ut_Message("Connecting to server…"+<>sCR)
			
			
			$Error_l:=ut_SQLMakeConnnection(Current user:C182; $Password; <>DestIP; Current user:C182+", you are about to download data from the central database.")
			
			
			Case of 
				: (<>Transfer=0)
					ut_SQLReturnINSPRecordKeys(f_IsDistrictServer; Current user:C182)
				: (<>Transfer=1)
					ut_SQLReturnINSPRecordKeys("ALL"; Current user:C182)
			End case 
		End if 
		
		
		
		If ($Error_l=1)
			
			C_LONGINT:C283($InspCount_L)
			InspDownLd_L:=0
			C_BOOLEAN:C305($DowloadComplete_B; $UpdateLocal_B)
			
			
			If ((SQLCount_l=0) & (Not:C34(SQLError_b)))  //All remote act log records for here have been transfered or OK to go
				
				vCurrBIN_s:=[Bridge MHD NBIS:1]BIN:3
				vApprVar_s:=String:C10(2)
				Case of 
					: (Not:C34(INSP_DWNLD_Task("FindBINinsp")))
						
					: (Not:C34(INSP_DWNLD_Task("CheckRemoteIsnps")))
						
				End case 
				
			Else 
				ALERT:C41("There are Inspection related transfer records for current DB. Please execute data"+" transfer first!!")
				
			End if 
			
			
		Else 
			Case of 
				: ($Error_l=-2)
					ALERT:C41("Tranfer cancelled due to invalid password")
				: ($Error_l=-4)
					ALERT:C41("Tranfer cancelled due to Password entry screen cancelled")
				Else 
					
			End case 
		End if 
		If (Not:C34(INSP_BatchDownload_b))
			ut_SQLLogout
			
			If (InspDownLd_L>0)
				ALERT:C41("DownLoaded "+String:C10(InspDownLd_L)+" approved Inspections from remote server!")
			Else 
				ALERT:C41("No approved Inspections found on remote server that are not here!")
			End if 
			
			INSP_UpdateInspList
			
			ut_CloseMessage
		End if 
End case 