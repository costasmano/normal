//%attributes = {"invisible":true}

//  ut_ReturnDateFromTimeStamp
//----------------------------------------------------
// User name (OS): cjmiller
// Date and time: 09/16/03, 15:48:27
// ----------------------------------------------------
// Description
// This method will reformat time stamp into a date for entry
//
// Parameters
//$1 TEXT (OR STRING) TIME STAMP PASSED IN
//$0 returned date
// ----------------------------------------------------
If (False:C215)
	Mods_2004_CJM02
End if 
C_TEXT:C284($1; $PassedInTimeStamp_txt; $Month_txt; $Day_txt; $Year_txt)
$PassedInTimeStamp_txt:=$1

C_DATE:C307($0; $ReturnDate_d)
$ReturnDate_d:=!00-00-00!


If (Length:C16($PassedInTimeStamp_txt)>7)
	$Year_txt:=Substring:C12($PassedInTimeStamp_txt; 1; 4)
	$Month_txt:=Substring:C12($PassedInTimeStamp_txt; 5; 2)
	$Day_txt:=Substring:C12($PassedInTimeStamp_txt; 7; 2)
	$ReturnDate_d:=Date:C102($Month_txt+"/"+$Day_txt+"/"+$Year_txt)
End if 

$0:=$ReturnDate_d

//end method ut_ReturnDateFromTimeStamp