//Method: Object Method: [TunnelInfo].SpecialFreqCheck.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/30/13, 10:58:38
	// ----------------------------------------------------
	//Created : 
	Mods_2013_09
End if 
//
//Verify data is OK
C_TEXT:C284($MSg_txt)
$MSg_txt:=""
C_BOOLEAN:C305($DoApply_b)
$DoApply_b:=True:C214
Case of 
	: (INSP_TunnelSpecMemReq_L ?? 1)  //3 mo requested?
		If ((INSP_TunnelSp1Freq_L=3) | (INSP_TunnelSp2Freq_L=3) | (INSP_TunnelSp3Freq_L=3))
		Else 
			$MSg_txt:="Required 3 month frequency not applied!"+Char:C90(13)
		End if 
	: (INSP_TunnelSpecMemReq_L ?? 2)  //6 mo requested?
		If ((INSP_TunnelSp1Freq_L=6) | (INSP_TunnelSp2Freq_L=6) | (INSP_TunnelSp3Freq_L=6))
		Else 
			$MSg_txt:="Required 6 month frequency not applied!"+Char:C90(13)
		End if 
	: (INSP_TunnelSpecMemReq_L ?? 2)  //12 mo requested?
		If ((INSP_TunnelSp1Freq_L=12) | (INSP_TunnelSp2Freq_L=12) | (INSP_TunnelSp3Freq_L=12))
		Else 
			$MSg_txt:="Required 12 month frequency not applied!"+Char:C90(13)
		End if 
End case 
If ($msg_txt#"")
	CONFIRM:C162($msg_txt+"Apply changes?"; "Apply"; "Cancel")
	$DoApply_b:=(OK=1)
End if 

If ($DoApply_b)
	[TunnelInfo:151]SpecialInsp1Desc_s:30:=INSP_TunnelSp1Desc_s
	[TunnelInfo:151]SpecialInsp1Freq_i:25:=INSP_TunnelSp1Freq_L
	[TunnelInfo:151]SpecialInsp2Desc_s:31:=INSP_TunnelSp2Desc_s
	[TunnelInfo:151]SpecialInsp2Freq_i:27:=INSP_TunnelSp2Freq_L
	[TunnelInfo:151]SpecialInsp3Desc_s:32:=INSP_TunnelSp3Desc_s
	[TunnelInfo:151]SpecialInsp3Freq_i:29:=INSP_TunnelSp3Freq_L
	INSP_TunnelSpMDataChg_b:=False:C215
	OBJECT SET ENABLED:C1123(*; "BOK"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
End if 
//End Object Method: [TunnelInfo].SpecialFreqCheck.Button