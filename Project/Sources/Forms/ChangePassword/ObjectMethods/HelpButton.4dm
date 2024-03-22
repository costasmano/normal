//Method: "ChangePassword".HelpButton
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Dec 15, 2022, 11:23:22
	// ----------------------------------------------------
	
End if 
//
C_BOOLEAN:C305($openHelp)
$openHelp:=True:C214
If (OB Is defined:C1231(Form:C1466; "HelpWinID"))
	ARRAY LONGINT:C221($windIDs_aL; 0)
	
	WINDOW LIST:C442($windIDs_aL)
	If (Find in array:C230($windIDs_aL; Form:C1466.HelpWinID)>0)
		SHOW WINDOW:C435(Form:C1466.HelpWinID)
		$openHelp:=False:C215
	End if 
End if 


If ($openHelp)
	
	C_LONGINT:C283($fwidth; $fheight; $winID)
	FORM GET PROPERTIES:C674([Dialogs:21]; "BigAlert"; $fwidth; $fheight)
	$winID:=ut_OpenNewWindow($fwidth; $fheight; 0; Plain window:K34:13; "Password Rules")
	Form:C1466.HelpWinID:=$winID
	DIALOG:C40([Dialogs:21]; "BigAlert"; New object:C1471("messageDisplay"; "Rules for passwords\n"+\
		"Minimum length = 8\n"+\
		"Cannot be all numbers\n"+\
		"Cannot be all Capital letters\n"+\
		"Cannot be all Lowercase letters\n"+\
		"Must have at least 1 number\n"+\
		"Must have at least 1 Capital letter"))
	CLOSE WINDOW:C154
	
End if 
//End ChangePassword.HelpButton   