//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Chuck Miller
//Date and time: 08/02/16, 13:27:49
//----------------------------------------------------
//Method: ut_CNVLaunchImport
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2016_06  // 
	//Modified by: Chuck Miller (8/2/16 13:29:23)
	
End if 
C_LONGINT:C283($ProcessID_L)
$ProcessID_L:=New process:C317("CNV_ImportPictures"; 0; "Import Pictures")
//End ut_CNVLaunchImport

