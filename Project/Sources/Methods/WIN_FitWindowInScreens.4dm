//%attributes = {"invisible":true}
//Method: WIN_FitWindowInScreens
//Description
// Fit window coordinates in the current screens
// Parameters
// $1 : $x1_ptr pointer to top left x
// $2 : $y1_ptr pointer to top left y
// $3 : $x2_ptr pointer to bot right x
// $4 : $y2_ptr pointer to bot right y
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakiscompiler_ut
	//User (4D) : Designer
	//Date and time: 06/26/20, 18:12:06
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_POINTER:C301(WIN_FitWindowInScreens; $1; $2; $3; $4)
End if 
//

C_POINTER:C301($1; $2; $3; $4)

C_LONGINT:C283($x1; $y1; $x2; $y2; $winH_L; $winW_L; $menuHeight)
$x1:=$1->
$y1:=$2->
$x2:=$3->
$y2:=$4->

$winW_L:=$x2-$x1
$winH_L:=$y2-$y1

$menuHeight:=36

C_LONGINT:C283($numScreens)
$numScreens:=Count screens:C437
C_LONGINT:C283($SL; $ST; $SR; $Sb; $screen; $myscreen)
ARRAY LONGINT:C221($SL_al; $numScreens)
ARRAY LONGINT:C221($ST_al; $numScreens)
ARRAY LONGINT:C221($SR_al; $numScreens)
ARRAY LONGINT:C221($SB_al; $numScreens)

For ($screen; 1; $numScreens)
	SCREEN COORDINATES:C438($SL; $ST; $SR; $Sb; $screen)
	$SL_al{$screen}:=$SL
	$ST_al{$screen}:=$ST+$menuHeight  //Add space for menu bar
	$SR_al{$screen}:=$SR
	$SB_al{$screen}:=$Sb
End for 
$myscreen:=0
//try to find where top left is
For ($screen; 1; $numScreens)
	If (($SL_al{$screen}<=$x1) & ($x1<=$SR_al{$screen}) & ($ST_al{$screen}<=$y1) & ($y1<=$SB_al{$screen}))
		//top left is in this screen
		$myscreen:=$screen
		$screen:=$numScreens+1  //exit
	End if 
End for 
//if top left is not on any screen - find where bot right is 
If ($myscreen=0)
	
	For ($screen; 1; $numScreens)
		If (($SL_al{$screen}<=$x2) & ($x2<=$SR_al{$screen}) & ($ST_al{$screen}<=$y2) & ($y2<=$SB_al{$screen}))
			//bot right is in this screen
			$myscreen:=$screen
			$screen:=$numScreens+1  //exit
		End if 
	End for 
End if 

If ($myscreen>0)
	C_BOOLEAN:C305($TopLeftIn_b; $botRightIn_b)
	$TopLeftIn_b:=(($SL_al{$myscreen}<=$x1) & ($x1<=$SR_al{$myscreen}) & ($ST_al{$myscreen}<=$y1) & ($y1<=$SB_al{$myscreen}))
	$botRightIn_b:=(($SL_al{$myscreen}<=$x2) & ($x2<=$SR_al{$myscreen}) & ($ST_al{$myscreen}<=$y2) & ($y2<=$SB_al{$myscreen}))
	
	Case of 
		: ($TopLeftIn_b & $botRightIn_b)
			//both are in - no change needed
		: ($TopLeftIn_b)
			//only top left is on screen - move it
			$x1:=MinNum($x1; ($SR_al{$myscreen}-$winW_L))
			$y1:=MinNum($y1; ($SB_al{$myscreen}-$winH_L))
			//make sure top left stays on screen
			$x1:=MaxNum($x1; $SL_al{$myscreen})
			$y1:=MaxNum($y1; $ST_al{$myscreen})
			$x2:=$x1+$winW_L
			$y2:=$y1+$winH_L
		: ($botRightIn_b)
			//only bot right is on screen
			$x2:=MaxNum($x2; ($SL_al{$myscreen}+$winW_L))
			$y2:=MaxNum($y2; ($ST_al{$myscreen}+$winH_L))
			$x1:=$x2-$winW_L
			$y1:=$y2-$winH_L
			//make sure top left stays on screen
			$x1:=MaxNum($x1; $SL_al{$myscreen})
			$y1:=MaxNum($y1; $ST_al{$myscreen})
			$x2:=$x1+$winW_L  //and adjust bot right
			$y2:=$y1+$winH_L
			
	End case 
	
Else 
	//not on any screen - put it on top left of main screen 
	$x1:=20
	$y1:=$menuHeight
	$x2:=$x1+$winW_L
	$y2:=$y1+$winH_L
	
End if 

//update variables
$1->:=$x1
$2->:=$y1
$3->:=$x2
$4->:=$y2

//End WIN_FitWindowInScreens