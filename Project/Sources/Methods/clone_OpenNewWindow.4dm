//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 09/07/14, 21:29:37
//----------------------------------------------------
//Method: clone_OpenNewWindow
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 

//Procedure: clone_OpenNewWindow($Width_l;$Height_l;"position";"Type";"Title";"Close Proc")
//

//Purpose:  Open a window by passing the width, height and position of the window
//                also - type, titlebar text  and close box procedure to call

// POSITIONS:
// 0 = CenterUp -- centered & 1/3 to top of screen (nicer than Centered)
// 1 = Center
// 2 = Upper left;   3 = Upper right;   4 = Lower left;   5 = Lower right
// 6 = Stacked -- not supported
// 7 = FullScreen
// 8 = Left;   9 = Top;   10 = Right;   11 = Bottom
// 12 = CenterUp on current window
// 13 = Upper right of current window (like choice lists)
// 14 = Top center of current window

// TYPES:
// 0 = title bar, no zoom box
// 1 = modal dialog
// 2 = dialog plain single line border
// 3 = dialog, same as 2 with shaded border
// 4 = dialog with title bar, single line with shaded border
// 5 = moveable modal dialog w/title bar
// 8 = title bar, with zoom box
// 16 = black title bar, rounded corners
// 720 = palette (add third digits [1,2,4,8] to get combos)
// 721 = palette, titlebar disabled when not front
// 722 = palette, w/title
// 724 = palette w/scroll bars
// 728 = palette w/grow box

// 0, 4, 8, 16 types can have close boxes
// 0, 8, 724 types can have scroll bars
// -2, -3, -5, -720, -724 are floating windows

C_LONGINT:C283($0; $1; $2; $3; $4; $sh; $sw; $x1; $y1; $x2; $y2; $moveBy; $index; $pars; $menuHeight; $WinType; $Win)
C_TEXT:C284($WindowTitle_s)  // Command Replaced was o_C_STRING length was 80
$WindowTitle_s:=""
$WinType:=$4
If ($WinType=2)
	$WinType:=Movable dialog box:K34:7
End if 

If (Count parameters:C259>4)
	C_TEXT:C284($5)  // Command Replaced was o_C_STRING length was 80
	$WindowTitle_s:=$5
End if 
C_TEXT:C284($CloseBoxMethod_s)  // Command Replaced was o_C_STRING length was 41
$CloseBoxMethod_s:=""
If (Count parameters:C259>5)
	C_TEXT:C284($6)  // Command Replaced was o_C_STRING length was 41
	$CloseBoxMethod_s:=$6
End if 

C_BOOLEAN:C305($Windows_b)
//_O_PLATFORM PROPERTIES($Platform) // MassDOT_PS - conversion v19R7
//$Windows_b:=($Platform=3)
$Windows_b:=Is Windows:C1573
ARRAY LONGINT:C221($aWinRefs; 0)
WINDOW LIST:C442($aWinRefs)
If (Size of array:C274($aWinRefs)>0)
	$Win:=$aWinRefs{1}
End if 
$sh:=Screen height:C188
$sw:=Screen width:C187
$menuHeight:=50
If ($Windows_b)
	$sh:=$sh-56
	$sw:=$sw-8
	$menuHeight:=70
End if 

Case of 
	: ($3=12)  // Centered, up on current window
		
		GET WINDOW RECT:C443($x1; $y1; $x2; $y2; $win)  //6/27/00 dmk
		$sh:=$y2-(($y2-$y1)\2)
		$sw:=$x2-(($x2-$x1)\2)
		$x1:=$sw-($1/2)
		$moveBy:=($sh-($2/2)-$y1)\3  // bump window up a little
		$y1:=$sh-($2/2)
		$x2:=$sw+($1/2)
		$y2:=$sh+($2/2)
		$y1:=$y1-$moveBy
		$y2:=$y2-$moveBy
		
	: ($3=13)  // Upper right on current window
		GET WINDOW RECT:C443($x1; $y1; $x2; $y2; $win)
		$x1:=$x2-$1-20
		//    $y1:=$y1+36
		$y1:=$y1+60  //DBH for Windows
		$x2:=$x1+$1
		$y2:=$y1+$2
		
		
	: ($3=14)  // Upper center on current window
		GET WINDOW RECT:C443($x1; $y1; $x2; $y2; $win)
		$sw:=$x2-(($x2-$x1)\2)
		$x1:=$sw-($1/2)
		$y1:=$y1+36
		$x2:=$sw+($1/2)
		$y2:=$y1+$2
		
	: ($3=0)  //Centered and moved up a little
		$sh:=$sh\2
		$sw:=$sw\2
		$x1:=$sw-($1/2)
		$y1:=$sh-($2/2)
		$x2:=$sw+($1/2)
		$y2:=$sh+($2/2)
		$moveBy:=$y1\3  // bump window up a little - looks nicer -
		$y1:=$y1-$moveBy
		$y2:=$y2-$moveBy
		
	: ($3=1)  //Centered
		$sh:=$sh\2
		$sw:=$sw\2
		$x1:=$sw-($1/2)
		$y1:=$sh-($2/2)
		$x2:=$sw+($1/2)
		$y2:=$sh+($2/2)
		
	: ($3=6)  //Stacked
		//not supported
	: ($3=2)  //Upper left corner
		$x1:=20
		$y1:=$menuHeight
		$x2:=$x1+$1
		$y2:=$y1+$2
		
	: ($3=3)  //Upper right corner
		$x1:=$sw-$1-70
		$y1:=68
		$x2:=$x1+$1
		$y2:=$y1+$2
		
	: ($3=4)  //Lower left corner
		$x1:=20
		$y1:=$sh-$2-20
		$x2:=$x1+$1
		$y2:=$y1+$2
		
	: ($3=5)  //Lower right corner
		$x1:=$sw-$1-10
		$y1:=$sh-$2-10
		$x2:=$x1+$1
		$y2:=$y1+$2
		
	: ($3=7)  // Full screen window
		$x1:=2
		$y1:=$menuHeight
		$x2:=$sw-3
		$y2:=$sh-3
		
	: ($3=8)  // Left, centered vertically
		$sh:=$sh\2
		$x1:=20
		$y1:=$sh-($2/2)
		$x2:=$x1+$1
		$y2:=$sh+($2/2)
		
	: ($3=9)  // Top, centered horizontally
		$sw:=$sw\2
		$x1:=$sw-($1/2)
		$y1:=68
		$x2:=$sw+($1/2)
		$y2:=$y1+$2
		
	: ($3=10)  // Right, centered vertically
		$sh:=$sh\2
		$x1:=$sw-$1-20
		$y1:=$sh-($2/2)
		$x2:=$x1+$1
		$y2:=$sh+($2/2)
		
	: ($3=11)  // Bottom, centered horizontally
		$sw:=$sw\2
		$x1:=$sw-($1/2)
		$y1:=$sh-$2-20
		$x2:=$sw+($1/2)
		$y2:=$y1+$2
		
End case 

// make sure upper left corner of window is on screen
If ($x1<0)
	$moveBy:=(0-$x1)+20
	$x1:=$x1+$moveBy
	$x2:=$x2+$moveBy
End if 
If ($y1<40)
	$moveBy:=(0-$y1)+40
	$y1:=$y1+$moveBy
	$y2:=$y2+$moveBy
End if 
If ($x2>Screen width:C187(*))
	$moveBy:=($x2-Screen width:C187(*))+20
	If ($x1-$moveBy>0)
		$x1:=$x1-$moveBy
		$x2:=$x2-$moveBy
	End if 
End if 
If ($y2>Screen height:C188(*))
	$moveBy:=($y2-Screen height:C188(*))+20
	If ($y1-$moveBy>0)
		$y1:=$y1-$moveBy
		$y2:=$y2-$moveBy
	End if 
End if 


$pars:=Count parameters:C259
Case of 
	: ($pars=3)  // window in position
		$win:=Open window:C153($x1; $y1; $x2; $y2)
	: ($pars=4)  // window type
		$win:=Open window:C153($x1; $y1; $x2; $y2; $WinType)
	: ($pars=5)  // window name
		$win:=Open window:C153($x1; $y1; $x2; $y2; $WinType; $WindowTitle_s)
	: ($pars=6)  // close procedure
		$win:=Open window:C153($x1; $y1; $x2; $y2; $WinType; $WindowTitle_s; $CloseBoxMethod_s)
End case 

WINDOW LIST:C442($aWinRefs)
$0:=$aWinRefs{1}  // pass back the first window
//End clone_OpenNewWindow

