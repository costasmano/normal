//%attributes = {"invisible":true}
//Method: Mods_2020_07
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 07/02/20, 13:37:23
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07
End if 
//
//Begin change Continue to replace current user=Designer to select Listbox or not
//Modified by: CJ (7/2/20 13:55:42)
//P_ListContractMaintenance
//P_ListWorkHours 
//SCPOA_ListPOAs
//End change Continue to replace current user=Designer to select Listbox or not

//Begin change continue replace of old output forms with list boxes
//P_ListBridgeDesign 
//[Bridge Design];"View Bridge Design_LB"

//P_ListMissingConsNames
//[Conslt Address];"Match_LB"

//P_ReviewChanges
//[Activity Log];"Output_LB"
//Method: [Activity Log].Output_LB

//P_ListContracts 
//[Contracts];"Contracts_LB"
//LB_ListContracts

//P_ListConsultantNames 
//[Conslt_Name];"Conslt_Name_LB"

//P_ListConsAddress
//[Conslt Address];"View Conslt Address_LB"
//End change continue replace of old output forms with list boxes

//Begin Make sure that the input form opens with correct size
//[Work_Estimate];"Input"
//Method: Form Method: Input
//End Make sure that the input form opens with correct size

//Modified by: CJ (7/7/20 16:23:23)


//Skipped per Costas
//P_ListMissingConsNames 
//P_ReviewChanges 
//P_LoadBINSelection 
//P_ReviewBridges 
//P_ListContracts 
//P_ListConsultantNames 

//does not seem to be used
//DCM_OPENList
//G_DisplayTable_generic 
//G_ListTable 
//GModSelection 
//LSS_CheckForDuplicates 
//MOD_FILE
//End change continue replace of old output forms with list boxes

//**********`Modified by: Costas Manousakis-(Designer)-(7/9/20)
// InitPers
//  `use method INSP_addTeamLeaders to add to the list of TL members for Inventory photo inspections  

//**********`Modified by: Costas Manousakis-(Designer)-(7/10/20)
// [InventoryPhotoInsp];"ReviewDialog"
//  `Deleted page 2 - will not ask designer to choose LB or not;
//  `changed form type to "None" and set Vert marg to 0

// P_INV_Review
//  `Added Initializing review message

//**********`Modified by: Costas Manousakis-(Designer)-(7/15/20)
// ut_TestServerStructureName
//  `added use of Method called on error
// ut_SQLDownloadNewRecords
//  `unchecked method property "Ececute on Server" - does not work in case of Client.
// M_Exec Transfer
//  `removed Alert when launching normal

//```
//```    **** End of Release 7.3.0 17-Jul-2020
//```



//Begin Work on Movement and Storage of signed inpsection reports
//Compiler_Bridge
//End Mods_2020_07