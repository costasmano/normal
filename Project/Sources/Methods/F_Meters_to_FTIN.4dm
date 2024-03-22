//%attributes = {}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/20/06, 15:27:09
	// ----------------------------------------------------
	// Method: F_Meters_to_FTIN
	// Description
	// Convert Meters to FT-IN format.
	// 
	// Parameters
	// $0 : FT-IN (formatted string)
	// $1 : Meters (real)
	// $2 : Inch Accuracy (real) Optional in fraction : within how much of 12 inches to round up the inche part
	// ----------------------------------------------------
	
End if 
C_TEXT:C284($0; $Result_txt)
C_REAL:C285($1; $Meters_R; $2; $InchAccuracy_R; $Feet_R; $FeetInt_R; $DecFt_R; $Inches_R; $FT_Met_R)
C_LONGINT:C283($Inches_L)
$FT_Met_R:=0.3048  //ft to meters ratio
$Meters_R:=$1
If (Count parameters:C259=2)
	$InchAccuracy_R:=$2
Else 
	$InchAccuracy_R:=0
End if 

$Result_txt:=""
$Feet_R:=Abs:C99($Meters_R)/$FT_Met_R
$FeetInt_R:=Int:C8($Feet_R)
$DecFt_R:=$Feet_R-$FeetInt_R
$Inches_R:=12*$DecFt_R
If ($InchAccuracy_R=0)
	If (Round:C94($Inches_R; 0)=12)
		$FeetInt_R:=$FeetInt_R+1
		$Inches_R:=0
	End if 
Else 
	If (($Inches_R+$InchAccuracy_R)>=12)
		$FeetInt_R:=$FeetInt_R+1
		$Inches_R:=0
	End if 
End if 

$Inches_R:=Round:C94($Inches_R; 0)
If ($Meters_R<0)
	$FeetInt_R:=-$FeetInt_R
End if 
$Result_txt:=String:C10($FeetInt_R; "###,###,###,###,##0")+"'-"+String:C10($Inches_R; "00")+Char:C90(34)
$0:=$Result_txt