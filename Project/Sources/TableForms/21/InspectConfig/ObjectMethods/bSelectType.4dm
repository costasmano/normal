If (False:C215)
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(2/16/09 11:43:03)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: Costas Manousakis-(Designer)-(5/7/12 11:09:07)
	Mods_2012_05
	//Flood
	// Modified by: Costas Manousakis-(Designer)-(11/2/12 16:25:18)
	Mods_2012_11
End if 

ARRAY TEXT:C222($objNames_atxt; 0)
ARRAY POINTER:C280($object_aptr; 0)
FORM GET OBJECTS:C898($objNames_atxt; $object_aptr)
C_LONGINT:C283($check_L; $loop_L)
$check_L:=0
C_TEXT:C284(INSP_SelectedNewInspType_txt)
For ($loop_L; 1; Size of array:C274($objNames_atxt))
	If ($objNames_atxt{$loop_L}="@btn")
		$check_L:=$check_L+$object_aptr{$loop_L}->
	End if 
End for 

If (($check_L=0) & (INSP_SelectedNewInspType_txt=""))
	ALERT:C41("You must select an Inspection Type!!!")
Else 
	ACCEPT:C269
End if 