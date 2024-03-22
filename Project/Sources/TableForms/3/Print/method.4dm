//Method: Form Method: [NBIS Secondary]Print
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/27/14, 16:19:47
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
If (Form event code:C388=On Printing Detail:K2:18)
	C_TEXT:C284(sItem104)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem103)  // Command Replaced was o_C_STRING length was 1
	C_TEXT:C284(sItem110)  // Command Replaced was o_C_STRING length was 1
	
	G_SIA_BuildTownLine
	vDate:=Current date:C33(*)
	sItem104:=f_Boolean2String([NBIS Secondary:3]Item104:32; "YN")
	sItem103:=f_Boolean2String([NBIS Secondary:3]Item103:31; "YN")
	sItem110:=f_Boolean2String([NBIS Secondary:3]Item110:33; "YN")
	
End if 
//End Form Method: [NBIS Secondary]Print