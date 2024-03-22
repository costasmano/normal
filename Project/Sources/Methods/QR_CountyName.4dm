//%attributes = {"shared":true}
// ----------------------------------------------------
// Method: QR_CountyName
// Description
// Get County name for a Bridge
//
// Parameters
// $0 : $cName 
// $1 : $bDePt (Optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/06/05, 12:15:53
	
	Mods_2005_CM16
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_TEXT:C284($1; $bDePt)  // Command Replaced was o_C_STRING length was 6
C_TEXT:C284($0; $cName)
C_TEXT:C284($cCode)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($k)
If (Count parameters:C259=1)
	$bDePt:=$1
Else 
	$bDePt:=[Bridge MHD NBIS:1]BDEPT:1
End if 
$cName:=""
$cCode:=Get_County($bDePt)
$k:=Find in array:C230(<>aCountyCode; $cCode)
If ($k>0)
	$cName:=<>aCountyName{$k}
End if 

$0:=$cName