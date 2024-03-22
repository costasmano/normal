If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	If ((Self:C308->#[Inspections:27]Item 61 UW:72) & (Self:C308->#[Inspections:27]Item 61 Cur:159))
		C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
		$msg:="Entered value of Item 61  <"+Self:C308->+"> does not match either of values in Item 61 This Report <"
		$msg:=$msg+[Inspections:27]Item 61 Cur:159+"> nor in Item 61 from UW inspection <"+[Inspections:27]Item 61 UW:72+">"
		ALERT:C41($msg)
	End if 
	PushChange(1; Self:C308)  //DBD Added push change method
	G_SetThermometer(->tItem61; [Inspections:27]Item 61:82)
End if 