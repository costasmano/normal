//%attributes = {"invisible":true}
//G_RatingV2NBI
//Function to return a converted value appropriate for the
//[Bridge MHD NBIS]Inv / Opr fields based on the corresponding
//[Rating Report]Inv / Opr fields

C_REAL:C285($0; $1; $vrRatgValue)
C_REAL:C285($vrRes)
$vrRatgValue:=$1
If ($vrRatgValue<100)
	$vrRes:=Round:C94($vrRatgValue; 0)
Else 
	$vrRes:=99
End if 
$0:=$vrRes