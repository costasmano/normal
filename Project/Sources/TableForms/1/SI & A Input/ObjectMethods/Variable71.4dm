//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 33
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aItem33des_; ->aItem33_; ->[Bridge MHD NBIS:1]Item33:99)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([Bridge MHD NBIS:1]Item33:99)#[Bridge MHD NBIS:1]Item33:99)
		PushChange(1; ->[Bridge MHD NBIS:1]Item33:99)
	End if 
End if 
