If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/20/06, 16:02:19
	// ----------------------------------------------------
	// Method: Object Method: DnldInspBtn
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM03
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		Case of 
			: (Current user:C182="Designer")
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			: (<>Destination#"MHD BMS")
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
			: (<>TxUserName=Current user:C182)
				OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
				
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		C_BOOLEAN:C305(INSP_BatchDownload_b)
		INSP_BatchDownload_b:=False:C215
		INSP_DownloadMissing(Current user:C182#"Designer")
End case 