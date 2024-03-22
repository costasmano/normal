//Method: Object Method: [Contract_Assignment_Maintenance].PreservationInput.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/04/12, 22:52:04
	// ----------------------------------------------------
	//Created : 
	Mods_2012_06
End if 
//

If (Read only state:C362(Current form table:C627->))
	ALERT:C41("Current record is in READ ONLY mode! You must unlock it first!")
Else 
	C_LONGINT:C283($passwordErr_L)
	C_TEXT:C284($DelMsg_txt)
	$DelMsg_txt:="! ! ! WARNING : To Delete this Assignemnt, your password is required ! ! !"+<>sCR+"Enter your password to Delete the entire Assignment or Cancel to abort the deleti"+"on!!"
	$passwordErr_L:=OP_GetPassword($DelMsg_txt)
	
	If ($passwordErr_L=0)
		DELETE RECORD:C58([Contract_Assignment_Maintenance:101])
		CANCEL:C270
	End if 
	
End if 

//End Object Method: [Contract_Assignment_Maintenance].PreservationInput.bDelete