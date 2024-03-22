//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/11, 17:33:19
	// ----------------------------------------------------
	// Method: SCPOA_SetEnterable_Var
	// Description
	// 
	// 
	// Parameters
	// $1 : $Var_ptr
	// $2 : $Enterable_b
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_POINTER:C301($1; $Var_ptr)
C_BOOLEAN:C305($2; $Enterable_b)
$Var_ptr:=$1
$Enterable_b:=$2
OBJECT SET ENTERABLE:C238($Var_ptr->; $Enterable_b)
If ($Enterable_b)
	OBJECT SET RGB COLORS:C628($Var_ptr->; -1; -2; -11)
Else 
	OBJECT SET RGB COLORS:C628($Var_ptr->; -1; -11; -11)
End if 