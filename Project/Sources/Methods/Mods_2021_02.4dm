//%attributes = {"invisible":true}
//Method: Mods_2021_02
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/21, 19:24:58
	// ----------------------------------------------------
	//Created : 
	Mods_2021_02
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2/1/21)
// Modified Form and Form Methods : 
// [Activity Log];"ViewExtras"
//  `Added WP area on page 4 , quick report on page 5, and option to view blob as Text

// ut_ClearFileIDRes
//  `Added message at the end of deletion

//**********`Modified by: Costas Manousakis-(Designer)-(2/19/21)
// LSS_PrintInspection
//  `set units of photo log to inches before settingt the par indents. set paragraph indent to 1inch 
//  `clean up some code. added call to WR SET DOC PROPERTY ($CommentArea_L;wr widow orphan;wr ignored)
//  `we handle the widow paragraphs.
// LSS_NonDamageAddHeader
//  `adjusted spaces before and after printing a header label 2 spaces before , 1 after
//  `adjusted logic of when adding linefeeds before the labels

// Modified Forms : 
//[LSS_Inspection];"ITSStructurePg1"
//[LSS_Inspection];"LightStructurePg1"
//[LSS_Inspection];"SignStructurePg1"
//[LSS_Inspection];"SignStructurePg1v0"
//[LSS_Inspection];"StructureDamage_HS_P1"
//[LSS_Inspection];"StructureDamage_ITS_P1"
//[LSS_Inspection];"StructureDamage_Light_P1"
//[LSS_Inspection];"StructureDamage_TS_P1"
//[LSS_Inspection];"TrafficSignalStructurePg1"
//  //adjusted witdh of ADT YEAR label ; added ˚F to TEMP label ; Added (ft) to ELEVATION label

//**********`Modified by: Costas Manousakis-(Designer)-(2/22/21)
// LSS_CountandPrintDamagePages
//  `don't check for preview error - no need any more 
//  `added ignore on widow orphan for the two WR areas.

//**********`Modified by: Costas Manousakis-(Designer)-(2/23/21)

// ut_ControlUserPrefs
//  `removed alert for design group when setting debug log in standalone app
// LSS_PrintInspection
//  `added G_PrintOptions to correctly pick the Letter paper
// LSS_PrintDamageInspection
//  `added G_PrintOptions to correctly pick the Letter paper
// LSS_AddAddtlCmnts
//  `adjusted logic of prepending carriage returns - add only one line when damage inspection , two otherwise

//**********`Modified by: Costas Manousakis-(Designer)-(2/25/21)
//new form
// [TIN_Insp_Images].PrintPhoto_rotate
// Description
//  // Print rotated sketches and charts for Tunnel inspections
// NTI_PrintSketchChartSingle
//  `modified to use the new PrintPhoto_rotate form for landscape images
// INSP_PrintSketchChartSingle
//  `use the rotated form always for landscape sketches/charts
// INSP_PRN_InitVars
//  `initialize INSP_CreatePDFsofApproved_B

//**********`Modified by: Costas Manousakis-(Designer)-(2/26/21)
// fBLOB_2_Text
//  `added code to view contents of text, picture , blob fields.  Run only when the current form = "Input"
// [Activity Log];"Input"
//  `get vLogData last, otherwise the vars v_59_010_blb;v_59_027_blb are cleared from the call to get vOldLogData
//  `enabled On unload event on form, and added code to clear the v_59_010_blb;v_59_027_blb blob vars
// fGrpBlob2Text_2
//  `accumulate the data to view fields only when current form name = "input"

// [PERS_Groups];"PG_Output_LB"
//  `adjusted listbox size, enabled on open/close detail on the LB object


//Moved changed code over for inspection printing to PDFs
//INSP_CreateApprovedPDFS 
//INSP_CreatePDFByMonth   //done
//PRINT_ROUTINE_F_PDF   //done
//SHORT_MESSAGE   //done
//PrintTOPDFError //done

//End Mods_2021_02