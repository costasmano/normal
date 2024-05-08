  //Method: LSS_EditContracts.Save
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 8, 2024, 19:18:16
	  // ----------------------------------------------------
	
End if 
  //
  //Save
CONFIRM:C162("Update the list of Ancillary Contracts with all changes?";"Update";"Do not update")
If (OK=1)
	C_TEXT:C284($param_txt)
	$param_txt:=JSON Stringify:C1217(Form:C1466.LssContracts;*)
	ut_SaveSysParam ("LSS_Contracts";$param_txt)
	LSS_ContractsToStorage 
	CANCEL:C270
Else 
	CANCEL:C270
End if 
  //End LSS_EditContracts.Save   