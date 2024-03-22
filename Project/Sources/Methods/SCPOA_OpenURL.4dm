//%attributes = {"invisible":true}
//Method: SCPOA_OpenURL
//Description
//  ` Object method for the buttons that open URL for usgs, nws etc.
// Parameters
//  $1 : $URLText_txt
// $2 : $HelpMessage_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/07/14, 12:06:56
	// ----------------------------------------------------
	//Created : 
	Mods_2014_03
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($URLText_txt; $HelpMessage_txt)
$URLText_txt:=$1
$HelpMessage_txt:=$2
C_BOOLEAN:C305($DisableHlp_b)
If (Count parameters:C259>2)
	C_BOOLEAN:C305($3)
	$DisableHlp_b:=$3
End if 
$URLText_txt:=f_TrimStr(ut_getURLfromText($URLText_txt); True:C214; True:C214)
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If ($URLText_txt#"")
			OPEN URL:C673($URLText_txt)
		End if 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		SCPOA_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		If (($URLText_txt="") | $DisableHlp_b)
			vGenericHlpMsgVar1_S:=""
		Else 
			vGenericHlpMsgVar1_S:=$HelpMessage_txt
		End if 
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		If (SCPOA_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=SCPOA_OldGenMsg_txt
		End if 
		
End case 

//End SCPOA_OpenURL