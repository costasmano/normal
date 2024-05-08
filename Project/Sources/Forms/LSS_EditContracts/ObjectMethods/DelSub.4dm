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
If (Form:C1466.currsub#Null:C1517)
	CONFIRM:C162("Delete Subcontractor "+Form:C1466.CurrContract.Subs[Form:C1466.currsubpos-1].name+"?";"Delete";"Cancel")
	If (OK=1)
		Form:C1466.CurrContract.Subs.remove((Form:C1466.currsubpos-1);1)
	End if 
End if 

  //End LSS_EditContracts.Button1   