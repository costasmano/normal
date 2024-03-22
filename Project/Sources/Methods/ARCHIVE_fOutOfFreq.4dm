//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: ARCHIVE_fOutOfFreq
// Description
//  ` copied from fOutofFreq

// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/24/11, 11:54:54
	// First Release
	Mods_2011_10
End if 

If (False:C215)
	//fOutofFreq ($t; $leeway)
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Determine if a bridge is out of frequency given a leeway time
	
	// Modified by: costasmanousakis-(Designer)-(12/30/09 13:50:22)
	Mods_2009_12
	//  `Added Special case for UW Inspections to use the new mods in fUpforInsp
End if 
C_LONGINT:C283($1; $t)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($2; $leeway)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($3; $Waive)

C_BOOLEAN:C305($0; $test)
C_DATE:C307($d)
C_LONGINT:C283($Month)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Year)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

//Store parameters

$t:=$1
$leeway:=$2
If (Count parameters:C259>2)
	$Waive:=$3
Else 
	$Waive:=False:C215
End if 
If (Count parameters:C259>3)
	$d:=$4
Else 
	$d:=Current date:C33(*)
End if 

//Get current date from server
$Month:=Month of:C24($d)
$Year:=Year of:C25($d)

$test:=False:C215
Case of 
	: ($t=7)  //This is a combined inspection
		For ($i; 1; 5)
			If (ARCHIVE_fUpForInsp($Year; $Month; -1; $leeway; $i; $Waive))
				$test:=True:C214  //It is out of frequency
			End if 
		End for 
	: ($t=6)  //This is a combined UW inspection
		For ($i; 8; 9)
			If (ARCHIVE_fUpForInsp($Year; $Month; -1; $leeway; $i; $Waive))
				$test:=True:C214  //It is out of frequency
			End if 
		End for 
	Else 
		$test:=ARCHIVE_fUpForInsp($Year; $Month; -1; $leeway; $t; $Waive)
End case 

$0:=$test  //Return true or false