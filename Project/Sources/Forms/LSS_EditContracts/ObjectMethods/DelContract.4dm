  //Method: LSS_EditContracts.Button3
  //Description
  //
  // Parameters
  // ----------------------------------------------------
If (False:C215)
	  // ----------------------------------------------------
	  //User name (OS): Costas Manousakis
	  //User (4D) : Designer
	  //Created : 
	  //Date and time: Feb 8, 2024, 16:38:05
	
	  // ----------------------------------------------------
	
End if 
  //
If (Form:C1466.CurrContractIndx>0)
	CONFIRM:C162("Delete contract "+String:C10(Form:C1466.LssContracts[Form:C1466.CurrContractIndx-1].ContractNo)+" - "+\
		Form:C1466.LssContracts[Form:C1466.CurrContractIndx-1].ConsultantName+" ?";"Delete";"Cancel")
	
	If (OK=1)
		Form:C1466.LssContracts.remove(Form:C1466.CurrContractIndx-1;1)
		  //update the related listboxes
		If (Form:C1466.CurrContractIndx>Form:C1466.LssContracts.length)
			Form:C1466.CurrContract:=Null:C1517
			Form:C1466.SelectedContracts:=Null:C1517
		Else 
			Form:C1466.CurrContract:=Form:C1466.LssContracts[Form:C1466.CurrContractIndx-1]
			Form:C1466.SelectedContracts:=New collection:C1472(Form:C1466.LssContracts[Form:C1466.CurrContractIndx-1])
		End if 
		  //REDRAW(OBJECT Get pointer(Object named;"LSSContracts")->)
	End if 
	
End if 
  //End LSS_EditContracts.Button3   