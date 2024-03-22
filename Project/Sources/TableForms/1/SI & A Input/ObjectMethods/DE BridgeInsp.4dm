If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
	// Modified by: Costas Manousakis-(Designer)-(4/11/18 16:45:11)
	Mods_2018_04
	//  `added check to prevent entering too old dates.
End if 
If (Form event code:C388=On Data Change:K2:15)
	SIA_ApplyMinInspDate
	CalcItem91
	PushChange(1; Self:C308)
End if 
