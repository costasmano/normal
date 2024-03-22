//%attributes = {"invisible":true}
//Method: Mods_2020_07_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/06/20, 18:16:27
	// ----------------------------------------------------
	//Created : 
	Mods_2020_07_bug
End if 
//

// LSS_GetImages
//  `Set Auto relations to false before sorting - 
//  `[inventory] record was getting 'lost' from the order by formula when in the Review screen
//  `Call Reference #723

// P_LoadBINSelection
// Fix bug where modify selection still being used. It should have been dialog
//Also changed to use ut_OpenNewWindow so we can add a close box

// P_ReviewBridges
// Fix bug where modify selection still being used. It should have been dialog
//Also changed to use ut_OpenNewWindow so we can add a close box

// [Bridge MHD NBIS];"RAIL_SIA_Input"
//  `Replaced 263K lalbels and ratings on page 7 with HSP-46 data
// [Bridge MHD NBIS];"RailTransitSIA"
//  `Replaced 263K lalbels and ratings on page 7 with HSP-46 data

// SIA_RRVariableUtil
//  `added call to PushAllChanges before saving the [RailBridgeInfo] record

//**********`Modified by: Costas Manousakis-(Designer)-(7/10/20)
// NegotiatedDataToAssignmnt
//  `moved $columns_atxt{2}:=f_TrimStr inside if(Size of array($columns_atxt)>1)

//```
//```    **** End of Release 7.3.0 10-Jul-2020
//```

//**********`Modified by: Costas Manousakis-(Designer)-(7/20/20)
// ut_SQLTellServerGrp_2
//  `check if datatype in blob is same as the current data type of the field - use the current data type, 
//  `if different, to define the variable used for the sql transfer. this works only for numeric types.
//  `Call Reference #729

// SHORT_MESSAGE
//  `Use window type 0 always so it does not block other messages. Fix for Call Reference #730

//```
//```    **** End of Release 7.3.0.a 20-Jul-2020
//```


//**********`Modified by: Costas Manousakis-(Designer)-(7/21/20)
// Launch_CtrlClientProc
//  `changed stack size to 0 (use default) Call Reference #732, #731
// ControlClientProcess
//  `changed stack size of new processes created to 0 (use default) Call Reference #732, #731
// ut_SetUpBridgeInfoLinkTable
//  `changed <>LStackSize to match the one in INIT_UI_GV

//Method: Temp_FixRatingReportVeh
//Description
// temporary fix for records in table [RatingReportVehicles]
// Will log a deletion of the old id, assign new record ids to the current records in the table 
// and log the creation of a new record.
// this is from the roll-out of v7.3.0 where there was a table added and then deleted in the
// dev structure, but not in the production (bug fix) structure up to ver 7.2.1.x
// the rating vehicle tables were added (#190. 191) , but when v 7.3.0 opened the 7.2.1 data file
// the data in the tables was not accessible. 
// Call Reference #733

//```
//```    **** End of Release 7.3.0.b 24-Jul-2020
//```

//**********`Modified by: Costas Manousakis-(Designer)-(7/27/20)
// ControlClientProcess
//  `changed the Delay process for $DelayTime_r to a For loop by dividing $DelayTime_r by 600 (10 sec)
//  `one more try to address Call Reference #732, #731

// ut_DelayDBSynch
//  `added IDLE after each delay process command
//  `use system parameter DELAYDBSYNCPARAM for testing purposes compiled

// NegotiatedDataToAssignmnt
//  `moved $columns_atxt{2}:=f_TrimStr at the start of the if() statement. Call Reference #735

//```
//```    **** End of Release 7.3.0.c 27-Jul-2020
//```

//**********`Modified by: Costas Manousakis-(Designer)-(7/29/20)
// ut_SelectFieldNum
//  `use Field Titles set by SET FIELD TITLES for the field name, if found.

// ut_ReturnWindowsMountInfo
//  `check if the server name in $1 has "." in it. in that case and if not found from the 
//  `NET USE output, check using the first part ex mhd-shared.massdot.trans.internal -> mhd-shared



//End Mods_2020_07_bug