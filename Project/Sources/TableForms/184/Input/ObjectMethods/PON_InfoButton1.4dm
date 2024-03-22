//[TIN_Inspections].Input.PON_InfoButton

Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		ut_GenericHelp_OM("TIN Inspection Input help")
	: (Form event code:C388=On Mouse Leave:K2:34)
		ut_GenericHelp_OM
		
	: (Form event code:C388=On Clicked:K2:4)
		NTI_OpenNTEInfo
		
End case 

