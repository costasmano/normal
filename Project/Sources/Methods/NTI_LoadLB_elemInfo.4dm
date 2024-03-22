//%attributes = {"invisible":true}
//Method: NTI_LoadLB_elemInfo
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 16:55:43
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_POINTER:C301(NTI_LoadLB_elemInfo; $1; $2; $3; $4)
	// Modified by: Costas Manousakis-(Designer)-(1/12/18 12:47:39)
	Mods_2018_01
	//  `for elements with unit=percent do not show anything in QorP
End if 
//
C_POINTER:C301($1; $2; $3; $4)

C_POINTER:C301($Key_ptr; $QorP_ptr; $Parentkey_ptr)
Case of 
	: ($4=(->[NTI_ELEM_BIN_INSP:183]))
		$Key_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3
		$QorP_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_QorP:16
		$Parentkey_ptr:=->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7
		
	: ($4=(->[NTI_ELEM_TIN_INSP:185]))
		$Key_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3
		$QorP_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_QorP:16
		$Parentkey_ptr:=->[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7
End case 
QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$Key_ptr->)
$1->:=[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11
$2->:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
If ($QorP_ptr->)
	$3->:="Q"
Else 
	$3->:="%"
End if 
If (($Parentkey_ptr->>0) & ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y"))
	// need units of parent of defects
	QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$Parentkey_ptr->)
	$2->:=[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12
End if 
If ($2->="percent")
	$3->:=""
End if 
//End NTI_LoadLB_elemInfo