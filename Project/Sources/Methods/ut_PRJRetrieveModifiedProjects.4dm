//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_prjRetrieveModifiedProjects
// User name (OS): cjmiller
// Date and time: 02/10/06, 12:47:31
// ----------------------------------------------------
// Description
// 
//
// Parameters
//$0 success or failed sql
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5310  //06/28/07 `Modify sql to update from correct calls
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	// Modified by: ChuckMiller-(Designer)-(2/22/08 08:37:20)
	Mods_2008_CM_5402  //  `Added retrieval of status for projects   
	Mods_2009_07  //r003 `07/27/09, 10:28:44   `Fix errors when SQL calls fail
	// Modified by: costasmanousakis-(Designer)-(2/25/10 11:43:04)
	Mods_2010_02
	//  `Get the full first name of the expeditor instead of just first initial
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_TEXT:C284($EOL)
C_TIME:C306($SQLDocument_tm)
C_BOOLEAN:C305($0)
$0:=True:C214
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve project file  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
C_LONGINT:C283($Win)
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Modified Projects"; 0; False:C215; ""; 3)


If (SQL_Direct("sp_RTRVProjects"))
	//Arrays used
	//PRJ_PROJECT_NO_al            `[ProjectFile]PF_FileNumber_l                                  `TBL_PRJ_PROJECT.PROJECT_NO
	//PRJ_PARS_DESIGN_atxt       `[ProjectFile]PF_EWO_s                                            `TBL_PRJ_PROJECT.PARS_DESIGN
	//PRJ_COST_AD_ar                   `[ProjectFile]PF_CostAd_r                                        `TBL_PRJ_PROJECT.COST_AD
	//PRJ_EST_TOTAL_COST_ar      `[ProjectFile]PF_EstTotalCost_r                               `TBL_PRJ_PROJECT.EST_TOTAL_COST
	//PRJ_EMPLOYEE_FNAME_atxt  `[ProjectFile]PF_ProjectExpiditer_s (1st initial .)     `TBL_EMPLOYEES.EMPLOYEE_FNAME
	//PRJ_EMPLOYEE_MNAME_atxt `[ProjectFile]PF_ProjectExpiditer_s (1st Initial .)     `TBL_EMPLOYEES.EMPLOYEE_MNAME
	//PRJ_EMPLOYEE_LNAME_atxt  `[ProjectFile]PF_ProjectExpiditer_s (all)                  `TBL_EMPLOYEES.EMPLOYEE_LNAME
	//PRJ_BUSINESS_PHONE_atxt  `[ProjectFile]PF_ProjectExpiditer_s (- all)                `TBL_EMPLOYEES.BUSINESS_PHONE
	C_LONGINT:C283($Loop_l)
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l)
	$SizeOfArray_l:=Size of array:C274(PRJ_PROJECT_NO_al)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	C_TEXT:C284($FirstInitial_s; $MiddleInitial_s)  // Command Replaced was o_C_STRING length was 3
	//$win:=Open window(50;50;550;250;4;"Retrieving Modified Projects")
	OB SET:C1220($progressObj_o; "total"; $SizeOfArray_l)
	For ($Loop_l; 1; $SizeOfArray_l)
		UpdateProgressNew($progressObj_o; $Loop_l)
		//GOTO XY(5;2)
		//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
		//GOTO XY(5;5)
		//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time(*)-$StartTime_tm)
		//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
		//GOTO XY(5;7)
		//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
		
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_PROJECT_NO_al{$Loop_l})
		
		If (Records in selection:C76([PRJ_ProjectFile:117])=0)
			CREATE RECORD:C68([PRJ_ProjectFile:117])
			Inc_Sequence("PF_FileID_l"; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
			[PRJ_ProjectFile:117]PF_FileNumber_l:3:=PRJ_PROJECT_NO_al{$Loop_l}
			SAVE RECORD:C53([PRJ_ProjectFile:117])
			$NewRecords_l:=$NewRecords_l+1
		Else 
			$UpdatedRecords_l:=$UpdatedRecords_l+1
		End if 
		ut_LoadRecord(->[PRJ_ProjectFile:117])
		
		If (PRJ_EMPLOYEE_LNAME_atxt{$Loop_l}#"")
			C_TEXT:C284($FullName_txt)
			//$FirstInitial_s:=Substring(PRJ_EMPLOYEE_FNAME_atxt{$Loop_l};1;1)+". "
			$MiddleInitial_s:=Substring:C12(PRJ_EMPLOYEE_MNAME_atxt{$Loop_l}; 1; 1)+". "
			If ($MiddleInitial_s=". ")
				$MiddleInitial_s:=""
			End if 
			$FullName_txt:=PRJ_EMPLOYEE_FNAME_atxt{$Loop_l}+" "+$MiddleInitial_s+PRJ_EMPLOYEE_LNAME_atxt{$Loop_l}+" : "+PRJ_BUSINESS_PHONE_atxt{$Loop_l}
			[PRJ_ProjectFile:117]PF_ProjectExpediter_s:6:=Substring:C12($FullName_txt; 1; 80)
			//[PRJ_ProjectFile]PF_ProjectExpediter_s:=$FirstInitial_s+$MiddleInitial_s+PRJ_EMPLOYEE_LNAME_atxt{$Loop_l}+" : "+PRJ_BUSINESS_PHONE_atxt{$Loop_l}
		End if 
		[PRJ_ProjectFile:117]PF_EWO_s:4:=PRJ_PARS_DESIGN_atxt{$Loop_l}
		//[PRJ_ProjectFile]PF_CostAd_r:=PRJ_COST_AD_ar{$Loop_l}
		//[PRJ_ProjectFile]PF_EstTotalCost_r:=PRJ_EST_TOTAL_COST_ar{$Loop_l}
		[PRJ_ProjectFile:117]PF_FromSQL_b:11:=True:C214
		If (PRJ_Status_al{$Loop_l}=0)
			[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5:=!00-00-00!
			
			[PRJ_ProjectFile:117]PF_CostAd_r:9:=0
			
			[PRJ_ProjectFile:117]PF_EstTotalCost_r:10:=0
			[PRJ_ProjectFile:117]PF_TIP_s:7:=""
			[PRJ_ProjectFile:117]PF_InitialBidEstimate_r:8:=0
			[PRJ_ProjectFile:117]PF_BidOpened_d:12:=!00-00-00!
			[PRJ_ProjectFile:117]PF_OfficeEstimate_r:13:=0
			[PRJ_ProjectFile:117]PF_TypeCode_s:17:=""
			[PRJ_ProjectFile:117]PF_Description_txt:16:="Dropped - Status inactive"
			
		End if 
		
		SAVE RECORD:C53([PRJ_ProjectFile:117])
		UNLOAD RECORD:C212([PRJ_ProjectFile:117])
		
	End for 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($SizeOfArray_l)+" Project file records retrieved "+$Eol+String:C10($NewRecords_l)+" New project file records created"+$Eol+String:C10($UpdatedRecords_l)+" Project file records updated"+$Eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVProjects Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	$0:=False:C215
End if 
CLOSE WINDOW:C154
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve project file on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""

//End ut_RetrieveModifiedProjects