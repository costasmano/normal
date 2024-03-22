//%attributes = {"invisible":true}
//Method: Mods_2023_04
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Apr 6, 2023, 12:56:10
	// ----------------------------------------------------
	
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2023-04-06)
// ut_AddOwnerRecs
//  `replace creating records one at a time with using Array to selection

// PERS_GetName
//  `use ds.Personell.query instead of SQL

// [Personnel];"Inspectors Out_LB".QRPrintButton
//  `set table to Read only - running a Quick report left the last record locked

//**********`Modified by: Costas Manousakis-(Designer)-(2023-04-07)
// ArchiveLogFile
// ControlClientProcess
// clone_LoadRecord
// ut_AssignNextNumber
//  `removed IDLE 

// INSP_PrintToPDF
//  `Removed IDLe before calls to Delay process

// SIA_SelectAvailableBIN
// Server_LogOffUsers
// PRJ_BridgesEntry
// LSS_CheckForSave
// SQL_CloneDive
// SQL_ControlClone
// ut_DelayDBSynch
//  `Removed IDLE after delay process

// SQL_CreateNewDB
// Server_QuitServer
// ut_LoadRecord
//  `Remove IDLE before Delay process

// ut_LoadRecordInteractive
//  `use only one delay process command instead of two

// NTI_ExportFHWANTE
//  `replaced old progress with new 

// Inc_Sequence
//  `use tickcount parament in Semaphore-Use IDLE as shown in https://doc.4d.com/4Dv18/4D/18.4/Semaphore.301-5233674.en.html
//  // Removed IDLE from other places
// QR_ArchiveFunction
//  `use tickcount parameter in semaphore; remove other IDLE commands


//**********`Modified by: Costas Manousakis-(Designer)-(2023-04-10)
// QR_GetBridgeStairsInfo
//  `Replace SQL with ds query

// [Personnel];"Inspectors In"
//  `replaced inspection member info with a collection based listbox

// Bridge_ControlCopyBINRquest
//  `set table to Read only and re-set at the end.


//```
//```    **** End of changes before submittal to 4D group for upgrade/conversion to v19
//```


//**********`Modified by: Costas Manousakis-(Designer)-(2023-04-14)
// PON_SendNBEtoBrM
//  `Added use of parameter PON_BRMODBCName to define the ODBC name
// PON_SendNBItoBrM
//  `Added use of parameter PON_BRMODBCName to define the ODBC name

//End Mods_2023_04   