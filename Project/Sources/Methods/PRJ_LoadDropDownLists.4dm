//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_LoadDropDownLists
// User name (OS): cjmiller
// Date and time: 06/30/06, 13:24:08
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/15/07, 12:34:00`Modify to use group description
	Mods_2006_CJMv2  //03/15/07, 12:37:25  `Change name from Reviewers to StructReviewers
	Mods_2007_CJM_v5302  //r001 `10/02/07, 13:39:44`Try and fill tab arrays manually
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 08:41:22)
	Mods_2007_CM12_5302  //Reviewers are a combo of reviewers and strmgrs
	// Modified by: costasmanousakis-(Designer)-(10/8/08 08:23:25)
	Mods_2008_CM_5404  // ("ACCESS")
	//Modified the PRJ_BridgeSection_atxt array values to match the names in the Personnel groups tables.
	//11/19/08, 16:16:25 `Added ABP - Group to PRJ_BridgeSection_atxt dropdown
	Mods_2008_December  //CJM `r001    `12/17/08, 13:19:38 `Add new page to project input form with project file and design contract information    
	// Modified by: costasmanousakis-(Designer)-(1/22/09 22:19:12)
	Mods_2009_CM_5404
	//Additions for search by Expediter
	Mods_2013_01  //r001 ` Modify PRJ_BridgeSection_atxt so that first element read Technical Review. Additionally made that and PRJProjectTabs_as and PRJ_DefaultPage_atxt use table of lists
	//Modified by: Charles Miller (2/5/13 10:36:10)
End if 

If (Size of array:C274(PRJ_ProjectTypes_atxt)=0)
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="ProjectTypes")
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
	SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJ_ProjectTypes_atxt)
	INSERT IN ARRAY:C227(PRJ_ProjectTypes_atxt; 0; 1)
	PRJ_ProjectTypes_atxt{1}:="Select Project Type"
End if 
If (Size of array:C274(PRJ_BridgeSection_atxt)=0)
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="PRJ_BridgeSection_atxt")
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
	SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJ_BridgeSection_atxt)
End if 

If (Size of array:C274(PRJ_DefaultPage_atxt)=0)
	QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="PRJProjectTabs_as")
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
	SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJ_DefaultPage_atxt)
	
	PRJ_DefaultPage_atxt:=1
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
	SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJProjectTabs_as)
End if 


QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="GradingStatus")
ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListSequence_l:3; >)
SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJ_GradingStatus_atxt)

//Fill reviewers
PRJ_FillPersonnelDropDowns(->PRJ_StructReviewersID_al; ->PRJ_StructReviewers_atxt; "Struct Reviewers"; "Struct Proj Managers")
//Fill structural managers
PRJ_FillPersonnelDropDowns(->PRJ_StructPrjMgrID_al; ->PRJ_StructPrjMgr_atxt; "Struct Proj Managers")

ARRAY TEXT:C222(PRJ_SRCH_Expediters_atxt; 0)
READ ONLY:C145([PRJ_ProjectFile:117])
ALL RECORDS:C47([PRJ_ProjectFile:117])
DISTINCT VALUES:C339([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; PRJ_SRCH_Expediters_atxt)
SORT ARRAY:C229(PRJ_SRCH_Expediters_atxt)

//End PRJ_LoadDropDownLists