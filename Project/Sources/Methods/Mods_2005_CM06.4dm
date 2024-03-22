//%attributes = {"invisible":true}
//````````
//Changes on merges from ASL
//`````````
//Modified Method 
//PRINT_ROUTINE_F
//PRINT_CULVERT_F 
//  `Moved last page break before printing pontis.

//DISPL_CUs 
//  `Use query selection instead of relate many.

//Modifed Forms
//[Dialogs];"PrintInspRpt2"
//[Dialogs];"PrintInspRpt"
//  `Changed tab order
//[Cond Units];"Cond Units In"
//  `Removed rectangles, renamed objects to DE@; added splitter.
//[Cond Units];"Cond Units Inc"
//  `Made all object non-enterable.

//Modified Form method
//[Cond Units];"Cond Units In"
//  `Add code to enable/disable enterable objects; added code to cancel when
//  `new record and inspection is locked. Setup_CSs must be BEFORE setting
//  `enterable buttons and fields.
//Modified Object Method
//[Cond Units];"Cond Units In".vElem
//  `Changed the code that fires on Load event.


//Object methods
//[Cond Units];"Cond Units In".vElem
//  `Adjust code for new element case.
//[Inspections];"Routine Combined".aBIE
//[Inspections];"Routine Combined".aAgency
//[Inspections];"Routine Combined".aTeamLeader
//[Inspections];"Routine Combined".InspDate
//[Inspections];"Routine Combined".aBIE

//Modifed Method
//G_Insp_SetPersUI
//  `Adjust for combined inspections. Save [BMS Inspections] when making changes.
//G_InitInspVars 
//  `Replace Relate Many([bridge mhd nbis]) with query([TownLineInfo])
//  `Replaced Code with call to G_SIA_BuildTownLine

//Modified form method
//[Inspections];"BlankCombinedStarter"
//  `Incorporated code changes from [Inspections];"BlankStarter" form method
//  `Fixed the re-setting of the input form to "BlankCombinedStarter"
//  `Added code to load [Combined Inspections] and [BMS Inspections] records.
//  `Added case for "PON" type inspections.
//  `Added code to initialize vblnCombinedInspection variable
//  `Added code to unload BMS and Combined Insp records
//  `Added code to call InitChangeStack method 4 times for each needed stack.

//Modified method
//P_ReviewInspcts
//  `Use form [Inspections];"BlankCombinedStarter" as default input form.
//ADD_COMBINED_INSPECT 
//  `Use pushchange/FlushGrpChgs; Log Agency field for BMS Inspections;
//  `No need to LogChange on [Combined inspections]BIN field;
//  `Use methods G_SIA2Inspection ; G_AddDefInspElmts;
//  `For Non- Routine inspections don't create a pontis inspection record, 
//  `set the BMSInspID to -1
//LogLink 
//  `Cleaned up local variables not used.
//TellServerLNK 
//  `Cleaned up local vars not used; 
//  `Added code to account for case when Link ID is not in the 
//  `[FileIDRes] table
//XGetServerLnk 
//  `Cleaned up local vars not used; 
//  `For OLD field keep only code for Alpha, Integer and LongInteger types.
//XDownLoadServer
//NewTellServer 
//  `Added calls to XGetServerLnk and TellServerLNK.

//Modified Form Methods
//[Activity Log];"Input"
//[Activity Log];"Output"
//[Activity Log];"Print"
//  `Adjusted for LNK activity type.

//Modified Form
//[Activity Log];"Output"
//  `Assigned shortcuts to the buttons on the form;
//  `Set Form properties to resizable vertically.

//Modified Form Methods:
//[Inspections];"Culvert Combined"
//[Inspections];"Routine Combined"
//  `Combine form events on clicked and on close detail.
//  `Invoke RememberCombined after CheckDependencies
//  `Use G_Insp_RelateInsp instead of relate many[Inspections]

//Modified Methods
//Check_DupCU 
//  `Use Set query Destination instead of Pushing and Poping records.
//COND_UNIT_AFTER 
//  `Cleaned up coding.
//G_Insp_SaveInspection 
//G_Insp_SaveContinue 
//  `Added code to Flush Changes for related [BMS Inspections] and 
//  `[Combined Inspections] record.
//  `Added code to make sure [Combined]Inspdate is in step with
//  `[Inspections]Inspdate field

//Modified Form Method
//[Combined Inspections];"CombinedInc"
//  `Adjusted code that checks for Rtn+Spec Memb inspection to use the 
//  `[Inspections]InspRtnSpcMemFlag field.
//Modified Form
//[Combined Inspections];"CombinedInc"
//  `Adjusted Form Markers.

//Created Method
//G_CopyPontisToCombined 
//  `Methods to copy Cond Units from a previous Pontis inspection.
//G_AddPontisToCombined 
//  `Method to add a Pontis Inspection record to the current inspection.

//Modified Method
//Duplicate_Inspection 
//  `Added Messages to indicate stage and progress during copying.
//DUPLIC_INSP_NEW 
//  `Added param 1 to enable showing progress messages on or off

//Created method
//G_SpellCheckSetup 
//  `To initialize OEM license for GetitRight

//Modified Method
//G_Insp_SaveInspection 
//  `Added code to log date of when Consultant mark inspection as ready.
//  `Add code to save InspRtnSpcMemFlag flag and pushchange for
//  `versions >=5.0
//G_Insp_SaveContinue 
//  `Add code to save InspRtnSpcMemFlag flag and pushchange for
//  `versions >=5.0

//Modified form
//[Dialogs];"Stats"
//  `Allowed Resizing of objects.

//Created Method
//G_CheckCondUnits 
//  `Check completeness of Cond units

//Modified Methods
//G_CheckCulvertInsp 
//G_CheckRoutineInsp 
//  `Added checks for Pontis element Info.

//Modified Form
//[Bridge MHD NBIS];"Bridge Input"
//  `Hid Pontis button-assigned to Alt-Cmd-P;  Rearranged other buttons.

//Modified Forms:
//[Inspections];"Closed Bridge"
//[Inspections];"Critical Member"
//[Inspections];"Culvert Combined"
//[Inspections];"Damage Form"
//[Inspections];"Routine Combined"
//  `Added Horizontal Splitter in Review comments page.

//Modified Object methods:
//[Inspections];"Closed Bridge".Insp Date
//[Inspections];"Critical Member".Insp Date
//[Inspections];"Damage Form".Insp Date
//[Inspections];"Dive Form".Insp Date
//[Inspections];"Dive LowCl".Insp Date
//[Inspections];"Underwater Special Member"
//  `Added code to save date to Combined Inspections record.

//Modified Method
//Startup 
//  `Added call to G_SpellCheckSetup at the end.