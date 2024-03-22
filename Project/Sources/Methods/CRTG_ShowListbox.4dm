//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 16:03:20
	// ----------------------------------------------------
	// Method: CRTG_ShowListbox
	// Description
	//  ` Display a list box for Cons rating reports
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
If (Count parameters:C259=0)
	C_LONGINT:C283($Lpid_L)
	$Lpid_L:=LSpawnProcess("CRTG_ShowListbox"; <>LStackSize; "RatingReview"; True:C214; False:C215; "RUN")
Else 
	C_TEXT:C284($1)
	
	InitProcessVar
	ALL RECORDS:C47([Conslt Rating:63])
	CRTG_ReviewLBControl("LOAD")
	C_LONGINT:C283($win)
	CENTER_WINDOW(800; 600; Plain window:K34:13)
	SET MENU BAR:C67("BlankMenu")
	DIALOG:C40([Conslt Rating:63]; "RatingReviewLB")
	
	CLOSE WINDOW:C154
End if 

