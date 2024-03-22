//%attributes = {"invisible":true}
//Method: AddToDateTime
//Description
// add to a date and time similar to add to date include a time variable
// update the data pointed to in $1 and $2 
// Parameters
// $1 : $date_ptr
// $2 : $time_ptr
// $3 : $years_L
// $4 : $months_L
// $5 : $days_L
// $6 : $TimeToadd_t - to subtract time multiply by -1 (-1*?12:00:00?)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/26/20, 15:39:02
	// ----------------------------------------------------
	//Created : 
	Mods_2020_08_bug
	
	C_POINTER:C301(AddToDateTime; $1; $2)
	C_LONGINT:C283(AddToDateTime; $3; $4; $5)
	C_TIME:C306(AddToDateTime; $6)
	
End if 
//

C_POINTER:C301($1; $2)
C_LONGINT:C283($3; $4; $5)
C_TIME:C306($6)

C_DATE:C307($StartDate_d; $EndDate_d)
C_TIME:C306($StartTime_t; $EndTime_t)
C_LONGINT:C283($extraDays_L)

$StartDate_d:=$1->
$StartTime_t:=$2->

$EndTime_t:=$StartTime_t+$6

C_TIME:C306($Next_t)
Case of 
	: ($EndTime_t>?24:00:00?)
		$Next_t:=$EndTime_t%?24:00:00?
		$extraDays_L:=$EndTime_t\?24:00:00?
		$EndTime_t:=$Next_t
		
	: ($EndTime_t<?00:00:00?)
		$Next_t:=$EndTime_t%?24:00:00?
		$Next_t:=$Next_t+?24:00:00?
		$extraDays_L:=$EndTime_t\?24:00:00?
		$extraDays_L:=$extraDays_L-1  //since negative time we are already a day back at least.
		
		$EndTime_t:=$Next_t
End case 

//now adjust the date
$EndDate_d:=Add to date:C393($StartDate_d; $3; $4; ($5+$extraDays_L))

$1->:=$EndDate_d
$2->:=$EndTime_t
//End AddToDateTime