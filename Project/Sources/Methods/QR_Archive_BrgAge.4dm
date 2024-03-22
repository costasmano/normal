//%attributes = {"shared":true}
//Method: QR_Archive_BrgAge
//Description
//  ` The bridge age of an archive reord at time of archival
// Parameters
//$0 : Age (integer)
//$1: [Year Built (Integer)]
//$2: [Year ReConstructed] (integer)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/10/12
	// ----------------------------------------------------
	//Created : 
	Mods_2012_09
End if 
//
C_LONGINT:C283($0)
C_LONGINT:C283($Age_I; $YrBuilt_I; $YrReconstr_I; $CurrYear)
If (Count parameters:C259>=1)
	C_LONGINT:C283($1)
	$YrBuilt_I:=$1
Else 
	$YrBuilt_I:=[BridgeMHDNBISArchive:139]Item27:82
End if 
If (Count parameters:C259>=2)
	C_LONGINT:C283($2)
	$YrReconstr_I:=$2
Else 
	$YrReconstr_I:=[BridgeMHDNBISArchive:139]Item106:83
End if 
If ($YrReconstr_I>0)
	$YrBuilt_I:=$YrReconstr_I
End if 
$CurrYear:=Num:C11(Substring:C12([BridgeMHDNBISArchive:139]ArchiveReason_s:223; Length:C16("NBI TAPE ")+1))
//$CurrYear:=Year of(Current date(*))
$Age_I:=$CurrYear-$YrBuilt_I
$0:=$Age_I
//End QR_Archive_BrgAge