//%attributes = {"invisible":true}
// Method: ISODateTime
// Description
// return an ISO datetime string 
// 
// Parameters
// $0 : $ISODateTime_txt
// $1 : $date_d
// $2 : $time_t
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:26:42
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
C_TEXT:C284($0)
C_DATE:C307($1)
C_TIME:C306($2)

$0:=Substring:C12(String:C10($1; ISO date:K1:8); 1; 10)+"T"+Substring:C12(String:C10($2; ISO time:K7:8); 12)


//End ISODateTime