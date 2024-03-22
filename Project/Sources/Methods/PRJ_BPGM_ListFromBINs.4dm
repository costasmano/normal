//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/04/07, 18:47:55
	// ----------------------------------------------------
	// Method: PRJ_BPGM_ListFromBINs
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	// Modified by: costasmanousakis-(Designer)-(10/2/2007 16:44:03)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5303  //r004 changed name of array PRJ_ConsultantName_atxt
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:19:35)
	Mods_2008_CM_5403
	//Added var PRJ_RatingDone_s
	// Modified by: costasmanousakis-(Designer)-(8/19/11 07:38:33)
	Mods_2011_08
	//Added call to InitProcessVar
End if 

If (Not:C34(Is compiled mode:C492))
	Compiler_PRJ
	Compiler_LSTS
	Compiler_SQL
	C_TEXT:C284(PRJ_RoadwayUnder_txt; PRJ_WinTitle; PRJ_UnderConstr_txt)
	C_TEXT:C284(PRJ_DistrNo_txt)  // Command Replaced was o_C_STRING length was 2
	C_DATE:C307(PRJ_InitInsp_D)
	C_BOOLEAN:C305(PRJ_RatingDone_b)
	C_TEXT:C284(PRJ_RatingDone_s)  // Command Replaced was o_C_STRING length was 3
	
End if 
Compiler_PRJArrays
PRJ_BPGM_InitDispArrays
InitProcessVar
C_TEXT:C284($MyprocName_txt)
C_LONGINT:C283($MyProcState_L; $MyProcTime_L; $win)
PROCESS PROPERTIES:C336(Current process:C322; $MyprocName_txt; $MyProcState_L; $MyProcTime_L)
UpdatWindArray(""; Current process:C322)
READ ONLY:C145(*)
PRJ_LoadDropDownLists
ARRAY LONGINT:C221(PRJ_ConsultantID_al; 0)
ARRAY TEXT:C222(PRJ_ConsultantName_atxt; 0)
ALL RECORDS:C47([Conslt_Name:127])
SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; PRJ_ConsultantID_al; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsultantName_atxt)
READ WRITE:C146([PRJ_ProjectDetails:115])
USE SET:C118("◊"+$MyprocName_txt)
ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5)
PRJ_BPGM_LoadArrays
FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.i")
FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "BridgeProgram")
C_LONGINT:C283($Width_l; $Height_l; $Width_i_l)
//GET FORM PROPERTIES([PRJ_ProjectDetails];"BridgeProgram";$Width_l;$Height_l)
PRJ_WinTitle:=$MyprocName_txt
DELAY PROCESS:C323(Current process:C322; 2)
NewWindow(900; 600; 1; 0; PRJ_WinTitle+" ["+String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))+"]")
PRJ_BPGM_LoadSorts
SET MENU BAR:C67("BridgeProgram")
MODIFY SELECTION:C204([PRJ_ProjectDetails:115]; *)
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
CLEAR SET:C117("◊"+$MyprocName_txt)
PRJ_BPGM_InitDispArrays