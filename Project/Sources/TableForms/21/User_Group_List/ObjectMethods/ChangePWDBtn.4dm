If (USGRP_UserListActive_b)
	C_LONGINT:C283($itemref; $nblogin; $retcode)
	C_TEXT:C284($uname; $startup; $NewPW; $pw; $itemTxt)
	C_DATE:C307($lastlogin)
	GET LIST ITEM:C378(User_group_list; Selected list items:C379(User_group_list); $itemref; $itemTxt)
	If (Not:C34(Is user deleted:C616($ItemRef)))
		GET USER PROPERTIES:C611($itemref; $uname; $startup; $pw; $nblogin; $lastlogin)
		$NewPW:=f_TrimStr(Request:C163("Enter New Password"); True:C214; True:C214)
		If ((OK=1) & ($NewPW#""))
			$retcode:=Set user properties:C612($itemref; $uname; $startup; $NewPW; $nblogin; $lastlogin)
			If ($retCode=$itemref)
				ALERT:C41("Changed password for "+$uname)
			Else 
				ALERT:C41("Some error occured!!!")
			End if 
			
		End if 
	End if 
End if 