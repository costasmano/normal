//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/23/07, 14:56:54
	// ----------------------------------------------------
	// Method: FN_LastNameFirst
	// Description
	// Return the name is lastname, Firstname from FN Mi LN
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM10
End if 
C_TEXT:C284($0; $LastFirst_txt; $1; $FnMiLn_txt)
C_TEXT:C284($Fn_txt; $Ln_txt)
$FnMiLn_txt:=$1
$LastFirst_txt:=""
$Fn_txt:=Substring:C12($FnMiLn_txt; 1; (Position:C15(" "; $FnMiLn_txt)-1))
$Ln_txt:=Replace string:C233($FnMiLn_txt; ($Fn_txt+" "); "")
If (Position:C15(" "; $Ln_txt)>0)
	$Ln_txt:=Substring:C12($Ln_txt; (Position:C15(" "; $Ln_txt)+1))
End if 
$LastFirst_txt:=$Ln_txt+", "+$Fn_txt

$0:=$LastFirst_txt