//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/19/09, 20:24:32
	// ----------------------------------------------------
	// Method: SCPOA_MonitSampl_OM
	// Description
	// 
	// 
	// Parameters
	// $1 : $formEvent
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(3/23/11 21:54:44)
	Mods_2011_05
	//SCPOA Mods 2
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
			$index_l:=Find in array:C230(SCPOA_MonitSampl_atxt; SCPOA_SamplOther_txt)
			If (($index_l<=0) & (SCPOA_SamplOther_txt#""))
				$index_l:=Find in array:C230(SCPOA_MonitSampl_atxt; "Other")
			End if 
			
			If (($index_l<=0) & (SCPOA_DataFreqOther_txt=""))
				SCPOA_MonitSampl_atxt:=0
				SCPOA_SetEnterable_Name("SCPOA_SamplOther_txt@"; False:C215)
			Else 
				SCPOA_MonitSampl_atxt:=$index_l
				If ((SCPOA_MonitSampl_atxt{$index_l}="Other") & SCPOA_EditRecord_b)
					SCPOA_SetEnterable_Name("SCPOA_SamplOther_txt@"; True:C214)
				Else 
					SCPOA_SetEnterable_Name("SCPOA_SamplOther_txt@"; False:C215)
				End if 
				
			End if 
			SCPOA_Array2CheckBox($index_l; ->SCPOA_2CSamp30min_L; ->SCPOA_2CSamp1hr_L; ->SCPOA_2CSamp6hr_L; ->SCPOA_2CSamp12hr_L; ->SCPOA_2CSampOther_L)
			
		: ($FormEvent=On Clicked:K2:4)
			
			$index_l:=SCPOA_MonitSampl_atxt
			
			If (SCPOA_MonitSampl_atxt{$index_l}="Other")
				SCPOA_SetEnterable_Name("SCPOA_SamplOther_txt@"; True:C214)
			Else 
				SCPOA_SamplOther_txt:=SCPOA_MonitSampl_atxt{$index_l}
				SCPOA_SetEnterable_Name("SCPOA_SamplOther_txt@"; False:C215)
			End if 
			SCPOA_Array2CheckBox($index_l; ->SCPOA_2CSamp30min_L; ->SCPOA_2CSamp1hr_L; ->SCPOA_2CSamp6hr_L; ->SCPOA_2CSamp12hr_L; ->SCPOA_2CSampOther_L)
			
			[ScourPOA:132]BIN:2:=[ScourPOA:132]BIN:2
	End case 
	
End if 
SCPOA_SampleOpts(->SCPOA_MonitSampl_atxt; ->SCPOA_SamplOther_txt; ->SCPOA_SamplOtherDesc_txt; ->SCPOA_2CSampleCkBx_aptr; "SCPOA_SamplOtherDesc_txt"; $FormEvent)