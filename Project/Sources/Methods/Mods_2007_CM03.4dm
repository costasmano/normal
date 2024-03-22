//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(1/8/2007 12:28:27)
//ADDITIONS TO DOWNLOAD MISSING INSPECTIONS FROM MAIN SERVER

// Created Method(s) : 
//OP_ErrorText 
//INSP_OP_ErrorCheck 
//INSP_DownloadMissing 
//INSP_DownLoadInsp 
//INSP_DeleteLocalInsp
//INSP_InitDwnlFldPtrArr 
//INSP_LogTableChanges 
//INSP_DWNLD_CUs 
//INSP_DWNLD_ElmtsSfty 
//INSP_DWNLD_Images 
//INSP_DWNLD_InspRec 
//INSP_DWNLD_PontisRec 
//INSP_DWNLD_PONTmMembers 
//INSP_DWNLD_Record 
//INSP_DWNLD_TmMembers 

// Modified Forms : 
//[Bridge MHD NBIS];"CombinedInspections"
//  `Added button to Download missing approved inspections.

// Modified by: costasmanousakis-(Designer)-(1/9/2007 09:10:53)
// Modified Forms : 
//[Standard Photos];"Standard Photos"
//  `Added CopyOptiondropDwn pulldown to copy photo or description to clipboard.

// Modified by: costasmanousakis-(Designer)-(1/11/2007 09:04:46)
// Modified Method(s) : 
//ut_StartMessage
//  `Added 6th parameter for window location; 
//  `Use call to NewWindow instead of CENTER_WINDOW.