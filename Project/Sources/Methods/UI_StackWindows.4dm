//%attributes = {"invisible":true}
//Method: UI_StackWindows
//Description
// Stack all open windows - Can be used in case some windows have gone off screen on Mac or windows
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-01-03 17:55:11
	// ----------------------------------------------------
	//Created : 
	Mods_2022_01
End if 
//
ARRAY LONGINT:C221($alWnd; 0)

C_LONGINT:C283($vlLeft; $vlTop; $vlWL; $vlWT; $vlWR; $vlWB; $vlWnd)
WINDOW LIST:C442($alWnd; *)
ARRAY TEXT:C222($wintitles; Size of array:C274($alWnd))
ARRAY LONGINT:C221($winKinds; Size of array:C274($alWnd))
C_TEXT:C284($vsWinTitle)
$vlLeft:=10
$vlTop:=80  // Leave enough room for the Tool bar
For ($vlWnd; 1; Size of array:C274($alWnd))
	$wintitles{$vlWnd}:=Get window title:C450($alWnd{$vlWnd})
	$winKinds:=Window kind:C445($alWnd{$vlWnd})
	//will skip modal dialogs or windows open in designer mode
	// if in designer mode , there is a Window menu item to merge all windows
	If ($vsWinTitle#"Method:@") & ($vsWinTitle#"Form:@") & ($vsWinTitle#"Object Method:@") & ($vsWinTitle#"Form Method:@")
		If (Window kind:C445($alWnd{$vlWnd})#Modal dialog:K27:2)
			
			GET WINDOW RECT:C443($vlWL; $vlWT; $vlWR; $vlWB; $alWnd{$vlWnd})
			$vlWR:=$vlLeft+($vlWR-$vlWL)
			$vlWB:=$vlTop+($vlWB-$vlWT)
			$vlWL:=$vlLeft
			$vlWT:=$vlTop
			SET WINDOW RECT:C444($vlWL; $vlWT; $vlWR; $vlWB; $alWnd{$vlWnd})
			$vlLeft:=$vlLeft+10
			$vlTop:=$vlTop+25
			
		End if 
	End if 
	
End for 


//End UI_StackWindows