//%attributes = {"invisible":true}
//Method: Mods_2017_02
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/17, 12:40:52
	// ----------------------------------------------------
	//Created : 
	Mods_2017_02
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2/1/17)
// Created Method(s) : 
//Method: NTI_GetMyPending
//Description
//  ` Make a selection of [TIN_Inspections] for the pending list

//**********`Modified by: Costas Manousakis-(Designer)-(2/2/17)
// Modified Method(s) : 
//Method: ut_LoadServerProcessRecords
//  `unload records at the end
//Method: ut_LoadPrefRecord
//  `added unload record at the end and set ro at start

//Method: NTI_ListPendingTINInsp
//  `use new method NTI_GetMyPending

//Method: NTI_OpenInspection
//  `add code to load corresponding [NTI_TunnelInfo] record when in  RO mode

// Modified Object Methods : 
//Object Method: [TIN_Inspections];"ReviewList".bQuery 
//  `restrict QUERY to "TunnelEngineer" only
//Object Method: [TIN_Inspections];"ReviewList".bShowAll (Refresh button)
//  `use NTI_GetMyPending

//**********`Modified by: Costas Manousakis-(Designer)-(2/3/17)
// Modified Method(s) : 
// MacroUtils
//  `added NewName@  so that it formats the form method and object methdod; 
//  `adjusted CompilerDecl to use wildcard to pass the method name from the macro -
//  ` sample call is  :<text><method>MacroUtils("CompilerDecl"+"<method_name/>")</method></text>
//  `added ModComments@  to put the current text with the method name in pasteboard so that it can be copied into a Mods_ method; 


//```
//```   **** End of Release 6.6.4.d 06-Feb-2017
//```


//**********`Modified by: Costas Manousakis-(Designer)-(2/10/17)
// Modified Method(s) : 
// SIA_BridgeInpNavCTRL
//  `moved the def of table ptr and form name outside the If ($EditRRInfo_b)  in case =9 or =10

//**********`Modified by: Costas Manousakis-(Designer)-(2/22/17)
// Modified Method(s) : 
//G_ListTable
//  //Add the table name in the window title

//Modified by: Chuck Miller (2/28/17 16:59:14)

//ut_CompareIndexes //This method will compare indexed fields between local and remote dbs and report differences - you can choose to skip uuids or not

//Changes made to clone stuff especially when relating to creating new data file
//sql_FillLimitArrays 
//SQL_ControlClone 
//sql_CloneRemoveElement 
//SQL_CloneInspectionRelated 
//SQL_CloneElementSafety 
//SQL_CloneDive 
//Compiler_CNV 
//Compiler_clone 
//clone_Table 
//clone_ReturnUniqueKeys 
//clone_GetBlobs
//Method: Form Method: CloneTables
//SQL_CreateNewDB
//ut_ControlClone - I do not think this one is used any longer
//clone_ControlClone
//remove code that deletes user name and password form startup
//Startup 


//**********`Modified by: Costas Manousakis-(Designer)-(2/28/17)
// Modified Method(s) : 
//SET_Item70 
//  `Added case for 63 = D, E, or F - also  64 coded as RF

// Created Method(s) : 
//Temp_CheckPersonnel
//  ` Check the cross ref between external server or dist server and Boston
//  ` verifies if the records on first server match records on second server
//Method: TEMP_SavePersonnelLoginInfo
//Description
//  ` save the logininfo from field [Personnel]MachineName_txt
//  ` before loading should run method Temp_CheckPersonnel to verify that the ID matching is OK


//End Mods_2017_02