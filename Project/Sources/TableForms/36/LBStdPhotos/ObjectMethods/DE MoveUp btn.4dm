Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S)
		vGenericHlpMsgVar1_S:="Move Selected Images Up in the List"
		If (Folder separator:K24:12=":")
			vGenericHlpMsgVar1_S:=vGenericHlpMsgVar1_S+" (CMD-UpArrow)"
		Else 
			vGenericHlpMsgVar1_S:=vGenericHlpMsgVar1_S+" (CTRL-UpArrow)"
		End if 
	: (Form event code:C388=On Mouse Leave:K2:34)
		vGenericHlpMsgVar1_S:=""
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		INSP_MoveImages("UP")
End case 

