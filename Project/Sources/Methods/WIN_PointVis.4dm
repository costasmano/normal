//%attributes = {"invisible":true}
//Method: WIN_PointVis
//Description
// Find if a screen coordinate point is visible on a screen
// Parameters
// $0 : $Screen  screen number where point is visible
// $1 : $X
// $2 : $Y
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/30/20, 09:58:11
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_LONGINT:C283(WIN_PointVis; $0; $1; $2)
End if 
//

C_LONGINT:C283($0; $1; $2)

C_LONGINT:C283($numScreens)
$numScreens:=Count screens:C437
C_LONGINT:C283($SL; $ST; $SR; $Sb; $screen; $myscreen; $menuHeight)
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

For ($screen; 1; $numScreens)
	If (($SL_al{$screen}<=$1) & ($1<=$SR_al{$screen}) & ($ST_al{$screen}<=$2) & ($2<=$SB_al{$screen}))
		// is in this screen
		$myscreen:=$screen
		$screen:=$numScreens+1  //exit
	End if 
End for 

$0:=$myscreen

//End WIN_PointVis