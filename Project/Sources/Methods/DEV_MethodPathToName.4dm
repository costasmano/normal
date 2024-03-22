//%attributes = {"invisible":true}
//Method: DEV_MethodPathToName
//Description
// convert a Method path to method name
// Parameters
// $0 : $methodname_txt
// $1 : $Methodpath_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 2022-06-07T00:00:00, 20:09:22
	// ----------------------------------------------------
	//Created : 
	Mods_2022_06
	
	C_TEXT:C284(DEV_MethodPathToName; $0)
	C_TEXT:C284(DEV_MethodPathToName; $1)
End if 
//

C_TEXT:C284($methodname_txt; $methodPath_txt)
$methodPath_txt:=$1
C_LONGINT:C283($type)
C_POINTER:C301($Tbl_ptr)
C_TEXT:C284($objname_txt; $formobjname_txt)

METHOD RESOLVE PATH:C1165($methodPath_txt; $type; $Tbl_ptr; $objname_txt; $formobjname_txt)

Case of 
	: ($type=Path database method:K72:2)
		$methodname_txt:=$objname_txt
		
	: ($type=Path project form:K72:3)
		$methodname_txt:=$objname_txt
		
		If ($formobjname_txt="")
		Else 
			$methodname_txt:=$methodname_txt+"."+$formobjname_txt
		End if 
		
	: ($type=Path table form:K72:5)
		$methodname_txt:="["+Table name:C256($Tbl_ptr)+"]."+$objname_txt
		If ($formobjname_txt="")
		Else 
			$methodname_txt:=$methodname_txt+"."+$formobjname_txt
		End if 
		
	: ($type=Path project method:K72:1)
		$methodname_txt:=$objname_txt
		
	: ($type=Path trigger:K72:4)
		$methodname_txt:="Trigger on ["+Table name:C256($Tbl_ptr)+"]"
		
End case 

$0:=$methodname_txt
//End DEV_MethodPathToName