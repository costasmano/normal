//Check to see if value is not in agreement with 62 cur and 61 UW
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/22/15 10:30:29)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)  //DBD Added push change method
	G_SetThermometer(->tItem62; [Inspections:27]Item 62:113)
End if 