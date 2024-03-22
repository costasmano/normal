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
	Mods_2011_06  // CJ Miller`06/14/11, 15:48:38      ` Type all local variables for v11
	//Fix bug where $BDept_s could be blank
End if 

PRJ_ProcessAvailable


PRJ_ProcessUnassigned

C_TEXT:C284($BDept_s)  // Command Replaced was o_C_STRING length was 6
$BDept_s:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
PRJ_ProcessExisting($BDept_s)


ACCEPT:C269
//End Object Method: Button1