//%attributes = {"invisible":true}
//Method: INSPRTG_makeHeaderParam
//Description
// make object for paramaters INSPRTG_LTRHeader
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/20, 14:03:44
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
End if 
//

C_OBJECT:C1216($param_o; $entry1_o; $entry2_o; $entry3_o; $entry4_o)
ARRAY OBJECT:C1221($entries_ao; 0)

OB SET:C1220($entry1_o; "contracttype"; "Regular Inspection"; "header"; "Statewide Bridge Inspections")
OB SET:C1220($entry2_o; "contracttype"; "Regular Rating"; "header"; "Statewide Bridge Ratings")
OB SET:C1220($entry3_o; "contracttype"; "Complex Inspection"; "header"; "Statewide - Complex Structures Inspection Services")
OB SET:C1220($entry4_o; "contracttype"; "BRI Inspection"; "header"; "Statewide Inspection of Non-NBI Structures")
APPEND TO ARRAY:C911($entries_ao; $entry1_o)
APPEND TO ARRAY:C911($entries_ao; $entry2_o)
APPEND TO ARRAY:C911($entries_ao; $entry3_o)
APPEND TO ARRAY:C911($entries_ao; $entry4_o)
OB SET ARRAY:C1227($param_o; "List"; $entries_ao)
C_TEXT:C284($param_txt)
$param_txt:=JSON Stringify:C1217($param_o; *)
C_TEXT:C284(vsForward)
ut_SaveSysParam("INSPRTG_LTRHeader"; $param_txt)

//End INSPRTG_makeHeaderParam