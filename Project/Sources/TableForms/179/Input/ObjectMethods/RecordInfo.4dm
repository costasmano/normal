Case of 
	: (Form event code:C388=On Load:K2:1)
		If (User in group:C338(Current user:C182; "Design Access Group"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($msg)
		$msg:="Current record ID = "+String:C10([PON_ELEM_INSP:179]ELEMID:22)+<>sCR
		$msg:=$msg+"Current Insp ID = "+String:C10([PON_ELEM_INSP:179]INSPID:21)+<>sCR
		$msg:=$msg+"ParentID = "+String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27)+<>sCR
		$msg:=$msg+"GrandParentID = "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
		ALERT:C41($msg)
End case 
