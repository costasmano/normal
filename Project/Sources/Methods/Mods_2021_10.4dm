//%attributes = {"invisible":true}
//Method: Mods_2021_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2021-10-05T00:00:00, 19:31:11
	// ----------------------------------------------------
	//Created : 
	Mods_2021_10
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-04)
// P_ListConsInsp    **** Copied from v15
//  `unload record after sorting
// P_ListConsRating    **** Copied from v15
//  `unload record after sorting
// QR_ConsInspElecSubm    **** Copied from v15
//  `added optional 1st param to indicate if return values should be sortable - pass a string starting with "S"
// PRJ_DisplayProjects    **** Copied from v15
//  `unload [PRJ_ProjectDetails]
// InitProcessVar    **** Copied from v15
//  `move short_message to start of method
// LB_Tasks    **** Copied from v15
//  `add unload record 
// RtgReq_DisplayList    **** Copied from v15
//  `made stack size of new process 0
// RtgReq_Utility    **** Copied from v15
//  `unload record after default sort
// RtgReq_LB_OM    **** Copied from v15
//  `unload record after sorting
// LB_CSLT_Rating    **** Copied from v15
//  `enable on after sort on LB ; clean up sort code ; unload record at end of sorting
// LB_CSLT_Inspection    **** Copied from v15
//  `cleaned up sorting code - unload record after sorting
// LB_ListContracts    **** Copied from v15
//  `unload record after sorting / header click
// ut_UseListBox    **** Copied from v15
//  `Use SQL to avoid locking Parameters record
// LB_BridgePrgrmSetNamedSelection    **** Copied from v15
//  `Unload the record
// PRJ_SetUpDetailList    **** Copied from v15
//  `set all tables to RO since we run on server
// LB_ProjectDetailSort    **** Copied from v15
//  `initialize $0 to 0 ; remove code that is a simple sort
// LB_ResetHeaders    **** Copied from v15
//Description
// Reset the headers for a listbox to clear sort indicators
// Parameters
// $1 : $LB_name : name of listbox object

// [Conslt Rating];"View Cslt Rating_LB"    **** Copied from v15
//  `made LB focusable / hide focus rect - enable on resize event on form -on resize redraw the LB 
// [Conslt Rating];"View Cslt Rating_LB".Variable2     **** Copied from v15
//  ` unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".Variable4    **** Copied from v15
//  ` unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".Variable5    **** Copied from v15
//  `unload record and reset LB headers
// [Conslt Rating];"View Cslt Rating_LB".Variable6    **** Copied from v15
//  `unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".Variable7    **** Copied from v15
//  `unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".Variable1    **** Copied from v15
//  `added default sort ; unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".District Select    **** Copied from v15
//  `added default sort ; unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".Variable3    **** Copied from v15
//  `added default sort ; unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".PrioFlagAssgn_cbo    **** Copied from v15
//  `unload record 
// [Conslt Rating];"View Cslt Rating_LB".PrioFlagSrch_cbo    **** Copied from v15
//  `unload record and reset headers
// [Conslt Rating];"View Cslt Rating_LB".List Box    **** Copied from v15
//  `return result from method LB_CSLT_Rating to handle sorting - made number of static columns = 13
//  `fixed data source for NBIS Letter column

// [Cons Inspection];"View Cslt Insp_LB"
//  `made LB focusable / hide focus rect - enable on resize event on form -on resize redraw the LB 
// [Cons Inspection];"View Cslt Insp_LB".Variable2    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".Variable4    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".Variable5    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".Variable6    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".Variable7    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".Variable3    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".District Select    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".Variable1    **** Copied from v15
//  `unload record and reset headers of LB
// [Cons Inspection];"View Cslt Insp_LB".List Box    **** Copied from v15
//  `return result from method LB_CSLT_Inspection to handle sorting - made number of static columns = 11

// [Contracts];"Contracts_LB".Variable2    **** Copied from v15
//  `unload record and reset headers
// [Contracts];"Contracts_LB".Variable4    **** Copied from v15
//  `unload record and reset headers
// [Contracts];"Contracts_LB".Variable5    **** Copied from v15
//  `added default sort ; unload record and reset headers
// [Contracts];"Contracts_LB".Variable6    **** Copied from v15
//  `unload record and reset headers
// [Contracts];"Contracts_LB".Variable7    **** Copied from v15
//  `unload record and reset headers
// [Contracts];"Contracts_LB".Variable1    **** Copied from v15
//  `modified adding of record to scroll to the new record
// [Contracts];"Contracts_LB".Contract_LB    **** Copied from v15
//  `declare $0 ; made all LB columns Static; enabled On After Sort event; LB set to focusable/hide focus/not tabable

// [PRJ_ProjectDetails];"ProjectDetails.new"    **** Copied from v15
//  `do not resize window on Load

// [PRJ_ProjectDetails];"ProjectDetails_LB"    **** Copied from v15
//  `Unload record in On Load - redraw LB on resize ; enabled on Resize form event
// [PRJ_ProjectDetails];"ProjectDetails_LB".bAdd    **** Copied from v15
//  `unload record at the end ; use LB_ResetHeaders
// [PRJ_ProjectDetails];"ProjectDetails_LB".ProjectDetails_LB    **** Copied from v15
//  `added param $0 - returned by the sort method -
//  `enabled sortable in the object properties -
//  `corrected field for Ad Date to [PRJ_ProjectFile]PF_ScheduledAdvertising_d

// [DCM_Contracts];"DCM_Contracts_LB"    **** Copied from v15
//  `set all tables to RO ; Unload record of form table; set form table to RW 

// [RatingRequests];"Output".RtgReq_LB
//  `made all columns static - made lb focusable, hide rectangle - not tabable

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-06)
// [Personnel];"Inspectors Out_LB".AddRec    **** Copied from v15
//  `unload record at end
// [Personnel];"Inspectors Out_LB".Search    **** Copied from v15
//  `unload record at end
// [Personnel];"Inspectors Out_LB".SortBy    **** Copied from v15
//  `unload record at end
// [Personnel];"Inspectors Out_LB".AllRecs    **** Copied from v15
//  `unload record at end
// [Personnel];"Inspectors Out_LB".ShowSubset    **** Copied from v15
//  `unload record at end
// [Personnel];"Inspectors Out_LB".OmitSubset    **** Copied from v15
//  `unload record at end

// [Bridge Design];"View Bridge Design_LB"    **** Copied from v15
//  `unload record at load
// [Bridge Design];"View Bridge Design_LB".Variable2    **** Copied from v15
//  `unload record at end
// [Bridge Design];"View Bridge Design_LB".Variable3    **** Copied from v15
//  `unload record at end
// [Bridge Design];"View Bridge Design_LB".Variable4    **** Copied from v15
//  `unload record at end
// [Bridge Design];"View Bridge Design_LB".Variable5    **** Copied from v15
//  `unload record at end
// [Bridge Design];"View Bridge Design_LB".Variable6    **** Copied from v15
//  `unload record at end
// [Bridge Design];"View Bridge Design_LB".Variable7    **** Copied from v15
//  `unload record at end

// Form [Conslt Address];"View Conslt Address_LB"    **** Copied from v15

// [Conslt Address];"View Conslt Address_LB".SelectListBox    **** Copied from v15
//  `made LB focusable -not tabable-hide focus rect.- enable after sort event-all columns static
//  `clean up sort code
//  `Return $0 to handle sorting
//  `unload record after sort and on header click
//  `unload and reset headers on all buttons

// CONS_Address_O_FM    **** Copied from v15
//  `unload current record on load - remove setting of header vars

// [Town Address];"View Town Address_LB"    **** Copied from v15
//  `unload record at Load ; enable on resize in form events; redraw LB on Resize
// [Town Address];"View Town Address_LB".TownAddressLB    **** Copied from v15
//  //added to handle sorting ; enabled on after sort in LB events; made all columns static
// [Town Address];"View Town Address_LB". ALL Buttons that change selection or sort     **** Copied from v15
//  `unload record at end - reset LB headers

//Method: GetRandomArrayElmts    **** Copied from v15
//Description
// Create an array of randomly chosen X items from a source array
// Parameters
// $1 : $SourceArray_ptr
// $2 : $NumberItems_L
// $3 : $ResultArray_ptr

//Method: CreateRandomSelection    **** Copied from v15
//Description
// Create a random selection from the current selection of a table
// Parameters
// $1 : $Table_ptr
// $2 : $numOfRandomnlyChosenrecords

//Method: RandomNumber    **** Copied from v15
//Description
// generate a random number between two numbers -
// code copied from KB https://kb.4d.com/assetid=77777
// Parameters
// $0 : $result_L
// $1 : $start_L
// $2 : $end_L

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-13)

// [Contracts];"Contracts In"    **** Copied from v15
//  `changed picture of PRJ_GotoPrjInfo_FN to File projbtn.png

// created table [BridgeStairs]    **** Copied from v15
// fields
//[BridgeStairs]BridgeStairsID  : Longint
//[BridgeStairs]BIN - Child of [Brodge MHD NBIS]BIN - manual relations both ways
//[BridgeStairs]BridgeStairs_UUIDKey_s UUID - auto generate
//[BridgeStairs]OwnerCode_s  : A3
//[BridgeStairs]StairsTo_txt
//[BridgeStairs]Description_txt
//[BridgeStairs]CreatedBy
//[BridgeStairs]CreatedStamp
//[BridgeStairs]ModifiedBy
//[BridgeStairs]ModifiedStamp

//Method: SIA_StairsOn_OM    **** Copied from v15
//Description
// object method for stairs On /adjacent check box
// Parameters
// $1 : $Form event (Optional)

//Form: [Bridge MHD NBIS];"SI & A Input"    **** Copied from v15
//Added objects on page 10
// [Bridge MHD NBIS];"SI & A Input".DE StairsOnAdjacent ; .BridgeStairCount ; .StairsLabel
//  // call SIA_StairsOn_OM (On Load) in form method

// [Personnel];"Inspectors Out_LB"    **** Copied from v15
//  `added on resize event to redraw listbox
//  `resized Employer and Active column

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-14)
// LB_RtrnRatingBGColor    **** Copied from v15
//  `Return white background as default

// [Conslt Rating];"View Cslt Rating_LB"    **** Copied from v15
//  `removed setting of color on the background rect from form method

// [Cons Inspection];"View Cslt Insp_LB"    **** Copied from v15
//  `assign var LB_Detail1_txt for all users

//Form "[BridgeStairs];"StairsList"    **** Copied from v15
//Description
// Form to handle Stairs input for a bridge 

//Method: SIA_StairsLB_OM    **** Copied from v15
//Description
//object method for the Stairs LB object
// Parameters
// $0 : $Return
// $1 : $FormEvent

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-15)

//Method: Col_paletteToRGB    **** Copied from v15
//Col_paletteToRGB (couleurPalette_l) -> long
// Convert a palette color to RGB value
// Parameters
// $0 : $RGB_L
// $1 : $PaletteColor_L

//Method: SIA_Stairs_GetLBArrays    **** Copied from v15
//Description
// Return pointers to arrays for the Stairs listbox
// Parameters
// $0 : $InfoObject_o
//  "owners" : ptr to array of owners
//  "descriptions" : ptr to array of descriptions
//  "ids" : ptr to array of IDs
//  "enterable" : ptr to enterbale chkbox

// M_GetNBIS    **** Copied from v15
//  `added search for STAIRS and RANDOM selection

//menu BridgelistMenu     **** Copied from v15
//  //added items "Bridges with Stairs" : M_GetNBIS "STAIRS"
//  //added items "choose a random set" : M_GetNBIS "RANDOM"


//**********`Modified (2021-10-19)
// INSP_PrintToPDF     **** Copied from v15
//  `added printing of form [Inspections];"qcqaprint" 

// Duplicate_Inspection     **** Copied from v15
//  `when duplicating copy only Sketches / charts / Photos - unless doing a full copy


//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-20)
// ut_RelogRecords    **** Copied to v15
//  `Spawn a new process to do the relog - added $1 param

//Method: QR_GetBridgeStairsInfo     **** Copied from v15
//Description
// Return object with info about the stairs on/adjacent to a BIN
// Parameters
// $0 : $Info_o
// "count" : $numberofstairs_L
// "owners" : $owners_txt : list of owners comma separated
// $1 : $BIN (optional)

// [Bridge MHD NBIS];"SI & A (Insp)"     **** Copied from v15
//  `Added stairs on/adjacent info in Misc. - adjusted location of objects in Accessibility and Comments
// [Bridge MHD NBIS];"MHD Specific Items"
//  `Added stairs on/adjacent info in Misc. - adjusted location of objects in Accessibility and Comments

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-25)

//Method: INSP_QCAddNoticeToMsg     **** Copied from v15
//Description
// Add the notification of current user, os user and machine to confirm compitetion message
// Parameters
// $ 0: $Newmessage
// $1 : $startmessage

//Method: INSP_QCFillESignatures     **** Copied from v15
//Description
// Fill the E-signature objects on inspection print forms.
// will use form objects TLESignature and DBIEESignature

// G_Insp_SaveInspection     **** Copied from v15
//  `in the prompt for complete inspection add info about current user , OS user and workstation
//  `Call INSP_QCSaveApprovalInfo when marking inspection complete

// INSP_QCSaveApprovalInfo     **** Copied from v15
//  `add Personnel ID and user initials in approve object

// [Dialogs];"ApproveInsp"     **** Copied from v15
//  `resized vTextMssg - changed it to multi-style and re-arranged/re-sized objects for better fit 

// [Inspections];"Closed Insp Pg1"     **** Copied from v15
//  `added text objects TLEsignature and DBIEESignature - call INSP_QCFillESignatures

// [Inspections];"FCPrPg1_v2"     **** Copied from v15
//  `added text objects TLEsignature and DBIEESignature - call INSP_QCFillESignatures
// INSP_FCPrPg1_FM     **** Copied from v15
//  `call INSP_QCFillESignatures

// INSP_ReviewAction     **** Copied from v15
//  `added Current user, current machine owner and current machine in message
//  `call INSP_QCSaveApprovalInfo to save the e-sig when approving

// [Inspections];"Dive Template".DE Button Accept     **** Copied from v15
//  `added current user, os user and machine to confirm message and call to INSP_QCSaveApprovalInfo

// [Dialogs];"MyConfirm"     **** Copied from v15
//  `made text transparent/no border, also no border on picture button - clear var on pic button

//**********`Modified by: Costas Manousakis-(Designer)-(2021-10-28)

// INIT_UI_GV     **** Copied from v15
//  `added C_DATE(<>Insp_ESignatureStart)

// INSP_QCFillESignatures     **** Copied from v15
//  `use <>Insp_ESignatureStart to determine when e-sigs are active compared to inspection date

// INSP_QCAddNoticeToMsg     **** Copied from v15
//  `use <>Insp_ESignatureStart to determine when e-sigs are active compared to inspection date

//Make sure server processes never display anything to screen when on server
//Modified by: Chuck Miller (10/28/21 14:23:42)
//RecalcAASHTO
//HI_CalcBridgeHIFields
//InitFOSDFields


//End Mods_2021_10