//%attributes = {"invisible":true}
//Method: FORM_FitWindowToCurrPage
//Description
// Make the current window fit to the objects on the current page
// Parameters
// $1 : $Pagenumber
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/04/19, 11:45:56
	// ----------------------------------------------------
	//Created : 
	Mods_2019_12
	
	C_LONGINT:C283(FORM_FitWindowToCurrPage; $1)
End if 
//
C_LONGINT:C283($1)

C_LONGINT:C283($WinL; $WinT; $winR; $WinB)
C_LONGINT:C283($ObL; $ObT; $ObR; $ObB)
C_LONGINT:C283($BoxL; $BoxT; $BoxR; $BoxB)
ARRAY TEXT:C222($pageObjects_atxt; 0)
ARRAY POINTER:C280($pageVars_aptr; 0)
ARRAY LONGINT:C221($Pages_aL; 0)
FORM GET OBJECTS:C898($pageObjects_atxt; $pageVars_aptr; $Pages_aL; Form all pages:K67:7)

GET WINDOW RECT:C443($WinL; $WinT; $winR; $WinB)
C_LONGINT:C283($WinW; $WinH)
$WinW:=$winR-$WinL
$WinH:=$WinB-$WinT

$BoxL:=1000000
$BoxT:=1000000
$BoxR:=-1
$BoxB:=-1

C_LONGINT:C283($obj)
C_BOOLEAN:C305($objVis_b)
For ($obj; 1; Size of array:C274($pageObjects_atxt))
	If ($Pages_aL{$obj}=$1)  // | ($Pages_aL{$obj}=0)
		
		If (OBJECT Get visible:C1075(*; $pageObjects_atxt{$obj}))
			OBJECT GET COORDINATES:C663(*; $pageObjects_atxt{$obj}; $ObL; $ObT; $ObR; $ObB)
			If ($ObL<$BoxL)
				$BoxL:=$ObL
			End if 
			If (($ObR>$BoxR) & ($ObR>$WinW))
				$BoxR:=$ObR
			End if 
			If ($ObT<$BoxT)
				$BoxT:=$ObT
			End if 
			If ($ObB>$BoxB) & ($ObB>$WinH)
				$BoxB:=$ObB
			End if 
			
		End if 
		
		
	End if 
End for 

C_LONGINT:C283($BoxW; $BoxH)
$BoxW:=$BoxR-$BoxL
$BoxH:=$BoxB-$BoxT

If ($BoxW>0) | ($BoxH>0)
	C_LONGINT:C283($ResizeW; $ResizeH)
	$ResizeW:=0
	$ResizeH:=0
	
	If ($BoxW>($WinW-20))
		$ResizeW:=($BoxW+20)-$WinW
	End if 
	If (($BoxH+20)>$WinH)
		$ResizeH:=($BoxH+20)-$WinH
	End if 
	If ($ResizeH>0) | ($ResizeW>0)
		RESIZE FORM WINDOW:C890($ResizeW; $ResizeH)
	End if 
	
End if 
//End FORM_FitWindowToCurrPage