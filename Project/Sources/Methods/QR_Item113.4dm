//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/08, 13:37:47
	// ----------------------------------------------------
	// Method: QR_Item113
	// Description
	// Return the description for Item113
	// 
	// Parameters
	// $0 : $Itm113_txt
	// $1 : $Itm113_s (Optional)
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_TEXT:C284($0; $Itm113_txt)
$Itm113_txt:=""
C_TEXT:C284($Itm113_s)  // Command Replaced was o_C_STRING length was 1
If (Count parameters:C259>0)
	C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 2
	$Itm113_s:=$1
Else 
	$Itm113_s:=[Bridge MHD NBIS:1]Item113:151
End if 

Case of 
	: ($Itm113_s="N")
		$Itm113_txt:="Bridge not over waterway"
		
	: ($Itm113_s="U")
		$Itm113_txt:="Unknown foundation that has not been evaluated for scour.  Since risk cannot be d"+"etermined, flag for monitoring during flood events and, if appropriate, closure"
		
	: ($Itm113_s="T")
		$Itm113_txt:="Tidal waters that has not been evaluated for scour, but considered low risk.  Bri"+"dge will be monitored with regular inspection cycle and with appropriate underwat"+"er inspections"
		
	: ($Itm113_s="9")
		$Itm113_txt:="Foundations (including piles) on dry land well above flood water elevations"
		
	: ($Itm113_s="8")
		$Itm113_txt:="Foundations determined to be stable for assessed or calculated scour conditions; "+"calculated scour is above top of footing"
		
	: ($Itm113_s="7")
		$Itm113_txt:="Countermeasures have been installed to correct a previously existing problem with"+" scour.  Bridge is no longer scour critical"
		
	: (($Itm113_s="6") | ($Itm113_s="D"))
		$Itm113_txt:="Scour calculation/evaluation has not been made"
		
	: ($Itm113_s="5")
		$Itm113_txt:="Foundations determined to be stable for calculated scour conditions; scour within"+" limits of footing or piles"
		
	: ($Itm113_s="4")
		$Itm113_txt:="Foundations determined to be stable for calculated scour conditions; field review"+" indicates action is required to protect exposed foundations from effects of addi"+"tional erosion and corrosion"
		
	: ($Itm113_s="3")
		$Itm113_txt:="Scour critical; bridge foundations determined to be unstable for calculated scour"+" conditions"
		
	: ($Itm113_s="2")
		$Itm113_txt:="Scour critical; field review indicates that extensive scour has occurred at bridg"+"e foundations.  Immediate action is required to provide scour countermeasures"
		
	: ($Itm113_s="1")
		$Itm113_txt:="Scour critical; field review indicates that failure of piers/abutments is imminen"+"t.  Bridge is closed to traffic"
		
	: ($Itm113_s="0")
		$Itm113_txt:="Scour critical.  Bridge has failed and is closed to traffic"
		
End case 

$0:=$Itm113_txt