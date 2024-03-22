//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/08/11, 19:01:23
	// ----------------------------------------------------
	// Method: f_CountIFTrue
	// Description
	//  ` Return a count of 1 if the argument passed is true. A way to count items in 
	//  ` a quick report. Then to get the count, sum the result of the column
	// 
	// Parameters
	// $0 : $Count_L
	// $1 : $TrueFalse_b
	// ----------------------------------------------------
	
	Mods_2011_02
End if 
C_BOOLEAN:C305($1)
C_LONGINT:C283($0)
If ($1)
	$0:=1
Else 
	$0:=0
End if 