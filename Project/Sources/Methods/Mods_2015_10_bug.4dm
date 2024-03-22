//%attributes = {"invisible":true}
//Method: Mods_2015_10_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/02/15, 13:21:11
	// ----------------------------------------------------
	//Created : 
	Mods_2015_10_bug
End if 
//
//**********`Modified by: Costas Manousakis-(Designer)-(10/2/15)

// Modified Forms : 
//[PON_ELEM_INSP];"Input"
//  `Trap the Enter key with the Save & Exit button
//  `changed variable on Info and Help buttons to Button1 to avoide conflict with data entry buttons

// Modified Method(s) : 
//PON_ELEMINP_FM
//  `added PON_ELEMUNIT_txt  declaration in the On Load event
//  `added code to handle the percent/quantity UI setting when read only

//**********`Modified by: Costas Manousakis-(Designer)-(10/3/15)
// Created Method(s) : 
//  `Method: PON_ut_RelogPON_INSP_records
//Description
// relog records in [PON_ELEM_INSP]
// generally create GRP and LNK records.
// search for records using the Query command.
// check if there is a record in the FileIDRes table. if there is not probably need to create a NRC act log
// check to see if there is an NRC rec in act log already. matching pon id, insp id then check the source.
// also check if there is a record in the FileIDRes table for the LNK fields. if not, check if there is an NRC rec - maybe not sent yet.


//**********`Modified by: Costas Manousakis-(Designer)-(10/7/15)
// Modified Object Methods : 
//Object Method: [Standard Photos];"Standard Photos".CopyOptiondropDwn 
//  `When copying the image convert it to JPEG, unless the shift key is pressed where the original stored image will be put on the clipboard
//  `This done to address a OSX 10.10.5 problem where the original image was not recognized by the Preview app or the Pages app

//**********`Modified by: Costas Manousakis-(Designer)-(10/8/15)
// Modified Method(s) : 
//ut_ACTLOG_addInsp
//ut_SQLReturnActLogRecords
//  `for speed improvement search for [ElementsSafety],[Standard Photos],[TunnelInspection],[PON_ELEM_INSP] in one querry
//  `then do a query selection with array.

// Modified Method(s) : 
//G_SecureInspection
//  `Added  [PON_ELEM_INSP]


//**********`Modified by: Costas Manousakis-(Designer)-(10/14/15)
// Modified Form/Form Methods : 
//[Bridge MHD NBIS];"SI & A (Insp)"
//[Bridge MHD NBIS];"SI & A (Normal)"
//  `Print MBTA  Rating Loads version; added HWYRTG@ objects ; named  previous to DOT_@

//[Bridge MHD NBIS];"RailTransitSIA"
//  `moved to the correct spot sitem35 variable

// Created Method(s) : 
//Method: SIA_PrintForms
//Description
// Print SIA form(s)
// Parameters
// $1 : $PrintInventory_L (0|1)
// $2 : $PrintInsp_L (0|1)
// $3 : $PrintMHDSpecific_L (0|1)

// Modified Method(s) : 
//M_PrintRecords
//PRINT_SIA
//  `use method SIA_PrintForms

//INSP_PrintSIA
//  `print the "RailTransitSIA" only for @RO bridges; else use method SIA_PrintForms

//Compiler_SIA 
//  `Added SIA_PrintForms


//```
//```   **** End of Release 6.4.1 10/14/15
//```

//**********`Modified by: Costas Manousakis-(Designer)-(10/20/15)
// Created Method(s) : 
//Method: ut_DisplayArray
//Description
// Parameters
// $1 : $arr_ptr
// $2 : $title_txt
// $3 : $colTitle_txt

// Modified Method(s) : 
//COMPILER_Utilities
//  `added ut_DisplayArray

// Created Method(s) : 
//Method: PON_ut_compareNBEs
//Description
// Compare NBE elements between a local Db and the Destination db

//**********`Modified by: Costas Manousakis-(Designer)-(10/21/15)
// Modified Method(s) : 
//DEV_UPDATE_STRUCTURE_LOG
//  `modified so that a message is written in the log whether the struct blob was updated or this was just a comparison

//**********`Modified by: Costas Manousakis-(Designer)-(10/22/15)
// Modified Method(s) : 
//PON_ut_RelogPON_INSP_records
//  `fixed call to LogLink

//**********`Modified by: Costas Manousakis-(Designer)-(10/23/15)
// Modified Method(s) : 
//ut_DwnldMissingINSPForBridges
//  `fixed ending problem in the Repeat..Until loop when checking the Loop_l variable

// Created Method(s) : 
//Method: INSP_DWNLD_ElmtRR_ratings
//Description
// download records from table [ElmtRatingLoads] related to the [ElementsSafety] of current inspection
// Parameters
// $0 : True if downloaded ok

// Modified Method(s) : 
//Compiler_Inspections
//  `added INSP_DWNLD_ElmtRR_ratings

// Modified Method(s) : 
//INSP_DownLoadInsp
//  `Added code to download [PON_ELEM_INSP] and [TunnelInspection] records
//  `and code to download records from [ElmtRatingLoads]

// Modified Forms : 
//[Inspections];"Dive Pr Pg 1"
//[Inspections];"Dive Pr  LowCl Pg1"
//[Inspections];"Dive Special Pr Pg 1"
//  `Verified variable / label / text box vertical size

//**********`Modified by: Costas Manousakis-(Designer)-(10/26/15)
// Modified Method(s) : 
//INSP_SetElmtRtgVisibility
//  `Create a [ElmtRatingLoads] record only if the table is not in READ only

//**********`Modified by: Costas Manousakis-(Designer)-(10/28/15)
// Modified Forms : 
//[ScourPOA];"FieldVerificationCardpg1"
//  `fixed spelling in  "Scour critical feature"


//End Mods_2015_10_bug