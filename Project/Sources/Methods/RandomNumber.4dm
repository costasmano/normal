//%attributes = {"invisible":true}
//Method: RandomNumber
//Description
// generate a random number between two numbers -
// code copied from KB https://kb.4d.com/assetid=77777
// Parameters
// $0 : $result_L
// $1 : $start_L
// $2 : $end_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-08T00:00:00, 11:40:28
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	
	C_LONGINT:C283(RandomNumber; $0)
	C_LONGINT:C283(RandomNumber; $1)
	C_LONGINT:C283(RandomNumber; $2)
	
End if 
//

C_LONGINT:C283($0; $vlResult)
C_LONGINT:C283($1; $vlStart)
C_LONGINT:C283($2; $vlEnd)
If (Count parameters:C259=2)
	$vlStart:=$1
	$vlEnd:=$2
	$vlResult:=(((Random:C100 << 15)+Random:C100)%($vlEnd-$vlStart+1))+$vlStart
	$0:=$vlResult
End if 
//End RandomNumber