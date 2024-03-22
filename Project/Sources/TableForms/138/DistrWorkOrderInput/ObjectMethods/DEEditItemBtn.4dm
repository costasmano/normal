If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/29/10 16:19:06)
	Mods_2010_12
	//Bug Fix when no row was selected
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_LONGINT:C283($rowSelect_L; $Col_L)
C_POINTER:C301($ColVar_ptr)
$rowSelect_L:=-1
If (DCM_P_ITMLB_ItemQEnt_ar>0)
	$rowSelect_L:=DCM_P_ITMLB_ItemQEnt_ar
Else 
	If (Size of array:C274(DCM_PRJ_LineItems_lb)>0)
		$rowSelect_L:=1
	End if 
	
End if 

If ($rowSelect_L>0)
	LISTBOX GET CELL POSITION:C971(DCM_PRJ_LineItems_lb; $Col_L; $rowSelect_L; $ColVar_ptr)
	If ($Col_L>0)
		EDIT ITEM:C870($ColVar_ptr->; $rowSelect_L)
	Else 
		EDIT ITEM:C870(DCM_P_ITMLB_ItemQEnt_ar; 1)
	End if 
	
End if 