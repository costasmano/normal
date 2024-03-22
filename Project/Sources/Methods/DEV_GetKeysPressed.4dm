//%attributes = {"invisible":true}
//Method: DEV_GetKeysPressed
//Description
// return the keys pressed
// Parameters
// $0 : $keys_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/08/20, 11:24:28
	// ----------------------------------------------------
	//Created : 
	Mods_2020_06
	
	C_TEXT:C284(DEV_GetKeysPressed; $0)
	
End if 
//

C_TEXT:C284($0; $keys_txt)
C_BOOLEAN:C305($shft_b; $macCmd_b; $macTRL_b; $macOpt_b; $Caps_b; $winAlt_b; $WinCtrl_b; $RightClick_b)
$shft_b:=Shift down:C543
$macCmd_b:=Macintosh command down:C546
$macTRL_b:=Macintosh control down:C544
$macOpt_b:=Macintosh option down:C545
$Caps_b:=Caps lock down:C547
$winAlt_b:=Windows Alt down:C563
$WinCtrl_b:=Windows Ctrl down:C562

$keys_txt:=""
If ($shft_b)
	$keys_txt:=$keys_txt+"Shift "
End if 
If ($macCmd_b)
	$keys_txt:=$keys_txt+"Macintosh command "
End if 
If ($macTRL_b)
	$keys_txt:=$keys_txt+"Macintosh control "
End if 
If ($macOpt_b)
	$keys_txt:=$keys_txt+"Macintosh option "
End if 
If ($Caps_b)
	$keys_txt:=$keys_txt+"Caps lock "
End if 
If ($winAlt_b)
	$keys_txt:=$keys_txt+"Windows Alt "
End if 
If ($WinCtrl_b)
	$keys_txt:=$keys_txt+"Windows Ctrl "
End if 


$0:=$keys_txt
//End DEV_Get$keys_txt