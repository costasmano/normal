If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/18/09 09:57:22)
	Mods_2009_09
	//  `Additions to include search for word or phrase in Element comments
End if 

Case of 
	: (cbElementTxt=0)
		OBJECT SET ENTERABLE:C238(SRC_ELEMTEXT_txt; False:C215)
		OBJECT SET ENABLED:C1123(cbWholeWord; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		
	: (cbElementTxt=1)
		OBJECT SET ENTERABLE:C238(SRC_ELEMTEXT_txt; True:C214)
		OBJECT SET ENABLED:C1123(cbWholeWord; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		GOTO OBJECT:C206(SRC_ELEMTEXT_txt)
		cbIncludeComments:=1
		vIncludeComments:=True:C214
		cbPrintNow:=1
		vPrintNow:=True:C214
		
End case 