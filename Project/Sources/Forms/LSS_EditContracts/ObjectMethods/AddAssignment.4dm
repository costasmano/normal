  //Method: LSS_EditContracts.Button
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 8, 2024, 14:55:06
	  // ----------------------------------------------------
	
End if 
  //

If (Form:C1466.CurrContract#Null:C1517)
	  //get next assignment number
	If (Form:C1466.CurrContract.Assignments#Null:C1517)
		C_LONGINT:C283($maxassign_L)
		$maxassign_L:=Form:C1466.CurrContract.Assignments.max("assignnum")
		Form:C1466.CurrContract.Assignments.push(New object:C1471("assignnum";$maxassign_L+1;"ntpdate";String:C10(Current date:C33;Internal date short:K1:7)))
	Else 
		Form:C1466.CurrContract.Assignments:=New collection:C1472(New object:C1471("assignnum";1;"ntpdate";String:C10(Current date:C33;Internal date short:K1:7)))
	End if 
	
End if 


  //End LSS_EditContracts.Button   