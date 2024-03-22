//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 05/09/17, 14:48:22
//----------------------------------------------------
//Method: Mods_2017_05
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_05  //
End if 
//**********`Modified by: Costas Manousakis-(Designer)-(5/2/17)
// Created Method(s) : 
//Method: ut_GetRandomSet
//Description
// Create a random set of elements from an array
// Parameters
// $1 : $SourceArray_ptr
// $2 : $DestArray_ptr
// $3 : $NumElements_L


//Modified by: Chuck Miller (5/9/17 14:49:38)
//Add code to allow for re-import of converted pictures. Also seperate options into pop menu
// Method: Object Method: [Standard Photos].Standard Photos.Button
//New form
//[Standard Photos];"ImportPicturesFromConversion" 
//Compiler_Inspections

//**********`Modified by: Costas Manousakis-(Designer)-(5/30/17)
// Modified Object Methods : 
//[InventoryPhotoInsp];"Input".InvPhotoDate_D
//  `added missing PushChange call to the inv insp date object

// Created Method(s) : 
//Method: SFA_getServerFileList
//Description
// get list of folders and files under a folder mounted on the server or local machine ; Execute on server = ON
// this assumes it is run on a Mac Platform
// Parameters
// $1 : $Full_pathtosearch_txt
// $2 : $Listarray_ptr

//Method: SFA_SharedServerAvail
//Description
// check if a shared server is available. uses ping to check
// Parameters
// $0 : $Availalble_b
// $1 : $ServerName_txt (can be name or IP address

//Method: SFA_GetBridgeFolder
//Description
// get the base bridge/bin folder. load the data in text array passed as pointer in $3
// Parameters
// $1 : $BDEPT
// $2 : $BIN
// $3 : $FolderList_ptr  {1} = Bridge Folder ; {2} =Town Folder

//Method: SFA_openRatingReport
//Description
// test method to open a rating report or show a folder for a bridge/bin scanned by WRG saved to the shared drive
// Parameters
// $1 : $FileToOpen_txt

// Method: SFA_GetAvailRatingRpts
// Description
// Get list of available ratings for a bridge and display a popup menu to pick one.
// Parameters
// $1 : $Bdept_txt
// $2 : $BIN_txt

//Method: SFA_GetFolderListServer
//Description
//test method to test if folders under base path are named correctly

//Method: SFA_OpenScannedReport
//Description
// open a scanned rating report from mhd-shared for a bdept/BIN
// Parameters
// $1 : $BDEPT
// $2 : $BIN

//Compiler_SFA


//**********`Modified by: Costas Manousakis-(Designer)-(5/31/17)
// Modified Forms : 
// [Bridge MHD NBIS];"Bridge Input"
//  `added button to list available scanned rating reports in the rating reports page (4)

// Modified Method(s) : 
// SIA_BridgeInpNavCTRL
//  `for rating reports added code to enable/disable the button the lists available scanned ratings

//End Mods_2017_05