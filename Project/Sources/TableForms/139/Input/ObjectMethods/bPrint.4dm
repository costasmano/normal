//Method: [BridgeMHDNBISArchive];"Input".bPrint
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/30/18, 12:57:47
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
End if 
//

Case of 
	: ([BridgeMHDNBISArchive:139]Item8 BridgeCat:204="@RO")
		If (False:C215)
			G_PrintOptions
			//PAGE SETUP([BridgeMHDNBISArchive];"SI & A (Normal)")
			If (<>ShowPrint)
				PRINT SETTINGS:C106
			End if 
			If (OK=1)
				Print form:C5([BridgeMHDNBISArchive:139]; "RailTransitSIA")
				PAGE BREAK:C6
			End if 
		Else 
			ALERT:C41("Unable to print Rail and Transit SIA for Bridge Archive records!")
			
		End if 
		
	: ([BridgeMHDNBISArchive:139]Item8 BridgeCat:204="TNL") | ([BridgeMHDNBISArchive:139]Item8 BridgeCat:204="BTS")
		If (False:C215)
			G_PrintOptions
			//PAGE SETUP([BridgeMHDNBISArchive];"SI & A (Normal)")
			If (<>ShowPrint)
				PRINT SETTINGS:C106
			End if 
			If (OK=1)
				//READ ONLY([TunnelInfo])
				//QUERY([TunnelInfo];[TunnelInfo]BIN=[BridgeMHDNBISArchive]BIN)
				Print form:C5([BridgeMHDNBISArchive:139]; "TunnelSIA")
				PAGE BREAK:C6
			End if 
		Else 
			ALERT:C41("Unable to print Tunnel and Boat Section SIA for Bridge Archive records!")
		End if 
		
	Else 
		CENTER_WINDOW(250; 200; Movable dialog box:K34:7)
		DIALOG:C40([Dialogs:21]; "Print SIA")
		CLOSE WINDOW:C154
		
		If (Ok=1)
			G_PrintOptions
			//PAGE SETUP([BridgeMHDNBISArchive];"SI & A (Normal)")
			If (<>ShowPrint)
				PRINT SETTINGS:C106
			End if 
			If (Ok=1)  //Nov-2002 added check to see if canceled from Print Settings
				
				If (CBSIANormal=1)
					If ([BridgeMHDNBISArchive:139]InspResp:172="MBTA")
						If ([RAILBridgeInfo:37]BIN:1#[BridgeMHDNBISArchive:139]BIN:3)
							READ ONLY:C145([RAILBridgeInfo:37])
							QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
						End if 
						//Print form([BridgeMHDNBISArchive];"RailTransitSIA")
					End if 
					Print form:C5([BridgeMHDNBISArchive:139]; "SI & A (Normal)")
					
				End if 
				//PAGE BREAK(>)
				If (CBSIAInsp=1)
					
					If ([BridgeMHDNBISArchive:139]InspResp:172="MBTA")
						If ([RAILBridgeInfo:37]BIN:1#[BridgeMHDNBISArchive:139]BIN:3)
							READ ONLY:C145([RAILBridgeInfo:37])
							QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
						End if 
						//Print form([BridgeMHDNBISArchive];"RailTransitSIA")
					Else 
					End if 
					Print form:C5([BridgeMHDNBISArchive:139]; "SI & A (Insp)")
					
				End if 
				If (CBSIAMA=1)
					Print form:C5([BridgeMHDNBISArchive:139]; "MHD Specific Items")
				End if 
				
				PAGE BREAK:C6
			End if 
		End if 
End case 

REDRAW WINDOW:C456
//End [BridgeMHDNBISArchive].Input.bLast1