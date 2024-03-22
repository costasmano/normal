//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(10/10/2006 08:34:05)
// Modified Method(s) : 
//INSP_SavePhoto
//  `Renamed from G_Method_SavePhoto
//  `Added code to increment image counters as needed after a new record log. That to fix a problem 
//  `when printing/previewing an image before pressing the 'save' button. this would lead to 
//  `multiple LogNewRecord commands for the same image record.

// Modified Object Methods : 
//[standard photos]"Standard Photos".ZZ8  
//[standard photos]"Standard Photos".ZZ1
//[standard photos]"Standard Photos".ZZ2
//[standard photos]"Standard Photos".ZZ3
//[standard photos]"Standard Photos".ZZ4
//[standard photos]"Standard Photos".vbPrintImages
//  `Changed call from G_Method_SavePhoto to INSP_SavePhoto

// Modified Method(s) : 
//Mail_BridgeStatusRpt
//  `Modified the subject and body of email.
//  `Added code to retrieve all mail parameters from the [Parameters] table.

// Created Method(s) : 
//ut_Send2Clipboard
//  `Debugging tool

// Modified Method(s) : 
//INSP_ut_FixTeamMember
//  `Modified to use method G_PickFromList to select inspector IDs

// Modified by: costasmanousakis-(Designer)-(10/24/2006 12:23:18)
// Modified Method(s) : 
//Shutdown
//  `Cleaned up logic of going thru processes, to go a bit faster on exiting