//%attributes = {"invisible":true}
//Method: DEV_showEventPath
//Description
// show the contents of the DEV_LogEvents_o object filled with data from calls to DEV_logEventPath
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/17/17, 14:28:40
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
End if 
//
C_TEXT:C284($Path_txt)
C_OBJECT:C1216(DEV_LogEvents_o)
ARRAY TEXT:C222($methPaths_atxt; 0)

If (OB Is defined:C1231(DEV_LogEvents_o; "EventPaths"))
	OB GET ARRAY:C1229(DEV_LogEvents_o; "EventPaths"; $methPaths_atxt)
End if 

ut_DisplayArray(->$methPaths_atxt; "List of events"; "Method/Event/Name/Millisec")

G_MyConfirm("Clear log events?")
If (OK=1)
	ARRAY TEXT:C222($all_props_atxt; 0)
	OB GET PROPERTY NAMES:C1232(DEV_LogEvents_o; $all_props_atxt)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($all_props_atxt))
		OB REMOVE:C1226(DEV_LogEvents_o; $all_props_atxt{$loop_L})
	End for 
	
End if 
//End DEV_showEventPath