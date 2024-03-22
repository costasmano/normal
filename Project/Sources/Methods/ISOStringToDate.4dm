//%attributes = {"invisible":true}
//Method: ISOStringToDate
// Description
// Convert and iso string YYYY-MM-DD to date variable
// 
// Parameters
// $0 : $date_d
// $1 : $IsoDate_txt
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:28:52
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if   //

C_DATE:C307($0)
C_TEXT:C284($1)

C_DATE:C307($date_d)
C_TEXT:C284($IsoDate_txt)
$IsoDate_txt:=$1

$date_d:=Date:C102(Substring:C12($IsoDate_txt; 6; 2)+"/"+Substring:C12($IsoDate_txt; 9; 2)+"/"+Substring:C12($IsoDate_txt; 1; 4))

$0:=$date_d
//
//End ISOStringToDate