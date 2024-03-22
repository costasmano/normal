//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 100
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aItem100d_; ->aItem100_; ->[Bridge MHD NBIS:1]Item100:121)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([Bridge MHD NBIS:1]Item100:121)#[Bridge MHD NBIS:1]Item100:121)
		PushChange(1; ->[Bridge MHD NBIS:1]Item100:121)
	End if 
End if 