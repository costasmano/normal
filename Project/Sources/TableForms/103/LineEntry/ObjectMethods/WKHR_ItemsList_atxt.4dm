If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/01/09, 18:00:24
	// ----------------------------------------------------
	//Object Method: WKHR_ItemsList_atxt 
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_CM_5404  //("WKHRSMODS")
	Mods_2011_06  // CJ Miller`06/20/11, 11:38:42      ` Type all local variables for v11
End if 
Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($Itemindx; $picked_L; $itemIndex)
		$picked_L:=WKHR_ItemsList_atxt
		If ($picked_L>0)
			If (WKHR_ItemsList_atxt{$picked_L}#(Line_ItemNo+"@"))
				//1st save any changes
				$itemIndex:=Find in array:C230(arrPtr_1->; Line_ItemNo)
				WKHR_LoadLineItem($itemIndex; "SAVE")
				If (WKHR_DataEntered_B)
					[Work_Estimate:103]Consultant:6:=[Work_Estimate:103]Consultant:6
				End if 
				WKHR_DataEntered_B:=False:C215
				$itemIndex:=Find in array:C230(arrPtr_1->; Substring:C12(WKHR_ItemsList_atxt{$picked_L}; 1; 3))
				WKHR_InitLineItemVars
				WKHR_LoadLineItem($itemIndex; "LOAD")
				WKHR_LineEntry_FM(On Load:K2:1)
			End if 
		End if 
End case 
