If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/11/09, 14:14:07
	// ----------------------------------------------------
	// Method: Object Method: ExportContractsbn
	// Description
	// Button to export all contract information for 
	// Farhad Rastegari
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((Current user:C182="Designer") | (Current user:C182="Farhad Rastegari"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		ut_ExportAllBridgeContracts
End case 
