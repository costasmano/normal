//%attributes = {"invisible":true}
//Method: ut_PRJRetrieveProjectEvents
//Description
//  ` Retrieve the project events and store the latest PNF, PIF and PRC events
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/19/12, 16:09:48
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
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
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve Project Event data  "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Project Event data")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Project Event data"; 0; False:C215; ""; 3)

If (SQL_Direct("sp_VW_PRJ_TASKEVENTS"))
	//Arrays used
	//PRJ_PROJECT_NO_al;0
	//PRJ_TASK_TYPE_CODE_atxt;0
	//PRJ_EVENT_TYPE_DESC_atxt;0
	//PRJ_EVENT_ORDER_aL;0
	//PRJ_EVENT_DATE_atxt;0
	
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
			
			Case of 
				: (PRJ_TASK_TYPE_CODE_atxt{$Loop_l}="PNF")
					[PRJ_ProjectFile:117]PF_PNFDate_d:18:=Date:C102(PRJ_EVENT_DATE_atxt{$Loop_l})
					[PRJ_ProjectFile:117]PF_PNFEvent_s:21:=PRJ_EVENT_TYPE_DESC_atxt{$Loop_l}
				: (PRJ_TASK_TYPE_CODE_atxt{$Loop_l}="PIF")
					
					Case of 
						: (PRJ_EVENT_TYPE_DESC_atxt{$Loop_l}="PRC Subm@")
							[PRJ_ProjectFile:117]PF_PRCSubmDate_d:24:=Date:C102(PRJ_EVENT_DATE_atxt{$Loop_l})
						: (PRJ_EVENT_TYPE_DESC_atxt{$Loop_l}="PIF@")
							[PRJ_ProjectFile:117]PF_PIFDate_d:19:=Date:C102(PRJ_EVENT_DATE_atxt{$Loop_l})
					End case 
					
					[PRJ_ProjectFile:117]PF_PIFEvent_s:22:=PRJ_EVENT_TYPE_DESC_atxt{$Loop_l}
				: (PRJ_TASK_TYPE_CODE_atxt{$Loop_l}="PRC")
					
					If (PRJ_EVENT_TYPE_DESC_atxt{$Loop_l}="@Approved@")
						[PRJ_ProjectFile:117]PF_PRCApprDate_d:20:=Date:C102(PRJ_EVENT_DATE_atxt{$Loop_l})
					End if 
					[PRJ_ProjectFile:117]PF_PRCEvent_s:23:=PRJ_EVENT_TYPE_DESC_atxt{$Loop_l}
					
			End case 
			
			SAVE RECORD:C53([PRJ_ProjectFile:117])
			UNLOAD RECORD:C212([PRJ_ProjectFile:117])
			$UpdatedRecords_l:=$UpdatedRecords_l+1
		End if 
		
	End for 
	
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($UpdatedRecords_l)+" Project file records updated"+$eol
	
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_VW_PRJ_TASKEVENTS Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$0:=False:C215
End if 
//CLOSE WINDOW
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve Project File Event data on  "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol

//End ut_PRJRetrieveProjectEvents
