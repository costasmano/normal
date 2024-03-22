//%attributes = {"invisible":true}
//Method: WIN_FindVisibleNode
//Description
// find the visible point of a window starting from middle and spiraling out clockwise
// Parameters
// $1 : $WinObj : windowobj
// input
//  // topleft { x , y }
//  // bottomright { x , y}
//  // steps : number of steps in spiral defau;ts to 4
// returns
//  // visnode {x , y, screen}
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/29/20, 19:33:32
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_OBJECT:C1216(WIN_FindVisibleNode; $1)
End if 
//

C_OBJECT:C1216($1; $topleft; $botRight)
C_LONGINT:C283($XL; $YT; $XR; $YB)

$topleft:=OB Get:C1224($1; "topleft"; Is object:K8:27)
$botRight:=OB Get:C1224($1; "bottomright"; Is object:K8:27)
$XL:=OB Get:C1224($topleft; "x"; Is longint:K8:6)
$YT:=OB Get:C1224($topleft; "y"; Is longint:K8:6)
$XR:=OB Get:C1224($botRight; "x"; Is longint:K8:6)
$YB:=OB Get:C1224($botRight; "y"; Is longint:K8:6)

C_LONGINT:C283($N)
$N:=OB Get:C1224($1; "steps"; Is longint:K8:6)  // number of steps per half leg of window
If ($N=0)
	$N:=4
End if 

C_LONGINT:C283($W; $H)
$W:=$XR-$XL
$H:=$YB-$YT

C_LONGINT:C283($visX; $visy; $visscreen)
//indicate not visible anywhere
$visscreen:=0
$visX:=-1
$visy:=-1

C_LONGINT:C283($DX; $DY)
$DX:=$W/(2*$N)
$DY:=$H/(2*$N)

C_LONGINT:C283($Spiral)

C_OBJECT:C1216($node)  //start the node object

//check if middle is visible
C_LONGINT:C283($X0; $Y0)
$X0:=($XL+$XR)/2
$Y0:=($YB+$YT)/2
C_LONGINT:C283($pointVis)
$pointVis:=WIN_PointVis($X0; $Y0)  // screen number where middle point is in

If ($pointVis#0)
	OB SET:C1220($node; "x"; $X0; "y"; $Y0; "screen"; $pointVis)
Else 
	// if not visible (MiddleVis=0) , spiral outwards from center by $N steps
	For ($Spiral; 1; $N)
		C_LONGINT:C283($ArrayofPts; $i)
		$ArrayofPts:=$Spiral*8  // each spiral has 8*N points to check
		ARRAY LONGINT:C221($X_aL; $ArrayofPts)
		ARRAY LONGINT:C221($Y_aL; $ArrayofPts)
		
		C_LONGINT:C283($ipos; $CurrX; $CurrY)
		//1st point
		$CurrX:=$X0
		$CurrY:=MaxNum($YT; ($Y0-($Spiral*$DY)))
		$X_aL{1}:=$CurrX
		$Y_aL{1}:=$CurrY
		$pointVis:=WIN_PointVis($CurrX; $CurrY)
		If ($pointVis#0)
			OB SET:C1220($node; "x"; $CurrX; "y"; $CurrY; "screen"; $pointVis)
		End if 
		
		$ipos:=1
		
		If ($pointVis=0)
			//top right leg
			For ($i; 1; $Spiral)
				$ipos:=$ipos+1
				$CurrX:=MinNum($XR; $CurrX+$DX)
				$X_aL{$ipos}:=$CurrX
				$Y_aL{$ipos}:=$CurrY
				$pointVis:=WIN_PointVis($CurrX; $CurrY)
				If ($pointVis#0)
					OB SET:C1220($node; "x"; $CurrX; "y"; $CurrY; "screen"; $pointVis)
					$i:=$Spiral+1
				End if 
				
			End for 
			
		End if 
		
		If ($pointVis=0)
			//right vertical
			
			For ($i; 1; (2*$Spiral))
				$ipos:=$ipos+1
				$CurrY:=MinNum($YB; ($CurrY+$DY))
				$X_aL{$ipos}:=$CurrX
				$Y_aL{$ipos}:=$CurrY
				$pointVis:=WIN_PointVis($CurrX; $CurrY)
				If ($pointVis#0)
					OB SET:C1220($node; "x"; $CurrX; "y"; $CurrY; "screen"; $pointVis)
					$i:=(2*$Spiral)+1
				End if 
			End for 
			
		End if 
		
		If ($pointVis=0)
			//bottom
			For ($i; 1; (2*$Spiral))
				$ipos:=$ipos+1
				$CurrX:=MaxNum($XL; ($CurrX-$DX))
				$X_aL{$ipos}:=$CurrX
				$Y_aL{$ipos}:=$CurrY
				$pointVis:=WIN_PointVis($CurrX; $CurrY)
				If ($pointVis#0)
					OB SET:C1220($node; "x"; $CurrX; "y"; $CurrY; "screen"; $pointVis)
					$i:=(2*$Spiral)+1
				End if 
			End for 
			
		End if 
		
		If ($pointVis=0)
			//left vertical
			For ($i; 1; (2*$Spiral))
				$ipos:=$ipos+1
				$CurrY:=MaxNum($YT; ($CurrY-$DY))
				$X_aL{$ipos}:=$CurrX
				$Y_aL{$ipos}:=$CurrY
				$pointVis:=WIN_PointVis($CurrX; $CurrY)
				If ($pointVis#0)
					OB SET:C1220($node; "x"; $CurrX; "y"; $CurrY; "screen"; $pointVis)
					$i:=(2*$Spiral)+1
				End if 
			End for 
			
		End if 
		
		If ($pointVis=0)
			//top left leg
			For ($i; 1; ($Spiral-1))
				$ipos:=$ipos+1
				$CurrX:=$CurrX+$DX
				$X_aL{$ipos}:=$CurrX
				$Y_aL{$ipos}:=$CurrY
				$pointVis:=WIN_PointVis($CurrX; $CurrY)
				If ($pointVis#0)
					OB SET:C1220($node; "x"; $CurrX; "y"; $CurrY; "screen"; $pointVis)
					$i:=$Spiral+1
				End if 
			End for 
			
		End if 
		
		If ($pointVis#0)
			$Spiral:=$N+1
		End if 
		
	End for   // end of spiral
	
End if 

OB SET:C1220($1; "visnode"; $node)

//End WIN_FindVisibleNode