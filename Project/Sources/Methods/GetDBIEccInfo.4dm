//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: GetDBIEccInfo
// Description
// Get the list of DBIEs to be cc'd in a letter
// 
// Parameters
// $1 : Pointer to string array with the districts
// ----------------------------------------------------
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/29/2006 12:55:06)
	Mods_2006_CM06
	Mods_2011_06  // CJ Miller`06/13/11, 17:07:34      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(2/17/12 15:29:42)
	Mods_2012_02
	//  `Changed all string variables to text variables
End if 

C_TEXT:C284($sInitial1; $sInitial2; $sDBIEinitial; $sDistrict)
C_TEXT:C284(vDBIEcc)
C_POINTER:C301($1)

$sInitial1:=""
$sInitial2:=""
$sDBIEinitial:=""
$sDistrict:=""
C_LONGINT:C283($i)
For ($i; 1; 6)
	If (Find in array:C230($1->; String:C10($i))#-1)
		GetAreaBIEinfo(String:C10($i))
		If (($i=1) | ($i=2) | ($i=5))
			$sInitial1:=vAreaBIEinitial
		Else 
			$sInitial2:=vAreaBIEinitial
		End if 
		$sDistrict:=$sDistrict+"DBIE #"+String:C10($i)+", "
	End if 
End for 

$sDistrict:=Substring:C12($sDistrict; 1; Length:C16($sDistrict)-2)  //remove last semicolon

If (($sInitial1#"") & ($sInitial2#""))
	$sDBIEinitial:=$sInitial1+", "+$sInitial2
Else 
	$sDBIEinitial:=$sInitial1+$sInitial2
End if 

vDBIEcc:=$sDBIEinitial+", "+$sDistrict