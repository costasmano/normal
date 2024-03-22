//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(1/23/2007 15:10:03)
// Created Method(s) : 
//ut_CleanOwnersofDataDupl 
//  `Clear duplicates in the [Owners of Data] table

//ut_ClearFileIDRes
//  `Clear FileIDRes table entries

// Modified Object Methods : 
//[Inspections];"Routine Combined".vbPGPreview
//[Inspections];"Culvert Combined".vbPGPreview
//[Inspections];"Closed Bridge".vbPGPreview
//[Inspections];"Dive Template".vbPGPreview
// Modified Method(s) : 
//INSP_PreviewBtn_OM
//  `Added a PAGE BREAK after the print previewing of comments. Woudl lock up windows clients.

// Modified by: costasmanousakis-(Designer)-(1/25/2007 11:52:57)
// Modified Method(s) : 
//XGetServerLnk
//  `Fixed Typo in code where the wrong variable was being saved to the 
//  `data blob in the case of an integer linked field.
//Mail_SendInspRevuNotif
//  `Added sending a cc to the from address for record.

// Modified by: costasmanousakis-(Designer)-(1/26/2007 10:29:16)
// Modified Method(s) : 
//INSP_CheckLinks
//  `When checking for combined inspection loaded record, changed the case statement of
//  `number of records in selection of combined from =0 to #1. Addresses error when printing
//  `SIA report which changes the selection of combined records.
// Created Method(s) : 
//INSP_PrintSIA
//  `Print the SIA sheet from inside an inspection Print command.
// Modified Method(s) : 
//PRINT_ROUTINE_F 
//PRINT_CULVERT_F 
//PRINT_Closed 
//PRINT_Damage 
//PRINT_Critical 
//Print_Dive_F 
//  `Use the new method INSP_PrintSIA.

// Modified by: costasmanousakis-(Designer)-(1/27/2007 19:23:44)
// Created Form(s) : 
//[Dialogs];"ut_Request"
// Created Method(s) : 
//ut_Request 
//  `As a replacement for the Request 4D Function
// Modified Method(s) : 
//Mail_SendInspRevuNotif
//  `If there are multiple Emails show a list and also allow 
//  `modifications to the selected email address.
//  `Use the new ut_Request function.

// Modified by: costasmanousakis-(Designer)-(1/28/2007 11:06:04)
// Modified Method(s) : 
//NewTellServer
//  `Added check and confirm at the start to verify that all input screens have been closed
//  `, or returned to the list form.
