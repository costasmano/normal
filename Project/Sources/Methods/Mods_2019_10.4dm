//%attributes = {"invisible":true}
//Method: Mods_2019_10
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/07/19, 14:01:34
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10
End if 
//Made change to deselect row after editting
//Modified by: Chuck Miller (10/7/19 14:03:22)
//LSS_SelectUTResults
//Change form propereties so that resize not allowed 
//[LSS_UtResult];"Input"
//[LSS_UT];"Input"
//[LSS_TowerDistance];"Input"
//[LSS_SignPanel];"Input"
//[LSS_Photos];"Input"
//[LSS_ElementInspection];"Input"
//[LSS_VerticalClearance];"Input"

//Modified resource to activityLog form to make it easier to use 
//"SelectResources"
//Resource_FolderStructure 
//Server_ReturnResourceStructure 
//Server_SaveDocToResourceFolder


//Modified Poject retrieve to create CSV files for all returned data
//Modified by: Chuck Miller (10/24/19 11:07:37)
//SQL_Direct 
//ut_PRJRetrieveProjectFileData 
//ut_PRJGetAEData 
//ut_PRJCtrlRetrieveProjectData 




//End Mods_2019_10
