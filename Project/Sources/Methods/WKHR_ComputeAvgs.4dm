//%attributes = {"invisible":true}
// Method: WKHR_ComputeAvgs
// Description
// Compute averages for Work hour Estimates from approved ones
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/11/05, 13:22:17
	// ----------------------------------------------------
	//
	Server_UpdateWKHRSummary
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(3/12/2007 08:20:08)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(6/4/2007 16:21:44)
	Mods_2007_CM10a
	// Modified by: costasmanousakis-(Designer)-(11/5/2007 08:22:32)
	Mods_2007_CM12_5302  //set the folder where the log will be placed
	// Modified by: Costas Manousakis-(Designer)-(9/3/20 10:22:20)
	Mods_2020_09_bug
	//  `change the message folder name to include the server IP and port number
End if 
Startup_PL
C_OBJECT:C1216($serverinfo_o)
$serverinfo_o:=SYSUTIL_GetServerInfo
C_TEXT:C284($messageDir_txt)
$messageDir_txt:="DailyUpdates_"+Replace string:C233(OB Get:C1224($serverinfo_o; "ServerIP"; Is text:K8:3); "."; "_")+"_"+OB Get:C1224($serverinfo_o; "ServerPort"; Is text:K8:3)
ut_SetMessageDir($messageDir_txt)
If (Application type:C494#4D Server:K5:6)
	ut_StartMessage(1; "UpdateWKHRSummary.txt")
Else 
	ut_StartMessage(2; "UpdateWKHRSummary")
End if 

ut_Message("Starting... "+String:C10(Current time:C178(*))+Char:C90(13))

QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]WkHrEstApproved:18=2)
QUERY SELECTION:C341([Work_Estimate:103]; [Contract_Assignment_Maintenance:101]ProjectType:36#"")

C_LONGINT:C283($VNumRecs_L; $i)
$VNumRecs_L:=Records in selection:C76([Work_Estimate:103])
ORDER BY:C49([Work_Estimate:103]; [Contract_Assignment_Maintenance:101]ProjectType:36)

If ($VNumRecs_L>0)
	C_TEXT:C284($vProjType_s)  // Command Replaced was o_C_STRING length was 40
	C_LONGINT:C283($vNumToDivide_L)
	READ ONLY:C145([Work_Estimate:103])
	WKHR_InitConfigArrays
	$vProjType_s:=""
	$vNumToDivide_L:=0
	ut_Message("Looping... "+String:C10(Current time:C178(*))+Char:C90(13))
	For ($i; 1; $VNumRecs_L)
		GOTO SELECTED RECORD:C245([Work_Estimate:103]; $i)
		LOAD RECORD:C52([Work_Estimate:103])
		QUERY:C277([Contract_Assignment_Maintenance:101]; [Contract_Assignment_Maintenance:101]AssignID:3=[Work_Estimate:103]AssignID:2)
		WKHR_InitVars
		WKHR_LoadVariables_2
		Case of 
			: ($i=1)
				WKHR_InitSumVars
				$vProjType_s:=[Contract_Assignment_Maintenance:101]ProjectType:36
				$vNumToDivide_L:=1
				WKHR_AddEstToSum
				
			Else 
				If ([Contract_Assignment_Maintenance:101]ProjectType:36=$vProjType_s)
					$vNumToDivide_L:=$vNumToDivide_L+1
					WKHR_AddEstToSum
				Else 
					WKHR_StoreTypeSummary($vProjType_s; $vNumToDivide_L)
					$vProjType_s:=[Contract_Assignment_Maintenance:101]ProjectType:36
					$vNumToDivide_L:=1
					WKHR_InitSumVars
					WKHR_AddEstToSum
				End if 
				
		End case 
		
	End for 
	WKHR_StoreTypeSummary($vProjType_s; $vNumToDivide_L)
	WKHR_InitSumVars
	WKHR_InitVars
	WKHR_ClearConfigArrays
	ut_Message("Done Computing Averages"+String:C10(Current time:C178(*))+Char:C90(13))
Else 
	ut_Message("No approved Work Estimates found"+String:C10(Current time:C178(*))+Char:C90(13))
End if 
ut_Message("Saving time stamp "+String:C10(Current time:C178(*))+Char:C90(13))
ut_SetNextRunTimeStamp("Server_UpdateWKHRSummary")
ut_CloseMessage
ut_SetMessageDir("")