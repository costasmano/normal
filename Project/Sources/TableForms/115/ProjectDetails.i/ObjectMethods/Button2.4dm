// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 01/19/06, 12:03:44
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_LONGINT:C283(<>ProjectSelectionProcess_l)
<>SelectionOption_txt:="Program"
<>ProjectProcess_l:=Current process:C322
<>PRJ_SelectedData_txt:=[PRJ_ProjectDetails:115]PRJ_Program_s:23

PRJ_StartOrResumeProjSelection

//End Object Method: Button1