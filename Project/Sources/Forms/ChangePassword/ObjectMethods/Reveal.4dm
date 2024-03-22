//Method: ChangePassword.Reveal
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/12/22, 11:35:45
	// ----------------------------------------------------
	//Created : 
	// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
	Mods_2022_07  //Modified how passwords are changed in single user so that server password can be changed at the same time
	
End if 
//
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($Title_txt)
		$Title_txt:=OBJECT Get title:C1068(*; "Reveal")
		If ($Title_txt="Reveal")
			OBJECT SET FONT:C164(*; "Pass@"; "System Font Regular")
			OBJECT SET TITLE:C194(*; "Reveal"; "Hide")
		Else 
			OBJECT SET FONT:C164(*; "Pass@"; "%Password")
			OBJECT SET TITLE:C194(*; "Reveal"; "Reveal")
		End if 
		
		
End case 
//End ChangePassword.Reveal