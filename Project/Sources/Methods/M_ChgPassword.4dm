//%attributes = {"invisible":true}
//Procedure: M_ChgPassword
// Change a users password or open the Password system for Designer or Administrator
If (False:C215)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By: Jim Steinman
	//Date:   6/5/96
	
	// Modified by: costasmanousakis-(Designer)-(2/8/2006 10:12:36)
	Mods_2006_CM03
	// Modified by: Costas Manousakis-(Designer)-(3/17/21 19:17:26)
	Mods_2021_03
	//  `if passwords are not the same exit the char scan loop
	// Modified by: Costas Manousakis-(Designer)-(2021-12-02T00:00:00 11:04:53)
	Mods_2021_12_bug
	//  `After editing access, prompt to save the users and groups on server when on client
	
	// Modified by: Chuck Miller-(Designer)-(7/19/22 12:51:55)
	Mods_2022_07  //Modified how passwords are changed in single user so that server password can be changed at the same time
	// Modified by: Costas Manousakis-(Designer)-(2022-12-14 12:35:49)
	Mods_2022_12_bug
	//  `allow users in Design access group access to the password system
	//  `Re enable old way of changing password.
End if 
Compiler_SQL
Compiler_forSQL
C_TEXT:C284($sUser; $sPassword; $sPassword2)  // Command Replaced was o_C_STRING length was 31
C_BOOLEAN:C305($fOK)
C_LONGINT:C283($LLength; $i)

$sUser:=Current user:C182

If (User in group:C338($sUser; "Design Access Group"))
	EDIT ACCESS:C281  //Edit password system
	If (Application type:C494=4D Remote mode:K5:5)
		CONFIRM:C162("Save users and Groups on server?")
		If (OK=1)
			C_LONGINT:C283($procID_L)
			$procID_L:=Execute on server:C373("UG_SaveUsersAndGroups"; 0)
		End if 
		
	End if 
Else 
	
	If (False:C215)
		
		C_LONGINT:C283($Win_L)
		$Win_L:=Open form window:C675("ChangePassword"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40("ChangePassword")
		CLOSE WINDOW:C154($Win_L)
		
	Else 
		C_LONGINT:C283($OKboth)
		$sPassword:=Request:C163("Enter your new password!")  //Enter the new password
		$OKboth:=OK
		If (Ok=1)
			$sPassword2:=Request:C163("Repeat your new password!")  //Repeat to confirm
			$OKboth:=$OKboth+OK
		End if 
		
		$fOK:=True:C214
		$LLength:=Length:C16($sPassword)
		
		Case of 
			: ($Okboth#2)  //user canceled from at least one request
				$fOK:=False:C215
			: ($sPassword="")
				ALERT:C41("Password cannot be a zero length string!")
				$fOK:=False:C215
			: (Replace string:C233($sPassword; " "; "")="")
				ALERT:C41("Password cannot be a blank string!")
				$fOK:=False:C215
			: (Length:C16(Replace string:C233($sPassword; " "; ""))<6)
				ALERT:C41("Password must have 6 characters or more!")
				$fOK:=False:C215
			: ($LLength#Length:C16($sPassword2))  //Test the lengths entered are equal
				ALERT:C41("The two passwords are not the same!")
				$fOK:=False:C215
			: ($LLength=Length:C16($sPassword2))  //Test the lengths entered are equal
				For ($i; 1; $LLength)
					If (Character code:C91($sPassword[[$i]])#Character code:C91($sPassword2[[$i]]))  //Test that each character matches
						ALERT:C41("The two passwords are not the same!")
						$i:=$LLength+1  // exit the loop
						$fOK:=False:C215
					End if 
				End for 
			Else   //should not get here....
				ALERT:C41("Invalid password!")
				$fOK:=False:C215
		End case 
		
		If ($fOK)
			CHANGE PASSWORD:C186($sPassword)
			ALERT:C41("Your password has been changed!")
		End if 
	End if 
	
End if 
//End of procedure