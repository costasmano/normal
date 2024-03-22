//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/07, 18:32:23
	// ----------------------------------------------------
	// Method: FN_Date2DateTime
	// Description
	// 
	// 
	// Parameters
	// $0: $DateTime_S (A30)
	// $1 : $DateIn_d
	// $2 : $TimeIn_tm (Optional)
	// ----------------------------------------------------
	
	Mods_2007_CM10a
End if 
C_TEXT:C284($0; $DateTime_S)  // Command Replaced was o_C_STRING length was 30
C_DATE:C307($1; $DateIn_d)
C_TIME:C306($2; $TimeIn_tm)

If (Count parameters:C259>0)
	$DateIn_d:=$1
Else 
	$DateIn_d:=Current date:C33(*)
End if 
If (Count parameters:C259>1)
	$TimeIn_tm:=$2
Else 
	$TimeIn_tm:=?00:00:00?
End if 
$DateTime_S:=String:C10(Year of:C25($DateIn_d); "0000")+"-"+String:C10(Month of:C24($DateIn_d); "00")+"-"+String:C10(Day of:C23($DateIn_d); "00")+"T"
$DateTime_S:=$DateTime_S+String:C10($TimeIn_tm; HH MM SS:K7:1)+".000"

$0:=$DateTime_S