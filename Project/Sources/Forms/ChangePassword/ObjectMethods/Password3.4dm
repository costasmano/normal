//Method: ChangePassword.Password3
//Description
If (False:C215)
	ARRAY LONGINT:C221($UserIDs_aL; 0)
	ARRAY TEXT:C222($usernames_atxt; 0)
	GET USER LIST:C609($usernames_atxt; $UserIDs_aL)
	C_LONGINT:C283($indx)
	$indx:=Find in array:C230($usernames_atxt; Form:C1466.CurrentUser)
	
	If (Validate password:C638($UserIDs_aL{$indx}; Form:C1466.CurrentPassword))
		
	Else 
		ALERT:C41("Current Password is invalid")
		Form:C1466.Proceed:=False:C215
		OBJECT SET VISIBLE:C603(*; "Proceed"; False:C215)
	End if 
	
End if 

//
//End ChangePassword.Password3   