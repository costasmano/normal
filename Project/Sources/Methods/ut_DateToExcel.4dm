//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/11/10, 19:35:50
	// ----------------------------------------------------
	// Method: ut_DateToExcel
	// Description
	//  ` Return a string of date in eXcel yyyy-mm-dd
	
	// 
	// Parameters
	// $0 : $ExcelDate_txt
	// $1 : $Date
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(3/4/11 16:24:33)
	Mods_2011_03
	//  `If a date is Zero  return a blank string
End if 
C_DATE:C307($1; $Date)
$Date:=$1
If ($Date=!00-00-00!)
	$0:=""
Else 
	$0:=String:C10(Year of:C25($date); "0000")+"-"+String:C10(Month of:C24($date); "00")+"-"+String:C10(Day of:C23($date); "00")
End if 
