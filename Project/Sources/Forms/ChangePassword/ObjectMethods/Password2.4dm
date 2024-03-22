//Method: ChangePassword.Password2
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/12/22, 11:58:22
	// ----------------------------------------------------
	//Created : 
	// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
	Mods_2022_07  //Modified how passwords are changed in single user so that server password can be changed at the same time
	
End if 
//
If (False:C215)
	C_BOOLEAN:C305($Visible_B)
	
	ARRAY LONGINT:C221($UserIDs_aL; 0)
	ARRAY TEXT:C222($usernames_atxt; 0)
	GET USER LIST:C609($usernames_atxt; $UserIDs_aL)
	C_LONGINT:C283($indx)
	$indx:=Find in array:C230($usernames_atxt; Form:C1466.CurrentUser)
	
	If (Validate password:C638($UserIDs_aL{$indx}; Form:C1466.CurrentPassword))
		C_TEXT:C284($Pass1_txt; $Pass2_txt)
		$Pass1_txt:=Form:C1466.NewPassword1
		$Pass2_txt:=Form:C1466.NewPassword2
		$Visible_B:=ut_CheckPasswordRules($Pass1_txt; $Pass2_txt)
		
	Else 
		ALERT:C41("Current Password is incorrect!")
		$Visible_B:=False:C215
	End if 
	
	Form:C1466.Proceed:=$Visible_B
	
	OBJECT SET VISIBLE:C603(*; "Proceed"; $Visible_B)
	
End if 

//End ChangePassword.Password2