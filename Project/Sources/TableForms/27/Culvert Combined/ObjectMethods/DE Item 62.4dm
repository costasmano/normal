//Check to see if value is not in agreement with 62 cur and 61 UW
If ((Self:C308->#[Inspections:27]Item 62 UW:165) & (Self:C308->#[Inspections:27]Item 62 Cur:172))
	C_TEXT:C284($msg)  // Command Replaced was o_C_STRING length was 255
	$msg:="Entered value of Item 62  <"+Self:C308->+"> does not match either of values in Item 62 This Report <"
	$msg:=$msg+[Inspections:27]Item 62 Cur:172+"> nor in Item 62 from UW inspection <"+[Inspections:27]Item 62 UW:165+">"
	ALERT:C41($msg)
End if 
PushChange(1; Self:C308)  //DBD Added push change method
G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)