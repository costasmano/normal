//%attributes = {"invisible":true}
//Method: Mods_2023_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Mar 13, 2023, 18:10:21
	Mods_2023_03
	// ----------------------------------------------------
	
End if 

//**********`Modified by: Costas Manousakis-(Designer)-(2023-03-06)
//Method: Client_EnableLogsOnClient
//Description
// Enable Logs on client  - meant to be used by execute on client
// or on startup of client
// Parameters
// ----------------------------------------------------
//Method: Client_DisableLogs
//Description
// disable logs on a client - meant to be used by execute on client
// Parameters
// ----------------------------------------------------
//Method: Client_showLogRecordingStatus
//Description
//Show the status of log recording on a client and open the logs folder
// Parameters
// ----------------------------------------------------

//**********`Modified by: Costas Manousakis-(Designer)-(2023-03-07)
//Method: UpdateNBIFromBorderState
//Description
//Update current Bridge record from data from a border state
// Parameters
// $1 : $Text string of an NBI 'tape' line
// $2 : $RecType [optional] ("Primary" | "Secondary")
// ----------------------------------------------------
//Method: ImportNBI_RIDOTdata
//Description
// Import NBI data from RIDOT to update MassDOT records
// Parameters
// ----------------------------------------------------
//Method: ConvertBorderStateNBE
//Description
// Convert an .xml file with NBEs from a Border state to MassDOT
// Parameters

//**********`Modified by: Costas Manousakis-(Designer)-(2023-03-08)

// SFA_GetAvailRatingRpts
//  `clean up code of if(False)
//  `set progress to -1 
//  `added delay process (10) after progress quit , so that progress bar has time to close

//**********`Modified by: Costas Manousakis-(Designer)-(2023-03-13)
//Method: NTI_SplitFHWAexportToINV_NTE
//Description
// method to split the annual FHWA NTI submittal to inventory and NTE files separate.
// Will parse the XML ; find references for all TunnelInstances ;
// for each Tunnelinstance get all "/FHWAElements/FHWAED" elements
// append each element to a new ElementTree
// Remove the "/FHWAElements" element from the parsed document.
// Save the modified parsed xml and the new ElementTree to files
// ----------------------------------------------------

//**********`Modified by: Costas Manousakis-(Designer)-(2023-03-14)
//Method: OB_CopyToSharedCollection
//Description
// copy a collection to a shared collection
// Parameters
// $1:Collection to copy from
// $2:Shared Collection to copy to
// ----------------------------------------------------

//Method: OB_CopyToSharedObject
//Description
// copy an object to a shared object
// Parameters
// $1: Object to copy from
// $2: Shared Object to copy to
// ----------------------------------------------------

// ut_ImportFHWADataToArchive
//  `use ut_StartMessage, ut_Message for messaging - send log to file also 
//  `modified searching for existing records to use BIN instead of item8 for both primary and secondary records.
//  `added confirm whether to update Archive date and FHWARecord field for existing archive records.

//
//End Mods_2023_03   