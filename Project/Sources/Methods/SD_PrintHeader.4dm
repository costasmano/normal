//%attributes = {"invisible":true}
// ----------------------------------------------------
// SD_PrintHeader
// User name (OS): cjmiller
// Date and time: 11/09/04, 16:41:42
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2005_CJM01
	
End if 
C_TEXT:C284($1; $FormToPrint_txt)
$FormToPrint_txt:=$1
PAGE BREAK:C6(>)  //force all to be in one job
Print form:C5([SD_History:89]; "SummaryHeader.rpt")
Print form:C5([SD_History:89]; "SummarySubHeader.rpt")
Print form:C5([SD_History:89]; $FormToPrint_txt)

//End SD_PrintHeader