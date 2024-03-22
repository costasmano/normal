//Method: Object Method: [Bridge MHD NBIS].Bridge Input.bTunnelSIA
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/23/13, 14:05:55
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	// Modified by: Costas Manousakis-(Designer)-(6/6/13 10:28:59)
	Mods_2013_06
	//  `use new method ut_WindowSize to control window size 
End if 
//
//Can User Edit Tunnel?
C_BOOLEAN:C305($EditTunnelInfo_b)
C_TEXT:C284($CurrUser_txt)
$CurrUser_txt:=<>CurrentUser_Name
$EditTunnelInfo_b:=(User in group:C338($CurrUser_txt; "TunnelEdit") | User in group:C338($CurrUser_txt; "Design Access Group"))
C_LONGINT:C283($winW_L; $winH_L)
ut_WindowSize("GET"; ->$winW_L; ->$winH_L)
If ($EditTunnelInfo_b)
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
		FORM SET INPUT:C55([TunnelInfo:151]; "TunnelInput")
		QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
		
		If (Records in selection:C76([TunnelInfo:151])=1)
			LOAD RECORD:C52([TunnelInfo:151])
			If (ut_LoadRecordInteractive(->[TunnelInfo:151]))
				ut_WindowSize("FITFORM"; ->$winW_L; ->$winH_L; ->[TunnelInfo:151]; "TunnelInput")
				MODIFY RECORD:C57([TunnelInfo:151])
				ut_WindowSize("MATCH"; ->$winW_L; ->$winH_L)
			Else 
				ALERT:C41("Could not load for editing the Tunnel Info!")
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
				UNLOAD RECORD:C212([Bridge MHD NBIS:1])
				UNLOAD RECORD:C212([TunnelInfo:151])
				READ ONLY:C145([Bridge MHD NBIS:1])
				READ ONLY:C145([TunnelInfo:151])
				LOAD RECORD:C52([TunnelInfo:151])
				LOAD RECORD:C52([Bridge MHD NBIS:1])
				ut_WindowSize("FITFORM"; ->$winW_L; ->$winH_L; ->[TunnelInfo:151]; "TunnelInput")
				DIALOG:C40([TunnelInfo:151]; "TunnelInput")
				ut_WindowSize("MATCH"; ->$winW_L; ->$winH_L)
				DIALOG:C40([TunnelInfo:151]; "TunnelInput")
				
			End if 
			
		Else 
			READ WRITE:C146([TunnelInfo:151])
			ut_WindowSize("FITFORM"; ->$winW_L; ->$winH_L; ->[TunnelInfo:151]; "TunnelInput")
			ADD RECORD:C56([TunnelInfo:151])
			ut_WindowSize("MATCH"; ->$winW_L; ->$winH_L)
		End if 
	Else 
		
	End if 
	
Else 
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
	UNLOAD RECORD:C212([Bridge MHD NBIS:1])
	UNLOAD RECORD:C212([TunnelInfo:151])
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ ONLY:C145([TunnelInfo:151])
	LOAD RECORD:C52([Bridge MHD NBIS:1])
	QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	LOAD RECORD:C52([TunnelInfo:151])
	ut_WindowSize("FITFORM"; ->$winW_L; ->$winH_L; ->[TunnelInfo:151]; "TunnelInput")
	DIALOG:C40([TunnelInfo:151]; "TunnelInput")
	READ WRITE:C146([Bridge MHD NBIS:1])
	ut_WindowSize("MATCH"; ->$winW_L; ->$winH_L)
	
End if 
SIA_BridgeInput_FM(On Load:K2:1)
//End Object Method: [Bridge MHD NBIS].Bridge Input.bTunnelSIA