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
		C_LONGINT:C283($Col_L; $Row_L)
		LISTBOX GET CELL POSITION:C971(*; "ConsultantName_LB"; $Col_L; $Row_L)
		GOTO SELECTED RECORD:C245([Conslt_Name:127]; $Row_L)
		
		
		<>PRJ_SelectedData_txt:=String:C10([Conslt_Name:127]ConsultantNameID_l:1)
		If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
			POST OUTSIDE CALL:C329(<>ProjectProcess_l)
			CANCEL:C270
		Else 
			CANCEL:C270
		End if 
End case 

//End Object Method: Button1