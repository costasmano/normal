//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 26
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aItem26Des; ->aItem26; ->[Bridge MHD NBIS:1]Item26:120)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([Bridge MHD NBIS:1]Item26:120)#[Bridge MHD NBIS:1]Item26:120)
		PushChange(1; ->[Bridge MHD NBIS:1]Item26:120)
	End if 
End if 