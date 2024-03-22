//%attributes = {"invisible":true,"executedOnServer":true}
//Method: PRJ_SetUpDetailList
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 10/08/20, 17:09:49
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10
	C_BLOB:C604(PRJ_SetUpDetailList; $1; $0)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 18:42:03)
	Mods_2021_10
	//  `set all tables to RO since we run on server
End if 

C_BLOB:C604($1; $0)
C_LONGINT:C283($offset_L)
Compiler_FieldVariables
$offset_L:=0

READ ONLY:C145(*)

PRJ_FillPersonnelDropDowns(->PRJ_StructPrjMgrID_al; ->PRJ_StructPrjMgr_atxt; "Struct Proj Managers")

ARRAY LONGINT:C221($RecordIds_al; 0)
ARRAY INTEGER:C220(aPeople_ID; 0)
ARRAY TEXT:C222(aPeople; 0)
BLOB TO VARIABLE:C533($1; $RecordIds_al; $offset_L)
BLOB TO VARIABLE:C533($1; aPeople; $offset_L)
BLOB TO VARIABLE:C533($1; aPeople_ID; $offset_L)

ARRAY TEXT:C222($Bridge_atxt; 0)
ARRAY TEXT:C222($NonBridge_atxt; 0)
ARRAY BOOLEAN:C223($TempBridge_aB; 0)

CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; $RecordIds_al; "PRJ_Named")
USE NAMED SELECTION:C332("PRJ_Named")
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $Bridge_atxt; [PRJ_ProjectDetails:115]PRJ_NonBridge_s:7; $NonBridge_atxt; [PRJ_ProjectDetails:115]PRJ_TemporaryBridge_b:6; $TempBridge_aB)

ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(v_115_005_atxt; 0)
$offset_L:=Size of array:C274($RecordIds_al)
COPY ARRAY:C226($RecordIds_al; v_115_002_aL)
ARRAY TEXT:C222(v_115_005_atxt; $offset_L)

ARRAY TEXT:C222(PRJ_StructProjMgr_atxt; 0)
ARRAY TEXT:C222(PRJ_StructProjMgr_atxt; $offset_L)

ARRAY TEXT:C222(PRJ_ConsName_atxt; $offset_L)
ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
ALL RECORDS:C47([Conslt_Name:127])
SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; PRJ_ConsultantID_al; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsultantName_atxt)

//project detail Bridge
C_LONGINT:C283($loop_l)

USE NAMED SELECTION:C332("PRJ_Named")

For ($loop_l; 1; Size of array:C274($RecordIds_al))
	GOTO RECORD:C242([PRJ_ProjectDetails:115]; $RecordIds_al{$loop_l})
	
	PRJ_LoadDesignContractForOutput
	PRJ_SetUpStructuralPrjMgr(->[PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)
	PRJ_StructProjMgr_atxt{$loop_l}:=PRJ_StructPrjMgr_txt
	v_115_005_atxt{$loop_l}:=PRJ_LB_ReturnBridgeNo(->$Bridge_atxt{$loop_l}; ->$NonBridge_atxt{$loop_l}; ->$TempBridge_aB{$loop_l})
	PRJ_ConsName_atxt{$loop_l}:=PRJ_ConsultantName_txt
End for 
C_BLOB:C604($Return_blb)
CLEAR NAMED SELECTION:C333("PRJ_Named")
VARIABLE TO BLOB:C532(v_115_002_aL; $Return_blb; *)  //Records numbers
VARIABLE TO BLOB:C532(PRJ_StructProjMgr_atxt; $Return_blb; *)  //structural proj mgr
VARIABLE TO BLOB:C532(v_115_005_atxt; $Return_blb; *)  //structural proj mgr
VARIABLE TO BLOB:C532(PRJ_ConsName_atxt; $Return_blb; *)  //consultant
ARRAY LONGINT:C221(v_115_002_aL; 0)
ARRAY TEXT:C222(PRJ_StructProjMgr_atxt; 0)
ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
ARRAY TEXT:C222(v_115_005_atxt; 0)
ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
$0:=$Return_blb
//End PRJ_SetUpDetailList