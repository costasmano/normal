//Method: Form Method: [TIN_Inspections];"CmtsPrint"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/01/16, 14:15:47
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
End if 
//
Case of 
	: (Form event code:C388=On Header:K2:17)
		vPageNo:=vPageNo+1
		
	: (Form event code:C388=On Printing Detail:K2:18)
		vPageNo:=vPageNo+1
End case 
//End Form Method: [TIN_Inspections]CmtsPrint