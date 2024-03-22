//%attributes = {}
If (False:C215)
	//f_BrgStatus_PCT
	//Function to calculate percentage value to be reported
	//on the bridge status report
	//If the total is 0 (zero) it will return -1.
	//Parameters
	//$1 (Real) : Part 
	//$2 (Real) : Total
	
	//$0 (Real) : Part/Total in percent.
	
	// Modified by: costasmanousakis-(Designer)-(11/24/09 16:07:34)
	Mods_2009_11
	//Changed all variables to Longints
End if 

C_LONGINT:C283($0; $vrResult; $1; $vrPart; $2; $vrTotal)
$vrPart:=$1
$vrTotal:=$2

Case of 
	: ($vrTotal=0)
		$vrResult:=-1
	Else 
		$vrResult:=Round:C94(($vrPart*100)/$vrTotal; 0)
End case 

$0:=$vrResult