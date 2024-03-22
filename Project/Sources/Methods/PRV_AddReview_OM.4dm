//%attributes = {"invisible":true}
//Method: PRV_AddReview_OM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/06/12, 08:32:15
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
	// Modified by: Costas Manousakis-(Designer)-(9/25/13 15:02:54)
	Mods_2013_09
	//  `Copied to DEV
End if 
//
C_TEXT:C284($1; PRV_NEWREVIEWTYPE_s)
PRV_NEWREVIEWTYPE_s:=$1
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>1)
	C_LONGINT:C283($2)
	$FormEvent_L:=$2
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_TEXT:C284(vGEN_AddRecord_txt; PRV_LASTADDHLPMSG_txt)

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Mouse Enter:K2:33)
		PRV_LASTADDHLPMSG_txt:=vGEN_AddRecord_txt
		vGEN_AddRecord_txt:=PRV_NEWREVIEWTYPE_s
	: ($FormEvent_L=On Mouse Leave:K2:34)
		vGEN_AddRecord_txt:=PRV_LASTADDHLPMSG_txt
		
	: ($FormEvent_L=On Clicked:K2:4)
		
		FORM SET INPUT:C55([Preservation_Reviews:145]; "PreservReviewInput")
		ADD RECORD:C56([Preservation_Reviews:145])
		If (OK=1)
			PRV_CTRLSelections(PRV_NEWREVIEWTYPE_s)
			PRV_Variables("SUMM"+PRV_NEWREVIEWTYPE_s)
		End if 
End case 

//End PRV_AddReview_OM