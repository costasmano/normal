//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// ut_PRJRetrieveDesignContracts
	// User name (OS): cjmiller
	// Date and time: 01/25/07, 15:36:07
	// ----------------------------------------------------
	// Description
	// 
	//
	// Parameters
	//$0 success or failed sql
	
	// ----------------------------------------------------
	Mods_2006_CJMv2
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //11/21/06, 15:05:48 `add new sql calls to get consultant name and contact data
	Mods_2007_CJM_v5303  //r004 `10/23/07, 16:49:42``Add code to allow for overide  consultant
	Mods_2007_CJM_v54  //r001 `11/13/07, 11:45:28`Make param code no more than 20 characters
	// Modified by: costasmanousakis-(Designer)-(11/15/07 08:45:35)
	Mods_2007_CM12_5302
	// 11/15/07 Moved declaration of  C_LONGINT($UpdateConsultantOveride_l) to outside the iff statement
	//2/18/08 Fix bug where delete record and use set locked set did not work as expected. Changed to check for no record - i.e ecord number -1
	// Modified by: costasmanousakis-(Designer)-(12/16/08 11:31:06)
	Mods_2008_CM_5404  // ("PRJDESRTRV")
	//changes in the Retrieve of design contracts
	Mods_2009_04  //r003  `04/29/09, 11:01:38 `PRJ Design Contract Changes
	Mods_2009_05  //r001  `05/07/09, 11:55:16  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 13:22:16   `Merge PRJ Design Contract Changes
	Mods_2009_07  //r003 `07/27/09, 10:28:00   `Fix errors when SQL calls fail
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	Mods_2019_06_bug  //Modify sql server retrieves to not use ODBC plugin but native 4D SQL
	//Modified by: Chuck Miller (6/18/19 11:13:10)
	Mods_2019_11_bug  //Moved Project retrieve code from development into bug fix 
	//and back as there were a few changes made in testing
	//Modified by: Chuck Miller (11/5/19 13:28:12)
	
End if 
C_TEXT:C284($EOL)
C_LONGINT:C283($win; $NewRecords_l)

ARRAY TEXT:C222($Report_atxt; 1)
C_BOOLEAN:C305($0)
$0:=True:C214
If (<>PL_LPlatfrm<3)
	$EOL:=Char:C90(Carriage return:K15:38)
Else 
	$EOL:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
End if 
C_TIME:C306($StartTime_tm; $RemainingTime_tm; $SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Begin Retrieve design contracts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$EOL
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""
//TRACE
C_OBJECT:C1216($progressObj_o)
$progressObj_o:=ProgressNew("Updating Modified Design Contracts"; 0; False:C215; ""; 3)

//$win:=ut_OpenNewWindow (500;200;5;4;"Retrieving Modified Design Contracts")

If (SQL_Direct("sp_RTRVNewContract"; "Built"))
	READ WRITE:C146([Conslt Address:77])
	READ WRITE:C146([Conslt_Name:127])
	READ WRITE:C146([PRJ_DesignContracts:123])
	READ WRITE:C146([PRJ_ProjectFile:117])
	READ WRITE:C146([PRJ_ProjectDetails:115])
	
	C_LONGINT:C283($Loop_l)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	C_LONGINT:C283($Loop_l)
	$StartTime_tm:=Current time:C178(*)
	C_LONGINT:C283($Loop_l; $SizeOfArray_l; $NewRecords_l; $UpdatedRecords_l; $NewRecords_l; $UpdatedRecords_l; $UpdatedPFRecords_l; $NewPFRecords_l)
	$SizeOfArray_l:=Size of array:C274(CTR_Contract_No_al)
	$NewRecords_l:=0
	$UpdatedRecords_l:=0
	$NewPFRecords_l:=0
	$UpdatedPFRecords_l:=0
	C_TEXT:C284($FirstInitial_s; $MiddleInitial_s)  // Command Replaced was o_C_STRING length was 3
	
	C_LONGINT:C283($ArrayPosition_l; $InnerLoop_l)
	C_LONGINT:C283($Start_l)
	//$Start_l:=Find in array(CTR_ContractType_atxt;"Design@")
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	ARRAY TEXT:C222($CombineKey_atxt; 0)
	ARRAY TEXT:C222($CombineKey_atxt; $SizeOfArray_l)
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
		
		If (CTR_ContractType_atxt{$Loop_l}#"Design@")
			//$Loop_l:=$SizeOfArray_l+1
		Else 
			
			QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractNumber_l:3=CTR_Contract_No_al{$Loop_l})
			
			If (Records in selection:C76([PRJ_DesignContracts:123])=0)
				CREATE RECORD:C68([PRJ_DesignContracts:123])
				Inc_Sequence("DC_DesignProjectID_l"; ->[PRJ_DesignContracts:123]DC_DesignContractID_l:1)
				[PRJ_DesignContracts:123]DC_DesignContractNumber_l:3:=CTR_Contract_No_al{$Loop_l}
				SAVE RECORD:C53([PRJ_DesignContracts:123])
				$NewRecords_l:=$NewRecords_l+1
			Else 
				$UpdatedRecords_l:=$UpdatedRecords_l+1
				ut_LoadRecord(->[PRJ_DesignContracts:123])
			End if 
			[PRJ_DesignContracts:123]DC_Description_txt:4:=CTR_CONTRACT_DESC_atxt{$Loop_l}
			[PRJ_DesignContracts:123]DC_Completion_d:8:=Date:C102(CTR_COMPL_DATE_atxt{$Loop_l})
			[PRJ_DesignContracts:123]DC_ContrTypeDesc_s:14:=Replace string:C233(CTR_CONTR_TypeDesc_atxt{$Loop_l}; "Design -- "; "")
			[PRJ_DesignContracts:123]DC_ContractStatus_s:16:=CTR_CONTRACT_Status_atxt{$Loop_l}
			//[PRJ_DesignContracts]DC_ESTContractAmt_r:=CTR_EST_Contract_Amt_ar{$Loop_l}
			[PRJ_DesignContracts:123]DC_EstComplete_d:11:=Date:C102(CTR_EST_COMPL_DATE_atxt{$Loop_l})
			If (PRJ_EMPLOYEE_LNAME_atxt{$Loop_l}#"")
				$FirstInitial_s:=Substring:C12(PRJ_EMPLOYEE_FNAME_atxt{$Loop_l}; 1; 1)+". "
				$MiddleInitial_s:=Substring:C12(PRJ_EMPLOYEE_MNAME_atxt{$Loop_l}; 1; 1)+". "
				If ($MiddleInitial_s=". ")
					$MiddleInitial_s:=""
				End if 
				[PRJ_DesignContracts:123]DC_ContractManager_s:13:=$FirstInitial_s+$MiddleInitial_s+PRJ_EMPLOYEE_LNAME_atxt{$Loop_l}+" : "+PRJ_BUSINESS_PHONE_atxt{$Loop_l}
			End if 
			
			[PRJ_DesignContracts:123]DC_FromSQL_b:12:=True:C214
			C_TEXT:C284($Combinedkey_s)
			C_LONGINT:C283($UpdateConsultantOveride_l)  //Moved from inside if(601878) statement CM 11/15/07
			$UpdateConsultantOveride_l:=-9
			$Combinedkey_s:=String:C10([PRJ_DesignContracts:123]DC_DesignContractNumber_l:3)+"-"+String:C10(CTR_PROJECT_NO_al{$Loop_l})
			
			$CombineKey_atxt{$Loop_l}:=$Combinedkey_s
			If ((CTR_PROJECT_NO_al{$Loop_l}=601878) | (CTR_PROJECT_NO_al{$Loop_l}=0))
				
			Else 
				C_LONGINT:C283($FileID_l)
				$FileID_l:=0
				QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=CTR_PROJECT_NO_al{$Loop_l})
				If (Records in selection:C76([PRJ_ProjectFile:117])=1)
					QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1=$Combinedkey_s)
					If (Records in selection:C76([PRJ_DCPFJoin:135])=0)
						CREATE RECORD:C68([PRJ_DCPFJoin:135])
						ut_PRJCreateDCPFJoinRecord(->$Combinedkey_s; ->[PRJ_DesignContracts:123]DC_DesignContractID_l:1; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
						SAVE RECORD:C53([PRJ_DCPFJoin:135])
						UNLOAD RECORD:C212([PRJ_DCPFJoin:135])
					Else 
						
						QUERY SELECTION:C341([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DC_DesignProjectID_l:2=[PRJ_DesignContracts:123]DC_DesignContractID_l:1; *)
						QUERY SELECTION:C341([PRJ_DCPFJoin:135];  & ; [PRJ_DCPFJoin:135]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
						If (Records in selection:C76([PRJ_DCPFJoin:135])=0)
							ut_PRJCreateDCPFJoinRecord(->$Combinedkey_s; ->[PRJ_DesignContracts:123]DC_DesignContractID_l:1; ->[PRJ_ProjectFile:117]PF_FileID_l:1)
						End if 
					End if 
				End if 
			End if 
			
			If (PRJ_ConsultantID_al{$Loop_l}>0)
				QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]SQL_VendorID_l:3=PRJ_ConsultantID_al{$Loop_l})
				If (Records in selection:C76([Conslt_Name:127])=0)
					QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2=PRJ_ConsultantName_atxt{$Loop_l})
					If (Records in selection:C76([Conslt_Name:127])=0)
						CREATE RECORD:C68([Conslt_Name:127])
						Inc_Sequence("ConsultantNameID_l"; ->[Conslt_Name:127]ConsultantNameID_l:1)
					End if 
				End if 
				ut_LoadRecord(->[Conslt_Name:127])
				
				[Conslt_Name:127]SQL_VendorID_l:3:=PRJ_ConsultantID_al{$Loop_l}
				[PRJ_DesignContracts:123]ConsultantNameID_l:2:=[Conslt_Name:127]ConsultantNameID_l:1
				
				QUERY:C277([PRJ_DCPFJoin:135]; [PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1=$Combinedkey_s)
				ARRAY LONGINT:C221($FileIds_al; 0)
				ARRAY LONGINT:C221($FileIds_al; Records in selection:C76([PRJ_DCPFJoin:135]))
				SELECTION TO ARRAY:C260([PRJ_DCPFJoin:135]PF_FileID_l:3; $FileIds_al)
				QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PF_FileID_l:3; $FileIds_al)
				SAVE RECORD:C53([PRJ_DesignContracts:123])
				
				QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53#0)
				FIRST RECORD:C50([PRJ_ProjectDetails:115])
				For ($InnerLoop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
					
					If (Not:C34(ut_LoadRecord(->[PRJ_ProjectDetails:115])))
						Repeat 
							IDLE:C311
							uT_DelayUserProcess
						Until (ut_LoadRecord(->[PRJ_ProjectDetails:115]))
					End if 
					If ([PRJ_ProjectDetails:115]DC_DesignContractID_l:54>0)
						QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
						
						If ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
							[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=0
							SAVE RECORD:C53([PRJ_ProjectDetails:115])
						End if 
					End if 
					
					NEXT RECORD:C51([PRJ_ProjectDetails:115])
				End for 
				
				UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
				
				[Conslt_Name:127]ConsultantName_s:2:=PRJ_ConsultantName_atxt{$Loop_l}
				
				SAVE RECORD:C53([Conslt_Name:127])
				
				
				If ([Conslt_Name:127]ConsultantName_s:2#PRJ_ConsultantName_atxt{$Loop_l})
					QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[Conslt_Name:127]ConsultantNameID_l:1)
					Repeat 
						APPLY TO SELECTION:C70([Conslt Address:77]; [Conslt_Name:127]ConsultantName_s:2:=PRJ_ConsultantName_atxt{$Loop_l})
						If (Records in set:C195("LockedSet")#0)
							USE SET:C118("LockedSet")
						End if 
					Until (Records in set:C195("LockedSet")=0)
				End if 
				
			End if 
			
			UNLOAD RECORD:C212([Conslt Address:77])
			UNLOAD RECORD:C212([Conslt_Name:127])
			UNLOAD RECORD:C212([PRJ_DesignContracts:123])
			
			UNLOAD RECORD:C212([PRJ_ProjectFile:117])
			
		End if 
		
	End for 
	UNLOAD RECORD:C212([PRJ_DesignContracts:123])
	UNLOAD RECORD:C212([Conslt_Name:127])
	UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
	UNLOAD RECORD:C212([Conslt Address:77])
	UNLOAD RECORD:C212([PRJ_ProjectFile:117])
	
	//ok now lets deal with obsolete joins
	ALL RECORDS:C47([PRJ_DCPFJoin:135])
	CREATE SET:C116([PRJ_DCPFJoin:135]; "AllJoinsSet")
	SET QUERY DESTINATION:C396(Into set:K19:2; "CurrentJoinSet")
	CREATE EMPTY SET:C140([PRJ_DCPFJoin:135]; "ResultSet")
	QUERY WITH ARRAY:C644([PRJ_DCPFJoin:135]DCPF_Contract_FileNo_s:1; $CombineKey_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	DIFFERENCE:C122("AllJoinsSet"; "CurrentJoinSet"; "ResultSet")
	READ WRITE:C146([PRJ_DCPFJoin:135])
	
	If (Records in set:C195("ResultSet")>0)
		PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Deleting "+String:C10(Records in set:C195("ResultSet"))+"[PRJ_DCPFJoin] join records"+$Eol
		USE SET:C118("ResultSet")
		FIRST RECORD:C50([PRJ_DCPFJoin:135])
		C_LONGINT:C283($InnerLoop_l)
		For ($Loop_l; 1; Records in selection:C76([PRJ_DCPFJoin:135]))
			QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_DCPFJoin:135]PF_FileID_l:3)
			QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]DC_DesignContractID_l:54=[PRJ_DCPFJoin:135]DC_DesignProjectID_l:2)
			FIRST RECORD:C50([PRJ_ProjectDetails:115])
			For ($InnerLoop_l; 1; Records in selection:C76([PRJ_ProjectDetails:115]))
				ut_LoadRecord(->[PRJ_ProjectDetails:115])
				[PRJ_ProjectDetails:115]DC_DesignContractID_l:54:=0
				SAVE RECORD:C53([PRJ_ProjectDetails:115])
				NEXT RECORD:C51([PRJ_ProjectDetails:115])
			End for 
			UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
			NEXT RECORD:C51([PRJ_DCPFJoin:135])
		End for 
		Repeat 
			DELETE SELECTION:C66([PRJ_DCPFJoin:135])
			If (Records in set:C195("LockedSet")>0)
				uT_DelayUserProcess
				USE SET:C118("LockedSet")
			End if 
		Until (Records in set:C195("LockedSet")=0)
		
	End if 
	CLEAR SET:C117("AllJoinsSet")
	CLEAR SET:C117("CurrentJoinSet")
	CLEAR SET:C117("ResultSet")
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String:C10($SizeOfArray_l)+" Design Contract records retrieved"+$eol+String:C10($NewRecords_l)+" New design contract  records created"+$Eol+String:C10($UpdatedRecords_l)+" Design contract  records  updated"+$Eol
	
Else 
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"Calll to sp_RTRVNewContract Failed"+$Eol
	PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+SQL_ReturnErrorDescriptions+$eol
	$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
	SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
	CLOSE DOCUMENT:C267($SQLDocument_tm)
	PRJ_SQLRetrieveStats_txt:=""
	
	$0:=False:C215
End if 
Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))

//PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+String($NewPFRecords_l)+" New Project File Records created"+$eol+String($UpdatedPFRecords_l)+" Project file records updated"+$eol
PRJ_SQLRetrieveStats_txt:=PRJ_SQLRetrieveStats_txt+"End Retrieve design contracts  on "+String:C10(Current date:C33(*); 7)+" at "+String:C10(Current time:C178(*))+$Eol
$SQLDocument_tm:=Append document:C265(RTRV_DocmentPath_txt)
SEND PACKET:C103($SQLDocument_tm; PRJ_SQLRetrieveStats_txt)
CLOSE DOCUMENT:C267($SQLDocument_tm)
PRJ_SQLRetrieveStats_txt:=""

//CLOSE WINDOW

//End ut_PRJRetrieveDesignContracts