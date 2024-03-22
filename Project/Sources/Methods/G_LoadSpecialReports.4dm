//%attributes = {"invisible":true}
If (False:C215)
	
	// ----------------------------------------------------
	// User name (OS): vunguyen
	// User name (4D): Designer
	// Date and time: 11/08/05, 14:10:14
	// ----------------------------------------------------
	// Method: G_LoadSpecialReports
	// Description
	// Load the list of records based on the $1
	//
	// Parameters
	// $1 STRING - Text of Menu Item Passed in
	//
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(3/27/2007 10:01:14)
	Mods_2007_CM07
	Mods_2009_03  //CJM  r001   `03/06/09, 14:37:27`Upgrade from open form window to open window
	// Modified by: costasmanousakis-(Designer)-(12/23/10 09:58:06)
	Mods_2010_12
	//  `Save the selected item no in a process variable
End if 

C_TEXT:C284(vsPurpose)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($1)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($sReportName)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($FormWindow; $vlElem)
C_LONGINT:C283(SpecialReportSelected_L)
//this one will be used in [Dialogs];"SpecialReportSelect" form method 
vsPurpose:=$1

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "SpecialReportSelect"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$FormWindow:=Open form window([Dialogs];"SpecialReportSelect";13)
DIALOG:C40([Dialogs:21]; "SpecialReportSelect")
CLOSE WINDOW:C154($Win_l)

If ((OK=1) & (SpecialReportSelected_L>0))
	
	C_LONGINT:C283($ItemRef)
	GET LIST ITEM:C378(SpecialReports_HL; SpecialReportSelected_L; $ItemRef; $sReportName)
	$vlElem:=Find in array:C230(atSR_ReportNames; $sReportName)
	If ($vlElem>0)
		EXECUTE FORMULA:C63(atSR_MethodNames{$vlElem})
	End if 
	
End if 
If (Is a list:C621(SpecialReports_HL))
	CLEAR LIST:C377(SpecialReports_HL; *)
End if 

//Reset them when their jobs are done
vsPurpose:=""
ARRAY TEXT:C222(atSR_MethodNames; 0)
ARRAY TEXT:C222(atSR_ReportNames; 0)
ARRAY TEXT:C222(atSpecialReports; 0)