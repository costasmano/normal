If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/08, 15:08:02
	// ----------------------------------------------------
	// Method: Object Method: bPNFBtn
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		Case of 
			: (Current user:C182="Designer")
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			: (GRP_4DUIDinGroup(<>CurrentUser_UID; "PNF_INFO_GROUP")=1)
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			Else 
				
		End case 
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		SET TEXT TO PASTEBOARD:C523(QR_PNFInfo)
		ALERT:C41("Information for the PNF form has been copied to the clipboard!")
End case 