//%attributes = {"invisible":true}
//Method: Mods_2017_08_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 08/15/17, 12:06:20
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08_bug
End if 

//Remobve maintenance button from bridge inpurt form


//add redraw window to [InventoryPhotoInsp];"input"
//Method: [InventoryPhotoInsp].Input.DE Orientation


// Modified Method(s) : 
// NTI_AddTIN_Inspection
//  `Added determination of vsForward process var

// Modified Method(s) : 
// ut_NewSQLUpdateLocalTable
// Make sure that we do not include [Activity Log]Activity_Log_UUIDKey_s field in saving recorde data

// Modified Method(s) : 
// NTI_PrintNTEList
//  `fix to address bug where element comments were not printed correctly when spanning pages
// PON_PrintNBEs_FM
//  `fix problem with element comments not printing correctly when spaning pages

// Created Method(s) : 
//Method: Mods_replace_o_during
//Description
// locations where _o_during event was replaced.

// ut_ClearSavedPassword
//  `comment out line $PathToEngineLink_txt:=$1 - not needed

//End Mods_2017_08_bug