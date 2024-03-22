Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		vGenericHlpMsgVar1_S:="Show Initial Pending List"
		
	: (Form event code:C388=On Clicked:K2:4)
		USE NAMED SELECTION:C332("NTI_PendInspList")
		LB_Tasks("CLEARHEADERS"; "TunnelInspections")
		LB_Tasks("DESELECTALL"; "TunnelInspections")
		SET WINDOW TITLE:C213("Pending TIN Inspections ["+String:C10(Records in selection:C76([TIN_Inspections:184]))+"]")
End case 