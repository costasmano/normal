//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/08/09, 20:38:23
	// ----------------------------------------------------
	// Method: SCPOA_Footing_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_04
	// Modified by: costasmanousakis-(Designer)-(12/30/09 15:16:31)
	Mods_2009_12
	//  `When choosing OTHER, clear the foundation type field instead of highlighting it
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
		SC_FTG_Unknown:=0
		Case of 
			: ([ScourPOA:132]FoundationType:19="")
				SCPOA_FoundationType_atxt:=0
			Else 
				C_LONGINT:C283($index_L)
				$index_L:=Find in array:C230(SCPOA_FoundationType_atxt; [ScourPOA:132]FoundationType:19)
				If ($index_L>0)
					SCPOA_FoundationType_atxt:=$index_L
					If ([ScourPOA:132]FoundationType:19="UNKNOWN")
						SC_FTG_Unknown:=1
					End if 
				Else 
					$index_L:=Find in array:C230(SCPOA_FoundationType_atxt; "OTHER")
					SCPOA_FoundationType_atxt:=$index_L
				End if 
				
		End case 
		
		If (Position:C15("Spread"; [ScourPOA:132]FoundationType:19)>0)
			SC_FTG_SpreadFtg:=1
			SC_FTG_Unknown:=0
		Else 
			SC_FTG_SpreadFtg:=0
		End if 
		If (Position:C15("Extension"; [ScourPOA:132]FoundationType:19)>0)
			SC_FTG_PileExt:=1
			SC_FTG_Unknown:=0
		Else 
			SC_FTG_PileExt:=0
		End if 
		If (Position:C15("on Piles"; [ScourPOA:132]FoundationType:19)>0)
			SC_FTG_OnPiles:=1
			SC_FTG_Unknown:=0
		Else 
			SC_FTG_OnPiles:=0
		End if 
		
	: ($formevent=On Clicked:K2:4)
		C_LONGINT:C283($index_L)
		$index_L:=SCPOA_FoundationType_atxt
		If (SCPOA_FoundationType_atxt{$index_L}="OTHER")
			[ScourPOA:132]FoundationType:19:=""
			GOTO OBJECT:C206([ScourPOA:132]FoundationType:19)
			POST KEY:C465(Tab key:K12:28)
			POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
		Else 
			[ScourPOA:132]FoundationType:19:=SCPOA_FoundationType_atxt{$index_L}
		End if 
		If ([ScourPOA:132]FoundationType:19="UNKNOWN")
			SC_FTG_Unknown:=1
		End if 
		
		PushChange(1; ->[ScourPOA:132]FoundationType:19)
		
End case 