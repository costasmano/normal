If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If ((Self:C308->#[Inspections:27]Item 60 UW:66) & (Self:C308->#[Inspections:27]Item 60 Cur:155))
		C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
		$msg:="Entered value of Item 60  <"+Self:C308->+"> does not match either of values in Item 60 This Report <"
		$msg:=$msg+[Inspections:27]Item 60 Cur:155+"> nor in Item 60 from UW inspection <"+[Inspections:27]Item 60 UW:66+">"
		ALERT:C41($msg)
	End if 
End if 
//Thermometer for Item 60
G_SetThermometer(->tItem60; [Inspections:27]Item 60:81)