//%attributes = {"invisible":true}
// Method: PON_ElemSort
// Description
// method to return a sortable variable for the NBE elements
// 
// Parameters
// $0 : $sortvalue_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/18/15, 16:43:25
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 

C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 80
QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
C_TEXT:C284($myformat_txt; $parformat_txt)
Case of 
	: ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
		$myformat_txt:="200000"
	: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
		$myformat_txt:="100000"
	Else 
		$myformat_txt:="000000"
End case 

$0:=String:C10([PON_ELEM_INSP:179]ELEM_KEY:3; $myformat_txt)+String:C10([PON_ELEM_INSP:179]ENVKEY:5; "0")
If ([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4>0)
	QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)
	Case of 
		: ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
			$parformat_txt:="200000"
		: ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
			$parformat_txt:="100000"
		Else 
			$parformat_txt:="000000"
	End case 
	$0:=String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4; $parformat_txt)+String:C10([PON_ELEM_INSP:179]ENVKEY:5; "0")+$0
End if 
If ([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0)
	$parformat_txt:="000000"
	$0:=String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19; $parformat_txt)+String:C10([PON_ELEM_INSP:179]ENVKEY:5; "0")+$0
End if 
$0:=$0+((21-Length:C16($0))*"0")  //pad to 21 chars
//End PON_ElemSort