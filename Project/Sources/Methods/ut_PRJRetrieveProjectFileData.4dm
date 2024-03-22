//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// ut_PRJRetrieveProjectFileData
	// User name (OS): cjmiller
	// Date and time: 05/18/07, 
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJMv2
	Mods_2007_CJM_v5310  //06/28/07 `Modify sql to update from correct calls
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	Mods_2008_CJM_v001  //r001 `01/22/08, 16:15:41     
	Mods_2008_CJM_v001  //r001 `01/22/08, 16:15:41   
	// Modified by: costasmanousakis-(Designer)-(11/14/08 12:22:12)
	Mods_2008_CM_5404
	//Remove CharRets, LineFeeds, Tabs from description and trim it  
	Mods_2009_07  //r003 `07/27/09, 10:36:46   `Fix errors when SQL calls fail
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_10_bug  //Modified Poject retrieve to create CSV files for all returned data
	//Modified by: Chuck Miller (10/24/19 11:07:37)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_TEXT:C284($EOL)
ARRAY TEXT:C222($Report_atxt; 1)
C_LONGINT:C283($win)
C_BOOLEAN:C305($0)
$0:=True:C214
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Project File data  "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Project File data")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Project File data"; 0; False:C215; ""; 3)


If (SQL_Direct("sp_VW_PRJ_PROJECT"))
	If (False:C215)  //This is now false as we are creating for each sql call
		C_TEXT:C284($res_txt)
		
		$res_txt:=ut_ArraysToText(","; \
			->PRJ_PROJECT_NO_al; \
			->PRJFileAdDate_atxt; \
			->PRJ_AdCost_ar; \
			->PRJ_FedPartCost_ar; \
			->PRJTipYear_atxt; \
			->PRJ_TipCost_ar; \
			->PRJ_BidOpenedDate_atxt; \
			->PRJ_OfficeEst_ar; \
			->PRJ_Description_atxt)
		
		C_TEXT:C284($doc_txt)
		ARRAY TEXT:C222($PRJ_Description_atxt; 0)
		
		$doc_txt:=Select document:C905(""; ".csv"; "Pick a CSV file"; File name entry:K24:17; $PRJ_Description_atxt)
		$doc_txt:=$PRJ_Description_atxt{1}
		TEXT TO DOCUMENT:C1237($doc_txt; $res_txt)
		SHOW ON DISK:C922($doc_txt)
	End if 
	//Arrays used
	//(PRJ_PROJECT_NO_al;0)
	//PRJFileAdDate_atxt;0)
	//(PRJ_AdCost_ar;0)
	//(PRJ_FedPartCost_ar;0)
	//(PRJTipYear_atxt;0)
	//(PRJ_TipCost_ar;0)
	//(PRJ_BidOpenedDate_atxt;0)
	//(PRJ_OfficeEst_ar;0)
	//PRJ_TypeCode_as
	//PRJ_Description_atxt
	
	C_LONGINT:C283($Loop_l)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_LONGINT:C283($Loop_l)
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l)
	$SizeOfArray_l:=Size of array:C274(PRJ_PROJECT_NO_al)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	
	OB SET:C1220($progressObj_o; "total"; $SizeOfArray_l)
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
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
		
		If (Records in selection:C76([PRJ_ProjectFile:117])=1)
			ut_LoadRecord(->[PRJ_ProjectFile:117])
			[PRJ_ProjectFile:117]PF_FromSQL_b:11:=True:C214
			[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5:=Date:C102(PRJFileAdDate_atxt{$Loop_l})
			If (PRJ_AdCost_ar{$Loop_l}>0)
				[PRJ_ProjectFile:117]PF_CostAd_r:9:=PRJ_AdCost_ar{$Loop_l}
			Else 
				[PRJ_ProjectFile:117]PF_CostAd_r:9:=PRJ_FedPartCost_ar{$Loop_l}
			End if 
			[PRJ_ProjectFile:117]PF_EstTotalCost_r:10:=PRJ_FedPartCost_ar{$Loop_l}
			[PRJ_ProjectFile:117]PF_TIP_s:7:=PRJTipYear_atxt{$Loop_l}
			[PRJ_ProjectFile:117]PF_InitialBidEstimate_r:8:=PRJ_TipCost_ar{$Loop_l}
			[PRJ_ProjectFile:117]PF_BidOpened_d:12:=Date:C102(PRJ_BidOpenedDate_atxt{$Loop_l})
			[PRJ_ProjectFile:117]PF_OfficeEstimate_r:13:=PRJ_OfficeEst_ar{$Loop_l}
			[PRJ_ProjectFile:117]PF_TypeCode_s:17:=PRJ_TypeCode_as{$Loop_l}
			[PRJ_ProjectFile:117]PF_Description_txt:16:=Replace string:C233(f_TrimStr(PRJ_Description_atxt{$Loop_l}; True:C214; True:C214); <>sCR; "_")
			[PRJ_ProjectFile:117]PF_Description_txt:16:=Replace string:C233([PRJ_ProjectFile:117]PF_Description_txt:16; <>sLF; "")
			[PRJ_ProjectFile:117]PF_Description_txt:16:=Replace string:C233([PRJ_ProjectFile:117]PF_Description_txt:16; <>sTAB; " ")
			
			SAVE RECORD:C53([PRJ_ProjectFile:117])
			UNLOAD RECORD:C212([PRJ_ProjectFile:117])
			$UpdatedRecords_l:=$UpdatedRecords_l+1
		End if 
		
	End for 
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($UpdatedRecords_l)+" Project file records updated"+$eol
	
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_VW_PRJ_PROJECT Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$0:=False:C215
End if 
//CLOSE WINDOW
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Project File data on  "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol

//End ut_PRJRetrieveProjectFileData