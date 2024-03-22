//%attributes = {"invisible":true}
// Method: NTI_ElemSort_TIN
// Description
// calculate a string that sorts the NTI elements for printing, displaying and exporting.
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 05/20/16, 17:39:06
	// ----------------------------------------------------
	// First Release
	Mods_2016_NTE
	C_TEXT:C284(NTI_ElemSort_TIN; $0)  // old C_STRING length 80
	// Modified by: Costas Manousakis-(Designer)-(3/21/18 17:04:11)
	Mods_2018_03
	//  `additions for protective systems
End if 

C_TEXT:C284($0)  // old C_STRING length 80
QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_KEY:3)
C_TEXT:C284($myformat_txt; $parformat_txt)
Case of 
	: ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
		$myformat_txt:="200000"
		$0:=String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $myformat_txt)
	: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
		$myformat_txt:="100000"
		$0:=String:C10([NTI_ELEM_TIN_INSP:185]ELEM_KEY:3; $myformat_txt)
	Else 
		$myformat_txt:="000000"
		$0:=String:C10(ut_DOM_GetElementIndex(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; [NTI_ELEM_TIN_INSP:185]ELEM_KEY:3); $myformat_txt)
End case 

If ([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7>0)
	QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7)
	Case of 
		: ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
			$parformat_txt:="200000"
			$0:=String:C10([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $parformat_txt)+$0  //+String([NTI_ELEM_TIN_INSP]ENVKEY;"0")+$0
		: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			$parformat_txt:="100000"
			$0:=String:C10([NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7; $parformat_txt)+$0  //+String([NTI_ELEM_TIN_INSP]ENVKEY;"0")+$0
		Else 
			$parformat_txt:="000000"
			$0:=String:C10(ut_DOM_GetElementIndex(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; [NTI_ELEM_TIN_INSP:185]ELEM_PARENT_KEY:7); $parformat_txt)+$0
	End case 
End if 
If ([NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25>0)
	$parformat_txt:="000000"
	$0:=String:C10(ut_DOM_GetElementIndex(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; [NTI_ELEM_TIN_INSP:185]ELEM_GRANDPARENT_KEY:25); $parformat_txt)+$0
End if 
$0:=$0+((21-Length:C16($0))*"0")  //pad to 21 chars

//End NTI_ElemSort