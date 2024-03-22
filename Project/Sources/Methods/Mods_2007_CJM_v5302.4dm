//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2007_CJM_v5302
// User name (OS): cjmiller
// Date and time: 10/02/07, 10:53:54
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r001 `10/02/07, 13:59:30
End if 
//Fix errors found by sanitycheck where possible
//Method:
//Error: Method name 'TEMP_UpdSelList_31-1-01' contains a gremlin('-'=45). [340]
//ut_ControlFieldReset:
//Error: Object Method refers to form 'ResetDialog' for table '[zDialogs]' which do<view>
//'G_GetServerDoc_Server':

//Error: The method 'GetServerDocErr'(used as a string parameter)Does not exist (line 36). [372]<view>
//'G_GetDirList_Server':
//Error: The method 'GetServerDocErr'(used as a string parameter)Does not exist (line 22). [372]<view>
//Mnt_GetReportType:
//Error: Object Method refers to form 'MntReportType' for table '[Dialogs]' which d<view>
//P_ListContractMaintenance:
//Error: Object Method refers to form 'Contract Maintenance Detail In' for table '[<view>


//G_MaintenanceCalculateTLFandDE `FIXED
//Error: Syntax: Unexpected ')' on line 20. [96]<view>
//ut_PutTWNDATAtoDoc: `FIXED
//Error: Syntax: Unexpected ')' on line 20. [96]<view>
//ut_PRJCreateTypeStudy: `FIXED
//Error: Syntax: ']' unexpected on line 16. [97]<view>
//'P_ListConsultantNames': `FIXED
//Error: Object Method refers to form 'Conslt_Name.i' for table '[Conslt_Name]' whi<view>


//r001 `10/02/07, 14:04:42
//Fix defect where tabs did not work compiled
//PRJ_LoadDropDownLists
//Fix issue with screen opening wrong when compiled
//[PRJ_ProjectDetails];"ProjectDetails.i"`modified how form opened to use yellow rectangle as size basis


//End Mods_2007_CJM_v5302