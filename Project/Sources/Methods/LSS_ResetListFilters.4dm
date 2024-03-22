//%attributes = {"invisible":true}
//Method: LSS_ResetListFilters
//Description
// reset the filter dropdowns in the inventory output form
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 06/20/23, 14:54:16
	// ----------------------------------------------------
	//Created : 
	Mods_2023_LSSNew
End if 
//
LSS_Districts_as:=0
LSS_Categories_as:=0
LSS_StructType_atxt:=0
LSS_Categories_as{0}:=""
LSS_Districts_as{0}:=""
LSS_StructType_atxt{0}:=""
C_POINTER:C301($status_ptr; $prjno_ptr)
$status_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_Status")
$status_ptr->:=0
$status_ptr->{0}:=""
$prjno_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "LSS_ProjNumdropdwn")
$prjno_ptr->{0}:=-10
$prjno_ptr->:=0

//End LSS_ResetListFilters