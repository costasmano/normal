//%attributes = {"invisible":true}
// Test_Memory
// Description
// show memory statistics
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): charlesmiller
	// Date and time: 03/06/09, 14:12:07
	// ----------------------------------------------------
	Mods_2009_03  //CJM  r001   `03/06/09, 14:12:11`Upgrade from open form window to open window
	// Modified by: Costas Manousakis-(Designer)-(8/12/20 13:00:52)
	Mods_2020_08_bug
	//  `use results from GET MEMORY STATISTICS command.
End if 

ARRAY TEXT:C222($names_atxt; 0)
ARRAY REAL:C219($values_ar; 0)
ARRAY REAL:C219($count_ar; 0)

GET MEMORY STATISTICS:C1118(1; $names_atxt; $values_ar; $count_ar)  //general info
C_TEXT:C284($vsText; vtMessage)
C_LONGINT:C283($loop_L)
vtMessage:="General memory info\n"
For ($loop_L; 1; Size of array:C274($names_atxt))
	vtMessage:=vtMessage+$names_atxt{$loop_L}+" :\t "+String:C10($values_ar{$loop_L}; "###,###,###,###,###,###")+" count "+String:C10($count_ar{$loop_L})+"\n"
End for 
GET MEMORY STATISTICS:C1118(2; $names_atxt; $values_ar; $count_ar)  //db cache
vtMessage:=vtMessage+"\nDatabase cache occupancy statistics\n"

For ($loop_L; 1; Size of array:C274($names_atxt))
	vtMessage:=vtMessage+$names_atxt{$loop_L}+" :\t "+String:C10($values_ar{$loop_L}; "###,###,###,###,###,###")+" count "+String:C10($count_ar{$loop_L})+"\n"
End for 
ut_MessageDia(vtMessage; "Memory Status"; 1; 5)

//End Test_Memory