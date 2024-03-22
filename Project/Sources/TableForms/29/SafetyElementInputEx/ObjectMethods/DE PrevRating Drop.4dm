//[ElementsSafety];"Safety ElmInput"
//Popupmenu for Rating_i
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aRatCAT2_; ->aRatCode_; ->[ElementsSafety:29]Rating_i:15)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([ElementsSafety:29]Rating_i:15)#[ElementsSafety:29]Rating_i:15)
		PushChange(2; ->[ElementsSafety:29]Rating_i:15)
	End if 
End if 