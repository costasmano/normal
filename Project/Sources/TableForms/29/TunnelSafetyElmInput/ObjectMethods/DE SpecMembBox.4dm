If (False:C215)
	//Object Method: [ElementsSafety].Safety ElmInput.SpecMemb Flag 
	// Modified by: Costas Manousakis-(Designer)-(4/15/14 17:41:54)
	Mods_2014_04
	//  `use INSP_SetElmtRtgVisibility
End if 

PushChange(2; Self:C308)
If ([ElementsSafety:29]SpecMemb Flag:8)  //25-nov-03
	FORM GOTO PAGE:C247(2)
	INSP_SetElmtRtgVisibility
Else 
	FORM GOTO PAGE:C247(1)
End if 