
//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 05/09/17, 13:36:22
//----------------------------------------------------
//Method: [Standard Photos].ImportPicturesFromConversion.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_04  //
	
	
	//Modified by: Chuck Miller (5/9/17 13:36:23)
	
End if 
If (Picture size:C356(vPicture1)>0)
	CONFIRM:C162("Replace Existing picture with the one you selected"; "Yes"; "No")
	If (OK=1)
		[Standard Photos:36]Std Photo:3:=vPicture1
		PushChange(2; ->[Standard Photos:36]Std Photo:3)
		CLEAR VARIABLE:C89(vPicture1)
		vbPictureChanged:=True:C214
		CANCEL:C270
		CLEAR VARIABLE:C89(vPicture1)
		CLEAR VARIABLE:C89(vPicture2)
		
	End if 
Else 
	ALERT:C41("You must select a row")
	
End if 

//End [Standard Photos].ImportPicturesFromConversion.Button

