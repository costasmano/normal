//%attributes = {"invisible":true}
//Method: LSS_AddUTResultRecord
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): administrator
	//Date and time: 04/16/15, 15:58:48
	//----------------------------------------------------
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/16/15 15:58:50)
	// Modified by: Costas Manousakis-(Designer)-(5/13/16 16:05:20)
	Mods_2016_05_bug
	//  `Sort order for ut results should be location then Rod num.
	// Modified by: Costas Manousakis-(Designer)-(12/15/16 17:18:25)
	Mods_2016_12
	//  `use LSS_SortUTResults
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
	Mods_2018_08  //Add code to fix problem with UT page on ibput form where uncompoiled ut and ut results data not didplayed correctly
	//Changed list boxes to use named selections ""UT_LB" and "UTResults_LB"
	//Modified by: Chuck Miller (8/30/18 15:35:58)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-18T00:00:00 18:07:06)
	Mods_2021_10
	//  `no ned to check for UTRow since we are opening inside a UT input form - use LSS_SelectUTResults_New
	//  `Must Save current LSS_UT record before adding if it's a new record
	//  `Use Center_Window_2 to open the window centered on current window
	
End if 
//If (LSS_UTRow_L>0)  //Make sure you have selected a UT Row
//  //ORDER BY([LSS_UtResult];[LSS_UtResult]LSS_Location_txt;>;[LSS_UtResult]LSS_RodNo_L;>)
//End if 
If (Is new record:C668([LSS_UT:175]))
	//must save UT record before we add results
	//save the current id
	C_TEXT:C284($UTID_s)
	$UTID_s:=[LSS_UT:175]LSS_UTId_s:1
	FM_SaveUT
	//load record - it gets unloaded in FM_SaveUT
	QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_UTId_s:1=$UTID_s)
	LOAD RECORD:C52([LSS_UT:175])
End if 
FORM SET INPUT:C55([LSS_UtResult:176]; "Input")
C_LONGINT:C283($Width_L; $Height_l)
FORM GET PROPERTIES:C674([LSS_UtResult:176]; "Input"; $Width_L; $Height_l)
Center_Window_2($Width_L; $Height_l; Plain window:K34:13)
ADD RECORD:C56([LSS_UtResult:176])
LSS_SelectUTResults_New

LSS_SetSaveandDelete
//End LSS_AddUTResultRecord