//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/18/05, 11:05:53
	// ----------------------------------------------------
	// Method: Mods_2005_CM15
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	
End if 

// Modified by: costasmanousakis-(Designer)-(8/11/05 11:15:33)
// Modified Table : 
//[Personnel]
//  `Indexed fields :
//  `[Personnel]Employer;[Personnel]First Name;[Personnel]Last Name;[Personnel]Middle Name;
//  `[Personnel]Active;[Personnel]DiveTeam;[Personnel]Division No .

// Modified by: costasmanousakis-(Designer)-(8/18/05 11:06:04)
// Modified Object Methods : 
//[Bridge MHD NBIS];"CombinedInspections".bDuplicate
//  `Allow Designer to copy any inspection (approved or not)
//  `Added return value for Open window command.
// Modified Methods : 
//Duplicate_Inspection
//  `Allow Designer to make copy of an inspection as it is without modifying any values and
//  `keeping team member list as is.
//  `Changed method of recording changes to [BMS Inspections] table making it same as [Inspections]
//  `table.

// Modified by: costasmanousakis-(Designer)-(8/19/05 12:18:15)
// Modified Object Methods : 
//[Combined Inspections];"Input"`CombDelButton
//  `Added deletion of NBI inspection also.

// Modified Methods : 
//G_InspInfo
//  `Added listing of IDs of Combined and Pontis inspection records.

// Modified Forms : 
//[Dialogs];"RecordInfo"
//  `Added margins, changed size an location of items displayed.

// Modified Forms : 
//[Dialogs];"ReSendActLog"
//  `Added entry for combined inspection ID.

// Modified Methods : 
//ReSendLogEntries
//  `Modified to allow Combined inspection IDs and allow to do in one shot, Combined Insp records,
//  `Nbi Inspection and Pontis inspection records.

// Modified by: costasmanousakis-(Designer)-(8/22/05 08:55:17)
// Modified Methods : 
//ExprtImprtDlog
//  `Added check to make sure pFile is a pointer and points at least points to table [Bridge MHD NBIS];
//  `Create a resizable window for the export dialog.

// Modified Forms : 
//[zDialogs];"ExportImport"
//  `Changed appearance to MacTheme; Allowed form to be resizable; 
//  `Moved Esc,UpAr, DnArr, Rtn buttons to top and made them hidden;
//  `Cleaned up/re-sized some objects for better look; Re-Set shortcuts for hidden buttons;

// Modified Form Methods : 
//[zDialogs];"ExportImport"
//  `Add code on load to disable the 'OK' button,

// Modified by: costasmanousakis-(Designer)-(8/23/05 12:42:58)
// Modified Methods : 
//GetKey 
//  `Changed call to command Undefined(Keycode) to Type(Keycode)=is undefined
//G_WRT_GenericBridgeLetter
//ut_CheckCombines
//G_WRT_MakeDocument
//  `Added two single char string parameters to call to AP ShellExecute 
//  `to avoid Compilation warnings.

// Modified by: costasmanousakis-(Designer)-(8/23/05 16:10:19)
// Created Methods : 
//G_Insp_FmtBDEPT_P_107 
//G_Insp_FmtBDEPT_P_86
//  `To do formatting for Bridge Department text in inspection forms.

// Modified Forms : 
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"Culvert Pr Pg 2"
//[Inspections];"Damage Pg1"
//[Inspections];"Dive Pr  LowCl Pg1"
//[Inspections];"Dive Pr Pg 1"
//[Inspections];"Dive Pr Pg 2 wrt"
//[Inspections];"Dive Special Pr Pg 1"
//[Inspections];"DivePg1 Blank"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Routine Pr Pg 2"
//[Inspections];"SpecialExtra"
//[Standard Photos];"PrintPhoto"
//[Standard Photos];"PrintPhotoPortrait"
//[Standard Photos];"PrintPhotoSingle"
//  `Replaced sBDEPT object with sBDEPT_P object with calls to methods to do the
//  `formating for multi-town bridge numbers.

// Modified Form Methods : 
//[Inspections];"Closed Insp Pg1"
//[Inspections];"Culvert Pr Pg 1"
//[Inspections];"Culvert Pr Pg 2"
//[Inspections];"Damage Pg1"
//[Inspections];"Dive Pr  LowCl Pg1"
//[Inspections];"Dive Pr Pg 1"
//[Inspections];"Dive Pr Pg 2 wrt"
//[Inspections];"Dive Special Pr Pg 1"
//[Inspections];"DivePg1 Blank"
//[Inspections];"FC Pr (Pg 1)"
//[Inspections];"Routine Arch Pr Pg 1"
//[Inspections];"Routine Pr Pg 1"
//[Inspections];"Routine Pr Pg 2"
//[Inspections];"SpecialExtra"
//  `Removed statements that format the bridge department number.

// Deleted Form Methods : 
//[Standard Photos];"PrintPhoto"
//[Standard Photos];"PrintPhotoPortrait"
//[Standard Photos];"PrintPhotoSingle"
//  `Became empty since removed statements that format the 
//  `bridge department number.

// Modified Methods : 
//G_InitInspVars 
//  `Added sBDEPT_P variable.
//PRINT_Critical 
//PRINT_Damage 
//Print_Dive_F 
//PRINT_Closed
//  `Removed declarations of sBDEPT,sTown,sInspDate since they are in G_InitInspVars.

// Modified by: costasmanousakis-(Designer)-(8/24/05 08:41:45)
// Created Object Methods : 
//[Standard Photos];"PrintPhotoLand".sBDEPT
//  `To Adjust font size for townline bridges with more than 2 BDEPT numbers.


// Modified by: costasmanousakis-(Designer)-(8/24/05 11:23:38)
// Created Method : 
//G_Insp_FmtSTOWN 
//  `Change font size of sTOWN object in print forms.

// Created Object Methods : 
//[Inspection];"@" ALL print forms where the sTOWN is used
//[Standard Photos];"@" all Print forms where the sTOWN is used
//  `Added either in Form methods or .sTown object methods call to G_Insp_FmtSTOWN;
//  `Adjusted size of sTown object for more consistancy across forms.