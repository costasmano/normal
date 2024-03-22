// ----------------------------------------------------
// Object Method: PRJ_BridgeSection_atxt
// User name (OS): cjmiller
// Date and time: 04/12/07, 10:47:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	// Modified by: costasmanousakis-(Designer)-(9/28/09 12:15:52)
	Mods_2009_09
	//  `  don't make change if text selected is "select..." or ""
End if 
If (Form event code:C388=On Clicked:K2:4)
	If ((PRJ_BridgeSection_atxt{PRJ_BridgeSection_atxt}#"select@") & (PRJ_BridgeSection_atxt{PRJ_BridgeSection_atxt}#""))
		[PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44:=PRJ_BridgeSection_atxt{PRJ_BridgeSection_atxt}
	End if 
End if 
//End Object Method: PRJ_BridgeSection_atxt