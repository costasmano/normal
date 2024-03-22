//%attributes = {"invisible":true}
// Modified by: costasmanousakis-(Designer)-(4/19/2006 14:13:25)
//All related changes and new project methods done to fix the issue of
//loging using the LNK method of changes to the DBIE/UOE and Teamleader
//in Inspections (above and Dive).
// Modified Method(s) : 
//Duplicate_Inspection
//  `Made sure DBengr and Teamleader are zeroed out when copying both for 
//  `[Inspection] and [BMS Inspection] record.
//G_AddPontisToCombined
//  `Made LNK changes. Also made sure the Copy Elements button was enabled at the end.

//In the process, the location/size in objects on some of the input forms (dive and Above)
//were adjusted for consistancy, and appearance was set to Auto.

//Also the saving of UW inspections was modified and new methods were created.

//All UW input forms use the same project method as a form method INSP_UWInputForm_FM.

//A new method INSP_BuildTmMbrArea was created and used in other methods to build 
//the team member list on the input forms at Load.

//*******
//Following NOT recorded ::
//Search thru the DB for calls to Current Date and replaced all occurancies with
//Current Date(*) and Current Time(*). 
//Also replaced Current Date+◊hDiff , Current Time + ◊tDiff with 
//Current Date(*), Current Time(*)
//********

// Modified by: costasmanousakis-(Designer)-(6/20/2006 15:59:22)
// Modified Method(s) : 
//G_Insp_SetPersUI 
//G_AddPontisToCombined 
//INSP_aDiveMaster_OM 
//INSP_UWSaveInsp
//  `Added the checks required to avoid using LogLink before the required version.