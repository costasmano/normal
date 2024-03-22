//%attributes = {"shared":true}
//Method: QR_YearBuiltReBuilt
//Description
//  ` Return the Year Built or rebuilt based on items 27 or 106
// ` Parameters
//  ` $0 : $YrBltRBlt_L
//  ` $1 : $Item27_L (optional) - if not zero - must pass $2
//  ` $2 : $Item106_L (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/21/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_11
End if 
//
C_LONGINT:C283($0; $YrBltRBlt_L)
$YrBltRBlt_L:=0
C_LONGINT:C283($Item27_L; $Item106_L)
$Item27_L:=[Bridge MHD NBIS:1]Item27:83
$Item106_L:=[Bridge MHD NBIS:1]Item106:84
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	C_LONGINT:C283($2)
	$Item27_L:=$1
	$Item106_L:=$2
	
	$YrBltRBlt_L:=$Item27_L
End if 

If ($Item106_L>0)
	$YrBltRBlt_L:=$Item106_L
End if 

$0:=$YrBltRBlt_L
//End QR_YearBuiltReBuilt