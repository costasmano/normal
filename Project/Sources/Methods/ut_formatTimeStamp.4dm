//%attributes = {"invisible":true}
//Method: ut_formatTimeStamp
//Description
// format a time stamp string to YYYY-MM-DD HH:MM
// Parameters
// $0 : $ReturnStamp_txt
// $1 : $TimeStamp_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/04/13, 12:46:36
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
End if 
//
C_TEXT:C284($0; $ReturnStamp_txt)
C_TEXT:C284($1; $TimeStamp_txt)

$TimeStamp_txt:=$1
$ReturnStamp_txt:=""

If (Length:C16($TimeStamp_txt)>4)
	
	$ReturnStamp_txt:=Substring:C12($TimeStamp_txt; 1; 4)+"-"+Substring:C12($TimeStamp_txt; 5; 2)+"-"+Substring:C12($TimeStamp_txt; 7; 2)
	
	If (Length:C16($TimeStamp_txt)>8)
		$ReturnStamp_txt:=$ReturnStamp_txt+" "+Substring:C12($TimeStamp_txt; 9; 2)+":"+Substring:C12($TimeStamp_txt; 11; 2)
	End if 
Else 
	$ReturnStamp_txt:=$TimeStamp_txt
End if 

$0:=$ReturnStamp_txt
//End ut_formatTimeStamp