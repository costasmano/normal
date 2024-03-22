//%attributes = {"invisible":true}
If (False:C215)
	//GP CENTER_WINDOW(width;height;type;title;close box procedure)
	//$WinWidth:=$1 - Window Width
	//$WinHght:=$2 - Window Height
	//$WinType:=$3 - Type (optional)
	//$WinTitle:=$4 - Window Title (optional)
	//$ClosBoxPrc:=$5 - Close Box procedure  (optional)
	
	// Modified by: costasmanousakis-(Designer)-(5/13/11 16:15:53)
	Mods_2011_05
	//If window type is a 2 change it to a 5 movable dialog box
	
End if 
C_LONGINT:C283($1; $2; $3)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($4; $5)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($WinWidth; $WinHght; $WinType; $ScrCtrW; $ScrCtrH; $WinCntrW; $WinCntrH)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($WinTitle; $ClosBoxPrc)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($winID)
$WinWidth:=$1
$WinHght:=$2
Case of 
	: (Count parameters:C259=3)
		$WinType:=$3
	: (Count parameters:C259=4)
		$WinType:=$3
		$WinTitle:=$4
	: (Count parameters:C259=5)
		$WinType:=$3
		$WinTitle:=$4
		$ClosBoxPrc:=$5
End case 
If ($WinType=2)
	$WinType:=Movable dialog box:K34:7
End if 

$ScrCtrW:=Screen width:C187/2
$ScrCtrH:=(Screen height:C188/2)+10
$WinCntrW:=$WinWidth/2
$WinCntrH:=$WinHght/2
Case of 
	: (Count parameters:C259=2)
		$winID:=Open window:C153($ScrCtrW-$WinCntrW; $ScrCtrH-$WinCntrH; $ScrCtrW+$WinCntrW; $ScrCtrH+$WinCntrH)
		
	: (Count parameters:C259=3)
		$winID:=Open window:C153($ScrCtrW-$WinCntrW; $ScrCtrH-$WinCntrH; $ScrCtrW+$WinCntrW; $ScrCtrH+$WinCntrH; $WinType)
		
	: (Count parameters:C259=4)
		$winID:=Open window:C153($ScrCtrW-$WinCntrW; $ScrCtrH-$WinCntrH; $ScrCtrW+$WinCntrW; $ScrCtrH+$WinCntrH; $WinType; $WinTitle)
		
	: (Count parameters:C259=5)
		$winID:=Open window:C153($ScrCtrW-$WinCntrW; $ScrCtrH-$WinCntrH; $ScrCtrW+$WinCntrW; $ScrCtrH+$WinCntrH; $WinType; $WinTitle; $ClosBoxPrc)
		
End case 
