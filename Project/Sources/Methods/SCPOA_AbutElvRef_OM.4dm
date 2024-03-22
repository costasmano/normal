//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/29/11, 18:35:32
	// ----------------------------------------------------
	// Method: SCPOA_AbutElvRef_OM
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_05
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
		If (SCPOA_AbutElevRef_txt="")
			Case of 
				: (Position:C15(Substring:C12([Bridge MHD NBIS:1]Item43:75; 2); "-11-12-")>0)  //arches
					SCPOA_AbutElevRef_txt:="Bottom of Key"
				: (Position:C15(Substring:C12([Bridge MHD NBIS:1]Item43:75; 2); "-09-10-")>0)  //trusses
					SCPOA_AbutElevRef_txt:="Bottom of Low Chord"
				Else 
					SCPOA_AbutElevRef_txt:="Lowest Bottom Flange"
			End case 
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		Else 
			
		End if 
		
	: ($formevent=On Clicked:K2:4)
		C_LONGINT:C283($index_L)
		$index_L:=SCPOA_AbutElevRef_atxt
		If ($index_L>1)
			If (SCPOA_AbutElevRef_atxt{$index_L}="OTHER")
				GOTO OBJECT:C206(SCPOA_AbutElevRef_txt)
				POST KEY:C465(Tab key:K12:28)
				POST KEY:C465(Tab key:K12:28; Shift key mask:K16:3)
			Else 
				SCPOA_AbutElevRef_txt:=SCPOA_AbutElevRef_atxt{$index_L}
			End if 
			
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		End if 
		
End case 