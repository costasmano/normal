If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/05, 09:45:43
	// ----------------------------------------------------
	// Method: Object Method: Arr_AllCategories_txt
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

Case of 
	: (Form event code:C388=On Drop:K2:12)
		If (Arr_CurrCategories_txt<1)
		Else 
			WKHR_MoveToAvailable
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Arr_AllCategories_txt<1)
		Else 
			WKHR_MoveToExcluded
		End if 
End case 

//End Object Method: aIt8OwnerDes