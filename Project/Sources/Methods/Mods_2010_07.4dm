//%attributes = {"invisible":true}
// **********  ` Modified by: costasmanousakis-(Designer)-(7/21/10 11:09:26)
// Modified Forms : 
//[Dialogs];"User_group_list"
//  `Added "Load File" and "Export" and  "SaveOnServer" buttons 

// Modified Method(s) : 
//Temp_ExportUGroups
//  `Additions in the exporting of the users and groups to a text file;
//  `Additon of loading users and groups from a 4DUG type file
//  `Also added call to execute on server method ut_SaveUsersAndGroups:
//ut_addGroupMembers
//  `Use Append to array instead of insert element, etc.

// **********  ` Modified by: costasmanousakis-(Designer)-(7/23/10 08:28:12)
// Modified Method(s) : 
//ut_LoadUsersAndGroups 
//  `Add confirm message to avoid loading users and groups that are too old, 
// `  ie. in case of a server crash where the last users and groups were not saved.

//ut_executeMethod 
//  `Added optional parameters and better handling of executing on server - to serve as a generic execute method.
// Parameters
// $1 (Optional) : $methodname
// $2 (Optional) : ("S" | anything or blank ) "S" indicates execute on server
// $3-9 (Optional) : text parameters for the method 

// Modified Forms : 
//[Inspections];"FreezeThaw"
//  `Added the Info Button on the second page

// Modified Forms and form method : 
//[Activity Log];"Print"
//  `Replaced Parent ID and Local ID fields with text vars that combine them with the Destination ones.

// **********  ` Modified by: costasmanousakis-(Designer)-(7/26/10 13:30:37)
// Created Method(s) : 
//ut_GenerateInspVarCompiler
//  ` Generate a text file with compiler directives for all Inspection variables. based on
//  ` the records in [ElementDict] and a count of variables in the print forms for damage, FC, special member 
//  `inspections

//COMPILER_InspElmtVars
//  `Method containing var defs for all Element variables used in Inspection forms which are based on the
//  ` Element number.
//  `  See method ut_GenerateInspVarCompiler for generation of the code

//G_InitInspVars 
//  `Replaced a lot of declarations with a call to COMPILER_InspElmtVars