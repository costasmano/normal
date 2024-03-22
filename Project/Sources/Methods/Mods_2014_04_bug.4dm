//%attributes = {"invisible":true}
//Method: Mods_2014_04_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/01/14, 13:07:33
	// ----------------------------------------------------
	//Created : 
	Mods_2014_04_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(4/1/14)
// Modified Method(s) : 
//Duplicate_Inspection 
//  `fix type in sequence for "TunnelInspection

//**********`Modified by: Costas Manousakis-(Designer)-(4/3/14)
// Modified Method(s) : 
//G_InspParagProt 
//  `When adding line feeds to move the item to next page ($vbMovetoTop=true)  applystylesheet 1 after each char return

//**********`Modified by: Costas Manousakis-(Designer)-(4/4/14)
// Created Method(s) : 
//ARCH_ChangeNRCSeq
//  ` new uiltity method to fix bad sequence name entered in the NRC record

//Temp_FixTableOfListSeq
//  `Fix keyID_L in table of lists

// Modified Method(s) : 
//G_ListTable
//  `Launch in a separate process- avoides errors  "A Boolean argument was expected." 
//  `Also added a repeat loop to avoid having to re start the method for different tables and a check for valid table number
// Modified Method(s) : 
//COMPILER_Utilities
//  `added G_listTable

//**********`Modified by: Costas Manousakis-(Designer)-(4/8/14)
// Modified Method(s) : 
//Inc_Sequence
//  `added code to create a record in [ONSQLAuthenticationErrors] if sequence name is blank



//**********`Modified by: Costas Manousakis-(Designer)-(4/9/14)
// Modified Method(s) : 
//Duplicate_Inspection
//  `fixed call to TNL_QAQCEngr_L - added the distr number
//  `fixed call to LogNewRecord - fixed the seq name

// Modified Method(s) : 
//G_Insp_SetPersUI
//  `added code to set the tunnel insp engr using pers groups
//  `removed check for app version (◊LNK_Vers ) - use LogLink for all cases

//INSP_DTIE_OM
//  `used Case statement


//```
//```   **** End of Release 6.3.1.c 04/09/2014
//```

//**********`Modified by: Costas Manousakis-(Designer)-(4/24/14)
// Modified Method(s) : 
//RtgReq_Input_FM
//  `make sure correct bridge record is loaded RO

//G_AddElmtTxt2Area
//  `removed calls to set the font and fontnumber

//**********`Modified by: Costas Manousakis-(Designer)-(4/30/14)

// Modified Method(s) : 
//RtgReq_Input_FM
//  `Move the lognewrecord in the save button. At the On Validate event the record is not new anymore

// Modified Object Methods : 
//[RatingRequests];"Input".bValidate
//  `LogNewRecord must be here because after the ACCEPT action of the button is complete, the record is not new anymore
//[RatingRequests].Input.bDelete
//  `missing code to log the deletion of a rating request

//RtgReq_AdtlInp_FM
//  `moved code to log new record in the accept button. fixed call the pushall to indicate the ID fields.

// Modified Object Methods : 
//[AddtlRatingRequests];"Input".bDelete
//  `Log deletion here - made Action of button - delete record
//[AddtlRatingRequests];"Input".bValidate
//  `log new record here


//End Mods_2014_04_bug