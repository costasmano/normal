//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: NewWindow(width;height;position;type;title;close proc)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:  10/1/95
	
	//Purpose:  This procedure opens a window whenever one is needed
	
	<>fGeneric:=False:C215
	<>f_Ver1x10:=False:C215
	<>fJ_Steinman:=False:C215
	
	//$LWinWidth:=$1 - Window Width
	//$LWinHght:=$2 - Window Height
	//$LPosition:=$3 - Position
	//  `0=Center, 1=Stacked, 2=Upper left, 3 = Upper right, 4=Lower left,
	//  `5=Lower right, 6=1/3 from top and centered, 7=Upper Centered,
	//  `8-32=try to place top middle of window on a 5x5 grid.
	//$LWinType:=$4 - Type (optional)
	//$sWinTitle:=$5- Window Title (optional)
	//$sClosBoxPrc:=$6 - Close Box procedure (optional)
	//  
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(5/13/11 16:17:35)
	Mods_2011_05
	//If window type is a 2 change it to a 5 movable dialog box
	// Modified by: Costas Manousakis-(Designer)-(2023-12-08 14:26:40)
	Mods_2023_12
	//  ` When re-setting <>LwinY - set to 50
	//  ` top left corner is set to 50 from 40
	
End if 

C_LONGINT:C283($LWinWidth; $LWinHght; $LPosition; $LWinType; $LScrW; $LScrH; $LLeft; $LTop; $LRight; $LBottom; $Lparm)
C_LONGINT:C283($1; $2; $3; $4)  //Remove this line if defining params in COMPILER procedures
C_TEXT:C284($sWinTitle; $sClosBoxPrc)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284($5; $6)  // Command Replaced was o_C_STRING length was 255//Remove this line if defining params in COMPILER procedures
C_LONGINT:C283($winID)
$LScrW:=Screen width:C187
$LScrH:=Screen height:C188

$Lparm:=Count parameters:C259
Case of 
	: ($Lparm=3)
		$LPosition:=$3
	: ($Lparm=4)
		$LPosition:=$3
		$LWinType:=$4
	: ($Lparm=5)
		$LPosition:=$3
		$LWinType:=$4
		$sWinTitle:=$5
	: ($Lparm=6)
		$LPosition:=$3
		$LWinType:=$4
		$sWinTitle:=$5
		$sClosBoxPrc:=$6
	: ($Lparm=2)
		$LPosition:=0  //Centered
	Else 
		$LPosition:=2  //Upper left
End case 

If ($Lparm>1)
	$LWinWidth:=$1
	$LWinHght:=$2
Else 
	$LWinWidth:=$LScrW-20
	$LWinHght:=$LScrH-50  //  Start of Mods_2023_12
End if 

Case of 
	: ($LPosition=0)  //Centered
		$LScrH:=$LScrH\2
		$LScrW:=$LScrW\2
		$LLeft:=$LScrW-($LWinWidth/2)
		$LTop:=$LScrH-($LWinHght/2)
		$LRight:=$LScrW+($LWinWidth/2)
		$LBottom:=$LScrH+($LWinHght/2)
		
	: ($LPosition=1)  //Stacked
		If ((($LWinWidth+<>LwinX)>$LScrW) | (($LWinHght+<>LwinY)>$LScrH))
			//the window would open off screen, so reset to the upper left
			<>LwinX:=10
			<>LwinY:=50  //  Start of Mods_2023_12
		End if 
		$LLeft:=<>LwinX
		$LTop:=<>LwinY
		$LRight:=$LWinWidth+<>LwinX
		$LBottom:=$LWinHght+<>LwinY
		//increment the tiling coordinates
		<>LwinX:=<>LwinX+20
		<>LwinY:=<>LwinY+20
		
	: ($LPosition=2)  //Upper left corner
		$LLeft:=20
		$LTop:=50  //  Start of Mods_2023_12
		$LRight:=$LLeft+$LWinWidth
		$LBottom:=$LTop+$LWinHght
		
	: ($LPosition=3)  //Upper right corner
		$LLeft:=$LScrW-$LWinWidth-20
		$LTop:=50  //  Start of Mods_2023_12
		$LRight:=$LLeft+$LWinWidth
		$LBottom:=$LTop+$LWinHght
		
	: ($LPosition=4)  //Lower left corner
		$LLeft:=20
		$LTop:=$LScrH-$LWinHght-20
		$LRight:=$LLeft+$LWinWidth
		$LBottom:=$LTop+$LWinHght
		
	: ($LPosition=5)  //Lower right corner
		$LLeft:=$LScrW-$LWinWidth-20
		$LTop:=$LScrH-$LWinHght-20
		$LRight:=$LLeft+$LWinWidth
		$LBottom:=$LTop+$LWinHght
		
	: ($LPosition=6)  //1/3 from top & centered 
		$LScrH:=$LScrH\3
		$LScrW:=$LScrW\2
		$LLeft:=$LScrW-($LWinWidth\2)
		$LTop:=$LScrH-($LWinHght\2)
		$LRight:=$LScrW+($LWinWidth\2)
		$LBottom:=$LScrH+($LWinHght\2)
		
	: ($LPosition=7)  //  top & centered 
		$LScrW:=$LScrW\2
		$LLeft:=$LScrW-($LWinWidth\2)
		$LTop:=50  //  Start of Mods_2023_12
		$LRight:=$LLeft+$LWinWidth
		$LBottom:=$LTop+$LWinHght
	: (($LPosition>7) & ($LPosition<(25+8)))  //on a grid 5x5 with window justified top-center
		C_LONGINT:C283($row; $col; $wMid)  //Command Replaced was o_C_INTEGER
		$row:=($LPosition-8)\5
		$col:=($LPosition-8)%5
		Case of   //figure out left and right of window
			: ($col=0)
				$LLeft:=0
				$LRight:=$LLeft+$LWinWidth
			: ($col=4)
				$LRight:=$LScrW
				$LLeft:=$LRight-$LWinWidth
			: (($col>0) & ($col<4))
				$wMid:=$col*($LScrW\4)
				$LLeft:=$wMid-($LWinWidth\2)
				If ($LLeft<0)
					$LLeft:=0
				End if 
				$LRight:=$LLeft+$LWinWidth
				If (($LLeft#0) & ($LRight>$LScrW))
					$LRight:=$LScrW
					$LLeft:=$LRight-$LWinWidth
				End if 
				
		End case 
		Case of   //figure out top and bottom
			: ($row=0)
				$LTop:=50  //allow for window title.//  Start of Mods_2023_12
				$LBottom:=$LTop+$LWinHght
			: ($row=4)
				$LBottom:=$LScrH
				$LTop:=$LBottom-$LWinHght
			: ($row<4)
				$LTop:=$row*($LScrH\4)
				$LBottom:=$LTop+$LWinHght
		End case 
		
End case 

If ($LWinType=2)
	$LWinType:=Movable dialog box:K34:7
End if 

Case of 
	: ($Lparm<4)
		$winID:=Open window:C153($LLeft; $LTop; $LRight; $LBottom)
	: ($Lparm=4)
		$winID:=Open window:C153($LLeft; $LTop; $LRight; $LBottom; $LWinType)
	: ($Lparm=5)
		$winID:=Open window:C153($LLeft; $LTop; $LRight; $LBottom; $LWinType; $sWinTitle)
	: ($Lparm=6)
		$winID:=Open window:C153($LLeft; $LTop; $LRight; $LBottom; $LWinType; $sWinTitle; $sClosBoxPrc)
End case 
//End of procedure