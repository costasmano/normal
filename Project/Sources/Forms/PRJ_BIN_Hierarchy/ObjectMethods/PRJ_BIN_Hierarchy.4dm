//Method: Hierarchy_test.PRJ_BIN_Hierarchy
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/05/19, 16:51:31
	// ----------------------------------------------------
	//Created : 
	
End if 
//
C_LONGINT:C283($Col_L; $Row_L)
LISTBOX GET CELL POSITION:C971(*; "PRJ_BIN_Hierarchy"; $Col_L; $Row_L)
If (Bin_atxt{$Row_L}="")
	OBJECT SET ENABLED:C1123(*; "Move_Button"; False:C215)
	
	OBJECT SET ENABLED:C1123(*; "Remove_Button"; False:C215)
	OBJECT SET ENABLED:C1123(*; "Switch_Button"; False:C215)
	
	OBJECT SET ENABLED:C1123(*; "RemoveBlank_Button"; True:C214)
Else 
	OBJECT SET ENABLED:C1123(*; "Move_Button"; ($Col_L=3))
	OBJECT SET ENABLED:C1123(*; "Remove_Button"; ($Col_L=3))
	
	OBJECT SET ENABLED:C1123(*; "RemoveBlank_Button"; False:C215)
	If (Position:C15("DES"; v_1_206_atxt{$Row_L})>0)
		OBJECT SET ENABLED:C1123(*; "Switch_Button"; False:C215)
		OBJECT SET TITLE:C194(*; "Switch_Button"; "Can't change from Proposed")
	Else 
		If (Type_atxt{$Row_L}="Existing")
			OBJECT SET TITLE:C194(*; "Switch_Button"; "Change To Proposed")
		Else 
			OBJECT SET TITLE:C194(*; "Switch_Button"; "Change To Existing")
		End if 
	End if 
	OBJECT SET ENABLED:C1123(*; "Switch_Button"; ($Col_L=3))
End if 

//End Hierarchy_test.PRJ_BIN_Hierarchy