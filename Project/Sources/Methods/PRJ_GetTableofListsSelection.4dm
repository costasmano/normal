//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_GetTableofListsSelection
// User name (OS): cjmiller
// Date and time: 03/17/06, 11:12:53
// ----------------------------------------------------
// Description
// Thgis method will return the appropriate records for project selections
//
// Parameters
//$1 query parameter
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
End if 
C_TEXT:C284($1; $Query_txt)
$Query_txt:=$1
QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=$Query_txt)
QUERY SELECTION:C341([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=<>PRJ_SelectedData_txt+"@")
ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListValue_s:2; >)

//End PRJ_GetTableofListsSelection