//%attributes = {"invisible":true}
//Method: SIA_Stairs_GetLBArrays
//Description
// Return pointers to arrays for the Stairs listbox
// Parameters
// $0 : $InfoObject_o
//  "owners" : ptr to array of owners
//  "descriptions" : ptr to array of descriptions
//  "ids" : ptr to array of IDs
//  "enterable" : ptr to enterbale chkbox
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-15
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
	C_OBJECT:C1216(SIA_Stairs_GetLBArrays; $0)
End if 
//

C_OBJECT:C1216($0)

C_POINTER:C301($codes_ptr; $descriptions_ptr; $stairIds_ptr; $enterableflag_ptr)

ARRAY TEXT:C222($ColNames_atxt; 0)
ARRAY TEXT:C222($headernames_atxt; 0)
ARRAY POINTER:C280($ColVars_aptr; 0)
ARRAY POINTER:C280($headerVars_aptr; 0)
ARRAY BOOLEAN:C223($visible_ab; 0)
ARRAY POINTER:C280($styles_aptr; 0)
LISTBOX GET ARRAYS:C832(*; "Stairs_LB"; $ColNames_atxt; $headernames_atxt; $ColVars_aptr; $headerVars_aptr; $visible_ab; $styles_aptr)
$codes_ptr:=$ColVars_aptr{Find in array:C230($ColNames_atxt; "OwnerCodes")}
$descriptions_ptr:=$ColVars_aptr{Find in array:C230($ColNames_atxt; "Descriptions")}
$stairIds_ptr:=$ColVars_aptr{Find in array:C230($ColNames_atxt; "StairIDs")}
$enterableflag_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "StairsEnterable")

OB SET:C1220($0; "owners"; $codes_ptr; \
"descriptions"; $descriptions_ptr; \
"ids"; $stairIds_ptr; \
"enterable"; $enterableflag_ptr)

//End SIA_Stairs_GetLBArrays