//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mnt_GetReportType
// User name (OS): charlesmiller
// Date and time: 03/06/09, 14:32:40
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Define report type to generate a summary
//Created : May-2005
If (False:C215)
	Mods_2009_03  //CJM  r001   `03/06/09, 14:32:58`Upgrade from open form window to open window
End if 
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 12
C_LONGINT:C283($FormWindow)
C_LONGINT:C283(r1; r2; r3)  //Command Replaced was o_C_INTEGER
r1:=0
r2:=0
r3:=0
$0:=""

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "MntReportType"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")

//$FormWindow:=Open form window([Dialogs];"MntReportType";13)
DIALOG:C40([Dialogs:21]; "MntReportType")
CLOSE WINDOW:C154($Win_l)
If (OK=1)
	Case of 
		: (r1=1)
			$0:="Assignment"
		: (r2=1)
			$0:="Cost"
		: (r3=1)
			$0:="Payment"
	End case 
End if 
//End Mnt_GetReportType