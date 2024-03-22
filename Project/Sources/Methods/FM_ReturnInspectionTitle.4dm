//%attributes = {"invisible":true}
//Method: FM_ReturnInspectionTitle
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/09/18, 14:36:46
	// ----------------------------------------------------
	//Created : 
	Mods_2018_01
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 17:57:23)
	Mods_2018_04
	//  `use DOM tree NTI_INSPREQUIREMENTSTREE_txt
	
End if 
//
C_TEXT:C284($0; $Name_txt)
C_TEXT:C284($prevErrHandler_txt)
$prevErrHandler_txt:=Method called on error:C704
ON ERR CALL:C155("XMLErrorHandler")

C_TEXT:C284($elemref_txt; $elemName_txt)
$elemref_txt:=ut_DOM_FindElmtRef(NTI_INSPREQUIREMENTSTREE_txt; "NTI_INSPREQ/INSPTYPE"; ->[TIN_Inspections:184]InspType:21)
DOM GET XML ATTRIBUTE BY NAME:C728($elemref_txt; "Name"; $elemName_txt)
//ON ERR CALL($prevErrHandler_txt)

$Name_txt:=Uppercase:C13($elemName_txt)+" TUNNEL INSPECTION"
$0:=$Name_txt
//End FM_ReturnInspectionTitle