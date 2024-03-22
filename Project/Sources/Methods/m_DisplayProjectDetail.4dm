//%attributes = {"invisible":true}
// ----------------------------------------------------
// m_DisplayProjectDetail
// User name (OS): cjmiller
// Date and time: 04/27/06, 14:04:41
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	Mods_2006_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_LONGINT:C283($ProcessID_l)
$ProcessID_l:=LSpawnProcess("PRJ_DisplayProjects"; <>LStackSize; "Project Details"; True:C214; False:C215)
//End m_DisplayProjectDetail