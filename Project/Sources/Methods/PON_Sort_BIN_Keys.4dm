//%attributes = {"invisible":true}
//Method: PON_Sort_BIN_Keys
//Description
//
// Parameters
// $0 : $SortValue_txt
// $1 : $SortOrder_txt  ">" | "ASC" | "<" | "DESC" (Optional def =">")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/22/17, 17:14:40
	// ----------------------------------------------------
	//Created : 
	Mods_2017_08
	
	C_TEXT:C284(PON_Sort_BIN_Keys; $0)
	C_TEXT:C284(PON_Sort_BIN_Keys; $1)
End if 
//
C_TEXT:C284($0; $SortValue_txt)
C_TEXT:C284($1; $SortOrder_txt)

If (Count parameters:C259>0)
	$SortOrder_txt:=$1
Else 
	$SortOrder_txt:=">"
End if 

$SortValue_txt:=[PON_ELEM_INSP:179]BRKEY:1
C_TEXT:C284($KeyMask_txt; $Filler_txt)
$KeyMask_txt:="00000"
QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=[PON_ELEM_INSP:179]ELEM_KEY:3)
C_LONGINT:C283($Key_L; $ParKey_L; $GrandParKey_L; $EnvKey_L)
Case of 
	: ($SortOrder_txt=">") | ($SortOrder_txt="ASC@")
		$Key_L:=[PON_ELEM_INSP:179]ELEM_KEY:3
		$ParKey_L:=[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4
		$GrandParKey_L:=[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19
		$EnvKey_L:=[PON_ELEM_INSP:179]ENVKEY:5
		$Filler_txt:=$KeyMask_txt
	: ($SortOrder_txt="<") | ($SortOrder_txt="DESC@")
		$Key_L:=99999-[PON_ELEM_INSP:179]ELEM_KEY:3
		$ParKey_L:=99999-[PON_ELEM_INSP:179]ELEM_PARENT_KEY:4
		$GrandParKey_L:=99999-[PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19
		$EnvKey_L:=9-[PON_ELEM_INSP:179]ENVKEY:5
		$Filler_txt:="99999"
End case 

If ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3#"Y") & ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4#"Y")
	$SortValue_txt:=$SortValue_txt+String:C10($Key_L; $KeyMask_txt)+String:C10($EnvKey_L; "0")+(2*$Filler_txt)
End if 
If ([PON_ELEM_DEFS:178]ELEM_PROTECT_SYS:3="Y")
	$SortValue_txt:=$SortValue_txt+String:C10($ParKey_L; $KeyMask_txt)+String:C10($EnvKey_L; "0")+String:C10($Key_L; $KeyMask_txt)+$Filler_txt
End if 

If ([PON_ELEM_DEFS:178]ELEM_SMART_FLAG:4="Y")
	
	If ([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19>0)
		$SortValue_txt:=$SortValue_txt+String:C10($GrandParKey_L; $KeyMask_txt)+String:C10($EnvKey_L; "0")+String:C10($ParKey_L; $KeyMask_txt)+String:C10($Key_L; $KeyMask_txt)
	Else 
		$SortValue_txt:=$SortValue_txt+String:C10($ParKey_L; $KeyMask_txt)+String:C10($EnvKey_L; "0")+$Filler_txt+String:C10($Key_L; $KeyMask_txt)
	End if 
	
End if 

$0:=$SortValue_txt
//End PON_Sort_BIN_Keys