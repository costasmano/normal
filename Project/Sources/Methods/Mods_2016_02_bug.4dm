//%attributes = {"invisible":true}
//Method: Mods_2016_02_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/01/16, 16:03:38
	// ----------------------------------------------------
	//Created : 
	Mods_2016_02_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(2/1/16)
// Modified Method(s) : 
//ut_Use4DChartorSVG
//  `added a check for unicode mode  - use 4Dchart when not unicode

//**********`Modified by: Costas Manousakis-(Designer)-(2/3/16)
// Modified Method(s) : 
//ADDUSER_Utils
//  `in the call to Random add Tickcount for more randomness

//**********`Modified by: Costas Manousakis-(Designer)-(2/5/16)
// Modified Method(s) : 
//LSS_GotToInspectionPage 
//  `For Images case - added check if the tab title has been named as Photos

//**********`Modified by: Chuck Miller (2/9/16 17:31:02)

// Added short message when saving and updating picture sequences
//FM_SaveInspection 
// Add code to make sure sequence update only occurs when seq has changed
//FM_SavePhotoInput 
// Add code tp make sure sequence numbers update when user enters a number > all others found
//LSS_ResequencePictures 
// Add new code to display saved quick reports for [lss_inventory]
//[LSS_Inventory];"ListBoxOutput"`Changed quick report button 
//LSS_LoadReportTemplates 

// Add short message as this could take some time as well

//LSS_AccessibilitySave 

// Created Method(s) : 
//Method: LSS_ExportInspection

//**********`Modified by: Costas Manousakis-(Designer)-(2/10/16)
// Modified Method(s) : 
//INSP_ExportInspection 
//  `remove  Clear Selection at end - not needed because they were  CUT at the beginning

// Modified Method(s) : 
//PON_VerifyQuantity 
//PON_VerifyNBEQuantities 
//PON_ELEMINPTOOL_OM 
//  `Account for Damage element which must be included in other defects
//Compiler_PON
//  `added  PON_ELEM_Defect_b

// Modified Object Methods : 
//Object Method: [PON_ELEM_INSP]."Input".PON_ELEMSELECT_atxt 
//  ` use PON_ELEM_Defect_b to keep track if element is a defect - attempt to change 
//  `logic of doing quantities to allow users to enter quantities in states and then add them to get total Q for defects 
//  `only for Q - percentages have to go the normal way

// Modified Method(s) : 
//Method: PON_ELEMINP_FM
//  ` use PON_ELEM_Defect_b to keep track if element is a defect

// Modified Forms : 
//[PON_ELEM_INSP];"Input"
//  `added splitters and invisible buttons to allow resizing of defect and prot sys lists

// Modified Forms : 
//[Contract Invoice];"ContractInvoice In" 
//  `added splitter - enabled resizing of comments and asignement list
//`[Contracts];"Contracts In"
//  `Added splitters  and enabled resizing of lists, and text entry areas in the comments

//**********`Modified by: Costas Manousakis-(Designer)-(2/12/16)
// Modified Method(s) : 
//PON_ExportFHWANBE
//  `removed the tests to get Bin records from the [pon_elem_insp] table
//  `use the current selection of bridge records
//  `skip the processing if there are no bridge records
//  `find the last dbie approved inspection with NBEs

//**********`Modified by: Costas Manousakis-(Designer)-(2/16/16)
// Modified Forms : 
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//  `made rectangles behind UT and Dmeter sketches to Grow/grow on resize

//[LSS_Inspection];"Input_Signal"
//  `made rectangles behind UT and Dmeter sketches to Grow/grow on resize
//  `Made comments and recommendation fields AutoSpellcheck

//**********`Modified by: CJ MIller (Designer)-(2/16/16)
// Created Method(s) : 
// Method: ut_FixGetActivityLogRecords

//**********`Modified by: Costas Manousakis-(Designer)-(2/17/16)
// Modified Method(s) : 
//ut_UpdateorCreatePhotoRecord
//  `fixed wrong sequence in the lognewrecord was LSS_Photo should be LSS_PhotoID_s

// Modified Object Methods : 
//Method: Object Method: [LSS_Photos].Input.Photo_pct
//  `removed "SAVE RECORD" after the PushChange (5;->[LSS_Photos]LSS_Photo_blb) Record is saved on the Save button

// Modified Method(s) : 
//LSS_CheckTeamMembership
//  `for Convenience allow other members of the same company to edit an inspection


//**********`Modified by: Costas Manousakis-(Designer)-(2/19/16)
// Created Method(s) : 
//Method: LSS_AddAddtlCmnts
//Description
//  ` print the Additional Comments field;
//  ` copy from LSS_AddHeader
//  ` Parameters
//  ` $1 : $CommentArea_L

// Modified Method(s) : 
// Method: LSS_PrintInspection
//  `added call to LSS_AddAddtlCmnts when needed; consider [LSS_Inspection]LSS_AdditionalComments_txt when  printing comments
// Method: Compiler_LSS
//  `added LSS_AddAddtlCmnts

// Modified Forms : 
//[LSS_Inspection];"Input_Signal"
//[LSS_Inspection];"Input_ITS"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_Sign"
//  `added field [LSS_Inspection]LSS_AdditionalComments_txt on page one ; re-arranged other text fields to fit.

//```
//```   **** End of Release 6.5.0.d 02/21/2016
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2/23/16)
// Modified Forms : 
//`[PON_ELEM_INSP]SearchNBE
//  `vrSearchElmttotQty filter to PosREals min val :0, max: none


//**********`Modified by: Costas Manousakis-(Designer)-(2/23/16)
// Modified Method(s) : 
//PON_util1
//  `fixed wrong <b> (bold) marker after quantity calc label - should have been </b>

//**********`Modified by: Costas Manousakis-(Designer)-(2/24/16)
// Modified Forms : 
//Form  [Conslt Rating];"Cslt Rating In"
//  `moved CRTGMaintTools button in page 5 to a better spot.

//LO: [Inspections];"Critical Member"
//  `changed filter for items  58-62 prev and current to allow entry for N

//Form  [LSS_Inspection];"Input_Sign"
//  `replaced 3.0   Luminaire with SignPanel ratings and label - rearranged condition ratings and labels; 
// ` fixed pulldown for 3.0 to point to the correct fields
//Form  [LSS_Inspection];"SignStructurePg1"
//  `fixed field : instead of Luminaire should be Sign Panels
// Modified Method(s) : 
//LSS_SetUpInventoryListBox
//  `for section 3.0 and Highway signs (HS) use field [LSS_Inspection]LSS_CondSignPanelsCurr_s

// Modified Method(s) : 
//PON_VerifyQuantity
//  `fixed the code that is checking when the current element is NOT and NBE or prot sys  - was not excluding 7000

//PON_VerifyNBEQuantities
//  `fixed  bug where damage 7000 and child quantities were not initialized correctly for new elements

// Created Method(s) : 
//Method: LSS_TempFixSignInspections
//Description
// temp method to fix Sign "HS" inspections because the wrong field was being used
// for the Sign Panel & Illumination rating (was  [LSS_Inspection]LSS_CondLuminaire
// should be [LSS_Inspection]LSS_CondSignPanels
// find all inspections that are for HS type structures and NOT imported (inspID # "IMPORT@"
// set [LSS_Inspection]LSS_CondSignPanels=[LSS_Inspection]LSS_CondLuminaire
// and Log changes
// Parameters
// ----------------------------------------------------


//```
//```   **** End of Release 6.5.0.e 02/25/16
//```

//**********`Modified by: Costas Manousakis-(Designer)-(2/26/16)
// Modified Object Methods : 
//Object Method: [Bridge MHD NBIS]."BDEPT Input".ZZ8 
//  `log new record only if the record is a new record. it might have been saved already if user canceled out of the "AssignReplacement.dlg" dialog
//  ` PRJ_DEBridgeNo_s was coded wrong
// Modified Forms : 
//`[Bridge MHD NBIS];"BDEPT Input"
//  `removed extra form events (on validate, on displa detail,...) from all pulldowns; and fields/variables.

// Created Method(s) : 
//Method: LSS_Temp_FixPhotoActLog
//Description
// fix errors in activity log of entries for LSS_photos

//**********`Modified by: CJMiller-(Designer)-(2/ /16)
// Created Method(s) : 
//Method: LSS_DeleteImportedRecords
//  `deletes imported LSS records  and calls to re-import using LSS_CloneFromImport

//**********`Modified by: Costas Manousakis-(Designer)-(2/29/16)
// Modified Method(s) : 
//G_InspParagProt
//  `removed TRACE at start

//**********`Modified by: CJMiller-(Designer)-(2/29/16)
// Created Method(s) : 
//LSS_CompareImportTableCounts


//```
//```   **** End of Release 6.5.0.f 03/02/16
//```

//End Mods_2016_02_bug