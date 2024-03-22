Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(Self:C308->; User in group:C338(Current user:C182; "Design Access Group"))
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($msg)
		$msg:="Current record ID = "+String:C10([NTI_ELEM_BIN_INSP:183]ELEMID:2)+<>sCR
		$msg:=$msg+"Current Insp ID = "+String:C10([NTI_ELEM_BIN_INSP:183]INSPID:1)+<>sCR
		$msg:=$msg+"ParentID = "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8)+<>sCR
		ALERT:C41($msg)
End case 
