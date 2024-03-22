//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(1/2/2007 15:44:21)

// Modified Object Methods : 
//[Bridge MHD NBIS];"SI & A Input".aPostStat_
//  `Added code to handle new Posting Status "UNKNOW" - (unknown)

// Modified by: costasmanousakis-(Designer)-(1/3/2007 08:38:17)
// Modified Method(s) : 
//G_SpellCheckSetup
//  `Added code to set spell checking options

// Modified Forms : 
//[Conslt Rating];"Cslt Rating In"
//  `Added DropDown button cboFillRtgStatus to provide standard text for the status.
//  `Re-arranged some of the objects on the second page.
//  `Renamed Save and Delete btn variables to xxxCRtg.
// Modified Form Methods : 
//[Conslt Rating];"Cslt Rating In"
//  `Do not hide Delete btn any more - fixed by renaming variable

// Modified by: costasmanousakis-(Designer)-(1/9/2007 12:22:11)
// Modified Forms : 
//[Dialogs];"ListType"
//  `Changed Bridge key radio button to be Item 8

// Modified Method(s) : 
//M_LoadBINfile
//  `Changed query to handle Item 8 searches.

// Modified by: costasmanousakis-(Designer)-(1/10/2007 08:22:07)
// Modified Method(s) : 
//ut_UpdatePontis
//  `Added code to quit 4D if executed by user "BMSPontis Transfer"
// Modified Method(s) : 
//prt_substdrep
//  `Added line to reset the spooler doc name