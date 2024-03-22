//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(10/26/2005 11:50:56)

// Modified Table : 
//[Status Report]
//  `Added Fields Real for Health Index by State/Town/Agency/District/Road Category.

// Modified Methods : 
//P_CondRep 
//P_OutofFreqRep 
//  `Use menubar 3 and Plain Window

// Modified Forms : 
//[Status Report];"O_StatusReport"
//  `Assign menu bar 3 and make active
//[Status Report];"I_StatusReport"
//  `Added page for Health Index fields.
//[Status Report];"P_StatusReport_HI"
//  `Modified Old print form to include Health Indexes.

// Modified Methods : 
//GenerateCondRep 
//  `Added code to calculate Health index values for the current report.

// Created Methods : 
//Temp_SetCondRepHIFlds
//  `Initialize HI fields in table [Status Report]
//G_PickFromList
//  `Select from a long list
//HI_CalcBridgeHI 
//  `Calculate individual bridge HI values
//HI_CalcBridgeHIFields 
//  `Loop through a selection of bridges to calculate HI values.
//HI_CalcElemUnitCost 
//  `Determine Element cost.
//HI_CalcElmtHI 
//  `Calculate the Element HI state.
//HI_CalcHI_Function 
//  `Do the CEV/TEV calculation setting to -1 if TEV=0
//HI_LoadElementCosts 
//  `To do health Index calculations.

// Created Forms : 
//[Dialogs];"SelectFromList"

// Modified Table : 
//[Personnel]
//  `Added field [Personnel]UserID_4D to keep the 4D User ID for the user.

// Modified Forms : 
//[Personnel];"Inspectors In"
//  `Added the filed [Personnel]UserID_4D in the form. Made it enterable only for
//  `Designer  or Administrator.

// Modified by: ManousakisC (11/1/2005)
// Modified Methods : 
//prt_substdrep
//  `Added check to stop printing if user cancels after print Settings command.
//  `Added option to print Health Index version or normal print form.

// Modified by: costasmanousakis-(Designer)-(11/2/2005 16:01:50)
// Created Methods : 
//G_GetDirList_Client 
//G_GetDirList_Server 
//G_GetServerDoc_Client 
//G_GetServerDoc_Server 
//  `Methods to get documents stored in the server.

// Modified by: costasmanousakis-(Designer)-(11/3/2005 10:41:51)
// Modified Methods : 
//CheckDependencies
//G_InspGetRatings
//  `Added code to set [RatingsReports] to read only and re-load related [RatingReports] records.

//XDownLoadServer
//  `Modified Query for records on server to include records whose LocalFileID (table they refer to)
//  `is the [Bridge MHD NBIS] table.

// Modified by: costasmanousakis-(Designer)-(11/4/2005 14:58:43)
// Modified Methods : 
//INIT_UI_GV 
//  `Added Global variable ◊CurrentUser_UID.

// Created Methods : 
//utf_GetUserID
//  `Get the ID of the current user

// Modified by: costasmanousakis-(Administrator)-(11/7/2005 11:47:55)
// Modified Methods : 
//Startup
//  `Added Group "ExternalDesigners" to the check for external users.

// Modified Methods : 
//ArchiveLogFile
//  `Removed deleting of Owners of data records while exporting. 
//  `All Deletions are done at the end since ActivityLog-OwnersofData have a Delete many relation.

//CA_fAllowLogins 
//  `Allow users part of BatchOperators to avoid login warnigns.

// Modified by: costasmanousakis-(Designer)-(11/14/05 20:59:34)
// Picture Library
//  `Added Icon OSX Custom Query

// Modified Forms : 
//[Conslt Address];"View Conslt Address"
//[Town Address];"View Town Address"
//[Bridge Design];"View Bridge Design"
//  `Changed buttons to picture buttons using OSX icons from Picture Library; 
//  `Assigned blank menu bar; Assigned shortcuts to buttons

// Modified by: costasmanousakis-(Designer)-(11/15/05 17:54:41)
// Modified Method(s) : 
//G_Insp_SaveContinue 
//G_Insp_SaveInspection 
//  `Added code to make sure a [combined inspections] and, if needed, a [Bms inspections] record in loaded on save,