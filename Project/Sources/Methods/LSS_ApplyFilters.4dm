//%attributes = {"invisible":true}
//Method: LSS_ApplyFilters
//Description
// apply filters from the dropdowns in the LSS inventory output form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 06/21/23, 11:12:37
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
End if 
//
C_POINTER:C301($prjnum_ptr; $distr_ptr; $cat_ptr; $strType_ptr; $status_ptr)
C_LONGINT:C283($projnum_L; $cat_L; $structType_L; $Dist_L; $status_L)
$prjnum_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_ProjNumdropdwn")
$distr_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_Districts_as")
$cat_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_Categories_as")
$strType_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_StructType_atxt")
$status_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_Status")

$projnum_L:=$prjnum_ptr->
$Dist_L:=$distr_ptr->
$cat_L:=$cat_ptr->
$structType_L:=$strType_ptr->
$status_L:=$status_ptr->

Case of 
	: ($projnum_L>2)  // an actual proj number
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_ProjNoBuilt_L:37=$prjnum_ptr->{$projnum_L}; *)
		QUERY:C277([LSS_Inventory:165];  | ; [LSS_Inventory:165]LSS_ProjNoRemoved_L:38=$prjnum_ptr->{$projnum_L}; *)
	: ($projnum_L=2)  // any valid project number
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_ProjNoBuilt_L:37>0; *)
		QUERY:C277([LSS_Inventory:165];  | ; [LSS_Inventory:165]LSS_ProjNoRemoved_L:38>0; *)
	Else 
		//anything
		QUERY:C277([LSS_Inventory:165]; [LSS_Inventory:165]LSS_ProjNoBuilt_L:37>=0; *)
End case 

If ($Dist_L>1)
	QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_District_L:3=Num:C11($distr_ptr->{$Dist_L}); *)
End if 
If ($cat_L>1)
	QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Category_s:2=$cat_ptr->{$cat_L}; *)
	//structure type search can be in here since $cat #"all"
	If ($structType_L>1)
		QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_StructureTypeId_s:25=LSS_StructTypeID_atxt{$structType_L}; *)
	End if 
	
End if 
If ($status_L>1)
	QUERY:C277([LSS_Inventory:165];  & ; [LSS_Inventory:165]LSS_Status_s:35=$status_ptr->{$status_L}; *)
End if 

QUERY:C277([LSS_Inventory:165])

LSS_SortInventory
COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")
WIN_SetWindowTitle(->[LSS_Inventory:165])

//End LSS_ApplyFilters