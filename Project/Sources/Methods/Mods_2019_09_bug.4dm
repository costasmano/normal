//%attributes = {"invisible":true}
//Method: Mods_2019_09_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/22/19, 11:48:21
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09_bug
End if 
//

//Modified by: Chuck Miller (9/5/19 16:10:37)
//Bring in new sql stuff - CallReference #657
//ut_PRJRetrieveVendorID 
//ut_PRJRetrieveProjTypes 
//ut_PRJRetrieveProjectFileData 
//ut_PRJRetrieveProjectEvents 
//ut_PRJRetrievePRJxrefs 
//ut_PRJRetrievePRJ_Bridge 
//ut_PRJRetrieveOffice_EstAndOpen 
//ut_PRJRetrieveModifiedProjects 
//ut_PRJRetrieveDesignContracts 
//ut_PRJRetrieveDCAmounts 
//ut_PRJRetrieveCPName 
//ut_PRJRetrieveCPAmounts 
//ut_PRJRetrieveConstructionCont 
//ut_PRJRetrieveAttributes 
//ut_PRJRetrieveAEData 
//ut_PRJRetrieveAdDate 
//ut_PRJNewFiscal 
//ut_PRJGetCPAmounts 
//ut_PRJGetAEData 
//ut_PRJCtrlRetrieveProjectData 
//ut_PRJCntrlRetrieveOfAmounts 
//SQL_ReturnErrorDescriptions 
//SQL_ERROR 
//SQL_Direct_ReturnArrays 
//SQL_Direct 
//SQL_Connect_New 
//PRJ_ReturnFileNumber 
//Compiler_SQL 
//Compiler_PRJ 


//**********`Modified by: Costas Manousakis-(Designer)-(9/20/19)
// [Bridge MHD NBIS];"BDEPT Input".Save
//  `added more checks on BDEPT entry

//**********`Modified by: Costas Manousakis-(Designer)-(9/23/19)
// [Bridge MHD NBIS];"BDEPT Input".TownNames
//  `enabled on mouse enter event; skip assigning the inspection responsibility;
//make changes to BDEPT only if it is blank or has only the townpart
// [Bridge MHD NBIS];"BDEPT Input".BDEPT
//  `check for valid Town code; or if not enough characters entered; don't assign inspection responsibility
// [Bridge MHD NBIS];"BDEPT Input"
//  `changed font of Town listbox; small size and location adjustment in the reference bridge dropdown 

//**********`Modified by: Costas Manousakis-(Designer)-(9/24/19)
// HI_CalcBridgeHI
//  `Fix calculation of HI : use the NBE or CoRE depending on the inspection date - CallReference #660
//  `For NBEs , if there is no total value stored in the [BMS Inspections] table, do a calculation based
//  `on table [PON_ELEM_INSP] ;  Set all tables to RO

// HI_CalcBridgeHIFields
//  `log changes to the H.I. fields - CallReference #660
//  `All other tables except [bridge mhd nbis] set to RO; check if the Bridge record is loaded for write
//  `unload the last record

// PON_ExportFHWANBE
//  `moved to the end the clearing of the blob variables

// utf_ConnectedToBoston_b
//  `dev structure files start with "v_" and end with "MHD BMS"

//End Mods_2019_09_bug