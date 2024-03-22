//%attributes = {"invisible":true}
//Method: PERS_ConvertStatsToObj
//Description
// Convert login stats tab delim text to an object ; return the object
// Parameters
// $0 : $Stats_o
// $1 : $statstabdelim_txt : tab delim text
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/18/21, 14:39:21
	// ----------------------------------------------------
	//Created : 
	Mods_2021_03
	
	C_OBJECT:C1216(PERS_ConvertStatsToObj; $0)
	C_TEXT:C284(PERS_ConvertStatsToObj; $1)
End if 
//
C_TEXT:C284($1; $statstabdelim_txt)
$statstabdelim_txt:=$1
C_OBJECT:C1216($0; $stats_o)

ARRAY TEXT:C222($MachineList_atxt; 0)
ut_TextToArray([Personnel:42]MachineName_txt:18; ->$MachineList_atxt; Char:C90(Tab:K15:37))
ARRAY OBJECT:C1221($machines_ao; Size of array:C274($MachineList_atxt))
C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274($MachineList_atxt))
	
	ARRAY TEXT:C222($Machinedata_atxt; 0)
	ut_TextToArray($MachineList_atxt{$loop_L}; ->$Machinedata_atxt; ";")
	If (Size of array:C274($Machinedata_atxt)>0)
		OB SET:C1220($machines_ao{$loop_L}; "station"; $Machinedata_atxt{1})
	End if 
	If (Size of array:C274($Machinedata_atxt)>1)
		OB SET:C1220($machines_ao{$loop_L}; "lastdate"; Date:C102($Machinedata_atxt{2}))
	End if 
	If (Size of array:C274($Machinedata_atxt)>2)
		OB SET:C1220($machines_ao{$loop_L}; "count"; Num:C11($Machinedata_atxt{3}))
	End if 
	
End for 
OB SET ARRAY:C1227($stats_o; "stations"; $machines_ao)

$0:=$stats_o
//End PERS_ConvertStatsToObj