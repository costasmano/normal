//%attributes = {"invisible":true}
//Method: PRJ_DetailLBSetUpDisplayEvent
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 10/08/20, 17:03:06
	// ----------------------------------------------------
	//Created : 
	Mods_2020_10
	// Modified by: Costas Manousakis-(Designer)-(2021-10-06T00:00:00 13:24:31)
	Mods_2021_10
	//  `unload [PRJ_ProjectDetails] record at the end
End if 
//
//We need Consultant Name
InitPers

ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)

//Record numbers
ARRAY LONGINT:C221(v_115_002_aL; 0)

//project detail Bridge
ARRAY TEXT:C222(v_115_005_atxt; 0)

C_BLOB:C604($Return_blb; $Blob_blb)
SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]; $RecordIds_al)
VARIABLE TO BLOB:C532($RecordIds_al; $Blob_blb; *)
VARIABLE TO BLOB:C532(aPeople; $Blob_blb; *)
VARIABLE TO BLOB:C532(aPeople_ID; $Blob_blb; *)
$Return_blb:=PRJ_SetUpDetailList($Blob_blb)
C_LONGINT:C283($Offset_L)
$Offset_L:=0

BLOB TO VARIABLE:C533($Return_blb; v_115_002_aL; $Offset_L)  //Records numbers
BLOB TO VARIABLE:C533($Return_blb; PRJ_StructProjMgr_atxt; $Offset_L)
BLOB TO VARIABLE:C533($Return_blb; v_115_005_atxt; $Offset_L)  //Bridge number
BLOB TO VARIABLE:C533($Return_blb; PRJ_ConsName_atxt; $Offset_L)  //consultant

//always resort back to inital sort
SORT ARRAY:C229(v_115_005_atxt; \
v_115_002_aL; \
PRJ_StructProjMgr_atxt; \
PRJ_ConsName_atxt; >)
LB_Header1_L:=1
CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; v_115_002_aL; "SortedProjects")
USE NAMED SELECTION:C332("SortedProjects")
CLEAR NAMED SELECTION:C333("SortedProjects")
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])

//End PRJ_DetailLBSetUpDisplayEvent