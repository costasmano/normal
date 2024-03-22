// ----------------------------------------------------
// Object Method: aIt8OwnerDes
// User name (OS): cjmiller
// Date and time: 04/19/05, 13:55:02
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM03
End if 
Case of 
	: (Form event code:C388=On Drop:K2:12)
		If (aIt8OwnerDesIncluded<1)
		Else 
			SD_MoveToExluded
			
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (aIt8OwnerDes<1)
		Else 
			SD_MoveToIncluded
			
		End if 
End case 

//End Object Method: aIt8OwnerDes