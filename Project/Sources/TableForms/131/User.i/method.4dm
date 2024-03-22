If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/02/09, 09:27:55
	// ----------------------------------------------------
	// Method: Form Method: UserList.o
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_08
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		QUERY:C277([PRJ_Attributes:130]; [PRJ_Attributes:130]ATTR_ID_l:1=[PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 
