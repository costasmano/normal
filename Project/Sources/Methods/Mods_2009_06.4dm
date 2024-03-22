//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(6/1/09 15:15:12)
// Modified Method(s) : 
//Fn_GetTextBlob
//  `Changed call to WR Get Text to start at 0;32000 instead of 1;32000 

//r002 `06/02/09, 14:05:21   `Modify Pontis retrieve
//Add code to allow for deletion of a run
//Add code to log what occurred during run
//[Pontis_Metrics];"PontisImport.dlg"
//Add code to log what occurred during run
//PM_ControlLogDocument`new method
//PM_ControlMetricRetrieve 


//r002 `06/11/09, 13:10:05   `Merge PRJ Design Contract Changes

//ut_PRJ_FillDCPFJoinTable   `completed 
//ut_PRJRetrieveDesignContracts   `completed
//ut_PRJCreateDCPFJoinRecord   `completed
//ut_PRJUpgradeForDesignContract   `completed 
//ut_PRJUpgradeProjectDetail   `completed
//PRJ_BPGM_CreateSearchSet   `completed
//PRJ_BPGM_ListDetailData   `completed
//PRJ_LoadDesignContractForOutput   `completed
//PRJ_DET_CreateSearchSet   `completed
//PRJ_DisplayBridgePgm   `completed
//PRJ_LoadDesignContractData   `completed
//PRJ_QR_ReturnConsultant   `completed
//ut_PRJSetUpConsualtantNameData   `completed
//PRJ_ProjUpdPrepRow   `completed
//PRJ_LTR_ConsAddr   `completed
//PRJ_ProcessfromChapter85  `deleted
//PRJ_DetailOutsideCall   `completed
//ut_PRJUpdateConsName   `completed
//PRJ_FillConsAndSetButton   `completed
//PRJ_SelectCorrectPF   `completed
//PRJ_SelectCorrectDC   ` `completed
//ut_RetrieveAllBridgeContracts 




//[PRJ_ProjectFile];"UserList.o"
//[PRJ_ProjectFile];"User.i"
//[PRJ_ProjectDetails];"ProjectDetails.i" - no form change
//  ` Object Method: PRJ_SelectConsultant_l

//[PRJ_ProjectDetails];"ProjectDetails.o" `- no form change
//  ` Object Method: PRJ_SortButton
//[PRJ_ProjectDetails];"SelectFileFromDC"` - new form

//[PRJ_ProjectFile];"ProjectFile.i"`- no form change
//  ` Form Method: ProjectFile.i
//  ` Object Method: PRJConsultantHList_l
//[PRJ_DesignContracts];"Input"`- no form change
//  ` Form Method: Input
//PRJ_ProcessfromChapter85 
//[PRJ_ProjectDetails];"SelectFileFromPF"
//[PRJ_ProjectDetails];"SelectFileFromDC"
//
//ut_PRJSetUpConsualtantNameData` - one time use no changes
//ut_PRJUpdateConsName` - one time use no changes
//
//
//
//

//merge in scour changes costas made
//[ScourPOA];"Print" `form method
//SCPOA_ut_GeneratePOAs
//SIA_CustomQRBtn_OM
//SCPOA_CopyInvPhotos 
//SCPOA_CopyScourNotes


// **********  ` Modified by: costasmanousakis-(Designer)-(6/26/09 16:26:43)
// Modified Method(s) : 
//GetServerBIN 
//NewTellServer 
//XDownLoadServer 
//INSP_DownloadMissing 
//OP_GetPassword 
//INSP_UpdateInspection
//Compiler_Variables
//Compiler_Methods
//  ` Changed vsDialogtxt to TEXT
