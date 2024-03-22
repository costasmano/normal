//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/29/09, 15:31:10
	// ----------------------------------------------------
	// Method: PM_GetPctDeteriorationDiff
	// Description
	// 
	// 
	// Parameters
	// $0 : $PctDiff_r
	// $1 : $startYr_L
	// $2  : $EndYr_L
	// ----------------------------------------------------
	
	Mods_2009_06
End if 
C_REAL:C285($0; $PctDiff_r)
$PctDiff_r:=0
C_LONGINT:C283($1; $2)

C_REAL:C285($StartHI_r; $EndHI_r)

$StartHI_r:=PM_GetYearHI($1)
$EndHI_r:=PM_GetYearHI($2)
If ($StartHI_r>0)
	$PctDiff_r:=($StartHI_r-$EndHI_r)/$StartHI_r
	
End if 

$0:=$PctDiff_r