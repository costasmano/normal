//%attributes = {"invisible":true}
//Method: Center_Window_2
//Description
//open a window centered on the frontmost window
// Parameters
// $1 : $width_L
// $2 : $Ht_l
// $3 : $windowtype_L
// $4 : $winTitle_txt
// $5 : $closeBoxMethod_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/02/20, 17:12:59
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03_bug
	
	C_LONGINT:C283(Center_Window_2; $1)
	C_LONGINT:C283(Center_Window_2; $2)
	C_LONGINT:C283(Center_Window_2; $3)
	C_TEXT:C284(Center_Window_2; $4)
	C_TEXT:C284(Center_Window_2; $5)
	
	// Modified by: Costas Manousakis-(Designer)-(6/30/20 12:37:53)
	Mods_2020_06
	//  `use methods WIN_FindVisibleNode and WIN_FitWindowInScreens to better place window
End if 
//

C_LONGINT:C283($1; $2; $3)
C_TEXT:C284($4; $5)
C_LONGINT:C283($WinWidth; $WinHght; $WinType; $ScrCtrW; $ScrCtrH; $WinCntrW; $WinCntrH)
C_TEXT:C284($WinTitle; $ClosBoxPrc)
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
C_LONGINT:C283($front; $FL; $FT; $FR; $FB)
$front:=Frontmost window:C447
GET WINDOW RECT:C443($FL; $FT; $FR; $FB; $front)
C_OBJECT:C1216($windOb; $topl; $botR)
OB SET:C1220($topl; "x"; $FL; "y"; $FT)
OB SET:C1220($botR; "x"; $FR; "y"; $FB)
OB SET:C1220($windOb; "topleft"; $topl; "bottomright"; $botR)
WIN_FindVisibleNode($windOb)
If (OB Get:C1224(OB Get:C1224($windOb; "visnode"; Is object:K8:27); "screen"; Is longint:K8:6)#0)
	$ScrCtrW:=OB Get:C1224(OB Get:C1224($windOb; "visnode"; Is object:K8:27); "x"; Is longint:K8:6)
	$ScrCtrH:=OB Get:C1224(OB Get:C1224($windOb; "visnode"; Is object:K8:27); "y"; Is longint:K8:6)
Else 
	$ScrCtrW:=($FR+$FL)/2
	$ScrCtrH:=($FT+$FB)/2
End if 
//$ScrCtrW:=Screen width/2
//$ScrCtrH:=(Screen height/2)+10
$WinCntrW:=$WinWidth/2
$WinCntrH:=$WinHght/2
C_LONGINT:C283($x1; $y1; $x2; $y2)
$x1:=$ScrCtrW-$WinCntrW
$y1:=$ScrCtrH-$WinCntrH
$x2:=$ScrCtrW+$WinCntrW
$y2:=$ScrCtrH+$WinCntrH
WIN_FitWindowInScreens(->$x1; ->$y1; ->$x2; ->$y2)
Case of 
	: (Count parameters:C259=2)
		$winID:=Open window:C153($x1; $y1; $x2; $y2)
		
	: (Count parameters:C259=3)
		$winID:=Open window:C153($x1; $y1; $x2; $y2; $WinType)
		
	: (Count parameters:C259=4)
		$winID:=Open window:C153($x1; $y1; $x2; $y2; $WinType; $WinTitle)
		
	: (Count parameters:C259=5)
		$winID:=Open window:C153($x1; $y1; $x2; $y2; $WinType; $WinTitle; $ClosBoxPrc)
		
End case 

//End Center_Window_2