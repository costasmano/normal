//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 15:57:01
	// ----------------------------------------------------
	// Method: CRTG_ReviewLB_OM
	// Description
	//  `Object method for the listbox shown by the CRTG_ShowListbox method
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
	Mods_2017_07_bug  //Add InDoubleClick_B so that user can nor double click into a list box. This is a workaround to a 4D bug
	//Modified by: Chuck Miller (7/14/17 11:50:35)
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		InDoubleClick_B:=False:C215
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		//ALERT("DoubleCkicked!")
		If (Not:C34(InDoubleClick_B))
			InDoubleClick_B:=True:C214
			CRTG_ReviewLBControl("OPENRTG")
			InDoubleClick_B:=False:C215
		End if 
End case 