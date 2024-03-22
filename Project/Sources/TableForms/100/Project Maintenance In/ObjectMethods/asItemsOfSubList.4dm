Case of 
	: (Form event code:C388=On Load:K2:1)
		//fill in the items of sublist into asItemsOfSubList array
		CM_GetItemsOfSubList
		
		asItemsOfSubList:=Find in array:C230(asItemsOfsubList; [Contract_Project_Maintenance:100]Project Type:3)
		If (asItemsOfSubList=-1)
			asItemsOfSubList:=0
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		[Contract_Project_Maintenance:100]Project Type:3:=asItemsOfSubList{asItemsOfSubList}
		
End case 

