If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/30/11 08:36:37)
	Mods_2011_08
	//  `convert milepoint to kilopoint for item11
End if 

[Bridge MHD NBIS:1]Item11:67:=Round:C94([RAILBridgeInfo:37]MilePt:2*1.609344; 5)
PushChange(2; Self:C308)
PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)