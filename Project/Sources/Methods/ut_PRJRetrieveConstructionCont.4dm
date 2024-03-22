//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_PRJRetrieveConstructionCont
// User name (OS): cjmiller
// Date and time: 04/27/06, 16:16:41
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2007_CJM_v5310
	Mods_2007_CJM_v5310  //06/20/07 `Add data to stored procedure and a new stored procedure call
	Mods_2007_CM12_5301  //10/01/07 `Check for more than one constr project.
	// Modified by: costasmanousakis-(Designer)-(10/10/2007 13:54:41)
	Mods_2007_CM12_5301  // Added array PRJ_ComplDate_2_atxt to get more recent completion dates
	// Modified by: costasmanousakis-(Designer)-(10/11/2007 16:33:42)
	Mods_2007_CM12_5301  //Go thru all [PRJ_ProjectDetails] recs with PF_FileID>0 to update construction contracts.
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	Mods_2009_07  //r003 `07/27/09, 10:39:03   `Fix errors when SQL calls fail
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2013_09  //r001 `Only create or update [PRJ_ConstructionProject] if PRJ_ConstructionContract_atxt{$Loop_l} is not blank
	//Modified by: Charles Miller (9/4/13 13:16:30)
	
	// Modified by: manousakisc (1/25/2016)
	Mods_2016_01_bug
	//  ` in sp_RTRVSpecData reduce to use only planstoprint and toCashier - other fields were deprecated in new Tish
	
	Mods_2017_05  //removed call to sp_RTRVSpecData
	//Modified by: Chuck Miller (5/30/17 12:44:10)
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_TEXT:C284($EOL)
C_TIME:C306($SQLDocument_tm)
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm)
C_LONGINT:C283($win)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve construction contracts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Construction Contracts")
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Construction Contracts"; 0; False:C215; ""; 3)

ARRAY TEXT:C222($Error_axt; 1)
If (SQL_Direct("sp_RTRVConstData"))
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l)
	$SizeOfArray_l:=Size of array:C274(PRJ_ConstructionContract_atxt)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	C_TEXT:C284($FirstInitial_s; $MiddleInitial_s)  // Command Replaced was o_C_STRING length was 3
	C_BOOLEAN:C305($BlankConstructionContract_b)
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
		$BlankConstructionContract_b:=False:C215
		QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_SQLID_l:13=PRJ_SQLID_al{$Loop_l})
		
		If (PRJ_ConstructionContract_atxt{$Loop_l}="")
			$BlankConstructionContract_b:=True:C214
			
		Else 
			If (Records in selection:C76([PRJ_ConstructionProject:116])=0)
				QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5=PRJ_ConstructionContract_atxt{$Loop_l})
				If ([PRJ_ConstructionProject:116]CP_SQLID_l:13=0)
					
				Else 
					REDUCE SELECTION:C351([PRJ_ConstructionProject:116]; 0)
				End if 
			End if 
			
			
		End if 
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_FileNumber_ar{$Loop_l})
		If (Records in selection:C76([PRJ_ProjectFile:117])=1)
			ut_LoadRecord(->[PRJ_ProjectFile:117])
			If (Date:C102(PRJ_AdvertisedDate_atxt{$Loop_l})#!00-00-00!)  // Mods_2007_CM12_5301 10/01/07
				If (Date:C102(PRJ_AdvertisedDate_atxt{$Loop_l})>[PRJ_ProjectFile:117]PF_Advertised_d:14)
					[PRJ_ProjectFile:117]PF_Advertised_d:14:=Date:C102(PRJ_AdvertisedDate_atxt{$Loop_l})
				End if 
			End if 
			
			SAVE RECORD:C53([PRJ_ProjectFile:117])
			If (Not:C34($BlankConstructionContract_b))  //Only create or update if PRJ_ConstructionContract_atxt{$Loop_l} is not blank
				If (Records in selection:C76([PRJ_ConstructionProject:116])=0)
					CREATE RECORD:C68([PRJ_ConstructionProject:116])
					Inc_Sequence("CP_ConstructionProj"; ->[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)
					$NewRecords_l:=$NewRecords_l+1
				Else 
					ut_LoadRecord(->[PRJ_ConstructionProject:116])
					$UpdatedRecords_l:=$UpdatedRecords_l+1
				End if 
				C_BOOLEAN:C305($NewDataFound_B)
				$NewDataFound_B:=True:C214
				Case of 
					: ([PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5#PRJ_ConstructionContract_atxt{$Loop_l})
					: ([PRJ_ConstructionProject:116]CP_SQLID_l:13#PRJ_SQLID_al{$Loop_l})
					: ([PRJ_ConstructionProject:116]CP_NTP_d:12#Date:C102(PRJ_NTPDate_atxt{$Loop_l}))
					: ([PRJ_ConstructionProject:116]PF_FileID_l:11#[PRJ_ProjectFile:117]PF_FileID_l:1)
					: ([PRJ_ConstructionProject:116]CP_Awarded_d:4#Date:C102(PRJ_AwardDate_atxt{$Loop_l}))
					: ([PRJ_ConstructionProject:116]CP_BidEstimate_r:6#PRJ_OFFiceEst_ar{$Loop_l})
					: ([PRJ_ConstructionProject:116]CP_LowBid_r:7#PRJ_BidAmt_ar{$Loop_l})
					: ([PRJ_ConstructionProject:116]CP_BidOpening_d:3#Date:C102(PRJ_BidOpenedDate_atxt{$Loop_l}))
					: ([PRJ_ConstructionProject:116]CP_Completion_d:8#Date:C102(PRJ_ComplDate_atxt{$Loop_l}))
					Else 
						$NewDataFound_B:=False:C215
				End case 
				
				If (Date:C102(PRJ_ComplDate_2_atxt{$Loop_l})#!00-00-00!)
					If (Date:C102(PRJ_ComplDate_2_atxt{$Loop_l})>[PRJ_ConstructionProject:116]CP_Completion_d:8)
						[PRJ_ConstructionProject:116]CP_Completion_d:8:=Date:C102(PRJ_ComplDate_2_atxt{$Loop_l})
						$NewDataFound_B:=True:C214
					End if 
				End if 
				
				
				
				If ($NewDataFound_B)
					[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5:=PRJ_ConstructionContract_atxt{$Loop_l}
					[PRJ_ConstructionProject:116]CP_SQLID_l:13:=PRJ_SQLID_al{$Loop_l}
					[PRJ_ConstructionProject:116]CP_NTP_d:12:=Date:C102(PRJ_NTPDate_atxt{$Loop_l})
					[PRJ_ConstructionProject:116]PF_FileID_l:11:=[PRJ_ProjectFile:117]PF_FileID_l:1
					[PRJ_ConstructionProject:116]CP_Awarded_d:4:=Date:C102(PRJ_AwardDate_atxt{$Loop_l})
					[PRJ_ConstructionProject:116]CP_BidEstimate_r:6:=PRJ_OFFiceEst_ar{$Loop_l}
					[PRJ_ConstructionProject:116]CP_LowBid_r:7:=PRJ_BidAmt_ar{$Loop_l}
					[PRJ_ConstructionProject:116]CP_BidOpening_d:3:=Date:C102(PRJ_BidOpenedDate_atxt{$Loop_l})
					[PRJ_ConstructionProject:116]CP_Completion_d:8:=Date:C102(PRJ_ComplDate_atxt{$Loop_l})
					
					//Next lines commented out as call to sp_RTRVSpecData no longer being made as
					//[PRJ_ConstructionProject]CP_PlansToPrint_d and
					//[PRJ_ConstructionProject]CP_ToCashier_d no longer being updated
					//If (SQL_Do ("sp_RTRVSpecData";"Built"))
					//  //If (Size of array(PRJ_SpecsFromPrint_as)>0)
					//If (Size of array(PRJ_PlansToPrint_as)>0)
					//  //[PRJ_ConstructionProject]CP_SpecsFromPrint_d:=Date(PRJ_SpecsFromPrint_as{1})
					//  //[PRJ_ConstructionProject]CP_SpecsToPrint_d:=Date(PRJ_SpecsToPrint_as{1})
					//  //[PRJ_ConstructionProject]CP_PlansFromPrint_d:=Date(PRJ_PlansFromPrint_as{1})
					//[PRJ_ConstructionProject]CP_PlansToPrint_d:=Date(PRJ_PlansToPrint_as{1})
					//[PRJ_ConstructionProject]CP_ToCashier_d:=Date(PRJ_ToCashier_as{1})
					//End if 
					//End if 
					[PRJ_ConstructionProject:116]CP_FromSQL_b:10:=True:C214
					SAVE RECORD:C53([PRJ_ConstructionProject:116])
				End if 
			End if 
		End if 
		UNLOAD RECORD:C212([PRJ_ConstructionProject:116])
		UNLOAD RECORD:C212([PRJ_ProjectFile:117])
		
		
	End for 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($SizeOfArray_l)+" Construction Contract records retrieved"+$eol+String:C10($NewRecords_l)+" New Construction contract  records created"+$Eol+String:C10($UpdatedRecords_l)+" Construction contract  records  updated"+$Eol
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Call to sp_RTRVConstData Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	
End if 
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3>0)
//QUERY SELECTION([PRJ_ProjectDetails];[PRJ_ProjectDetails]CP_ConstructionProjectID_l=0)
FIRST RECORD:C50([PRJ_ProjectDetails:115])
$SizeOfArray_l:=Records in selection:C76([PRJ_ProjectDetails:115])

$progressObj_o:=ProgressNew("Updating Project Details"; Records in selection:C76([PRJ_ProjectDetails:115]); False:C215; ""; 3)

SET WINDOW TITLE:C213("Updating Project Details")
For ($Loop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
	UpdateProgressNew($progressObj_o; $Loop_l)
	//GOTO XY(5;2)
	//MESSAGE("Updating "+String($Loop_l)+" out of "+String($SizeOfArray_l))
	//GOTO XY(5;5)
	//$RemainingTime_tm:=(($SizeOfArray_l/$Loop_l)-1)*(Current time(*)-$StartTime_tm)
	//MESSAGE("Estimated time remaining is "+Time string($RemainingTime_tm))
	//GOTO XY(5;7)
	//MESSAGE("Elapsed time is "+Time string(Current time(*)-$StartTime_tm))
	
	QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]PF_FileID_l:11=[PRJ_ProjectDetails:115]PF_FileID_l:3)
	If (Records in selection:C76([PRJ_ConstructionProject:116])>0)  // Mods_2007_CM12_5301 10/01/07
		If (Records in selection:C76([PRJ_ConstructionProject:116])>1)
			QUERY SELECTION:C341([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5#"")
		End if 
		ORDER BY:C49([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_Awarded_d:4; <)
		If ([PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2#[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1)
			ut_LoadRecord(->[PRJ_ProjectDetails:115])
			[PRJ_ProjectDetails:115]CP_ConstructionProjectID_l:2:=[PRJ_ConstructionProject:116]CP_ConstructionProjectID_l:1
			SAVE RECORD:C53([PRJ_ProjectDetails:115])
		End if 
	End if 
	NEXT RECORD:C51([PRJ_ProjectDetails:115])
End for 
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
//CLOSE WINDOW
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve construction contracts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL

//End ut_PRJRetrieveConstructionCont