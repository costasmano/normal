
If (False:C215)
	// Method: Form Method: SI & A (Insp)
	// Description
	// 
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/18/11, 12:42:24
	// ----------------------------------------------------
	// First Release
	Mods_2011_10
	// Modified by: Costas Manousakis-(Designer)-(3/21/12 13:49:46)
	Mods_2012_03
	//  `changed sMissingSignstext from A(30) to text
	// Modified by: Costas Manousakis-(Designer)-(6/27/17 16:56:21)
	Mods_2017_06_bug
	//  `<>aFreezeThawDesc can be a text array
	// Modified by: Costas Manousakis-(Designer)-(10/30/18 12:52:33)
	Mods_2018_10
	//  `Added single posting values - use method ARCH_Utils
	
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	
	C_TEXT:C284(sFreezeThawList)  // old C_STRING length 80
	If ((Type:C295(<>aFreezeThawDesc)=String array:K8:15) | (Type:C295(<>aFreezeThawDesc)=Text array:K8:16))
		sFreezeThawList:=Get_Description(-><>aFreezeThawDesc; -><>aFreezeThawCode; ->[BridgeMHDNBISArchive:139]FreezeThaw:222)
	End if 
	
	ARCH_Utils("TOWNLINE")
	
	ARCH_Utils("AccessibilityPrint")
	
	//added to get the Recommended Posting values from the [RatingReports] table
	
	ARCH_Utils("RATINGS")
	ARCH_Utils("Rank")
	// 
End if 