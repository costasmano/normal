//%attributes = {"invisible":true}
//Method: NTI_GetMyPending
//Description
// Make a selection of [TIN_Inspections] for the pending list
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/17, 12:40:34
	// ----------------------------------------------------
	//Created : 
	Mods_2017_02
	// Modified by: Costas Manousakis-(Designer)-(12/17/18 12:15:02)
	Mods_2018_12_bug
	//  `Fixed case statement for users in TunnelEngineer group.
	// Modified by: Costas Manousakis-(Designer)-(12/20/18 10:59:22)
	Mods_2018_12_bug
	//  `Cleaned up method of retrieving pending based on insp resp - CallReference #593 
	//  `sort the selection by the TIN sort method NTI_SortByFormula.
End if 
//
CREATE EMPTY SET:C140([TIN_Inspections:184]; "MYREVIEWS")
CREATE EMPTY SET:C140([TIN_Inspections:184]; "MYINSPECTIONS")
ARRAY TEXT:C222($TunnelInspEng_atxt; 0)
ARRAY TEXT:C222($TunnelEng_atxt; 0)
C_BLOB:C604($RO_State_x)
$RO_State_x:=ut_db_SaveROState
READ ONLY:C145(*)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="TunnelInspEng@")
SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupName_s:2; $TunnelInspEng_atxt)
QUERY:C277([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2="TunnelEngineer@")
QUERY SELECTION:C341([PERS_Groups:109]; [PERS_Groups:109]PERS_GroupName_s:2#"TunnelEngineer")
SELECTION TO ARRAY:C260([PERS_Groups:109]PERS_GroupName_s:2; $TunnelEng_atxt)

QUERY:C277([TIN_Inspections:184]; [TIN_Inspections:184]InspApproval:6#BMS Approved)
CREATE SET:C116([TIN_Inspections:184]; "ALLPENDING")
Case of 
	: (User in group:C338(Current user:C182; "Design Access Group"))
		CREATE SET:C116([TIN_Inspections:184]; "MYREVIEWS")
	: (GRP_UserInGroup("TunnelEngineer")=1)
		CREATE SET:C116([TIN_Inspections:184]; "MYREVIEWS")
	: ((GRP_UserInGroupList(->$TunnelInspEng_atxt)>0) | (GRP_UserInGroupList(->$TunnelEng_atxt)>0))
		//TIE or TE for district /agency
		C_LONGINT:C283($loop_L)
		C_TEXT:C284($inspResp_txt)
		For ($loop_L; 1; Size of array:C274($TunnelInspEng_atxt))
			If (GRP_UserInGroup($TunnelInspEng_atxt{$loop_L})>0)
				$inspResp_txt:=""
				If ($TunnelInspEng_atxt{$loop_L}="TunnelInspEngD@")
					//district
					$inspResp_txt:="DIST"+Replace string:C233($TunnelInspEng_atxt{$loop_L}; "TunnelInspEngD"; "")
				Else 
					//agency
					$inspResp_txt:=Replace string:C233($TunnelInspEng_atxt{$loop_L}; "TunnelInspEng"; "")
				End if 
				//ARRAY TEXT($TINs_atxt;0)
				//QUERY([NTI_TunnelInfo];[NTI_TunnelInfo]NTI_InspResp=$inspResp_txt)
				//SELECTION TO ARRAY([NTI_TunnelInfo]NTI_i1_s;$TINs_atxt)
				USE SET:C118("ALLPENDING")
				SET QUERY DESTINATION:C396(Into set:K19:2; "PENDDISTAGENCY")
				//QUERY SELECTION WITH ARRAY([TIN_Inspections]NTI_i1_S;$TINs_atxt)
				QUERY SELECTION:C341([TIN_Inspections:184]; [NTI_TunnelInfo:181]NTI_InspResp:73=$inspResp_txt)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				UNION:C120("MYREVIEWS"; "PENDDISTAGENCY"; "MYREVIEWS")
				CLEAR SET:C117("PENDDISTAGENCY")
			End if 
			
		End for 
		
		For ($loop_L; 1; Size of array:C274($TunnelEng_atxt))
			If (GRP_UserInGroup($TunnelEng_atxt{$loop_L})>0)
				$inspResp_txt:=""
				If ($TunnelEng_atxt{$loop_L}="TunnelEngineerD@")
					//district
					$inspResp_txt:="DIST"+Replace string:C233($TunnelEng_atxt{$loop_L}; "TunnelEngineerD"; "")
				Else 
					//agency
					$inspResp_txt:=Replace string:C233($TunnelEng_atxt{$loop_L}; "TunnelEngineer"; "")
				End if 
				
				//ARRAY TEXT($TINs_atxt;0)
				//QUERY([NTI_TunnelInfo];[NTI_TunnelInfo]NTI_InspResp=$inspResp_txt)
				//SELECTION TO ARRAY([NTI_TunnelInfo]NTI_i1_s;$TINs_atxt)
				USE SET:C118("ALLPENDING")
				SET QUERY DESTINATION:C396(Into set:K19:2; "PENDDISTAGENCY")
				//QUERY SELECTION WITH ARRAY([TIN_Inspections]NTI_i1_S;$TINs_atxt)
				QUERY SELECTION:C341([TIN_Inspections:184]; [NTI_TunnelInfo:181]NTI_InspResp:73=$inspResp_txt)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				UNION:C120("MYREVIEWS"; "PENDDISTAGENCY"; "MYREVIEWS")
				CLEAR SET:C117("PENDDISTAGENCY")
				
			End if 
			
		End for 
		
	Else 
		If (GRP_UserInGroup("TIN_AddInspections_ALL")>1)
			//these are consultants
			//get all of my company and any where i'm the proj manager
			SET QUERY DESTINATION:C396(Into set:K19:2; "MYREVIEWS")
			QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]ProjManager:14=<>CurrentUser_PID; *)
			QUERY SELECTION:C341([TIN_Inspections:184];  | ; [TIN_Inspections:184]Agency:13=<>PERS_MyCompany_txt)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
		End if 
End case 

USE SET:C118("ALLPENDING")
SET QUERY DESTINATION:C396(Into set:K19:2; "MYINSPECTIONS")
QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]TeamLeader:11=<>CurrentUser_PID)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY DESTINATION:C396(Into set:K19:2; "TMMEMBERSET")
QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Insp_TmMembers:187]PersonID:2=<>CurrentUser_PID)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
UNION:C120("MYINSPECTIONS"; "TMMEMBERSET"; "MYINSPECTIONS")
SET QUERY DESTINATION:C396(Into set:K19:2; "TMMEMBERSET")
QUERY SELECTION:C341([TIN_Inspections:184]; [TIN_Inspections:184]CreatedBy:8=<>CurrentUser_Name)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
UNION:C120("MYINSPECTIONS"; "TMMEMBERSET"; "MYINSPECTIONS")

CLEAR SET:C117("TMMEMBERSET")
CLEAR SET:C117("ALLPENDING")
UNION:C120("MYREVIEWS"; "MYINSPECTIONS"; "MYREVIEWS")
USE SET:C118("MYREVIEWS")
CLEAR SET:C117("MYREVIEWS")
CLEAR SET:C117("MYINSPECTIONS")
ORDER BY FORMULA:C300([TIN_Inspections:184]; NTI_SortByFormula(1))
ut_db_RestoreROState($RO_State_x)

//End NTI_GetMyPending