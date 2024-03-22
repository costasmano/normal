//%attributes = {}
//fOutofFreq ($t; $leeway)
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Determine if a bridge is out of frequency given a leeway time

If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/30/09 13:50:22)
	Mods_2009_12
	//  `Added Special case for UW Inspections to use the new mods in fUpforInsp
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 11:25:44)
	Mods_2013_09
	//  `added handling of tunnel inspections
End if 

C_LONGINT:C283($1; $t)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($2; $leeway)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($3; $Waive)

C_BOOLEAN:C305($0; $test)
C_DATE:C307($d)
C_LONGINT:C283($Month)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($Year)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($i)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER

//Store parameters

$t:=$1
$leeway:=$2
If (Count parameters:C259>2)
	$Waive:=$3
Else 
	$Waive:=False:C215
End if 

//Get current date from server
$d:=Current date:C33(*)
$Month:=Month of:C24($d)
$Year:=Year of:C25($d)

$test:=False:C215
Case of 
	: ($t=7)  //This is a combined inspection
		For ($i; 1; 5)
			If (fUpforInsp($Year; $Month; -1; $leeway; $i; $Waive))
				$test:=True:C214  //It is out of frequency
			End if 
		End for 
	: ($t=6)  //This is a combined UW inspection
		For ($i; 8; 9)
			If (fUpforInsp($Year; $Month; -1; $leeway; $i; $Waive))
				$test:=True:C214  //It is out of frequency
			End if 
		End for 
	: ($t=28)  //This is a combined Tunnel inspection
		For ($i; 21; 27)
			If (fUpforInsp($Year; $Month; -1; $leeway; $i; $Waive))
				$test:=True:C214  //It is out of frequency
			End if 
		End for 
	Else 
		$test:=fUpforInsp($Year; $Month; -1; $leeway; $t; $Waive)
End case 

$0:=$test  //Return true or false