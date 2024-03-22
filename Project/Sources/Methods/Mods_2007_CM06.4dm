//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(1/30/2007 09:23:20)
// Modified Method(s) : 
//INIT_UI_GV
//  `Enabled loging of TwnEmail address
// Modified Forms : 
//[ExtendTime_Maintenance];"ExtTime In"
//  `Deleted 2nd  page.

// Modified by: costasmanousakis-(Designer)-(1/31/2007 14:22:43)
// Modified Method(s) : 
//INV_InvInspListObjM
//  `Added 2nd optional parameter to pass the form event.
// Modified Forms : 
//[Bridge MHD NBIS];"InventoryPhoto"
//[InventoryPhotoInsp];"ReviewDialog"
//  `Added hidden button 'CMD-O' to be used to open inspection using keyboard. 
//  `Calls method INV_InvInspListObjM.
// Modified Method(s) : 
//INV_PhotoListObjM
//  `Added optional parameter to pass the form event.
// Modified Forms : 
//[InventoryPhotoInsp];"Input"
//  `Added hidden button 'CMD-O' to be used to open photo using keyboard. 
//  `Calls method INV_PhotoListObjM.

// Modified by: costasmanousakis-(Designer)-(2/2/2007 12:33:39)
// Modified Method(s) : 
//Mail_SendInspRevuNotif 
//  `Added check to get Team Leaders email and add it to the list of people getting email.

// Modified Forms : 
//[Inspections];"InspectionReview"
//  `Added hidden buttons mapped to Shift-Cmd-1, Shift-Cmd-2 to switch
//  `approve levels to 1 and 2.

// Modified Forms : 
//[Personnel];"Inspectors Out"
//  `Added Quick Report button.

// Modified by: costasmanousakis-(Designer)-(2/6/2007 10:03:56)
// Modified Forms : 
//[InventoryPhotoInsp];"Input"
//  `Adjusted size of BIN, date, BDEPT fiels for better visibility;
//  `Named color bkgrnd and objects on the tab, so they can be moved/resized
//  `when on Windows because the tab on Windows is on top.
// Modified Form Methods : 
//[InventoryPhotoInsp];"Input"
//  `Added code to move and resize objects on the tab area when in Windows.

// Modified by: costasmanousakis-(Designer)-(2/6/2007 12:01:08)
// Modified Method(s) : 
//Print_CUL_Cmts
//  `When printing the 1st page of comments (culvert page 2), scale the picture
//  `generated by 4D Write by .75
// Modified Forms : 
//[Inspections];"Culvert Pr Pg 2"
//  `Changed picture -format to be truncated-non centered for the fix above.

// Modified by: costasmanousakis-(Designer)-(2/7/2007 15:02:11)
// Modified Method(s) : 
//DisplayDocProps
//  `got complete list of 4D Write doc properties.

// Modified by: costasmanousakis-(Designer)-(2/12/2007 10:09:59)
// Modified Forms : 
//[InventoryPhotoInsp];"ReviewDialog"
//  `Added hidden button 'Shift-CMD-G' to get all inv photo inspections for a district. 

// Modified Method(s) : 
//TMPL_Do_Template_Choise
//  `Added code to strip CRs from titles of columns and formats when the
//  `print destination is 2 - disk file.

// Modified by: costasmanousakis-(Designer)-(2/14/2007 09:33:52)
// Created Method(s) : 
//ut_LoadRecordInteractive
//  `An Interactive version of load record.
// Modified Method(s) : 
//WKHR_ProposalToAssgn
//  `Use the new ut_LoadRecordInteractive method; 
//  `give a prompt if changing existing non-zero values.

// Added Picture to Library
//BMS DollarTo - 883

// Modified Method(s) : 
//G_RoutinetoBMS 
//G_CulverttoBMS
//G_Insp_ApproveReject
//  `Use new method ut_LoadRecordInteractive

// Modified Object Methods : 
//[Dialogs].PrintInspRpt.aInvPhotoDate_aD
//[Dialogs].PrintInspRpt2.aInvPhotoDate_aD
//[Dialogs].ut_Request.ut_Request_Choises
//[Standard Photos].Standard Photos.CopyOptiondropDwn
//[Conslt Rating].Cslt Rating In.cboFillRtgStatus
//[InventoryPhotos].Input.CopyOptiondropDwn
//  `Added code to avoid the compiler warning on assuming array index is real.