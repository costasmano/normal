If (False:C215)
	//Object Method: [TIN_Inspections];"ReviewList".bShowAll 
	// Modified by: Costas Manousakis-(Designer)-(2/2/17 17:16:37)
	Mods_2017_02
	//  `use NTI_GetMyPending
	// Modified by: Costas Manousakis-(Designer)-(12/20/18 11:13:14)
	Mods_2018_12_bug
	//  `The sort is done in NTI_GetMyPending
End if 

Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		vGenericHlpMsgVar1_S:="Refresh List"
		
	: (Form event code:C388=On Clicked:K2:4)
		NTI_GetMyPending
		//QUERY([TIN_Inspections];[TIN_Inspections]InspApproval#BMS Approved )
		COPY NAMED SELECTION:C331([TIN_Inspections:184]; "NTI_PendInspList")
		LB_Tasks("CLEARHEADERS"; "TunnelInspections")
		LB_Tasks("DESELECTALL"; "TunnelInspections")
		SET WINDOW TITLE:C213("Pending TIN Inspections ["+String:C10(Records in selection:C76([TIN_Inspections:184]))+"]")
End case 