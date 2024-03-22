//%attributes = {"invisible":true}
If (False:C215)
	//function : aDblLookUpDest  
	//purpose : try to confirm that there is no cross reference errors
	//   when looking up record destinations.
	//$1 : Table number
	//$2 : Local Id
	//$3 : Initial destination
	//$4 : Cross check destination
End if 

C_LONGINT:C283($1; $vlTNo)
C_TEXT:C284($2; $vsLocID; $3; $vsDest; $4; $vsRevDest)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($0; $aRef_ID)  // Command Replaced was o_C_STRING length was 80

$vlTNo:=$1
$vsLocID:=$2
$vsDest:=$3
$vsRevDest:=$4

$aRef_ID:=aLookUpDest($vlTNo; $vsLocID; $vsDest)
If ($aRef_ID="")
	$aRef_ID:=aLookUpDest($vlTNo; $vsLocID; $vsRevDest)
	If ($aRef_ID="")
		//No reverse match either so assume IDs match
		$aRef_ID:=$vsLocID
	Else 
		//A Reverse match was found - check if it is the same as the one coming
		If ($aRef_ID#$vsLocID)
			//if they don't match - set it to blank
			$aRef_ID:=""
		End if 
	End if 
End if 
$0:=$aRef_ID