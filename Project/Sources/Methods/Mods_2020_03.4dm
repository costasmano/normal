//%attributes = {"invisible":true}
//Method: Mods_2020_03
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/05/20, 16:25:17
	// ----------------------------------------------------
	//Created : 
	Mods_2020_03
End if 
//

//Method: test_wordgenerator
//Description
// a test method to generate 'words' from a set of characters using each one once
// Parameters
// $1 : $Letters_txt
// $2 : $Array_ptr

//ADD buttons to Methods List Form _ This is utility method
//"MethodsList"

// FN_ReturnRecordCount
//Fix issue with clone call to return record counts for
//[Standard Photos] and [ElementsSafety]

// SQL_CreateNewDBTable
// Fix compilert sytanx problems

//**********`Modified by: Costas Manousakis-(Designer)-(3/30/20)
// Bridge_NBISSearchPicker_OM
//  `font size cannot be changed
//  `declare interproc variable only if not defined, 
//  `reload the local $BridgeSearchArray_atxt after calls to Bridge_FileBridgeSearchArray

// M_DISTRICT6
//  `removed old code used while transitioning from MTA etc. Now use same code as in the P_Districtx methods
// P_OtherAgc
//  `added missing title for DIST6
// ModSelSort
//  `combined the NewNBIS_StackInfo and NewMBTANBIS_StackInfo cases
// [Activity Log];"Input".View_Data
//  `fixed cleaning of other vars in case of "Picture"

//End Mods_2020_03