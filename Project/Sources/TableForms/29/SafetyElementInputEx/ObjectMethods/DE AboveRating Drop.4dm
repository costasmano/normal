//[ElementsSafety];"Safety ElmInput"
//Popupmenu for Rating
If (False:C215)
	// Modified by: Chuck Miller-(Designer)-(8/24/17 14:54:52)
	Mods_2017_08_bug  //replace _ o _during
End if 

POPUPMENUC(->aRatCAT1_; ->aRatCode_; ->[ElementsSafety:29]Rating:2)
If (Form event code:C388=On Clicked:K2:4)
	If (Old:C35([ElementsSafety:29]Rating:2)#[ElementsSafety:29]Rating:2)
		PushChange(2; ->[ElementsSafety:29]Rating:2)
	End if 
End if 