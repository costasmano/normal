//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(1/3/12 09:42:04)
// Modified Forms : 
//[Parameters];"Output"
//  `Added Button with object method LockButton to make table editable or not


// **********  ` Modified by: Costas Manousakis-()-(1/4/12 11:03:04)

// Modified Forms : 
//[SD_History].QryForm
//  `Added Pulldown to allow selection by District

// Modified Method(s) : 
//SD_SetPrintOptions
//  `Made var $SD_ReportFilePath_txt to global ◊SD_ReportFilePath_txt will be used to open the folder.

//SD_NewDetailReport
//SD_NewSummaryReport
//SD_ReportByOwner
//  `Use the variable ◊SD_DistrictSelect_txt  to fiilter results by district;
//  `At the end show the location where the output was generated.


// **********  ` Modified by: Costas Manousakis-()-(1/12/12 14:46:46)

// Modified Method(s) : 
//SIA_BridgeRankOM
//  `Allow everyone access to the Rank

// Created Method(s) : 
//PRJ_SearchClipboard
//  ` Search [PRJ_ProjectFile] by file no from text in Clipboard

// Modified Forms : 
//[PRJ_ProjectFile];"UserList.o"
//  `Added Button to execute method PRJ_SearchClipboard

// Modified Method(s) : 
//PRJ_QR_BridgeRank
//  `Added 3rd optional parameter for output options 


// **********  ` Modified by: Costas Manousakis-(Designer)-(1/13/12 16:42:41)
// Modified Method(s) : 
//CreateRandomSetForDefElement
//  `Exclude Freeze Thaw inspections in the search. Elements do not follow normal coding

