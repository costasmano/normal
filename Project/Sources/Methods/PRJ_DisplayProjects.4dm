//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_DisplayProjects
// User name (OS): cjmiller
// Date and time: 01/26/06, 12:30:06
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //10/19/06, 13:07:23`Make a new output form with diferent columns
	Mods_2007_CJMv2  //04/26/07, 12:15:37`Integrate Changes made by Costas
	Mods_2007_CJMv2  //04/30/07, 12:00:48`Fix compiler errors
	Mods_2007_CJMv2  //r060   `05/16/07, 11:51:22` `Add code to control access 
	Mods_PRJSELECTION
	Mods_2007_CJM_v5303  //r004 changed name of array PRJ_ConsultantName_atxt
	// Modified by: costasmanousakis-(Designer)-(1/23/09 00:20:02)
	Mods_2009_CM_5404
	//Reduce the starting list by where user belongs to.
	// Modified by: Costas Manousakis-(Designer)-(4/29/15 13:30:51)
	Mods_2015_04_bug
	//  `do initial search of project details based on belonging to a personell groups
	//  `added one more table of lists "PRJ_BrgSectPersGroup" which matches the [pers_groups] groups 
	//  `to the list "PRJ_BridgeSection_atxt"
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-01T00:00:00 18:26:25)
	Mods_2021_10
	//  `unload [PRJ_ProjectDetails]
End if 
If (Not:C34(Is compiled mode:C492))
	Compiler_PRJ
	Compiler_LSTS
	Compiler_SQL
End if 
Compiler_FieldVariables
Compiler_PRJArrays
UpdatWindArray(""; Current process:C322)
InitProcessVar
PRJ_SetManyTablesReadOnly
ARRAY TEXT:C222(PRJ_ConsName_atxt; 0)
READ ONLY:C145(*)
PRJ_LoadDropDownLists
//ALL RECORDS([Conslt Address])
//SELECTION TO ARRAY([Conslt Address]ConsltAddressID;PRJ_ConsultantIDs_al;[Conslt Address]ContactFName;PRJ_ConsultantFNames_atxt;[Conslt Address]ContactLName;PRJ_ConsultantLNames_atxt)
ALL RECORDS:C47([Conslt_Name:127])
SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantNameID_l:1; PRJ_ConsultantID_al; [Conslt_Name:127]ConsultantName_s:2; PRJ_ConsultantName_atxt)
//READ WRITE([PRJ_ProjectDetails])
ALL RECORDS:C47([PRJ_ProjectDetails:115])
UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
C_LONGINT:C283($loop_L; $Win_L)
C_BOOLEAN:C305($doSearch_b)
$doSearch_b:=False:C215
ARRAY TEXT:C222($PersGroups_atxt; 0)
QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="PRJ_BrgSectPersGroup")
ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; $PersGroups_atxt)
For ($loop_L; 1; Size of array:C274($PersGroups_atxt))
	If (GRP_4DUIDinGroup(<>CurrentUser_UID; $PersGroups_atxt{$loop_L})=1)
		QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeSectResp_s:44=PRJ_BridgeSection_atxt{$loop_L}; *)
		$doSearch_b:=True:C214
	End if 
End for 
If ($doSearch_b)
	QUERY:C277([PRJ_ProjectDetails:115])
End if 
C_BOOLEAN:C305($useLB_B)

$useLB_B:=ut_UseListBox(Current method name:C684)
C_TEXT:C284($Form_txt)
If ($useLB_B)
	C_BLOB:C604($Blob_blb)
	$Form_txt:="ProjectDetails_LB"
	ut_PRJSortByBridge  //sort by bridge first
	//SELECTION TO ARRAY([PRJ_ProjectDetails];$RecordIds_al)
	//VARIABLE TO BLOB($RecordIds_al;$Blob_blb;*)
	//VARIABLE TO BLOB(aPeople;$Blob_blb;*)
	//VARIABLE TO BLOB(aPeople_ID;$Blob_blb;*)
	SHORT_MESSAGE("Retrieving data")
	PRJ_DetailLBSetUpDisplayEvent
	CLOSE WINDOW:C154
Else 
	$Form_txt:="ProjectDetails.o"
	FORM SET OUTPUT:C54([PRJ_ProjectDetails:115]; "ProjectDetails.o")
End if 
FORM SET INPUT:C55([PRJ_ProjectDetails:115]; "ProjectDetails.i")
C_LONGINT:C283($Width_l; $Height_l; $Width_i_l; $win)
FORM GET PROPERTIES:C674([PRJ_ProjectDetails:115]; $Form_txt; $Width_l; $Height_l)
C_TEXT:C284($RecSel)
PRJ_MembershipGroup_txt:=ut_PRJ_IdentifyHighestGroup
$RecSel:=String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))
$Win_L:=ut_OpenNewWindow($Width_l; 600; 1; Plain form window:K39:10; "Project Details ["+$RecSel+"]"; "ut_CloseCancel")

// set table to RW befor we open the output list
READ WRITE:C146([PRJ_ProjectDetails:115])
SET MENU BAR:C67("ProjectDetail")  //Mods_PRJSELECTION
If ($useLB_B)
	DIALOG:C40([PRJ_ProjectDetails:115]; $Form_txt)
Else 
	If (PRJ_MembershipGroup_txt="No Access")
		DISPLAY SELECTION:C59([PRJ_ProjectDetails:115]; *)
	Else 
		MODIFY SELECTION:C204([PRJ_ProjectDetails:115]; *)
	End if 
End if 
UpdatWindArray(""; Current process:C322)
CLOSE WINDOW:C154
//End PRJ_DisplayProjects