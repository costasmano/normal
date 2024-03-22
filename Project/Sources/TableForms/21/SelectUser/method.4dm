Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((Current user:C182="Designer") | (Current user:C182="administrator"))
			GET USER LIST:C609(aUserNames; aUserIDs)
			SORT ARRAY:C229(aUserNames; aUserIDs)
			C_LONGINT:C283($i; NumUsers)  //Command Replaced was o_C_INTEGER
			Numusers:=Size of array:C274(aUserNames)
			//Build user disp array
			ARRAY TEXT:C222(aUserInfo; NumUsers)  //Command Replaced was o_ARRAY string length was 132
			For ($i; 1; NumUsers)
				aUserInfo{$i}:=aUserNames{$i}+"  ID: "+String:C10(aUserIDs{$i}; "#######")
				If (Is user deleted:C616(aUserIDs{$i}))
					aUserInfo{$i}:=aUserInfo{$i}+" Deleted"
				End if 
			End for 
		Else 
			CANCEL:C270
		End if 
	: (Form event code:C388=On Unload:K2:2)
		// CLEAR VARIABLE(aUserNames)
		//CLEAR VARIABLE(aUserIDs)
		//CLEAR VARIABLE(aUserInfo)
		//CLEAR VARIABLE(vGroupList)
		
End case 
