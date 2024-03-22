//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/09/05, 11:34:31
	// ----------------------------------------------------
	// Method: WKHR_InsertRow
	// Description
	// Add a new Item to the list of items after the selected Item,
	// or at the end of list if none selected.
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 14:50:36)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(4/2/09 11:20:46)
	Mods_2009_04
	//  `Fix for the new Version of Work hours. 
End if 
C_POINTER:C301(arrPtr_1; arrPtr_2; arrPtr_3; arrPtr_4; arrPtr_5; arrPtr_6; arrPtr_7; arrPtr_8)
arrPtr_1:=Get pointer:C304("Arr_"+CategoryPrefix+"_1")
arrPtr_2:=Get pointer:C304("Arr_"+CategoryPrefix+"_2")
arrPtr_3:=Get pointer:C304("Arr_"+CategoryPrefix+"_Values")
Case of 
	: ((Arr_ItemNos#0) & (Num:C11(Arr_ItemNos{Arr_ItemNos})<WKHR_MaxDefItemNo))
		ALERT:C41("Can Insert only after Default Item List")
	Else 
		
		C_LONGINT:C283($StoredElmPos_L; $LastRow; $LastID; $NewRow)
		If ((Arr_ItemNos>0) & (Arr_ItemNos<Size of array:C274(Arr_ItemNos)))
			$StoredElmPos_L:=Find in array:C230(arrPtr_1->; Arr_ItemNos{Arr_ItemNos})
			$LastRow:=$StoredElmPos_L+1
		Else 
			$LastRow:=Size of array:C274(arrPtr_1->)
			$LastRow:=$LastRow+1
		End if 
		INSERT IN ARRAY:C227(arrPtr_1->; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_2->; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_3->{1}; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_3->{2}; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_3->{3}; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_3->{4}; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_3->{5}; $LastRow)
		INSERT IN ARRAY:C227(arrPtr_3->{6}; $LastRow)
		If ([Work_Estimate:103]Version_L:47>0)
			INSERT IN ARRAY:C227(arrPtr_3->{7}; $LastRow)
		End if 
		
		WKHR_RenumberItemList
		
		WKHR_LoadItemHRs
		$NewRow:=Find in array:C230(Arr_ItemNos; arrPtr_1->{$LastRow})
		WKHR_SetListRow($NewRow)
		//force validate event to kick in
		[Work_Estimate:103]Consultant:6:=[Work_Estimate:103]Consultant:6
		
End case 