//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/03/09, 21:06:41
	// ----------------------------------------------------
	// Method: SCPOA_StreamBedMatl_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_06
End if 
C_LONGINT:C283($formevent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$formevent:=$1
Else 
	$formevent:=Form event code:C388
End if 
Case of 
	: ($formevent=On Load:K2:1)
		If ([ScourPOA:132]StreamBedMaterial:25="")
			SCPOA_BedMat_Unknown:=1
			OBJECT SET ENTERABLE:C238([ScourPOA:132]StreamBedMaterial:25; False:C215)
			OBJECT SET RGB COLORS:C628([ScourPOA:132]StreamBedMaterial:25; -1; -11; -11)
		Else 
			SCPOA_BedMat_Unknown:=0
			If (SCPOA_INPUTMODE_L=1)
				OBJECT SET ENTERABLE:C238([ScourPOA:132]StreamBedMaterial:25; True:C214)
				OBJECT SET RGB COLORS:C628([ScourPOA:132]StreamBedMaterial:25; -1; -2; -11)
			End if 
			
		End if 
		
	: ($formevent=On Clicked:K2:4)
		Case of 
			: (Focus object:C278=(->SCPOA_BedMat_Unknown))
				If (SCPOA_BedMat_Unknown=1)
					[ScourPOA:132]StreamBedMaterial:25:=""
					OBJECT SET ENTERABLE:C238([ScourPOA:132]StreamBedMaterial:25; False:C215)
					OBJECT SET RGB COLORS:C628([ScourPOA:132]StreamBedMaterial:25; -1; -11; -11)
				Else 
					[ScourPOA:132]StreamBedMaterial:25:=""
					OBJECT SET ENTERABLE:C238([ScourPOA:132]StreamBedMaterial:25; True:C214)
					OBJECT SET RGB COLORS:C628([ScourPOA:132]StreamBedMaterial:25; -1; -2; -11)
					
				End if 
				
			Else 
				OBJECT SET ENTERABLE:C238([ScourPOA:132]StreamBedMaterial:25; True:C214)
				OBJECT SET RGB COLORS:C628([ScourPOA:132]StreamBedMaterial:25; -1; -2; -11)
				SCPOA_BedMat_Unknown:=0
				
				PushChange(1; ->[ScourPOA:132]StreamBedMaterial:25)
		End case 
		PushChange(1; ->[ScourPOA:132]StreamBedMaterial:25)
		
End case 
