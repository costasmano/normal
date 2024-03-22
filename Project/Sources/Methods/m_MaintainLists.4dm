//%attributes = {"invisible":true}
// ----------------------------------------------------
// m_MaintainLists
// User name (OS): cjmiller
// Date and time: 06/30/06, 13:26:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
If (User in group:C338(Current user:C182; "Design Access Group")) | (User in group:C338(Current user:C182; "Application Admin"))
	<>LST_MaintainTableProcessID_l:=New process:C317("LST_MaintainListTable"; 0; "List Maintenance")
Else 
	ALERT:C41("You do  not have access to this option ")
End if 
//End m_MaintainLists