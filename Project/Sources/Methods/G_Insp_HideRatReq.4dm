//%attributes = {"invisible":true}
If (False:C215)
	//  G_Insp_HideRatReq 
	//Method to hide Rating Request info in inspection
	//printed forms, depending on who and when prints it.
	
	Mods_2004_CM11
	Mods_2005_CM12
End if 

If ((User in group:C338(Current user:C182; "ExternalInspectors") & ([Inspections:27]InspApproved:167#BMS Approved)) & False:C215)
	//SET VISIBLE(vRerating;False)
	//SET VISIBLE([Inspections]RatingTxt;False)
	//SET VISIBLE(xS1;False)
	//SET VISIBLE(xS2;False)
	//SET VISIBLE(xS3;False)
Else 
	OBJECT SET VISIBLE:C603(vRerating; True:C214)
	OBJECT SET VISIBLE:C603([Inspections:27]RatingTxt:76; True:C214)
	OBJECT SET VISIBLE:C603(xS1; True:C214)
	OBJECT SET VISIBLE:C603(xS2; True:C214)
	OBJECT SET VISIBLE:C603(xS3; True:C214)
End if 