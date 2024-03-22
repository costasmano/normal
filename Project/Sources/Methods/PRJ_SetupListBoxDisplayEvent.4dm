//%attributes = {"invisible":true}
//Method: PRJ_SetupListBoxDisplayEvent
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 09/29/20, 15:46:57
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10  //Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
	//Modified by: CJ (10/8/20 14:28:27) 
End if 
//

C_BLOB:C604($Return_blb; $Blob_blb)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $RecordIds_al)
VARIABLE TO BLOB:C532($RecordIds_al; $Blob_blb)
SHORT_MESSAGE("Retrieving data")
$Return_blb:=PRJ_SetUpArraysForList($Blob_blb)
C_LONGINT:C283($Offset_L)
CLOSE WINDOW:C154
$Offset_L:=0
ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYOver_atxt; 0)
ARRAY TEXT:C222(PRJ_RWYUnder_atxt; 0)

BLOB TO VARIABLE:C533($Return_blb; v_115_002_aL; $Offset_L)  //Records numbers
BLOB TO VARIABLE:C533($Return_blb; v_117_014_ad; $Offset_L)  //PF_Advertised_d
BLOB TO VARIABLE:C533($Return_blb; v_117_005_ad; $Offset_L)  //PF_ScheduledAdvertising_d
BLOB TO VARIABLE:C533($Return_blb; v_115_034_atxt; $Offset_L)  //PRJ_PrimaryBin_s
BLOB TO VARIABLE:C533($Return_blb; v_115_005_atxt; $Offset_L)  //PRJ_BridgeNo_s
BLOB TO VARIABLE:C533($Return_blb; PRJ_ConsName_atxt; $Offset_L)  //ConsultantName_s
BLOB TO VARIABLE:C533($Return_blb; v_116_004_ad; $Offset_L)  //CP_Awarded_d
//BLOB TO VARIABLE($Return_blb;v_115_037_ad;$Offset_L)  //PRJ_Completion_d// Not Used
//BLOB TO VARIABLE($Return_blb;v_115_001_aL;$Offset_L)  //PRJ_ProjectID_l// Not Used
BLOB TO VARIABLE:C533($Return_blb; v_127_005_atxt; $Offset_L)  //Under Constructions
BLOB TO VARIABLE:C533($Return_blb; PRJ_RWYOver_atxt; $Offset_L)  //Roadway Over Item 7
BLOB TO VARIABLE:C533($Return_blb; PRJ_RWYUnder_atxt; $Offset_L)  //Roadway under Item 6A
BLOB TO VARIABLE:C533($Return_blb; v_139_059_atxt; $Offset_L)  //Item 2 district
BLOB TO VARIABLE:C533($Return_blb; v_115_006_ab; $Offset_L)  //used for rating

//ORDER BY([PRJ_ProjectDetails];[PRJ_ProjectDetails]PRJ_BridgeNo_s;>)
//LB_Header2_l:=1
ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CityOrTown_s:8; >)
LB_Header1_l:=1
//End PRJ_SetupListBoxDisplayEvent