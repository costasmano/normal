//%attributes = {"invisible":true}
//Method: Mods_2020_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 12/08/20, 13:49:51
	// ----------------------------------------------------
	//Created : 
	Mods_2020_12
End if 
//ut_ResetBlankUUIDS - reset UUIDS if not unique
//PrintListBox// add ability to print selection based list boxes 
//PrintListBoxUsingObject
// Note that to print variable, there must be object method for the column as an example, see
//[PRJ_DesignContracts];"Output_LB", where column 2 is a method PRJ_DesignContractLBReturnName that returns the name
// Modifed to add current method name to ut_UseListBox call
//SCPOA_ListPOAs 
//PRJ_DisplayProjects 
//PRJ_DisplayDesignContr 
//PRJ_DisplayBridgePgm 
//P_ReviewChanges 
//P_ListWorkHours 
//P_ListTownAddress 
//P_ListMissingConsNames 
//P_ListContracts 
//P_ListContractMaintenance 
//P_ListConsultantNames 
//P_ListConsRating 
//P_ListConsInsp 
//P_ListConsAddress 
//P_ListBridgeDesign 
//M_ListDistrMaint

//Update LSS inpsection and import
//to allow regenerate UUIDS
//to allow change of [LSS_Inventory]LSS_InventoryId_s if inventory record doesn't exist
//look at bug fix
//Add activity log stuff?

//Create code to print inspection reports to PDF stored on shared data same directory structuire like Rating reports
//File name BDEPT_BIN_INSPType_INspection Date
//start with regular inspections
//then lss inspections
//TIN inspections
//OPEN PRINTING JOB

//close printing job

//End Mods_2020_12