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
Case of 
	: (PRJ_Item1_atxt=1)
		ALERT:C41("You have selected header data and this is not a legitimate choice")
	: (PRJ_Item1_atxt=0)
		CONFIRM:C162("Are you sure you want nothing selected"; "Yes"; "No")
		If (OK=1)
			<>PRJ_SelectedData_txt:=""
			POST OUTSIDE CALL:C329(<>ProjectProcess_l)
			HIDE PROCESS:C324(Current process:C322)
			PAUSE PROCESS:C319(Current process:C322)
		End if 
	Else 
		<>PRJ_SelectedData_txt:=PRJ_Item1_atxt{PRJ_Item1_atxt}
		
		POST OUTSIDE CALL:C329(<>ProjectProcess_l)
		HIDE PROCESS:C324(Current process:C322)
		PAUSE PROCESS:C319(Current process:C322)
End case 
//End Object Method: Button1