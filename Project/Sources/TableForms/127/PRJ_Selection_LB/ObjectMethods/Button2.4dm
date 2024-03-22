// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 03/09/06, 10:49:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 

<>PRJ_SelectedData_txt:="Skip"

If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
	POST OUTSIDE CALL:C329(<>ProjectProcess_l)
	//HIDE PROCESS(Current process)
	//PAUSE PROCESS(Current process)
	CANCEL:C270
Else 
	CANCEL:C270
End if 
//End Object Method: Button1