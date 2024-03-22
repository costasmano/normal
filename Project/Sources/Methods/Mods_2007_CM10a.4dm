//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(5/29/2007 11:39:28)

// Modified Method(s) : 
//ut_UpdatePontis
//  `Added declaration of variable ◊PontisChange_d

//PRJ_SetProjectChangesMade
//  `Added assignement of field pointer vars
// Modified Form Methods : 
//[PRJ_TypeStudy];"TypeStudy.i"
//  `Fixed syntax error line 45
// Modified Method(s) : 
//ut_PRJImportData
//  `Added $win variable in the open form command.
//  `Added variable $StructureReviewApproval_txt  to all calls to method ut_PRJCreateStructuralReview.

// Modified Method(s) : 
//SMTPAuth
//mail_testSend
//Mail_BridgeStatusRpt
//Mail_SendInspRevuNotif
//CM_MailInvoiceNotice
//  `Added optional parameters (zeros) at the end of some SMTP calls to avoid the warnigns during compile.

// Modified by: costasmanousakis-(Designer)-(6/4/2007 16:21:55)
// Modified Method(s) : 
//WKHR_ComputeAvgs
//  `Made sure all alerts are not shown when run in Server.
//  `Added call to set the next run time
// Created Method(s) : 
//Server_UpdateWKHRSummary
//  `launch the WKHR_ComputeAvgs process on the server.

// Modified by: costasmanousakis-(Designer)-(6/5/2007 09:18:24)

// Modified Method(s) : 
//CM_MailInvoiceNotice
//  `Changed label of Total paid to total aprroved....

// Modified Forms : 
//[Contract_Maintenance];"Contract Maintenance In"
//[Contracts];"Contracts In"
//  `Added ProjectInfo button to go to Projectinfo with the current contract number
//[PRJ_ProjectDetails];"ProjectDetails.i"
//  `Added Help message to the project info buttons

// Modified by: costasmanousakis-(Designer)-(6/6/2007 08:36:03)
// Modified Form Methods : 
//[Parameters];"Input"
//  `Do not log changes if the parameter length is more than 20 chars due to limit in Activity log fields
// Modified Object Methods : 
//[Parameters];"Input".bDelete
//[Parameters];"Input".bValidate
//  `Do not log changes if the parameter length is more than 20 chars due to limit in Activity log fields

// Modified by: costasmanousakis-(Designer)-(6/7/2007 09:07:43)
// Modified Method(s) : 
//SQL_FillUpdate
//SQL_FillRetrieve
//  `Use new process var SQL_DatabaseName_s from the old ◊Pontisxxx_txt

//ut_UpdatePontis
//  `Added  setting of variable ◊ODBC_DEBUG_WINDOW before connecting to the SQL server
//  `Also use method ut_ResetSQLLastUpdateDate 