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
	Mods_2007_CJM_v5303
End if 

Case of 
	: (Records in set:C195("UserSet")>1)
		ALERT:C41("You can not select more than one consultant")
	: (Records in set:C195("UserSet")=0)
		ALERT:C41("You must select a consultant")
	Else 
		USE SET:C118("UserSet")
		<>PRJ_SelectedData_txt:=String:C10([Conslt_Name:127]ConsultantNameID_l:1)
		If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
			POST OUTSIDE CALL:C329(<>ProjectProcess_l)
			HIDE PROCESS:C324(Current process:C322)
			PAUSE PROCESS:C319(Current process:C322)
		Else 
			CANCEL:C270
		End if 
End case 

//End Object Method: Button1