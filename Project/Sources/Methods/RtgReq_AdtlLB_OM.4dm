//%attributes = {"invisible":true}
// Method: RtgReq_AdtlLB_OM
// Description
//  ` Object method for the Additional request list box
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:31:18
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/21/17 15:07:37)
End if 
//
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Load:K2:1)
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		
	: ($FormEvent_L=On Double Clicked:K2:5)
		
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			C_LONGINT:C283($taskRes_L)
			$taskRes_L:=LB_Tasks("DOUBLECLICK"; "AddtlReq")
			
			If ($taskRes_L=1)
				QUERY:C277([AddtlRatingRequests:155]; [AddtlRatingRequests:155]RatingRequestID_L:1=[RatingRequests:154]RatingRequestID_L:2)
				ORDER BY:C49([AddtlRatingRequests:155]; [AddtlRatingRequests:155]NewRequestDate_d:3; <)
			End if 
			InDoubleClick_B:=False:C215
		End if 
		
End case 
//End RtgReq_AdtlLB_OM