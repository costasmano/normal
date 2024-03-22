If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/18/11, 10:41:30
	// ----------------------------------------------------
	// Method: Object Method: SCPOA_NWSSites_atxt
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Choise_L)
		$Choise_L:=SCPOA_NWSSites_atxt
		Case of 
			: ($Choise_L=1)
				If (SCPOA_NWSStation_txt#"")
					CONFIRM:C162("Do you want to clear the current Station :"+SCPOA_NWSStation_txt+"?")
					If (OK=1)
						SCPOA_NWSStation_txt:=""
						SCPOA_NWSStationURL_txt:=""
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
					
				End if 
				
			: ($Choise_L>1)
				$Choise_L:=$Choise_L-1
				SCPOA_NWSStation_txt:=SCPOA_NWSStations_atxt{$Choise_L}
				SCPOA_NWSStationURL_txt:=SCPOA_NWSStationURLs_atxt{$Choise_L}
				[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		End case 
		
End case 