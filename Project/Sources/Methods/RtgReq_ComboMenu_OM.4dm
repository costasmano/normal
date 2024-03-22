//%attributes = {"invisible":true}
//Method: RtgReq_ComboMenu_OM
//Description
//  ` method for Combomenus in rating request input forms
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:33:42
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
End if 
//
C_POINTER:C301($1; $2; $3)
ut_ComboMenuC($1; $2)

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	
	If ($2->#Old:C35($2->))
		$3->:=Current date:C33(*)
		C_LONGINT:C283($Field_L)
		$Field_L:=Field:C253($2)
		
		If (($Field_L=Field:C253(->[RatingRequests:154]ActionByAreaEng_s:6)) | ($Field_L=Field:C253(->[RatingRequests:154]ActionByBrgInspEng_s:9)) | ($Field_L=Field:C253(->[RatingRequests:154]ActionByStateBridgeEng_s:12)))
			If ($2->="Rejected@")
				[RatingRequests:154]Status_s:15:=$2->
				[RatingRequests:154]StatusDate_d:16:=Current date:C33(*)
				RtgReq_Status_cb{0}:=[RatingRequests:154]Status_s:15
			End if 
		End if 
		
	End if 
	
End if 

//End RtgReq_ComboMenu_OM