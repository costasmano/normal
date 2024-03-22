//%attributes = {"invisible":true}
//Method: ut_DOM_GetElementIndex
//Description
// find the index in a DOM tree of an element value
// Parameters
// $0 : $Index_L
// $1 : $DomTree_txt
// $2 : $ElementPath_txt
// $3 : $FindElemValue_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/25/16, 16:58:26
	// ----------------------------------------------------
	//Created : 
	Mods_2016_04_bug
	
	C_LONGINT:C283(ut_DOM_GetElementIndex; $0)
	C_TEXT:C284(ut_DOM_GetElementIndex; $1)
	C_TEXT:C284(ut_DOM_GetElementIndex; $2)
	C_LONGINT:C283(ut_DOM_GetElementIndex; $3)
	
	// Modified by: Costas Manousakis-(Designer)-(4/6/18 13:49:03)
	Mods_2018_04
	//  `added error handler for the XML
End if 
//

C_LONGINT:C283($0; $Index_L)
C_TEXT:C284($1; $DomTree_txt)
C_TEXT:C284($2; $ElementPath_txt)
C_LONGINT:C283($3; $FindElemValue_L)

$DomTree_txt:=$1
$ElementPath_txt:=$2
$FindElemValue_L:=$3
C_TEXT:C284($elemRef_txt)
C_LONGINT:C283($elemValue_L)
ARRAY TEXT:C222($ElemeRefs_atxt; 0)
$Index_L:=-1

C_BOOLEAN:C305(XMLError_b)
XMLError_b:=False:C215
C_TEXT:C284($prevErrorHandler)
$prevErrorHandler:=Method called on error:C704
ON ERR CALL:C155("XMLErrorHandler")

$elemRef_txt:=DOM Find XML element:C864($DomTree_txt; $ElementPath_txt; $ElemeRefs_atxt)
If (Not:C34(XMLError_b))
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ElemeRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($ElemeRefs_atxt{$loop_L}; $elemValue_L)
		If ($elemValue_L=$FindElemValue_L)
			$Index_L:=$loop_L
			$loop_L:=Size of array:C274($ElemeRefs_atxt)+1
		End if 
	End for 
End if 
ON ERR CALL:C155($prevErrorHandler)
$0:=$Index_L
//End ut_DOM_GetElementIndex