//[ElementsSafety];"Safety ElmInput"
//Popupmenu for Priority
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aUORCAT_; ->aUORCode_; ->[ElementsSafety:29]Priority:20)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([ElementsSafety:29]Priority:20)#[ElementsSafety:29]Priority:20)
		PushChange(2; ->[ElementsSafety:29]Priority:20)
	End if 
End if 