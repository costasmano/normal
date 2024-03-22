//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/11, 17:38:00
	// ----------------------------------------------------
	// Method: SCPOA_SetEnterable_Name
	// Description
	// 
	// 
	// Parameters
	// $1 : $VarName_txt
	// $2 : $Enterable_b
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_TEXT:C284($1; $VarName_txt)
C_BOOLEAN:C305($2; $Enterable_b)
$VarName_txt:=$1
$Enterable_b:=$2
OBJECT SET ENTERABLE:C238(*; $VarName_txt; $Enterable_b)
If ($Enterable_b)
	OBJECT SET RGB COLORS:C628(*; $VarName_txt; -1; -2; -11)
Else 
	OBJECT SET RGB COLORS:C628(*; $VarName_txt; -1; -11; -11)
End if 