//[Bridge MHD NBIS];"SI & A Input"
//Popupmenu for Item 102
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aItem102Des; ->aItem102; ->[Bridge MHD NBIS:1]Item102:123)

If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([Bridge MHD NBIS:1]Item102:123)#[Bridge MHD NBIS:1]Item102:123)
		PushChange(1; ->[Bridge MHD NBIS:1]Item102:123)
	End if 
End if 