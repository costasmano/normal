//%attributes = {"invisible":true}
//Method: LSS_SortFunction
//Description
// function that can be used in order by formula to sort ancillary structures in order of 
//  ` class
//  ` route
//  ` district
//  ` direction
//  ` ascending milepoint when going E or N, descending milepoint when going W or S
// Parameters
// $0 : $sortString_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/11/15, 12:06:56
	// ----------------------------------------------------
	//Created : 
	Mods_2015_05
	
	C_TEXT:C284(LSS_SortFunction; $0)
	
End if 
//
C_TEXT:C284($0; $sortString_txt)

C_TEXT:C284($dir_txt)
$sortString_txt:=[LSS_Inventory:165]LSS_InventoryType_s:28
$sortString_txt:=$sortString_txt+Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 5)
$sortString_txt:=$sortString_txt+String:C10([LSS_Inventory:165]LSS_District_L:3)
//combine the direction with the milepost - use the ascii value of the direction
$dir_txt:=Uppercase:C13(Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 6; 1))
C_LONGINT:C283($Dir_milepost_L)
$Dir_milepost_L:=Character code:C91($dir_txt)*100000

If (Position:C15($dir_txt; "-E-N-")>0)
	//if East or North add the milepost * 100
	$Dir_milepost_L:=$Dir_milepost_L+([LSS_Inventory:165]LSS_MilePoint_r:8*100)
Else 
	$Dir_milepost_L:=$Dir_milepost_L-([LSS_Inventory:165]LSS_MilePoint_r:8*100)
End if 
$sortString_txt:=$sortString_txt+String:C10($Dir_milepost_L; "0000000")

$0:=$sortString_txt
//End LSS_SortFunction