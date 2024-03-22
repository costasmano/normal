//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:55:26
	// ----------------------------------------------------
	// Method: BRG_ReplWidth
	// Description
	// Calculate the Replacement width for a bridge structure
	// 
	// Parameters
	// $1 : Required width (REAL)
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_REAL:C285($0; $ReplWidth)
C_REAL:C285($1; $RyWdth)
$RyWdth:=$1
If ([Bridge MHD NBIS:1]Item51:96>=$RyWdth)
	$RyWdth:=[Bridge MHD NBIS:1]Item51:96
End if 

If ([Bridge MHD NBIS:1]Item52:97>[Bridge MHD NBIS:1]Item51:96)
	$ReplWidth:=$RyWdth+([Bridge MHD NBIS:1]Item52:97-[Bridge MHD NBIS:1]Item51:96)
Else 
	$ReplWidth:=$RyWdth
End if 

$0:=$ReplWidth