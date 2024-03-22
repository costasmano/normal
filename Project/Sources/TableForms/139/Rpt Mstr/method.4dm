// ----------------------------------------------------
// User name (OS): costasmanousakis
// User name (4D): Designer
// Date and time: 10/18/11, 12:15:23
// ----------------------------------------------------
// Method: Form Method: Rpt Mstr
// Description
// 
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(5/10/16 16:44:12)
	Mods_2016_05_bug
	//  `added item 104
	// Modified by: Costas Manousakis-(Designer)-(6/14/19 10:35:11)
	Mods_2019_06_bug
	//  `Adjusted size and vert location of column labels, TownNmae and row data
End if 


Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		If (<>WindowsPL_b)
			OBJECT SET FONT SIZE:C165(*; "Text@"; 6)
		End if 
		
End case 