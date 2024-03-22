//Method: [Bridge MHD NBIS].SI & A Input.SinglePosting
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/18/18, 15:33:26
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10  //Add code and fields to allow for entry and reporting of single posting
	//Modified by: Chuck Miller (10/18/18 14:59:31)
End if 
//
If (False:C215)
	// Fixes for move to v14 or 15 to make sure object method only runs using approriarte for event
	//Modified by: administrator (12/17/15 13:44:23)
End if 
If (Form event code:C388=On Data Change:K2:15)
	PushChange(1; Self:C308)
	If ([Bridge MHD NBIS:1]PostingSingle:231>0)
		If ([Bridge MHD NBIS:1]Posting2Axle:9>0)
			[Bridge MHD NBIS:1]Posting2Axle:9:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Posting2Axle:9)
		End if 
		If ([Bridge MHD NBIS:1]Posting3Axle:10>0)
			[Bridge MHD NBIS:1]Posting3Axle:10:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Posting3Axle:10)
		End if 
		If ([Bridge MHD NBIS:1]Posting5Axle:11>0)
			[Bridge MHD NBIS:1]Posting5Axle:11:=0
			PushChange(1; ->[Bridge MHD NBIS:1]Posting5Axle:11)
		End if 
		
	End if 
End if 
//End [Bridge MHD NBIS].SI & A Input.SinglePosting