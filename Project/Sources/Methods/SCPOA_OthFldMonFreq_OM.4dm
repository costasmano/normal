//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/19/09, 20:58:20
	// ----------------------------------------------------
	// Method: SCPOA_OthFldMonFreq_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $formEvent
	// ----------------------------------------------------
	
	Mods_2009_05
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
C_LONGINT:C283($index_l)
Case of 
	: ($FormEvent=On Load:K2:1)
		$index_l:=Find in array:C230(SCPOA_OthFldMonFreq_atxt; SCPOA_OthFldMonFreq_txt)
		If ($index_l<=0)
			SCPOA_OthFldMonFreq_atxt:=0
		Else 
			SCPOA_OthFldMonFreq_atxt:=$index_l
		End if 
		
	: ($FormEvent=On Clicked:K2:4)
		$index_l:=SCPOA_OthFldMonFreq_atxt
		SCPOA_OthFldMonFreq_txt:=SCPOA_OthFldMonFreq_atxt{$index_l}
		[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
		
End case 