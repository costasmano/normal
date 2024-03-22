//Method: Object Method: [Dialogs].ApproveInsp.vbAccept
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/31/12, 19:49:24
	// ----------------------------------------------------
	//Created : 
	Mods_2012_01
	// Modified by: Costas Manousakis-(Designer)-(3/25/12 10:17:10)
	Mods_2012_03
	//  `Fixed typo in the variable INSP_InDepthReview_L
End if 

Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (vApproveLvl=2)
			C_TEXT:C284($Options_txt)
			$Options_txt:="Regular Review;In Depth Review"
			C_LONGINT:C283($Choise_L)
			$Choise_L:=Pop up menu:C542($Options_txt)
			C_LONGINT:C283(INSP_InDepthReview_L)
			If ($Choise_L=2)
				INSP_InDepthReview_L:=1
			Else 
				INSP_InDepthReview_L:=0
			End if 
			
		End if 
		
End case 


//End Object Method: [Dialogs].ApproveInsp.vbAccept