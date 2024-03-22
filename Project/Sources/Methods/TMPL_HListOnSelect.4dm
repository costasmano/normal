//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/25/08, 08:55:21
	// ----------------------------------------------------
	// Method: TMPL_HListOnSelect
	// Description
	// Custom method to act on the selection of an item in the
	// HList displayed on form [Dialogs];"ReportTemplateSelect"
	// 
	// Parameters
	// $0 : $ItemPos_L : the number of the valid item selected
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("HLISTSELECT")
	// Modified by: costasmanousakis-(Designer)-(10/2/11 11:58:06)
	Mods_2011_10
	//  `Verify the aHL_ReportTemplates is a list
End if 
C_LONGINT:C283($0; $ItemPos_L)
$ItemPos_L:=0

C_LONGINT:C283($vlItemRef; $hSublist; $ItemPos_L)
C_TEXT:C284($vsItemText)
C_BOOLEAN:C305($vbExpanded)
If (Is a list:C621(aHL_ReportTemplates))
	
	GET LIST ITEM:C378(aHL_ReportTemplates; Selected list items:C379(aHL_ReportTemplates); $vlItemRef; $vsItemText; $hSublist; $vbExpanded)
	If (Is a list:C621($hSublist))
		vSelectionDescription:=""
		OBJECT SET ENABLED:C1123(bOK; False:C215)  // Command Replaced was o_DISABLE BUTTON 
		OBJECT SET ENABLED:C1123(RptSaveToDisk; False:C215)  // Command Replaced was o_DISABLE BUTTON 
	Else 
		OBJECT SET ENABLED:C1123(bOK; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(RptSaveToDisk; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		$ItemPos_L:=Find in array:C230(atQRT_ReportNames; $vsItemText)
	End if 
	
End if 

$0:=$ItemPos_L