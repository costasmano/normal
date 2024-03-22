//%attributes = {"invisible":true}
//Method: Mods_2022_11
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	// ----------------------------------------------------
	
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2022-11-09)
//Method: USR_GeneratePassword
//Description
// generate a password for a user
// Parameters
// $0 : $password_
// $1 : $params_o
//     .firstname
//     .lastname
// ----------------------------------------------------

//Method: [Personnel];"Inspectors In".ToolsButton
//Description
//New button to launch menu with tools

//**********`Modified by: Costas Manousakis-(Designer)-(2022-11-10)
//Method: PERS_ShowMemberships
//Description
// update arrays/collections used to display memberships.
// executed in context of the input form for [Personnel]
// Parameters
// $1  : $Option : "Expand" | "Collapse"
// ----------------------------------------------------

//**********`Modified by: Costas Manousakis-(Designer)-(2022-11-15)
// ut_TestUser
//  `use local arrays for people and people id so we can display employer and whether user is active
//  `only get people who have a 4d user id

//**********`Modified by: Costas Manousakis-(Designer)-(2022-11-21)
//Method: SRV_ServerLogRecording
//Description
// Execute tasks to handle server log reocrding tasks
// Meant to be executed on server using "Execute on server"
// Can use system parameter "SRV_LOGLimitation" as a parameter to Circular log limitation
// Parameters
// `$1 : $Task
//  // "START" | "STOP" | "CLEARLOG"

// On Startup
//  `load 4DPop only for Design Access users and move after call to Startup

// "Connect_d"
//  `changed IP address retrieve from system parameter CLONE_SERVERIP default "146.243.128.4:19812"

// clone_ControlClone
//  `added progress bars before login dialog and after.

//Method: PERS_GetName
//Description
// Return the name of a person from personnel table.
// Can specify a format.  Method can be used in a quick report
// Parameters
// $0 : $Pname
// $1 : $PersID_L
// $2 : $Format (optional)
//  // format can be a combination of codes FN, LN, MI, FI, LI , PRE, SUF
//  // (first name, last name, middle initial, First initial, last initial, Prefix, Suffix)
//  // ex "LN, FI"  or "PREFN MI. LN"  - default is "FN LN"
//  // For the PREfix ,if there is one, a space will be addded after the prefix.

//**********`Modified by: Costas Manousakis-(Designer)-(2022-11-25)
//Method: SRV_RetrieveLogFromServer
//Description
// retrieve a selected logfile zipped from server.
// execute on server attribute
// Parameters
// $0 : $Zippedfile_x : blob packed with the status, messages and zipped log file
// $1 : $LogFilePattern_txt : pattern of log file names - default "4DRequestsLog_@"

//Method: SRV_SaveziplogfileToLocal
//Description
// Call on server to zip a set of files in the logs folder matching a pattern,
// and return the zip file.  Then this file is saved in a local folder.

//Method: SRV_GetListOfLogsFromServer
//Description
// get the list of files in the logs folder on the server
// Parameters
// $0 : $List_object
//     .files : collection of files

//Method: SRV_DisplayFilesinLogsonServer
//Description
// display the list of files in the logs folder on the server

// SFA_GetAvailRatingRpts
//  `changes to work with new results from ut_isSharedFolderMounted on mac and use Posix file path from document list

//**********`Modified by: Costas Manousakis-(Designer)-(2022-11-28)
// [Parameters];"Output_LB"
//  `Uncheck the 'Hide blank lines' property of the listbox under Background and Border

// Server_ProcessStatus
//  `use parameters MAIL_BRGSTATFROM and MAIL_TRANSFCHKLIST for email from: and to:
//  `added machine name in the text.

//Method: [SQL_Connections].SQL_Connnectsions_LB
//Description
// New form for SQL parameters using Listbox

//End Mods_2022_11   