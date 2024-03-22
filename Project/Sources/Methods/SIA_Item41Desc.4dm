//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/23/07, 11:28:40
	// ----------------------------------------------------
	// Method: SIA_Item41Desc
	// Description
	// Set and size Item 41 description for general use
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/11/10 08:51:54)
	Mods_2010_06
	//  `Changed use of Before
End if 
C_TEXT:C284(vItem41)  // Command Replaced was o_C_STRING length was 32

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Printing Detail:K2:18))
	vItem41:=Get_Description(-><>aPosting; -><>aPostCode; ->[Bridge MHD NBIS:1]Item41:141)
End if 