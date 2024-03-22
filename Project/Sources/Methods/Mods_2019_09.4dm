//%attributes = {"invisible":true}
//Method: Mods_2019_09
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 09/05/19, 13:09:37
	// ----------------------------------------------------
	//Created : 
	Mods_2019_09
End if 
//
//Moved New sql stuff to BUG Fix
//Bring in new sql stuff
//ut_SQLSelectForLoad 
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

//Add code to check and make sure all data is filled before enabling the save button
//Modified by: Chuck Miller (9/17/19 11:50:29)
//[Bridge MHD NBIS];"BDEPT INPUT"
// FORM METHOD [Bridge MHD NBIS];"BDEPT Input"
//Object Method: [Bridge MHD NBIS].BDEPT Input.aIt8OwnerDes_ 
//Object Method: [Bridge MHD NBIS].BDEPT Input.aTownName_ 
//Object Method: [Bridge MHD NBIS].BDEPT Input.VARIABLE9 - ITEM 8 CATEGORY
//Object Method: [Bridge MHD NBIS].BDEPT Input.BDFEPT
//Object Method: [Bridge MHD NBIS].BDEPT Input.aInspRdes_
//NEW_BinSetSave


//Add new menu option to copy BIN request It replaces button on form
//Modified by: Chuck Miller (9/24/19 13:54:41)
//[Bridge MHD NBIS];"NewNBIS_StackInfo"
//Bridge_ControlCopyBINRquest 
//ControlMenuBar


//Add ability to query bridgle list in any field listed on output form - new variable that does the query
//[Bridge MHD NBIS].NewNBIS_StackInfo
//Bridge_FileBridgeSearchArray
//Compiler_BridgeList
//Method: [Bridge MHD NBIS].NewNBIS_StackInfo.Variable



//Create method to handle resize of windows between out and input forms
//Modified by: Chuck Miller (9/26/19 14:51:05)
//Compiler_Utilities 
//ModSelSort
//P_LoadSelection 
//Method: [Bridge MHD NBIS].NewNBIS_StackInfo.NBISStack_LB


//End Mods_2019_09