If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/13/06, 10:53:39
	// ----------------------------------------------------
	// Method: Object Method: Template_Qrt_TableNo_L
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2011_06  // CJ Miller`06/20/11, 11:30:05      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($Current_tblNo)
		$Current_tblNo:=QR Get report table:C758(QRT_Template)
		If ($Current_tblNo#Template_Qrt_TableNo_L)
			QR SET REPORT TABLE:C757(QRT_Template; Template_Qrt_TableNo_L)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 
