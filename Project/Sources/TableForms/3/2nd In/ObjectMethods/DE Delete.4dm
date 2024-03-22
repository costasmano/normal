//Method: Object Method: [NBIS Secondary].2nd In.ZZ5
//Description
// Delete Button
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/21/14, 17:13:36
	// ----------------------------------------------------
	//Created : 
	Mods_2014_05
End if 
//
CONFIRM:C162("Are you sure you want to delete this Secondary Record?")
If (OK=1)
	C_LONGINT:C283($passwordErr_L)
	C_TEXT:C284($Text)
	$Text:="TO DELETE THIS SECONDARY RECORD YOU MUST ENTER YOUR PASSWORD!"
	$passwordErr_L:=OP_GetPassword($Text)
	
	If ($passwordErr_L=0)
		LogDeletion(->[Bridge MHD NBIS:1]BIN:3; ->[NBIS Secondary:3]BIN:1; ->[NBIS Secondary:3]NBISSecondaryKey_l:39; 1)
		DELETE RECORD:C58([NBIS Secondary:3])
		CANCEL:C270
	End if 
	
End if 

//End Object Method: [NBIS Secondary].2nd In.ZZ5