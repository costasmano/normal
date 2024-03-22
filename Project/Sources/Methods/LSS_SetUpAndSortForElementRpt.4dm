//%attributes = {"invisible":true}
//Method: LSS_SetUpAndSortForElementRpt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/10/19, 17:18:39
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
End if 
//
C_BOOLEAN:C305($UseStructureOnly_B)
If (Count parameters:C259=1)
	C_BOOLEAN:C305($1; $UseStructureOnly_B)
End if 
ARRAY TEXT:C222($Insp_ids; 0)

ARRAY TEXT:C222(v_164_002_atxt; 0)
ARRAY TEXT:C222(v_164_001_atxt; 0)
ARRAY DATE:C224(v_164_004_ad; 0)

ARRAY TEXT:C222(v_165_001_atxt; 0)
ARRAY TEXT:C222(v_165_006_atxt; 0)



SELECTION TO ARRAY:C260([LSS_ElementInspection:163]LSS_InspectionId_s:3; $Insp_ids)
QUERY WITH ARRAY:C644([LSS_Inspection:164]LSS_InspectionId_s:1; $Insp_ids)
SELECTION TO ARRAY:C260([LSS_Inspection:164]LSS_InventoryId_s:2; v_164_002_atxt; [LSS_Inspection:164]LSS_InspectionId_s:1; v_164_001_atxt; [LSS_Inspection:164]LSS_InspectionDate_d:4; v_164_004_ad)
QUERY WITH ARRAY:C644([LSS_Inventory:165]LSS_InventoryId_s:1; v_164_002_atxt)
SELECTION TO ARRAY:C260([LSS_Inventory:165]LSS_StructureNumber_s:6; v_165_006_atxt; [LSS_Inventory:165]LSS_InventoryId_s:1; v_165_001_atxt)
DISTINCT VALUES:C339([LSS_Inventory:165]LSS_InventoryType_s:28; $Types_atxt)


Case of 
	: ($UseStructureOnly_B) | (Size of array:C274($Types_atxt)>1) | (Size of array:C274(v_162_001_aL)=0)
		ARRAY LONGINT:C221($recordsNumbers_aL; 0)
		ARRAY DATE:C224($dates_aD; 0)
		ARRAY TEXT:C222($Numbers_atxt; 0)
		
		SELECTION TO ARRAY:C260([LSS_ElementInspection:163]; $recordsNumbers_aL; [LSS_Inspection:164]LSS_InspectionDate_d:4; $dates_aD; [LSS_Inventory:165]LSS_StructureNumber_s:6; $Numbers_atxt)
		MULTI SORT ARRAY:C718($Numbers_atxt; >; $dates_aD; >; $recordsNumbers_aL)
		CREATE SELECTION FROM ARRAY:C640([LSS_ElementInspection:163]; $recordsNumbers_aL)
		
		//ORDER BY FORMULA([LSS_ElementInspection];LSS_OrderByJustStructure ;>)
	Else 
		ORDER BY FORMULA:C300([LSS_ElementInspection:163]; LSS_SortElements; >)
End case 
//End LSS_SetUpAndSortForElementRpt