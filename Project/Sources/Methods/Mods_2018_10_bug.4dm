//%attributes = {"invisible":true}
//Method: Mods_2018_10_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 10/09/18, 13:59:43
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10_bug
End if 
//
//Fix issue where UT seletion being lost. It looked like the results where not displaying.
//Modified by: Chuck Miller (10/9/18 14:03:45)
//LSS_SelectUTResults

//Make sure note on UT and D-Meter page set to invisible after a picture is imported
//Fix bug where [ictiure description not enterable when adding picture to new record
//ut_LSSControlPictureMod 


//Add code to UT results input so user can only check accept or reject not both
//[LSS_UtResult];"Input"
//Method: [LSS_UtResult];"Input".LSS_Accept_b
//Method: [LSS_UtResult];"Input".LSS_Accept_b



//End Mods_2018_10_bug