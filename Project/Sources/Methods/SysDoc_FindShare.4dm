//%attributes = {"invisible":true}
//Method: SysDoc_FindShare
//Description
// method used to find a share from a collection of mounted shares
// ex  $mountedShare_o:=$shares_c.find("SysDoc_FindShare";$share)
// Parameters
// $1 : $object
// $2 : $Sharename to look for
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Oct 5, 2022, 13:08:03
	Mods_2022_10
	// ----------------------------------------------------
	C_OBJECT:C1216(SysDoc_FindShare; $1)
	C_TEXT:C284(SysDoc_FindShare; $2)
End if 
//
C_OBJECT:C1216($1)
C_TEXT:C284($2)

$1.result:=$1.value.ShareName=$2
//End SysDoc_FindShare   