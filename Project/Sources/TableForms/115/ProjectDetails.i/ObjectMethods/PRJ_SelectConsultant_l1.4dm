// ----------------------------------------------------
// Object Method: PRJ_SelectConsultant_l
// User name (OS): cjmiller
// Date and time: 01/19/06, 12:03:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r006 `11/06/07, 10:38:25
	Mods_2009_05  //r001  `05/07/09, 11:28:58  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
End if 

If ([PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53=0)
	C_TEXT:C284($Message_txt)
	C_TEXT:C284($OKButton_s; $SkipButton_s)  // Command Replaced was o_C_STRING length was 15
	
	If (PRJ_ConsultantName_txt#"")
		$Message_txt:="Override consultant named "+PRJ_ConsultantName_txt+" by entering consultant or first few characters. and then press Override"
		$OKButton_s:="Override"
		$SkipButton_s:="Do NOT Override"
	Else 
		$Message_txt:="Add consultant to this project by entering consultant or first few characters. an"+"d then press Add"
		$OKButton_s:="Add"
		$SkipButton_s:="Do NOT Add"
	End if 
	
	
	C_LONGINT:C283(<>ProjectSelectionProcess_l)
	<>SelectionOption_txt:="OverideConsultant"
	<>ProjectProcess_l:=Current process:C322
	C_TEXT:C284($msg_txt)
	$msg_txt:="Override Design Contract Consultant"+Char:C90(Carriage return:K15:38)
	$msg_txt:=$msg_txt+"Enter consultant or first few characters. and then press proceed"
	<>PRJ_SelectedData_txt:=ut_Request($Message_txt; ->DummyField_txt; ""; $OKButton_s; $SkipButton_s)
	If (OK=1)
		PRJ_StartOrResumeProjSelection
		OBJECT SET TITLE:C194(PRJ_SelectConsultant_l; "Remove Override")
	End if 
	
Else 
	CONFIRM:C162("Are you sure you wish to remove Consultant named "+PRJ_ConsultantName_txt; "Yes"; "No")
	If (OK=1)
		[PRJ_ProjectDetails:115]PRJ_ConsultantOverideID_l:53:=0
		
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
		PRJ_LoadDesignContractData
		OBJECT SET TITLE:C194(PRJ_SelectConsultant_l; "Override Consultant")
		PRJ_LoadPage_0
		PRJ_ControlPageMovement
	End if 
End if 

//End Object Method: Button1