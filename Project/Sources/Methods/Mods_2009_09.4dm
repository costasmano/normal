//%attributes = {"invisible":true}
// Modified Method(s) : 
//PRJ_QR_ReturnBridge 
//  `Adjusted the method to add a "T" for Temporary bridges
// Modified Form Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.o"
//  `Use method PRJ_QR_ReturnBridge

// **********  ` Modified by: costasmanousakis-(Designer)-(9/18/09 13:26:26)
// Modified Method(s) : 
//M_SearchDefElement
//  `Additions to include search for word or phrase in Element comments- and a missing check
//  ` for the elementCat based search.
//SRC_ResetForm 
//G_DeficientElmtQuery
//  `Additions to include search for word or phrase in Element comments
// Modified Forms and method: 
//[Dialogs];"Search Def Element"
//  `Additions to include search for word or phrase in Element comments

// **********  ` Modified by: costasmanousakis-(Designer)-(9/28/09 12:17:33)
// Modified Object Methods : 
//[PRJ_ProjectDetails];"ProjectDetails.i".PRJ_BridgeSection_atxt
//  `  don't make change if text selected is "select..." or ""
