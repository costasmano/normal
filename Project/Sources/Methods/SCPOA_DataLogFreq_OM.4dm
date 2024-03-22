//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/19/09, 20:24:32
	// ----------------------------------------------------
	// Method: SCPOA_DataLogFreq_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $formEvent
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(3/30/11 18:31:33)
	Mods_2011_05
	//  `SCPOA V2 modifications
End if 
C_LONGINT:C283($FormEvent)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent:=$1
Else 
	$FormEvent:=Form event code:C388
End if 
If (False:C215)
	C_LONGINT:C283($index_l)
	Case of 
		: ($FormEvent=On Load:K2:1)
			$index_l:=Find in array:C230(SCPOA_DataLogFreq_atxt; SCPOA_DataFreqOther_txt)
			If (($index_l<=0) & (SCPOA_DataFreqOther_txt#""))
				$index_l:=Find in array:C230(SCPOA_DataLogFreq_atxt; "Other")
			End if 
			SCPOA_DataLogFreq_atxt:=$index_l
			If ((SCPOA_DataLogFreq_atxt{$index_l}="Other") & (SCPOA_EditRecord_b))
				SCPOA_SetEnterable_Name("SCPOA_DataFreqOther_txt@"; True:C214)
			Else 
				SCPOA_SetEnterable_Name("SCPOA_DataFreqOther_txt"; False:C215)
			End if 
			SCPOA_Array2CheckBox($index_l; ->SCPOA_2CDwnldDay_L; ->SCPOA_2CDwnldWk_L; ->SCPOA_2CDwnldMo_L; ->SCPOA_2CDwnldOther_L)
		: ($FormEvent=On Clicked:K2:4)
			$index_l:=SCPOA_DataLogFreq_atxt
			
			If (SCPOA_DataLogFreq_atxt{$index_l}="Other")
				SCPOA_SetEnterable_Name("SCPOA_DataFreqOther_txt"; True:C214)
			Else 
				SCPOA_DataFreqOther_txt:=SCPOA_DataLogFreq_atxt{$index_l}
				SCPOA_SetEnterable_Name("SCPOA_DataFreqOther_txt"; False:C215)
			End if 
			SCPOA_Array2CheckBox($index_l; ->SCPOA_2CDwnldDay_L; ->SCPOA_2CDwnldWk_L; ->SCPOA_2CDwnldMo_L; ->SCPOA_2CDwnldOther_L)
			
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
	End case 
	
End if 
SCPOA_SampleOpts(->SCPOA_DataLogFreq_atxt; ->SCPOA_DataFreqOther_txt; ->SCPOA_DataFreqOtherDesc_txt; ->SCPOA_2CDwnldCkBx_aptr; "SCPOA_DataFreqOtherDesc_txt@"; $FormEvent)