//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 111
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aItem111d_; ->aItem111_; ->[Bridge MHD NBIS:1]Item111:114)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([Bridge MHD NBIS:1]Item111:114)#[Bridge MHD NBIS:1]Item111:114)
		PushChange(1; ->[Bridge MHD NBIS:1]Item111:114)
	End if 
End if 