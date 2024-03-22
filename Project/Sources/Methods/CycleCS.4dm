//%attributes = {"invisible":true}
//GP CycleCS($CS)
//Copyright © 1996, Thomas D. Nee, All Rights Reserved.
//Return the next Condition State: increment or cycle to the first.

C_LONGINT:C283($1; $0; $CS)

$CS:=$1
If ($CS<vNoCSs)
	//Increment the Condition State.        
	$CS:=$CS+1
Else 
	//Cycle to the first Condition State.        
	$CS:=1
End if 
$0:=$CS