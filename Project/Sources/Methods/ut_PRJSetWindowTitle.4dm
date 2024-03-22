//%attributes = {"invisible":true}

// ----------------------------------------------------
// project Method: ut_PRJSetWindowTitle
// User name (OS): cjmiller
// Date and time: 05/30/07
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2  //add record number to output project lists
End if 
C_TEXT:C284($1; $WindowTitle_txt)
C_POINTER:C301($2; $File_Ptr)
$WindowTitle_txt:=$1
$File_Ptr:=$2
SET WINDOW TITLE:C213($WindowTitle_txt+" ["+String:C10(Records in selection:C76($File_Ptr->))+"] out of ["+String:C10(Records in table:C83($File_Ptr->))+"]")
