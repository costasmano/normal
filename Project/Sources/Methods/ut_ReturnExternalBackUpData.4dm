//%attributes = {"invisible":true}
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/14/12, 13:36:36
//----------------------------------------------------
//Method: ut_ReturnExternalBackUpData
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r003   `Add function call to get backup info
	//Modified by: Charles Miller (2/14/12 13:36:38)
	
End if 

ut_GetServerBackUpData("Designer"; "caesar"; "74.8.145.3:19812")

//End ut_ReturnExternalBackUpData