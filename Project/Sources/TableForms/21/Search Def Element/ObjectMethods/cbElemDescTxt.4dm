If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/24/10 14:17:29)
	Mods_2010_11
	//  `Mods for search by element description
	
End if 

Case of 
	: (cbElemDescTxt=0)
		OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; False:C215)
		cboDescComparison:=0
		OBJECT SET ENABLED:C1123(cboDescComparison; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
	: (cbElemDescTxt=1)
		OBJECT SET ENTERABLE:C238(SRC_ELEMDESC_txt; True:C214)
		GOTO OBJECT:C206(SRC_ELEMDESC_txt)
		OBJECT SET ENABLED:C1123(cboDescComparison; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
End case 