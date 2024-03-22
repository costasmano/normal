// ----------------------------------------------------
// Object Method: PRJ_ProjectTypes_atxt
// User name (OS): cjmiller
// Date and time: 01/10/06, 13:09:36
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r003 `10/09/07, 11:45:42`Add chapter 85
End if 
If (Form event code:C388=On Clicked:K2:4)
	If (PRJ_ProjectTypes_atxt>1)
		[PRJ_ProjectDetails:115]PRJ_ProjectType_s:4:=PRJ_ProjectTypes_atxt{PRJ_ProjectTypes_atxt}
	End if 
	
End if 
//End Object Method: PRJ_ProjectTypes_atxt