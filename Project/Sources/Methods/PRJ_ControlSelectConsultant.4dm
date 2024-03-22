//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_ControlSelectConsultant
// User name (OS): cjmiller
// Date and time: 11/27/07, 11:24:39
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v54  //r003 `11/27/07, 11:24:40
End if 
C_LONGINT:C283(<>ProjectSelectionProcess_l)
If (PRJ_ConsultantName_txt="")
	
	<>SelectionOption_txt:="Consultant"
	<>ProjectProcess_l:=Current process:C322
	<>PRJ_SelectedData_txt:=PRJ_ConsultantName_txt
	
	PRJ_StartOrResumeProjSelection
	
Else 
	QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2=PRJ_ConsultantName_txt)
	
	If (Records in selection:C76([Conslt_Name:127])=1)
		
	Else 
		<>SelectionOption_txt:="Consultant"
		<>ProjectProcess_l:=Current process:C322
		<>PRJ_SelectedData_txt:=PRJ_ConsultantName_txt
		PRJ_StartOrResumeProjSelection
		
	End if 
	
End if 

//End PRJ_ControlSelectConsultant