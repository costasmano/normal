//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(11/3/09 13:32:26)
// Modified List : 
//"Item8 Owner"
//  `Added DOT =  Mass. Department of Transportation

// Modified Method(s) : 

//G_InitInspVars
//  `MassDOT change on vsInspDepartment
//  `Added INSP_Item8_s var and adjust it according to inspection date

//INV_PrintInvInsp
//  `Added INSP_Item8_s var and adjust it according to inspection date

// Modified Forms : 
//  `All [Inspections] [Standard Photos] [InventoryPhotoInsp] forms that had the [Bridge MHD NBIS]item8
//  `field on them, got replaced with the new variabe INSP_Item8_s

// Modified Forms : 
//[Bridge MHD NBIS];"MHD Specific Items"
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//  `Added the field [Bridge MHD NBIS]LegacyOwner on the printed page
//[Bridge MHD NBIS];"SI & A Input"
//  `Added the field [Bridge MHD NBIS]LegacyOwner on the last page

// Modified Table(s) : 
//[Bridge MHD NBIS]
//  `Added field [Bridge MHD NBIS]InspRequired boolean, hidden, future use

// **********  ` Modified by: costasmanousakis-(Designer)-(11/10/09 08:47:07)
// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//  `Lock some buttons for DUM and REM bridges

// **********  ` Modified by: costasmanousakis-(Designer)-(11/12/09 14:39:28)
// Modified Object Methods : 
//[Bridge MHD NBIS];"BDEPT Input".PRJ_DEDBridgeNo_s
//  `Added handling of special case when there is not an existing project with the BDEPT
//  `being replaced. To avoid making replacement BINs - set the toggle to New bridge

// **********  ` Modified by: costasmanousakis-(Designer)-(11/18/09 12:24:51)
// Modified Method(s) : 
//G_SecureInspection
//  `Added Alerts when entering in readonly mode incomplete/not approved inspections.
// Modified Form Methods : 
//[Inspections];"BlankCombinedStarter"
//  `Added user group InspectionAllAccess to allow access to all inspections.
//  `Per request of S.Eslinger

// **********  ` Modified by: costasmanousakis-(Designer)-(11/19/09 09:28:03)
// Created Method(s) : 
//QR_PersonName
//  ` Return the name of the person passed in parameter 1 as the personID

// **********  ` Modified by: costasmanousakis-(Designer)-(11/20/09 11:46:48)
// Modified Method(s) : 
//PRJ_GetSelectedProjectFiles
//  `If the number of digits in the proj file is 6, then the upper is same as lower
//  `Compare file numbers LESS than the upper, not LESS OR EQUAL

// **********  ` Modified by: costasmanousakis-(Designer)-(11/24/09 16:09:49)
// Modified Method(s) : 
//f_BrgStatus_PCT
//  `Changed all variables to Longints

// **********  ` Modified by: costasmanousakis-(Designer)-(11/30/09 12:32:15)
// Modified Method(s) : 

//ModSelSort
//  `added 3rd pair of search variables
//P_MDC 
//  `Search for legacy owner too

// Created Method(s) : 
//SCPOA_MonitorChecks
//  ` Handle the Flood monitor check marks in the summary
//SCPOA_ImplementedChk
//  ` Handle the check boxes for the Implemented part in the Flood monitoring plan summary

// **********  ` Modified by: costasmanousakis-(Designer)-(12/1/09 14:32:46)
// Modified Method(s) : 
//BRG_RWAccess
//  `fixed the MDC security
// Modified Form Methods : 
//[Bridge MHD NBIS];"Bridge Input"
//  `fixed the MDC security

// **********  ` Modified by: costasmanousakis-(Designer)-(12/2/09 09:12:16)
// Modified Method(s) : 
//G_DeleteInspection
//  `Fixed the delete prompt to get the correct user name
