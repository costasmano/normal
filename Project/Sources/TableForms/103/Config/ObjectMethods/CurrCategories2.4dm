If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/05, 09:45:06
	// ----------------------------------------------------
	// Method: Object Method: Arr_CurrCategories_txt
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Drop:K2:12)
		C_LONGINT:C283($selectListItm_L)
		$selectListItm_L:=Selected list items:C379(AllCategories_HL)
		If ($selectListItm_L<1)
		Else 
			WKHR_MoveToExcluded_HL
			
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		WKHR_MoveToAvailable_HL
End case 

//End Object Method: aIt8OwnerDesIncluded