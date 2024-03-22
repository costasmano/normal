//%attributes = {"invisible":true}
//Method: LSS_SortStructureType
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 04/09/15, 14:07:32
	//--------------------
	
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/9/15 14:08:18)
	Mods_2015_08_bug  //Change the way display of structure type occurs
	//Modified by: administrator (9/1/15 14:40:24)
	// Modified by: Costas Manousakis-(Designer)-(10/4/18 17:04:50)
	//  `added sorting by Owner
	Mods_2020_10  //Fix sort direction issue where pointer was not set correctly
	//Modified by: CJ (10/6/20 13:35:45)
	
	// Modified by: manousakisc (4/28/2023)
	Mods_2023_LSSNew
	//added sort by status , year built and proj #built
End if 
C_TEXT:C284($NameofObj_txt)
C_LONGINT:C283($dumTbl_L; $dumFld_L; $0)
RESOLVE POINTER:C394(Self:C308; $NameofObj_txt; $dumTbl_L; $dumFld_L)
C_POINTER:C301($SortVariable_ptr)
$SortVariable_ptr:=Get pointer:C304($NameofObj_txt)
$0:=0
Case of 
	: ($nameofObj_txt="Header1")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureNumber_s:6; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header2")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Town_s:4; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Town_s:4; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header3")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Category_s:2; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Category_s:2; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header4")
		
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			ORDER BY FORMULA:C300([LSS_Inventory:165]; LSS_ReturnStructureType(->[LSS_Inventory:165]LSS_StructureTypeId_s:25; ->LSS_STID_atxt; ->LSS_STDescription_atxt); >)
			$SortVariable_ptr->:=1
			
		Else 
			ORDER BY FORMULA:C300([LSS_Inventory:165]; LSS_ReturnStructureType(->[LSS_Inventory:165]LSS_StructureTypeId_s:25; ->LSS_STID_atxt; ->LSS_STDescription_atxt); <)
			$SortVariable_ptr->:=2
			
			
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header5")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_District_L:3; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_District_L:3; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header6")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureLocation_txt:10; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_StructureLocation_txt:10; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header7")
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Owner_s:34; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Owner_s:34; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header8")  //status
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Status_s:35; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_Status_s:35; <)
		End if 
		$0:=-1
		
	: ($nameofObj_txt="Header9")  //year built
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY FORMULA:C300([LSS_Inventory:165]; Num:C11([LSS_Inventory:165]LSS_YearBuilt_s:11); >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY FORMULA:C300([LSS_Inventory:165]; Num:C11([LSS_Inventory:165]LSS_YearBuilt_s:11); <)
		End if 
		$0:=-1
		
		
	: ($nameofObj_txt="Header10")  //project no built
		If ($SortVariable_ptr->=0) | ($SortVariable_ptr->=2)
			$SortVariable_ptr->:=1
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_ProjNoBuilt_L:37; >)
		Else 
			$SortVariable_ptr->:=2
			ORDER BY:C49([LSS_Inventory:165]; [LSS_Inventory:165]LSS_ProjNoBuilt_L:37; <)
		End if 
		$0:=-1
End case 
COPY NAMED SELECTION:C331([LSS_Inventory:165]; "InventorySet")

//End LSS_SortStructureType