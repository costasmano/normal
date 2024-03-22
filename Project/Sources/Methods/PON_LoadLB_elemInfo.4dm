//%attributes = {"invisible":true}
//Method: PON_LoadLB_elemInfo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/19/15, 16:47:35
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_POINTER:C301($1; $2; $3)

QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
$1->:=[PON_ELEM_DEFS:178]ELEM_SHORTNAME:10
$2->:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
If ([PON_ELEM_INSP:179]ELEM_QorP:29)
	$3->:="Q"
Else 
	$3->:="%"
End if 
If (([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0) & ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y"))
	// need units of parent of defects
	QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
	$2->:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
End if 

//End PON_LoadLB_elemInfo