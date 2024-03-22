//%attributes = {"invisible":true}
//Method: GEN_GetTimeZoneOffset
// Description:
// Returns the current timezone offset as text like:
// "-08:00:00" if in Pacific Standard Time
// "-06:00:00" if in Central America
// "+04:30:00" if in Kabul
// "+12:00:00" if in Fiji
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/26/18, 14:07:10
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09
	C_TEXT:C284(GEN_GetTimeZoneOffset; $0)
End if 

C_TEXT:C284($0; $local_DATE; $gmt_DATE; $gmt_TIME)
$local_DATE:=Substring:C12(String:C10(Current date:C33; ISO date:K1:8); 1; 10)
$gmt_DATE:=Substring:C12(String:C10(Current date:C33; ISO date GMT:K1:10); 1; 10)
$gmt_TIME:=Substring:C12(String:C10(Current date:C33; ISO date GMT:K1:10); 12; 8)
If ($gmt_DATE=$local_DATE)
	// - time
	$0:="-"+$gmt_TIME
Else 
	// + time
	$0:="+"+String:C10(?24:00:00?-Time:C179($gmt_TIME))
End if 
//End GEN_GetTimeZoneOffset