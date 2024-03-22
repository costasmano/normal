LSS_CustomSearch
If (OK=1)
	USE NAMED SELECTION:C332("InspReviewSet")
	CREATE SET:C116([LSS_Inspection:164]; "StartSetOne")
	ARRAY TEXT:C222($inv_ids_atxt; 0)
	SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_InventoryId_s:1; $inv_ids_atxt)
	SET QUERY DESTINATION:C396(Into set:K19:2; "FoundSetOne")
	QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InventoryId_s:2; $inv_ids_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	INTERSECTION:C121("StartSetOne"; "FoundSetOne"; "FoundSetOne")
	
	If (Records in set:C195("FoundSetOne")>0)
		USE SET:C118("FoundSetOne")
		
		Header1:=0
		Header2:=0
		Header3:=0
		Header4:=0
		Header5:=0
		Header6:=0
		Header7:=0
		If (False:C215)
			// Modified by: Costas Manousakis-(Designer)-(11/29/18 14:47:28)
			Mods_2018_11
			//  `hide the review and print buttons
		End if 
		
		//hide the review and print buttons
		OBJECT SET VISIBLE:C603(*; "LSS_Approved_L"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LSS_Print_L"; False:C215)
		
		LSS_SortInspReview
		WIN_SetWindowTitle(Current form table:C627)
		
	Else 
		ALERT:C41("No Inspections were found!")
	End if 
	CLEAR SET:C117("FoundSetOne")
	CLEAR SET:C117("StartSetOne")
End if 
