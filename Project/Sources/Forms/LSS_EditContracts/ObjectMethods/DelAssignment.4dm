  //Method: LSS_EditContracts.Button1
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 8, 2024, 15:54:57
	  // ----------------------------------------------------
	
End if 
  //
If (Form:C1466.currassign#Null:C1517)
	CONFIRM:C162("Delete Assignment "+String:C10(Form:C1466.CurrContract.Assignments[Form:C1466.currassignpos-1].assignnum)+" ?";\
		"Delete";"Cancel")
	
	If (OK=1)
		Form:C1466.CurrContract.Assignments.remove((Form:C1466.currassignpos-1);1)
	End if 
	
End if 

  //End LSS_EditContracts.Button1   