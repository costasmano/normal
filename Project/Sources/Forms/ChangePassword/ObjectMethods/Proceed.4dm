//Method: "ChangePassword".Proceed
//Description
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 07/12/22, 15:00:26
	// ----------------------------------------------------
	//Created : 
	Mods_2022_07
	// Modified by: Costas Manousakis-(Designer)-(2022-12-23 15:38:35)
	Mods_2022_12_bug
	//  `Do all password validation here.
End if 
C_BOOLEAN:C305($Proceed)

ARRAY LONGINT:C221($UserIDs_aL; 0)
ARRAY TEXT:C222($usernames_atxt; 0)
GET USER LIST:C609($usernames_atxt; $UserIDs_aL)
C_LONGINT:C283($indx)
$indx:=Find in array:C230($usernames_atxt; Form:C1466.CurrentUser)

If (Validate password:C638($UserIDs_aL{$indx}; Form:C1466.CurrentPassword))
	C_TEXT:C284($Pass1_txt; $Pass2_txt)
	$Pass1_txt:=Form:C1466.NewPassword1
	$Pass2_txt:=Form:C1466.NewPassword2
	$Proceed:=ut_CheckPasswordRules($Pass1_txt; $Pass2_txt)
	
Else 
	ALERT:C41("Current Password is incorrect!")
	$Proceed:=False:C215
End if 

If ($Proceed)
	
	C_LONGINT:C283($PassedInID_L; $Offset_L; $ReturnedID_L; $Pos_L)
	C_TEXT:C284($CurrentUser_txt; $CurrentPassword_txt; $remoteIPAddress_txt; $AdminPassword)
	$PassedInID_L:=-99999
	$ReturnedID_L:=$PassedInID_L
	C_BOOLEAN:C305($Proceed_B)
	If (Application type:C494=4D Remote mode:K5:5)
		SQLConnectionMade_b:=False:C215
		$Proceed_B:=True:C214
		$CurrentUser_txt:=Current user:C182
	Else 
		
		$CurrentUser_txt:=Form:C1466.CurrentUser
		$CurrentPassword_txt:=Form:C1466.CurrentPassword
		$remoteIPAddress_txt:=<>DestIP
		SQLError_b:=False:C215
		//
		clone_sqlConnect($CurrentUser_txt; $CurrentPassword_txt; $remoteIPAddress_txt)
		$Proceed_B:=SQLConnectionMade_b
	End if 
	If ($Proceed_B)
		SQLError_b:=False:C215
		If (SQLConnectionMade_b)
			C_BLOB:C604(Send_Blb; Receive_Blb; $dbg_blb)
			
			GET USER LIST:C609($UserNames_atxt; $UserIDs_aL)
			C_TEXT:C284($TestUserName_txt)
			C_BOOLEAN:C305($Complete_B)
			
			$Pos_L:=Find in array:C230($UserNames_atxt; $CurrentUser_txt)
			$PassedInID_L:=$UserIDs_aL{$Pos_L}
			C_TEXT:C284($NewPassword_txt)
			$NewPassword_txt:=Form:C1466.NewPassword1
			
			VARIABLE TO BLOB:C532($CurrentUser_txt; Send_blb; *)
			VARIABLE TO BLOB:C532($NewPassword_txt; Send_blb; *)
			VARIABLE TO BLOB:C532($PassedInID_L; Send_blb; *)
			
			C_BOOLEAN:C305($dbg)
			If (OB Is defined:C1231(Form:C1466.dodebug))
				$dbg:=True:C214
				VARIABLE TO BLOB:C532($dbg; Send_blb; *)
			End if 
			
			C_TEXT:C284(SQLQuery_txt; BackUpdata_txt)
			SQLQuery_txt:="SELECT {fn FN_SetPassword(<<Send_Blb>>) AS BLOB} FROM Preferences INTO :Receive_Blb;"
			ON ERR CALL:C155("SQL_ERROR")  //
			Begin SQL
				EXECUTE IMMEDIATE :SQLQuery_txt;
			End SQL
			SQL LOGOUT:C872
			
			//error checking
			$Offset_L:=0
			BLOB TO VARIABLE:C533(Receive_Blb; $ReturnedID_L; $Offset_L)
			BLOB TO VARIABLE:C533(Receive_Blb; $dbg_blb; $Offset_L)
			If (BLOB size:C605($dbg_blb)>0)
				C_TEXT:C284($t1; $t2; $t3; $t4; $t5)
				$Offset_L:=0
				BLOB TO VARIABLE:C533($dbg_blb; $t1; $Offset_L)
				BLOB TO VARIABLE:C533($dbg_blb; $t2; $Offset_L)
				BLOB TO VARIABLE:C533($dbg_blb; $t3; $Offset_L)
				BLOB TO VARIABLE:C533($dbg_blb; $t4; $Offset_L)
				BLOB TO VARIABLE:C533($dbg_blb; $t5; $Offset_L)
				ut_BigAlert($t1+"\n"+$t2+"\n"+$t3+"\n"+$t4+"\n"+$t5)
				
			End if 
			
			If (Not:C34(SQLError_b)) & ($ReturnedID_L=$PassedInID_L)
				If (Current user:C182="Designer")
					C_TEXT:C284($Name_txt; $PassWord_txt; $startUp_txt)
					C_LONGINT:C283($NumberLogins_L; $Return_L)
					C_DATE:C307($LastLogin_D)
					GET USER PROPERTIES:C611($PassedInID_L; $Name_txt; $PassWord_txt; $startUp_txt; $NumberLogins_L; $LastLogin_D)
					$Return_L:=Set user properties:C612($PassedInID_L; $CurrentUser_txt; $startUp_txt; $NewPassword_txt; $NumberLogins_L; $LastLogin_D)
					If ($Return_L=$PassedInID_L)
						ALERT:C41("Local and Server password changed for "+$CurrentUser_txt)
					Else 
						ALERT:C41("Local password NOT changed and Server password changed for "+$CurrentUser_txt+" Notify Administrator")
						
					End if 
				Else 
					CHANGE PASSWORD:C186($NewPassword_txt)
					ALERT:C41("Password changed for "+$CurrentUser_txt)
				End if 
			Else 
				ALERT:C41("Password not changed as error updating on Server")
			End if 
		Else 
			CHANGE PASSWORD:C186($NewPassword_txt)
			ALERT:C41("Password changed for "+$CurrentUser_txt)
		End if 
		
	Else 
		ALERT:C41("Could not connect to remote server. password not changed!")
		
	End if 
	
	ACCEPT:C269
End if 

//End ChangePassword.Proceed