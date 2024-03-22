//%attributes = {"invisible":true}
//Method: Mods_2016_12
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/09/16, 12:05:20
	// ----------------------------------------------------
	//Created : 
	Mods_2016_12
End if 
//
//**********`Modified by: (Designer)-(12/9/16)
// Created Method(s) : 
//ut_ImportResizedPictures

//**********`Modified by: Costas Manousakis-(Designer)-(12/9/16)
// Created Method(s) : 
//Method: INSP_CheckImages
//Description
// check images in current inspection to verify that they are not PICT or PDF type.
// return a text with a list of found errors : Type - sequence - bad format
// Parameters
// $0 : $ImageCheck_txt

// Modified Method(s) : 
//G_Insp_SaveInspection 
//Object Method: [Inspections];"Dive Template".bzAccept 
//  `added Check of image types to avoid PICTs and PDFs ; change message to use  ut_BigAlert

// Modified Method(s) : 
//ut_BigAlert 
//  `Added optional parameter for Window title
//Compiler_Inspections
//  `added INSP_CheckImages

//MAP_SetLabelFields
//MAP_SetDataFields 
//  `use the field names set by SET FIELD TITLES
//MAP_UpdatePosFromKML
//  `added mod date /time mod by

//**********`Modified by: Costas Manousakis-(Designer)-(12/12/16)
// Modified Method(s) : 
//ut_MissingBINStoArray
//  `SET QUERY DESTINATION(Into current selection ) WAS MISSING!!!!

// Created Method(s) : 
//Method: SIA_SelectAvailableBIN
//Description
// allow user to choose one of the available BINs for a new record.
// BINs that do not exist in the DB , or where ITEM6A and Item 7 = Other available
// Parameters
// $0: $AvailableBin_txt

//**********`Modified by: Costas Manousakis-(Designer)-(12/15/16)
// Modified Method(s) : 
//Compiler_SIA 
//  `added SIA_SelectAvailableBIN

// Modified Forms : 
//[Inspections];"RailRoutine Arch Pr Pg 2"
//  `fixed wrong variablle for vDN61_3

// Created Method(s) : 
//Method: LSS_SortUTResults
//Description
// sort the current selection of UTResults records ; sorting by text field did not work in v11

// Modified Method(s) : 
//LSS_SelectUTResults 
//LSS_PrintUT 
//LSS_AddUTResultRecord
//  `use LSS_SortUTResults

//**********`Modified by: Costas Manousakis-(Designer)-(12/16/16)
// Modified Forms : 
//[PON_ELEM_INSP];"Print"
//  `modified form to include element comments as notes

// Modified Method(s) : 
//PON_PrintNBEs_FM
//  `added printing of element notes

//**********`Modified by: Costas Manousakis-(Designer)-(12/19/16)
// Created Method(s) : 
//Method: Print_TrimText
//Description
// Fit a text object in available space  on a print form.
// return the number of characters that the text object was trinmmed to.
// Parameters
// $0 : $Chars_L  = number of characters that the objext was trimmed to (0 = no trimming done)
// $1 : $Objvar_ptr = pointer to the text object (variable or field pointer)
// $2 : $BottomCoord_L = coord (points) of bottom of available area on page

// Modified Method(s) : 

//COMPILER_Utilities 
//  `added Print_TrimText

//PON_PrintNBEs_FM
//  `use Print_TrimText

//**********`Modified by: Costas Manousakis-(Designer)-(12/27/16)
// Modified Method(s) : 
//SIA_SelectAvailableBIN
//  `do not check for  BINs marked "Other Available", only look for BIN numbers not used
//  ` this must be re-written so that it saves the new bridge record with the selected BIN and then the semaphore is cleared.
//  ` Do not allow user to Cancel from selection if there are unused BINs found
//  ` return a blank only if there are no unused BINs.
//  ` this method will be called on the on Load event of the  [Bridge MHD NBIS];"BDEPT Input" form

//**********`Modified by: Costas Manousakis-(Designer)-(12/29/16)
// Created Method(s) : 
// Method: BID_RetrieveAwardDataFromTish
// Description
//  ` retrieve awarded bridge projects form Tish based on a federal fiscal year - meant to be run interactively
//  ` parse the list to get rid of 'duplicate' lines'
//  ` for each bridge-projinfo-contrno combination retrueve the appropriate bid items - asemble in one array
//  ` save the bid items to a text file
//  ` save needed bridge information to a text file
//  ` save the info retrieved from TISH to a text file
//  ` the text files can be imported into Excel for further processing.

// Modified Method(s) : 
//FM_SaveUT
//  `Fixed wrong sequence name in the LognewRecord call. was "[LSS_UT]LSS_UTId_s" 


//```
//```   **** End of Release 6.6.4 29-Dec-2016
//```

//**********`Modified by: Costas Manousakis-(Designer)-(12/30/16)
// Created Method(s) : 
//Method: Test_DEV_cleanCompilers
//Description
// Test to find double entries in Compiler_xx methods

//End Mods_2016_12