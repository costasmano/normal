If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/05/07, 15:56:03
	// ----------------------------------------------------
	// Method: Object Method: aInvPhotoDate_aD
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 10:26:13)
	Mods_2007_CM06
End if 
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Index_L)
		$Index_L:=Self:C308->
		If (Self:C308->{$Index_L}>!00-00-00!)
			vPrintInvPhotos:=1
			REDRAW:C174(vPrintInvPhotos)
		End if 
		
End case 
