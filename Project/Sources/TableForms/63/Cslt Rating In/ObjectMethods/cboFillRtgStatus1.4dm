If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/03/07, 08:55:05
	// ----------------------------------------------------
	// Method: Object Method: cboFillRtgStatus
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(2/14/2007 10:35:29)
	Mods_2007_CM06
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		Self:C308->:=0
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Index_L)
		$Index_L:=Self:C308->
		If (Self:C308->>1)
			[Conslt Rating:63]CRtgStatus:39:=Self:C308->{$Index_L}
			GOTO OBJECT:C206([Conslt Rating:63]CRtgStatus:39)
			POST KEY:C465(Right arrow key:K12:17; 0; Current process:C322)
		End if 
		
End case 