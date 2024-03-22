//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/08/09, 21:23:42
	// ----------------------------------------------------
	// Method: SCPOA_FootingMatl_OM
	// Description
	// Object method for the Footing Material
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_05
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
		If ([ScourPOA:132]FoundationMat:20="")
			SCPOA_FTMat_known:=0
			SCPOA_FTMat_Unknown:=1
			OBJECT SET ENTERABLE:C238([ScourPOA:132]FoundationMat:20; False:C215)
			OBJECT SET RGB COLORS:C628([ScourPOA:132]FoundationMat:20; -1; -11; -11)
		Else 
			SCPOA_FTMat_known:=1
			SCPOA_FTMat_Unknown:=0
			If (SCPOA_INPUTMODE_L=1)
				OBJECT SET ENTERABLE:C238([ScourPOA:132]FoundationMat:20; True:C214)
				OBJECT SET RGB COLORS:C628([ScourPOA:132]FoundationMat:20; -1; -2; -11)
			End if 
			
		End if 
		
	: ($formevent=On Clicked:K2:4)
		Case of 
			: (Focus object:C278=(->SCPOA_FTMat_Unknown))
				If (SCPOA_FTMat_Unknown=1)
					[ScourPOA:132]FoundationMat:20:=""
					SCPOA_FTMat_known:=0
					OBJECT SET ENTERABLE:C238([ScourPOA:132]FoundationMat:20; False:C215)
					OBJECT SET RGB COLORS:C628([ScourPOA:132]FoundationMat:20; -1; -11; -11)
				Else 
					[ScourPOA:132]FoundationMat:20:=""
					SCPOA_FTMat_known:=0
					OBJECT SET ENTERABLE:C238([ScourPOA:132]FoundationMat:20; True:C214)
					OBJECT SET RGB COLORS:C628([ScourPOA:132]FoundationMat:20; -1; -2; -11)
					
				End if 
				
			Else 
				OBJECT SET ENTERABLE:C238([ScourPOA:132]FoundationMat:20; True:C214)
				OBJECT SET RGB COLORS:C628([ScourPOA:132]FoundationMat:20; -1; -2; -11)
				SCPOA_FTMat_Unknown:=0
				
				PushChange(1; ->[ScourPOA:132]FoundationMat:20)
		End case 
		PushChange(1; ->[ScourPOA:132]FoundationMat:20)
		
End case 
