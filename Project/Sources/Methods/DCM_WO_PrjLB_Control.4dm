//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/05/10, 04:25:28
	// ----------------------------------------------------
	// Method: DCM_WO_PrjLB_Control
	// Description
	//  `  Control the list box on a work order input form
	// 
	// Parameters
	// $1 :
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(12/13/10 10:59:41)
	Mods_2010_12
	//  `mark changes
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		ARRAY TEXT:C222(DCM_WO_BINS_atxt; 0)
		ARRAY TEXT:C222(DCM_WO_BDEPT_atxt; 0)
		ARRAY TEXT:C222(DCM_WO_PRJTYPE_atxt; 0)
		ARRAY BOOLEAN:C223(DCM_WO_SDR_ab; 0)
		ARRAY TEXT:C222(DCM_WO_Town_atxt; 0)
		ARRAY TEXT:C222(DCM_WO_Location_atxt; 0)
		ARRAY LONGINT:C221(DCM_WO_RecNo_aL; 0)
		
	: ($Task_txt="LOAD")
		SELECTION TO ARRAY:C260([DCM_Project:138]BIN:5; DCM_WO_BINS_atxt; [DCM_Project:138]BridgeNo:4; DCM_WO_BDEPT_atxt; [DCM_Project:138]Project Type:3; DCM_WO_PRJTYPE_atxt; [DCM_Project:138]SDInfluence:15; DCM_WO_SDR_ab; [DCM_Project:138]Town:7; DCM_WO_Town_atxt; [DCM_Project:138]Location:6; DCM_WO_Location_atxt; [DCM_Project:138]ProjectID:1; DCM_WO_RecNo_aL)
		DCM_PROJITEMS_CTRL("CALCALL")
		C_BOOLEAN:C305(DCM_WO_ITEMQChange_b)
		If (DCM_WO_ITEMQChange_b)
			[DCM_WorkOrders:137]ContractNo:1:=[DCM_WorkOrders:137]ContractNo:1  //mark a change
		End if 
		
End case 
