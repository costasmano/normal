//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/11/09, 08:50:16
	// ----------------------------------------------------
	// Method: F_dateToString
	// Description
	// 
	// 
	// Parameters
	// $0 : $DateString_txt
	// $1 : $date_d
	// $2 : $format (Optional)
	// ----------------------------------------------------
	
	Mods_2009_05
End if 
C_TEXT:C284($0; $DateString_txt)
C_DATE:C307($1; $date_d)
$date_d:=$1
If ($date_d#!00-00-00!)
	If (Count parameters:C259>1)
		$DateString_txt:=String:C10($date_d; $2)
	Else 
		$DateString_txt:=String:C10($date_d)
	End if 
Else 
	$DateString_txt:=""
End if 

$0:=$DateString_txt
