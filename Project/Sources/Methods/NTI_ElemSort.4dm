//%attributes = {"invisible":true}
//Method: NTI_ElemSort
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/21/16, 17:10:06
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	C_TEXT:C284(NTI_ElemSort; $0)  // was length of 80
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 80
QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
C_TEXT:C284($myformat_txt; $parformat_txt)
Case of 
	: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
		$myformat_txt:="100000"
		$0:=String:C10([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3; $myformat_txt)
	Else 
		$myformat_txt:="000000"
		$0:=String:C10(ut_DOM_GetElementIndex(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; [NTI_ELEM_BIN_INSP:183]ELEM_KEY:3); $myformat_txt)  //+String([NTI_ELEM_BIN_INSP]ENVKEY;"0")
End case 
If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7>0)
	QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7)
	Case of 
		: ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			$parformat_txt:="100000"
			$0:=String:C10([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7; $parformat_txt)+$0  //+String([NTI_ELEM_BIN_INSP]ENVKEY;"0")+$0
		Else 
			$parformat_txt:="000000"
			$0:=String:C10(ut_DOM_GetElementIndex(NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7); $parformat_txt)+$0  //+String([NTI_ELEM_BIN_INSP]ENVKEY;"0")
	End case 
End if 
$0:=$0+((21-Length:C16($0))*"0")  //pad to 21 chars
//End NTI_ElemSort
