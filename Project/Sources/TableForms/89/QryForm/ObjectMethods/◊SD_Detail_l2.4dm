// ----------------------------------------------------
// Object Method: ◊SD_PrintHistory_l
// User name (OS): charlesmiller
// Date and time: 03/11/10, 15:41:01
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_03  //r002 CJ Miller`03/11/10, 15:57:19      `Add code to allow for printing different sections of the SD report
End if 
If (<>SD_PrintHistory_l=0) & (<>SD_PrintPosted_l=0)
	ALERT:C41("You must select one or both SD History and Posted History check boxes")
	<>SD_PrintHistory_l:=1
	<>SD_PrintPosted_l:=1
End if 
//End Object Method: ◊SD_PrintHistory_l