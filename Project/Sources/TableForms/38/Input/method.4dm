If (False:C215)
	//Change from FlushChanges to FlushGRPChanges
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		InitChangeStack(1)
		
	: (Form event code:C388=On Validate:K2:3)
		FlushGrpChgs(1; ->[Foundation Type:38]Code:1; ->[Foundation Type:38]Code:1; ->[Foundation Type:38]Code:1; 0)
End case 