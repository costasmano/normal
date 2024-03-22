//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/30/11, 09:46:44
	// ----------------------------------------------------
	// Method: SCPOA_OthMonInstrOth_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2011_05
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		If (SCPOA_OthMonInstrType_txt="")
			If (SCPOA_OthMonInstrOth_L#0)
				SCPOA_OthMonInstrOth_L:=0
				[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
			End if 
			SCPOA_SetEnterable_Var(->SCPOA_OthMonInstrType_txt; False:C215)
		Else 
			SCPOA_OthMonInstrOth_L:=0
			SCPOA_SetEnterable_Var(->SCPOA_OthMonInstrType_txt; False:C215)
			Case of 
				: (SCPOA_OthMonInstrType_txt="Portable")
					SCPOA_OthMonInstrPort_L:=1
					SCPOA_OthMonInstrType_txt:=""
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
				: (SCPOA_OthMonInstrType_txt="Geophysical")
					SCPOA_OthMonInstrGeo_L:=1
					SCPOA_OthMonInstrType_txt:=""
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
				: (SCPOA_OthMonInstrType_txt="Sonar")
					SCPOA_OthMonInstrSon_L:=1
					SCPOA_OthMonInstrType_txt:=""
					[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
				Else 
					If (SCPOA_OthMonInstrOth_L=0)
						SCPOA_OthMonInstrOth_L:=1
						[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
					End if 
					SCPOA_SetEnterable_Var(->SCPOA_OthMonInstrType_txt; (True:C214 & SCPOA_EditRecord_b))
			End case 
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		If (SCPOA_OthMonInstrOth_L=0)
			If (SCPOA_OthMonInstrType_txt="")
				SCPOA_SetEnterable_Var(->SCPOA_OthMonInstrType_txt; False:C215)
			Else 
				CONFIRM:C162("Clear value for Other Instrument type?"; "Clear"; "Cancel")
				If (OK=1)
					SCPOA_OthMonInstrType_txt:=""
					SCPOA_SetEnterable_Var(->SCPOA_OthMonInstrType_txt; False:C215)
				Else 
					SCPOA_OthMonInstrOth_L:=1
				End if 
				
			End if 
			
		Else 
			SCPOA_SetEnterable_Var(->SCPOA_OthMonInstrType_txt; (True:C214 & SCPOA_EditRecord_b))
		End if 
		SCPOA_InstrType_OM
	: ($FormEvent_L=On Double Clicked:K2:5)
		
End case 