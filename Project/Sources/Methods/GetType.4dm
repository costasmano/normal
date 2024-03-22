//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/11, 08:44:54
	// ----------------------------------------------------
	// Method: Method: GetType
	//Description: This method returns the type of data.
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 

//Method: GetType
C_LONGINT:C283($1)  //Command Replaced was o_C_INTEGER

Case of 
	: ($1=0) | ($1=2)
		$0:="String"
	: ($1=1) | ($1=8) | ($1=9)
		//$0:="Number"
		$0:="String"
	: ($1=4) | ($1=11)
		//$0:="DateTime"
		$0:="String"
End case 