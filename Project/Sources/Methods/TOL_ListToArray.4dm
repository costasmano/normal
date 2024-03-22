//%attributes = {"invisible":true}
//Method: TOL_ListToArray
//Description
// Load a list from the [Table of Lists] into an array
// Parameters
// $1 : $Listname_txt
// $2 : $Array_ptr (pointer to array - must be a text array)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/21/13, 16:15:12
	// ----------------------------------------------------
	//Created : 
	Mods_2013_08
End if 
//
ARRAY TEXT:C222(TOL_Values_atxt; 0)
C_TEXT:C284($1; $Listname_txt)
C_POINTER:C301($2; $Array_ptr)

$Listname_txt:=$1
$Array_ptr:=$2

C_TEXT:C284(SQL_txt)
SQL_txt:="Select [TableOfLists].ListValue_s from [TableOfLists] "
SQL_txt:=SQL_txt+" where [TableOfLists].ListName_s='"+$Listname_txt+"' "
SQL_txt:=SQL_txt+" order by [TableOfLists].ListSequence_l ASC, [TableOfLists].ListValue_s ASC into :TOL_Values_atxt ;"

Begin SQL
	execute immediate :SQL_txt
End SQL

If (Size of array:C274(TOL_Values_atxt)>0)
	//update target array only if the list was found
	COPY ARRAY:C226(TOL_Values_atxt; $Array_ptr->)
End if 

//End TOL_ListToArray