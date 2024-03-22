//Method: Object Method: [NBIS Secondary].2nd In.ZZ9
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/28/14, 16:31:22
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//

If (Modified record:C314([NBIS Secondary:3]))
	CONFIRM:C162("Changes have been made to this Secondary Record. Exit without saving?"; "Exit"; "Stay In Form")
	
	If (OK=1)
		CANCEL:C270
	End if 
Else 
	CANCEL:C270
End if 

//End Object Method: [NBIS Secondary].2nd In.ZZ9