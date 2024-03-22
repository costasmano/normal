//[Bridge MHD NBIS];"Other Info".DE Variable15
//Popupmenu for Historical Significance
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
	
	// Modified by: Costas Manousakis-(Designer)-(6/28/18 17:55:02)
	Mods_2018_06_bug
	//  `change in code - fixes problem that left it editable
	// Modified by: Costas Manousakis-(Designer)-(9/11/18 14:46:14)
	Mods_2018_09_bug
	//  `moved code that locks or unlocks to form method
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		POPUPMENUC(->aItem37des_; ->aItem37_; ->[Bridge MHD NBIS:1]Item37:129)
		
	: (Form event code:C388=On Clicked:K2:4)
		POPUPMENUC(->aItem37des_; ->aItem37_; ->[Bridge MHD NBIS:1]Item37:129)
		
End case 