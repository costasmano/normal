//%attributes = {"invisible":true}
//Method: Mods_2018_09_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/05/18, 10:19:47
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(9/5/18)
//Method: DEV_FindSequences
//Description
// Scan all methods for calls to Inc_Sequence, extract the sequence name and field used ; 
// create code to utilize ut_ScanSequences to correct the sequences; puts the code in the pasteboard.

// Modified Method(s) : 
// ut_ScanSequences
//  `added TIN inspection tables

//```
//```    **** End of Release 7.1.1.d 10-Sep-2018
//```

//**********`Modified by: Costas Manousakis-(Designer)-(9/11/18)
// Modified Form Methods : 
// [Bridge MHD NBIS];"SI & A Input"
//  `fixed filter on Item5 to allow route numbers in 5D such as 1A; alow only "A" for route suffix
//  //fixed style sheets of some objects on page 1

// Modified Method(s) : 
// ut_ScanSequences
//  `code copied from result of DEV_FindSequences inserted and corrected as needed

// SIA_SecureInputForm
//  `allow only members of personnel group "SIA_Item5Edit", or designer to edit Item 5

// [Bridge MHD NBIS];"SI & A Input".Field12
//  `added goto object when error; added additional checks for the route number Item 5D

// [Bridge MHD NBIS];"Other Info".DE Variable15
//  `moved code that locks or unlocks to form method
// [Bridge MHD NBIS];"Other Info"
//  `added code to make Item37 editable or not here.

//**********`Modified by: Costas Manousakis-(Designer)-(9/13/18)
// SIA_SecureInputForm
//  `change from 4D Group Historical Significance" to Personnel group SIA_Item37Edit
// [Bridge MHD NBIS];"Other Info"
//  `change from 4D Group Historical Significance" to Personnel group SIA_Item37Edit
// NTI_TinINSP_ImageLB_OM
//  `added form set input before modify record
// NTI_INSP_AddImage_OM
//  `added FORM SET INPUT([TIN_Insp_Images];"Input") 

// Created Method(s) : 
//Method: DBG_Collect4DWRData
//Description
// method to collect data from 4D Write areas on print forms while printing.
// can be called from the form methods while printing to append
// Parameters
// $1 : $Task_txt (Start | Append | Export )
// $2 : $FormName_txt
// $3 : $WriteArea_L

// Modified Form Methods : 
// [Inspections];"Culvert Pr Pg 2 wr"
//  `added debug code here too 
// [Inspections];"Dive Pr Pg 2 wrt"
//  `added form name in the debug text

// Modified Object Methods : 
// [LSS_refInspectionType];"Input".LSS_InspectionTypeId_s
//  `fixed order of $Key_atxt


//```
//```    **** End of Release 7.1.1.e 13-Sep-2018
//```

//**********`Modified by: Costas Manousakis-(Designer)-(9/17/18)
// INSP_ReportIncompleteInsp
//  `fixed bug when attempting to add to array $DistrictNotes_atxt data for dive inspection - it should not be done - set $position_L to 0 for dive.

//**********`Modified by: Costas Manousakis-(Designer)-(9/25/18)
// Modified Form Methods : 
// [Inspections];"Culvert Pr Pg 2"
//  `added code to scale the preview picture so that width fits object.
// Modified Method(s) : 
// Print_CUL_Cmts
//  `remove scaling of preview pic for windows. scaling is done in the print form to fit width of 


//Modified by: Chuck Miller (9/27/18 16:33:21)

//FM_SaveDMeter
//Fix bug to make sure $ErrorMethodCalled_txt is defined

//Addeded Needed Used to accessibility area of input forms
//[LSS_Inspection];"Input_Signal"
//[LSS_Inspection];"Input_Sign"
//[LSS_Inspection];"Input_Light"
//[LSS_Inspection];"Input_ITS"

//```
//```    **** End of Release 7.1.1.f 28-Sep-2018
//```

//End Mods_2018_09_bug