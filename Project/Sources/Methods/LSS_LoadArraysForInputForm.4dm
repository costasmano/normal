//%attributes = {"invisible":true}
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): administrator
	// Date and time: 10/23/14, 13:35:42
	// ----------------------------------------------------
	// Method: LSS_LoadArraysForInputForm
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
	//Compiler_FieldVariables 
	
	// Modified by: Costas Manousakis-(Designer)-(10/4/18 16:22:33)
	Mods_2018_10
	//  `added calls to load v_165_034_atxt array for Owners
	
End if 

If (Type:C295(v_170_002_atxt)=Is undefined:K8:13)
	ARRAY TEXT:C222(v_170_002_atxt; 0)  //DESCRIPTION
	ARRAY TEXT:C222(v_170_001_atxt; 0)  //ID
End if 

If (Size of array:C274(v_170_002_atxt)=0)
	Begin SQL
		select [LSS_refStructureMaterial].[LSS_StructureMaterialId_s],
		[LSS_refStructureMaterial].[LSS_Description_txt]
		from 
		[LSS_refStructureMaterial]
		into 
		:v_170_001_atxt,
		:v_170_002_atxt;
	End SQL
	
End if 

If (Type:C295(v_169_002_atxt)=Is undefined:K8:13)
	ARRAY TEXT:C222(v_169_002_atxt; 0)
	ARRAY TEXT:C222(v_169_001_atxt; 0)
End if 

If (Size of array:C274(v_169_002_atxt)=0)
	Begin SQL
		select [LSS_refStructureCoating].[LSS_StructureCoatingId_s],
		[LSS_refStructureCoating].[LSS_Description_txt]
		from 
		[LSS_refStructureCoating]
		into 
		:v_169_001_atxt,
		:v_169_002_atxt;
	End SQL
	
End if 

LSS_FillStructureTypes([LSS_Inventory:165]LSS_InventoryType_s:28; [LSS_Inventory:165]LSS_StructureTypeId_s:25)


If (Type:C295(LSS_RouteDirectionID_as)=Is undefined:K8:13)
	ARRAY TEXT:C222(LSS_RouteDirectionDesc_atxt; 0)
	ARRAY TEXT:C222(LSS_RouteDirectionID_as; 0)  //Command Replaced was o_ARRAY string length was 13
End if 

If (Size of array:C274(LSS_RouteDirectionDesc_atxt)=0)
	Begin SQL
		select [LSS_refRouteDirection].[LSS_RouteDirectionId_s],
		[LSS_refRouteDirection].[LSS_Description_txt]
		from [LSS_refRouteDirection]
		into 
		:LSS_RouteDirectionID_as,
		:LSS_RouteDirectionDesc_atxt;
	End SQL
	
End if 

ARRAY TEXT:C222(v_165_034_atxt; 0)

QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="LSS_Owners")
ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; v_165_034_atxt)
INSERT IN ARRAY:C227(v_165_034_atxt; 1)
v_165_034_atxt{1}:=""
