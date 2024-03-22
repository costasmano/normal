//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(7/9/09 09:43:44)
// Created Method(s) : 
//SCPOA_ut_UpdateBridgReplPrj
//  ` Update Page 2 of the scour poa, from info in the projects table.
//  ` Get the projects scheduled for the BIN either awarded or scheduled.


//CJM fix blank BDEPTS in [PRJ_ProjectDetailsIncludedBINS] records
//Wrote code ran and deleted
//Modified
//ut_PRJRetrievePRJ_Bridge

// **********  ` Modified by: costasmanousakis-(Designer)-(7/10/09 10:13:03)
// Modified Method(s) : 
//ut_AddOwnerRecs
//  `Added ability to 'copy' records owned by another user after getting a selection of activity Log records.
//  `Also added an execution boolean and predefined the Array of refIDs.

// **********  ` Modified by: costasmanousakis-(Designer)-(7/21/09 14:42:04)
// Modified Forms : 
//[Work_Estimate];"Input"
//  `Adjusted the spacing and size of the salary fields on page 1.
//[Work_Estimate];"Print4"
//  `The TotalFeeRate_x and ConstrTotalFeeRate_x variables were in the wrong spots.

// **********  ` Modified by: costasmanousakis-(Designer)-(7/22/09 13:58:28)
// Modified Form 
//[ScourPOA];"Print" : 
//  `Added "2." to the Scour Vulnerability label

//r001 `07/23/09, 10:38:05   `Add call to AE to retrieve additional [PRJ_ConstructionProject] data
//New fields in table [PRJ_ConstructionProject]
//CP_AEData_blb-blob
//CP_AEDescription_txt-text
//CP_AELocation_s string 41 characters
//New methods
//ut_PRJGetAEData
//ut_PRJRetrieveAEData
//Modified methods
//SQL_FillBuiltStatements
//ut_PRJCtrlRetrieveProjectData
//SQL_ClearArrays

//r002 `07/23/09, 13:19:50   `Add code to automatically quit all clients

//Server_LogOffAllUsers
//ut_AutoQuit
//M_Quit 
//Shutdown 

//r003 `07/27/09, 10:27:50   `Fix errors when SQL calls fail
//ut_PRJRetrieveConstructionCont 
//ut_PRJRetrieveCPName 
//ut_PRJRetrieveDesignContracts 
//ut_PRJRetrieveModifiedProjects 
//ut_PRJRetrieveDCAmounts 
//ut_PRJRetrieveProjectFileData 
//ut_PRJRetrieveAttributes 
//ut_PRJRetrievePRJxrefs 
//ut_PRJRetrievePRJ_Bridge 
//ut_PRJGetAEData 
//ut_PRJRetrieveAdDate 
//ut_PRJRetrieveOffice_EstAndOpen this method not used any longer
