//%attributes = {"invisible":true}
//Method: Mods_2023_10

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-02)
// InitPrefs - copied from v18Bug 2023-10-03
//  `when Windows in Local mode, the extension is .exe - so the MHD BMS Prefs file is placed next to the .exe

//```
//```    **** End of Release 8.0.3.a beta 2023-10-02 - for Windows standalone test
//```


//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-03)
// ***  changes only in v19R8 version
// ut_SendEmail
//  `added headers in email when priority = true
// Mail_BridgeStatusRpt
//  `use .push for Attachments ; add Attachments as plain attachments, no cid; added header for Disposition-Notification-To
// ut_ControlSendMail
//  `Added handling of attachments and headers

//```
//```    **** End of Release 9.0.0 beta 2023-10-04-1
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-04)
// ut_SendEmail
//  `added attachments and priority headers
// [Bridge MHD NBIS];"Bridge Input"
//  `removed Bold attr from all listboxes - was not in v18

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-06)
// prt_substdrep
//  `make sure a Letter size paper is selected from printer 8.5x11 (612x792)

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-10)
// ut_GetBackupInfo -- sync w v18 2023-10-10
//  `$priority_b was not evaluated - check if backupinfo contains "Priority Message!!"
// ut_ReturnBackupInfo -- sync w v18 2023-10-10
//  `don't raise error if the next backup date is 00/00/00 ie no scheduled backup

//**********`Modified by: manousakisc-(Designer)-(10/11/2023)
// WKHR_MailReviewNotice
// ut_ControlSendMail
// mail_testSend
// Mail_SendTINRevuNotif
// Mail_SendInspRevuNotif
// Mail_BridgeStatusRpt
// LSS_SendAcceptRejectEmail
// CM_MailInvoiceNotice_2
// CM_MailInvoiceNotice
//  `check if running as service or headless before showing Alert in case of error in email sending

//```
//```    **** End of Release 9.0.0 beta 2023-10-11-1
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-19)
// [PRJ_ProjectDetails];"BridgeProgram_LB"
//  `set font setting of List box to NOT bold

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-17)
// LSS_PermissionADDInventory 
//  `Enable the Add inventory button if user is allowed to add in any district.
//  `The town drop down in the Add form is controlled by the districts user is allowed to add into. 
//  `Pers groups LSS_AddInventory_Dx

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-24)
// ut_OpenNewWindow - merged from v18Bug 2023-12-20
//  `Return the window ID created by Open window command

// [Conslt Rating];"Cslt Rating In".Field11 - copied from v18Bug 2023-12-20
//  `modified to use DS to keep [Contract Assignments] unlocked

// ut_NewSaveMethod - copied from v18Bug 2023-12-20
//  `added checks for Box when in Mac OS 11 - Box folder is in Library:CloudStorage:Box-Box:

//**********`Modified by: Costas Manousakis-(Designer)-(2023-10-25)
// LSS_ImportUpdates - copied from v18Bug 2023-12-20
//  `changed to use G_PickFromList ; added options to update Lat Lon , import active structures
//  `when adding structures - consider the Description import column for [LSS_Inventory]LSS_StructureTypeId_s
//  `when adding structures - consider the year built for active structures - ignore for proposed

// INV_OpenInventoryPhoto - copied from v18Bug 2023-12-20
//  `removed clear set("userset") - not needed -caused errors when trying to use UserSet later when adding BINs

//```
//```    **** End of Release 8.0.3.b 2023-10-30
//```


//
//End Mods_2023_10   