
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/13, 12:08:33
//----------------------------------------------------
//Method: Form Method: [Bridge MHD NBIS];"NBIS Stack Info MBTA"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_02  //r001 `Created so that we can have two nbis stack info forms
	//NBIS Stack Info
	//NBIS Stack Info MBTA 
	//Modified by: Charles Miller (2/14/13 12:08:34)
	// Modified by: Costas Manousakis-(Designer)-(3/29/13 13:40:27)
	Mods_2013_03
	//Added Line Name on the list from field   [Bridge MHD NBIS]RRBranch
	//Field [Bridge MHD NBIS]RRBranch was increased to A80
	// Modified by: Costas Manousakis-(Designer)-(5/23/18 16:44:26)
	Mods_2018_05
	//  `removed the query by formula button for designer - can now use alt-click + button to add a formula. also the trash button
	
End if 
If (Form event code:C388=On Load:K2:1)
	C_TEXT:C284(mbta_BridgeType_txt)
End if 
NBISStackInfo_FM
//End Form Method: [Bridge MHD NBIS]NBIS Stack Info MBTA