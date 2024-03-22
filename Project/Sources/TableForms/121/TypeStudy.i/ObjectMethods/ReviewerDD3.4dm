// ----------------------------------------------------
// Object Method: PRJ_GradingStatus_atxt
// User name (OS): cjmiller
// Date and time: 01/26/06, 11:56:32
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2  //05/25/07, 
End if 
If (Form event code:C388=On Clicked:K2:4)
	[PRJ_TypeStudy:121]TYP_GradingStatus_l:15:=Num:C11(Substring:C12(PRJ_GradingStatus_atxt{PRJ_GradingStatus_atxt}; 1; Position:C15(" "; PRJ_GradingStatus_atxt{PRJ_GradingStatus_atxt})))
End if 
//End Object Method: PRJ_GradingStatus_atxt