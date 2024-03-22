//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/23/11, 21:40:39
	// ----------------------------------------------------
	// Method: SCPOA_Array2CheckBox
	// Description
	// 
	// 
	// Parameters
	// $1 : $arrayindex_L
	// ${2} : $checkboxes_ptrs
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_LONGINT:C283($1; $ArrIndx_L)
$ArrIndx_L:=$1
C_POINTER:C301(${2})
C_LONGINT:C283($NumChkBoxes_L; $i)
$NumChkBoxes_L:=Count parameters:C259-1
Case of 
	: (($ArrIndx_L=0) | ($ArrIndx_L=1) | ($ArrIndx_L>Count parameters:C259))
		For ($i; 2; Count parameters:C259)
			${$i}->:=0
		End for 
	Else 
		For ($i; 2; Count parameters:C259)
			If ($i=$ArrIndx_L)
				${$i}->:=1
			Else 
				${$i}->:=0
			End if 
			
		End for 
		
End case 