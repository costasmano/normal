If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/24/10, 15:02:01
	// ----------------------------------------------------
	// Method: Object Method: CRTGShowLBBTN
	// Description
	// 
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(6/20/11 15:26:54)
	Mods_2011_06
	//  `Removed declataion of a parameter $1 ; object methods do't accept parameters
End if 
C_LONGINT:C283($FormEvent_L)
$FormEvent_L:=Form event code:C388

Case of 
	: ($FormEvent_L=On Load:K2:1)
		If (Current user:C182="Designer")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		End if 
		
	: ($FormEvent_L=On Data Change:K2:15)
		
	: ($FormEvent_L=On Clicked:K2:4)
		CRTG_ShowListbox
	: ($FormEvent_L=On Double Clicked:K2:5)
		
End case 
