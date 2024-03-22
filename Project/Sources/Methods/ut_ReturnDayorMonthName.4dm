//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/11/16, 10:30:12
//----------------------------------------------------
//Method: ut_ReturnDayorMonthName
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_06  // 
	//Modified by: Chuck Miller (8/11/16 10:30:14)
	
	C_TEXT:C284(ut_ReturnDayorMonthName; $1; $0)
	C_LONGINT:C283(ut_ReturnDayorMonthName; $2)
	
End if 
C_TEXT:C284($1; $0)
C_LONGINT:C283($2)

Case of 
	: ($1="Init")
		
		ARRAY TEXT:C222(<>Weekdays_atxt; 7)
		
		<>Weekdays_atxt{1}:="Sunday"
		<>Weekdays_atxt{2}:="Monday"
		<>Weekdays_atxt{3}:="Tuesday"
		<>Weekdays_atxt{4}:="Wednesday"
		<>Weekdays_atxt{5}:="Thursday"
		<>Weekdays_atxt{6}:="Friday"
		<>Weekdays_atxt{7}:="Saturday"
	: ($1="Month")
		$0:=<>aMonths{$2}
	: ($1="Day")
		$0:=<>Weekdays_atxt{$2}
End case 

//End ut_ReturnDayorMonthName

