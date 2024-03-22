//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/05, 11:33:15
	// ----------------------------------------------------
	// Method: WKHR_DeleteRow
	// Description
	// Delete the selected row in the list of items.
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 14:50:36)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(4/2/09 11:19:13)
	Mods_2009_04
	//  `Fix for the new Version of Work hours.
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
If (Arr_ItemNos>0)
	If (Num:C11(Arr_ItemNos{Arr_ItemNos})<=WKHR_MaxDefItemNo)
		ALERT:C41("Cannot delete Default Items")
	Else 
		C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4; arrPtr_5; arrPtr_6; arrPtr_7; arrPtr_8)
		arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
		arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
		arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
		C_LONGINT:C283($delRow)
		$delRow:=Find in array:C230(arrPtr_1->; Arr_ItemNos{Arr_ItemNos})
		CONFIRM:C162("Delete item "+arrPtr_1->{$delRow}+" - "+arrPtr_2->{$delRow}+" ?")
		If (OK=1)
			DELETE FROM ARRAY:C228(arrPtr_1->; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_2->; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_3->{1}; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_3->{2}; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_3->{3}; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_3->{4}; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_3->{5}; $delRow)
			DELETE FROM ARRAY:C228(arrPtr_3->{6}; $delRow)
			If ([Work_Estimate:103]Version_L:47>0)
				DELETE FROM ARRAY:C228(arrPtr_3->{7}; $delRow)
			End if 
			
			WKHR_RenumberItemList
			WKHR_RecalcPage2
			WKHR_LoadItemHRs
			WKHR_SetListRow(0)
			//force validate event to kick in
			[Work_Estimate:103]Consultant:6:=[Work_Estimate:103]Consultant:6
			
		End if 
		
	End if 
	
End if 