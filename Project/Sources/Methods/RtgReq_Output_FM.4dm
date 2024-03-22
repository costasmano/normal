//%attributes = {"invisible":true}
// Method: RtgReq_Output_FM
// Description
//  ` Method for the output form of rating requests
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:47:03
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
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
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		READ ONLY:C145(*)
		
		If (True:C214)
			READ WRITE:C146([RatingRequests:154])
			READ WRITE:C146([AddtlRatingRequests:155])
		End if 
		SET MENU BAR:C67("RtgReqMenu")
		LB_Tasks("ADDTOLIST"; "RtgReq"; "Rating Requests"; "Input"; ->[RatingRequests:154]RatingRequestID_L:2)
		RtgReq_Utility("STARTOUTPUTLIST")
		RtgReq_Utility("DEFAULTSORT")
		
	: ($FormEvent_L=On Validate:K2:3)
		
	: ($FormEvent_L=On Unload:K2:2)
		
	: ($FormEvent_L=On Outside Call:K2:11)
		If (<>fQuit)
			CANCEL:C270
		End if 
	: ($FormEvent_L=On Activate:K2:9)
		UpdatFilesPalet
	: ($FormEvent_L=On Deactivate:K2:10)
		UpdatFilesPalet
		
		
End case 
//End RtgReq_Output_FM