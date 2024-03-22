//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(1/8/2007 11:40:54)
//ADDITIONS FOR INVENTORY PHOTOS

// Created HelpTips(s) :
//GEN_FirstRec
//GEN_PrevRec
//GEN_NextRec
//GEN_LastRec
//GEN_DeleteRec
//GEN_Print
//GEN_Close
//GEN_AddSubRec

// Created Style(s) : 
//Lucinda 13
//Lucinda 14 plain

// Created Picture button : 
//BMS SaveToDB
// Created Icons
//BMS AcceptIcon
//BMS RejectIcon

// Created Table(s) : 
//[InventoryPhotoInsp]
//[InventoryPhotos]

// Created Form(s) : 
//[InventoryPhotoInsp];"Input"
//[InventoryPhotoInsp];"Output"
//[InventoryPhotoInsp];"PrintForm"
//[InventoryPhotoInsp];"ReviewDialog"
//[InventoryPhotos];"Include"
//[InventoryPhotos];"Input"
//[InventoryPhotos];"Output"
//[Bridge MHD NBIS];"InventoryPhoto"

// Created Method(s) : 
//M_INV_Review
//P_INV_Review 
//INV_ApproveRejectInsp 
//INV_CreatePhotosList 
//INV_DeleteInsp 
//INV_DisplayInvInspections 
//INV_EnterCommentReply 
//INV_GetBINInventoryPhotos 
//INV_GetReviewInventoryPhotos 
//INV_InspDone 
//INV_InvInspListObjM 
//INV_LockUnLockCurrRec 
//INV_PhotoListObjM 
//INV_PrintInvInsp 
//INV_ReDoSort 
//INV_SaveInvInsp 
//INV_SavePhoto 
//INV_SetHelpMsg_Insp 
//INV_SetHelpMsg_List 
//INV_SetHelpMsg_Photo 
//INV_SetupSortVars 
//INV_SortButton_OM 
//INV_TeamLeader_OM 
//INV_TeamMember_OM 
//INV_UpdateReviewList 
//utf_GetDBIE_PID

// Modified Forms : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Added button bInventory
//[Dialogs];"PrintInspRpt"
//[Dialogs];"PrintInspRpt2"
//  `Added optional check box and date drop down to print the  
//  `Inventory photo inspection from the inspection report.
// Modified Form Methods : 
//[Dialogs];"PrintInspRpt"
//[Dialogs];"PrintInspRpt2"
//  `Handle the showing/hiding of the print inv checkbox

// Modified Method(s) : 
//PRINT_ROUTINE_F 
//PRINT_CULVERT_F 
//Print_Dive_F 
//PRINT_Closed 
//PRINT_Critical 
//INSP_PRN_InitVars 

// Modified Menu(s) : 
//Menu bar #1 - menu Special
//  `Added item Review Inventory Photos