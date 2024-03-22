If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/30/11 08:36:37)
	Mods_2011_08
	//  `convert milepoint to kilopoint for item11
	
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	
	[Bridge MHD NBIS:1]Item11:67:=Round:C94([RAILBridgeInfo:37]MilePt:2*1.609344; 5)
	PushChange(2; Self:C308)
	PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
End if 