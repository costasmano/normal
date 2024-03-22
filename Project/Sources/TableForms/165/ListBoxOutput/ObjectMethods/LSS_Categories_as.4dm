//Method: Object Method: [LSS_Inventory].ListBoxOutput.LSS_Categories_as
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/16/14, 13:49:21
	// ----------------------------------------------------
	
	// Modified by: manousakisc (5/9/2023)
	Mods_2023_LSSNew
	// re-worked logic, replace SQL call, account for Status
End if 
//
C_LONGINT:C283($cat_L; $structType_L)
$cat_L:=LSS_Categories_as
$structType_L:=LSS_StructType_atxt

If ($cat_L>0)
	If (LSS_Categories_as{$cat_L}#LSS_Categories_as{0})
		LSS_Categories_as{0}:=LSS_Categories_as{$cat_L}  // store the click
		
		LSS_ApplyFilters
		
		//now update the structure type dropdown
		If (LSS_Categories_as{$cat_L}#"ALL")
			ARRAY TEXT:C222(LSS_StructType_atxt; 0)
			ARRAY TEXT:C222(LSS_StructTypeID_atxt; 0)
			C_TEXT:C284($Category_txt)
			$Category_txt:=LSS_Categories_as{$cat_L}
			
			Case of 
				: ($Category_txt="ITS")
					$Category_txt:="IT"
				: ($Category_txt="Light")
					$Category_txt:="LI"
				: ($Category_txt="Sign")
					$Category_txt:="HS"
				: ($Category_txt="Signal")
					$Category_txt:="SI"
			End case 
			
			READ ONLY:C145([LSS_refStructureTypes:171])
			QUERY:C277([LSS_refStructureTypes:171]; [LSS_refStructureTypes:171]LSS_Category_s:2=$Category_txt)
			SELECTION TO ARRAY:C260([LSS_refStructureTypes:171]LSS_StructureTypeId_s:1; LSS_StructTypeID_atxt; \
				[LSS_refStructureTypes:171]LSS_Description_txt:3; LSS_StructType_atxt)
			
			INSERT IN ARRAY:C227(LSS_StructType_atxt; 0; 1)
			INSERT IN ARRAY:C227(LSS_StructTypeID_atxt; 0; 1)
			LSS_StructType_atxt{1}:="ALL"
			OBJECT SET VISIBLE:C603(*; "LSS_StructType_@"; True:C214)
			LSS_StructType_atxt:=0
			LSS_StructType_atxt{0}:=""
		Else 
			
			OBJECT SET VISIBLE:C603(*; "LSS_StructType_@"; False:C215)
			ARRAY TEXT:C222(LSS_StructType_atxt; 0)
			LSS_StructType_atxt:=0
		End if 
		
	End if 
	
	
End if 
//End Object Method: [LSS_Inventory].ListBoxOutput.LSS_Categories_as