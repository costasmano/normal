//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/03/11, 11:45:25
	// ----------------------------------------------------
	// Method: SCPOA_EvtSamplCkBx_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $ChkBox_ptr
	// $2 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2011_05
	
End if 
C_LONGINT:C283($FormEvent_L)
C_POINTER:C301($1; $ChkBox_ptr)
$ChkBox_ptr:=$1
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$FormEvent_L:=$2
Else 
	$FormEvent_L:=Form event code:C388
End if 

SCPOA_CheckBox_OM(->SCPOA_EvtMonitSampl_txt; ->SCPOA_EvtSamplOther_txt; ->SCPOA_EvtSamplCkBoxes_aptr; $ChkBox_ptr; $FormEvent_L)