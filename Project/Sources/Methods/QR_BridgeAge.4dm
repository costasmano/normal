//%attributes = {"shared":true}
// Method: QR_BridgeAge
// Description
// Return the age of the current bridge record based on Item 27 and 106.
//
// Parameters
//$0 : Age (integer)
//$1: [Year Built (Integer)]
//$2: [Year ReConstructed] (integer)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/05, 14:58:07
	// ----------------------------------------------------
	Mods_2005_CM12
End if 
C_LONGINT:C283($0; $1; $2)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Age_I; $YrBuilt_I; $YrReconstr_I; $CurrYear)  //Command Replaced was o_C_INTEGER
If (Count parameters:C259>=1)
	$YrBuilt_I:=$1
Else 
	$YrBuilt_I:=[Bridge MHD NBIS:1]Item27:83
End if 
If (Count parameters:C259>=2)
	$YrReconstr_I:=$2
Else 
	$YrReconstr_I:=[Bridge MHD NBIS:1]Item106:84
End if 
If ($YrReconstr_I>0)
	$YrBuilt_I:=$YrReconstr_I
End if 
$CurrYear:=Year of:C25(Current date:C33(*))
$Age_I:=$CurrYear-$YrBuilt_I
$0:=$Age_I