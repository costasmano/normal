//%attributes = {"invisible":true}
// Method: RtgReq_Utility
// Description
//  ` Utiltiy method  for RatingRequests
//  ` Parameters
//  ` $1 : $Task_txt ("SETUPSYSPARAMS" | "STARTOUTPUTLIST" | "DEFAULTSORT" | "LOADCBARRAYS" | 
//  `  ` "LOADCONTRACTS" | "LOADASSIGNMENTS"
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:43:11
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 10:29:26)
	Mods_2021_10
	//  `unload record after default sort
End if 
//
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="SETUPSYSPARAMS")
		C_TEXT:C284($prompt_txt)
		$prompt_txt:=" - Enter comma separated values with no spaces between values"
		ut_UpdateSysParameter("RTGREQ_Priority"; $prompt_txt)
		ut_UpdateSysParameter("RTGREQ_AEActions"; $prompt_txt)
		ut_UpdateSysParameter("RTGREQ_BIEActions"; $prompt_txt)
		ut_UpdateSysParameter("RTGREQ_StEActions"; $prompt_txt)
		ut_UpdateSysParameter("RTGREQ_Status"; $prompt_txt)
		
	: ($Task_txt="STARTOUTPUTLIST")
		C_TEXT:C284($LB_BaseName_txt)
		$LB_BaseName_txt:="RtgReq"
		QUERY:C277([RatingRequests:154]; [RatingRequests:154]Status_s:15#"Assigned"; *)
		QUERY:C277([RatingRequests:154];  & ; [RatingRequests:154]Status_s:15#"Rejected@")
		LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
		LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
		LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
		
	: ($Task_txt="DEFAULTSORT")
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		ORDER BY:C49([RatingRequests:154]; [Bridge MHD NBIS:1]Item2:60; >; [Bridge MHD NBIS:1]BDEPT:1; >)
		UNLOAD RECORD:C212([RatingRequests:154])
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		
	: ($Task_txt="LOADCBARRAYS")
		ARRAY TEXT:C222(RtgReq_AEAction_cb; 0)
		ARRAY TEXT:C222(RtgReq_Prio_cb; 0)
		ARRAY TEXT:C222(RtgReq_BIEAction_cb; 0)
		ARRAY TEXT:C222(RtgReq_StEAction_cb; 0)
		ARRAY TEXT:C222(RtgReq_Status_cb; 0)
		
		C_TEXT:C284($ParamValue_txt)
		$ParamValue_txt:=ut_GetSysParameter("RTGREQ_Priority")
		ut_TextToArray($ParamValue_txt; ->RtgReq_Prio_cb)
		
		$ParamValue_txt:=ut_GetSysParameter("RTGREQ_AEActions")
		ut_TextToArray($ParamValue_txt; ->RtgReq_AEAction_cb)
		
		$ParamValue_txt:=ut_GetSysParameter("RTGREQ_BIEActions")
		ut_TextToArray($ParamValue_txt; ->RtgReq_BIEAction_cb)
		
		$ParamValue_txt:=ut_GetSysParameter("RTGREQ_StEActions")
		ut_TextToArray($ParamValue_txt; ->RtgReq_StEAction_cb)
		
		$ParamValue_txt:=ut_GetSysParameter("RTGREQ_Status")
		ut_TextToArray($ParamValue_txt; ->RtgReq_Status_cb)
		
	: ($Task_txt="LOADCONTRACTS")
		QUERY:C277([Contracts:79]; [Contracts:79]ContractType:2="@rating"; *)
		QUERY:C277([Contracts:79];  | ; [Contracts:79]ContractType:2="")
		ARRAY LONGINT:C221(RtgReq_Contracts_cb; 0)
		ARRAY TEXT:C222($contracts_atxt; 0)
		SELECTION TO ARRAY:C260([Contracts:79]ContractNo:1; $contracts_atxt)
		ARRAY LONGINT:C221(RtgReq_Contracts_cb; Size of array:C274($contracts_atxt))
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(RtgReq_Contracts_cb))
			RtgReq_Contracts_cb{$loop_L}:=Num:C11($contracts_atxt{$loop_L})
		End for 
		SORT ARRAY:C229(RtgReq_Contracts_cb; >)
		
	: ($Task_txt="LOADASSIGNMENTS")
		QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=String:C10([RatingRequests:154]ContractNo_L:17))
		SELECTION TO ARRAY:C260([Contract Assignments:83]AssignNo:2; RtgReq_ContrAssign_cb)
		SORT ARRAY:C229(RtgReq_ContrAssign_cb; >)
		
End case 

//End RtgReq_Utility