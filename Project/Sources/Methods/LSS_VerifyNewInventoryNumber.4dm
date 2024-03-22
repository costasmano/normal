//%attributes = {"invisible":true}
//Method: LSS_VerifyNewInventoryNumber
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 03/06/18, 12:32:01
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03_bug
End if 
//


C_LONGINT:C283($MaxNumber_L; $Count_L; $Distr_L; $0)
C_POINTER:C301($1)

C_TEXT:C284($Type_txt; $Route_txt; $ID_txt)
//this will only happen if we were allowed to edit SIN part 2 which makes sure that type and route are filled
$Type_txt:=[LSS_Inventory:165]LSS_InventoryType_s:28
$Route_txt:=Substring:C12([LSS_Inventory:165]LSS_Route_s:9; 1; 5)+"%"  //SQL wildcard
$MaxNumber_L:=[LSS_Inventory:165]LSS_District_L:3*100000+LSS_SIN_2_L
$ID_txt:=[LSS_Inventory:165]LSS_InventoryId_s:1
$Distr_L:=[LSS_Inventory:165]LSS_District_L:3
Begin SQL
	select count(*)
	from
	[LSS_Inventory]
	where
	[LSS_Inventory].[LSS_Route_s] LIKE :$Route_txt
	and
	[LSS_Inventory].[LSS_InventoryType_s] = :$Type_txt
	and 
	[LSS_Inventory].[LSS_District_L] = :$Distr_L
	and
	[LSS_Inventory].[LSS_IdentificationNumber_L] = :$MaxNumber_L
	and
	[LSS_Inventory].[LSS_InventoryId_s] <> :$ID_txt
	into :$Count_L;
End SQL
$1->:=$MaxNumber_L
$0:=$Count_L


//End LSS_VerifyNewInventoryNumber