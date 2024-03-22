//%attributes = {"invisible":true}
If (False:C215)
	//fCombineInsp ($Year; $Month; $m; $leeway; $Waive)
	//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
	//Determine if a bridge is due for inspection for Routine, Critical, Closed, 
	//Special
	
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 11:27:12)
	Mods_2013_09
	//  `added handling of tunnel inspections
End if 
C_LONGINT:C283($Year)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Month)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($m)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($leeway)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($Waive)

C_BOOLEAN:C305($test)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER

//Store parameters

$Year:=$1
$Month:=$2
$m:=$3
$leeway:=$4
$Waive:=$5

$test:=False:C215
C_LONGINT:C283($start_L; $end_L)
C_BOOLEAN:C305(BRGList_TunnelsOnly_b)
If (BRGList_TunnelsOnly_b)
	$start_L:=21
	$end_L:=27
Else 
	$start_L:=1
	$end_L:=5
End if 
For ($i; $start_L; $end_L)  //Do all inspections except underwater (1 thru 5)
	If (fUpforInsp($Year; $Month; $m; $leeway; $i; $Waive))
		$test:=True:C214  //It needs to be inspected
	End if 
End for 
$0:=$test  //Return true or false