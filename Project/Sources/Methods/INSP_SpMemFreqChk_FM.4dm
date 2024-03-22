//%attributes = {"invisible":true}
// Method: INSP_SpMemFreqChk_FM
// Description
// 
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 09/30/13, 11:06:19
	// ----------------------------------------------------
	// First Release
	Mods_2013_09
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Data Change:K2:15)
		//has anything changed from the data stored?
		C_BOOLEAN:C305(INSP_TunnelSpMDataChg_b)
		INSP_TunnelSpMDataChg_b:=False:C215
		INSP_TunnelSpMDataChg_b:=INSP_TunnelSpMDataChg_b | (INSP_TunnelSp1Freq_L#[TunnelInfo:151]SpecialInsp1Freq_i:25)
		INSP_TunnelSpMDataChg_b:=INSP_TunnelSpMDataChg_b | (INSP_TunnelSp2Freq_L#[TunnelInfo:151]SpecialInsp2Freq_i:27)
		INSP_TunnelSpMDataChg_b:=INSP_TunnelSpMDataChg_b | (INSP_TunnelSp3Freq_L#[TunnelInfo:151]SpecialInsp3Freq_i:29)
		INSP_TunnelSpMDataChg_b:=INSP_TunnelSpMDataChg_b | (INSP_TunnelSp1Desc_s#[TunnelInfo:151]SpecialInsp1Desc_s:30)
		INSP_TunnelSpMDataChg_b:=INSP_TunnelSpMDataChg_b | (INSP_TunnelSp2Desc_s#[TunnelInfo:151]SpecialInsp2Desc_s:31)
		INSP_TunnelSpMDataChg_b:=INSP_TunnelSpMDataChg_b | (INSP_TunnelSp3Desc_s#[TunnelInfo:151]SpecialInsp3Desc_s:32)
		
		If (INSP_TunnelSpMDataChg_b)
			OBJECT SET ENABLED:C1123(*; "BOK"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: ($FormEvent_L=On Load:K2:1)
		OBJECT SET ENABLED:C1123(*; "BOK"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		INSP_TunnelSpMStack_L:=1  //is this stack correct ?????
		InitChangeStack(INSP_TunnelSpMStack_L)
		
	: ($FormEvent_L=On Close Box:K2:21)
		
		If (INSP_TunnelSpMDataChg_b)
			CONFIRM:C162("Changes made have not been saved! Are you sure you want to Exit this form?"; "Stay In Form"; "Exit")
			If (OK#1)
				CANCEL:C270
			End if 
		Else 
			CANCEL:C270
		End if 
		
End case 