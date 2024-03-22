//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/17/09, 17:26:22
	// ----------------------------------------------------
	// Method: DCM_WorkOrderDataControl
	// Description
	// 
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT"; "CLEAR")
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		C_BLOB:C604(DCM_WODefDesc_x; DCM_WORepScope_x; DCM_WOTraff_x; DCM_WOEquip_x; DCM_WOSched_x; DCM_WOSpec_x)
		ARRAY POINTER:C280(DCM_WOBlobs_aptr; 6)
		DCM_WOBlobs_aptr{1}:=->DCM_WODefDesc_x
		DCM_WOBlobs_aptr{2}:=->DCM_WORepScope_x
		DCM_WOBlobs_aptr{3}:=->DCM_WOTraff_x
		DCM_WOBlobs_aptr{4}:=->DCM_WOEquip_x
		DCM_WOBlobs_aptr{5}:=->DCM_WOSched_x
		DCM_WOBlobs_aptr{6}:=->DCM_WOSpec_x
		
	: ($Task_txt="LOAD")
	: ($Task_txt="SAVE")
	: ($Task_txt="CLEAR")
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(DCM_WOBlobs_aptr))
			SET BLOB SIZE:C606(DCM_WOBlobs_aptr{$loop_L}->; 0)
		End for 
		
End case 
