If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
	// Modified by: Costas Manousakis-(Designer)-(3/13/19 16:52:14)
	Mods_2019_03_bug
	//  `disable entry of and apostrophe and comma. CallReference #618
End if 
If (Form event code:C388=On Data Change:K2:15)
	If (Position:C15("'"; Self:C308->)>0) & (Position:C15(","; Self:C308->)>0)
		ALERT:C41("Cannot have an apostrophe and commas in the Item 9 field!. The comma(s) was replaced with a semicolon!")
		Self:C308->:=Replace string:C233(Self:C308->; ","; ";")
	End if 
	PushChange(1; Self:C308)
End if 