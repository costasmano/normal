//%attributes = {"invisible":true}
// Method: RtgReq_AdtlInp_FM
// Description
//  ` Form method for Adtl rating request input form
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:29:10
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	// Modified by: Costas Manousakis-(Designer)-(4/30/14 15:29:54)
	Mods_2014_04_bug
	//  `moved code to log new record in the accept button. fixed call the pushall to indicate the ID fields.
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		If (Is new record:C668([AddtlRatingRequests:155]))
			[AddtlRatingRequests:155]RatingRequestID_L:1:=[RatingRequests:154]RatingRequestID_L:2
			Inc_Sequence("AddRatingRequest"; ->[AddtlRatingRequests:155]AddtlRequestID_L:2)
		End if 
		InitChangeStack(2)  //Addtional
		
		If (Read only state:C362([AddtlRatingRequests:155]))
			OBJECT SET ENABLED:C1123(*; "DE @"; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		Else 
			OBJECT SET ENABLED:C1123(*; "DE @"; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		End if 
		
	: ($FormEvent_L=On Validate:K2:3)
		
		PushAllChanges(2; ->[AddtlRatingRequests:155]; ->[AddtlRatingRequests:155]RatingRequestID_L:1; ->[AddtlRatingRequests:155]AddtlRequestID_L:2)
		FlushGrpChgs(2; ->[RatingRequests:154]RatingRequestID_L:2; ->[AddtlRatingRequests:155]RatingRequestID_L:1; ->[AddtlRatingRequests:155]AddtlRequestID_L:2; 2)
		
	: ($FormEvent_L=On Unload:K2:2)
		
End case 
//End RtgReq_AdtlInp_FM