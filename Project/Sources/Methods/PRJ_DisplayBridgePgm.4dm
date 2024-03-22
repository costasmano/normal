//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/05/07, 10:50:37
	// ----------------------------------------------------
	// Method: PRJ_DisplayBridgePgm
	// Description
	// copied from  PRJ_DisplayProjects
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	// Modified by: costasmanousakis-(Designer)-(10/2/2007 16:58:03)
	Mods_2007_CM12_5301
	Mods_2007_CJM_v5303  //r004 changed name of array PRJ_ConsultantName_atxt
	// Modified by: costasmanousakis-(Designer)-(6/13/08 09:19:35)
	Mods_2008_CM_5403
	//Added var PRJ_RatingDone_s
	Mods_2009_05  //r001  `05/08/09, 14:06:20  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	//[PRJ_ProjectFile]DC_DesignContractID_l to [PRJ_ProjectDetails]DC_DesignContractID_l
	Mods_2009_06  //r002 `06/11/09, 13:35:08   `Merge PRJ Design Contract Changes
	Mods_2020_10  //Replace [PRJ_ProjectDetails];"BridgeProgram" with Listbox [PRJ_ProjectDetails];"BridgeProgram_LB"
	//Modified by: CJ (10/8/20 14:28:27)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	Mods_2021_03  //Fix so that changes on input form are updated on list box
	//Modified by: CJ (3/11/21 13:43:23)
End if 

If (Not:C34(Is compiled mode:C492))
	Compiler_PRJ
	Compiler_LSTS
	Compiler_SQL
	Compiler_LB
	C_TEXT:C284(PRJ_RoadwayUnder_txt; PRJ_WinTitle; PRJ_UnderConstr_txt)
	C_TEXT:C284(PRJ_DistrNo_txt)  // Command Replaced was o_C_STRING length was 2
	C_DATE:C307(PRJ_InitInsp_D)
	C_BOOLEAN:C305(PRJ_RatingDone_b)
	C_TEXT:C284(PRJ_RatingDone_s)  // Command Replaced was o_C_STRING length was 3
	
End if 
Compiler_PRJArrays
PRJ_BPGM_InitDispArrays
InitProcessVar

UpdatWindArray(""; Current process:C322)
READ ONLY:C145(*)
PRJ_LoadDropDownLists
READ WRITE:C146([PRJ_ProjectDetails:115])

QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
ORDER BY:C49([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5)
C_BOOLEAN:C305($useLB_B)
$useLB_B:=ut_UseListBox(Current method name:C684)
C_TEXT:C284($Form_txt)
If ($useLB_B)
	$Form_txt:="BridgeProgram_LB"
Else 
	$Form_txt:="BridgeProgram"
End if 
FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.i")
FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; $Form_txt)
C_LONGINT:C283($Width_l; $Height_l; $Width_i_l; $win_L)
FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; $Form_txt; $Width_l; $Height_l)
PRJ_WinTitle:="Bridge Program"
If (Not:C34($useLB_B))
	$win_L:=ut_OpenNewWindow($Width_l; 600; 1; Plain form window:K39:10; PRJ_WinTitle+"["+String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))+"]"; "ut_CloseCancel")
End if 
//NewWindow (900;600;1;0;PRJ_WinTitle+"["+String(Records in selection([PRJ_ProjectDetails]))+"]")
PRJ_BPGM_LoadSorts
SET MENU BAR:C67("BridgeProgram")

If ($useLB_B)
	
	Compiler_FieldVariables
	If (Application type:C494=4D Remote mode:K5:5)
	Else 
		COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "BridgeNS")
	End if 
	PRJ_SetupListBoxDisplayEvent
	If (Application type:C494=4D Remote mode:K5:5)
	Else 
		USE NAMED SELECTION:C332("BridgeNS")
		CLEAR NAMED SELECTION:C333("BridgeNS")
	End if 
	$win_L:=ut_OpenNewWindow($Width_l; 600; 1; Plain form window:K39:10; PRJ_WinTitle+"["+String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))+"]"; "ut_CloseCancel")
	DIALOG:C40([PRJ_ProjectDetails:115]; $Form_txt)
Else 
	PRJ_BPGM_LoadArrays
	MODIFY SELECTION:C204([PRJ_ProjectDetails:115]; *)
End if 
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
PRJ_BPGM_InitDispArrays