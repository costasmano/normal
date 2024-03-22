//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/16/11, 17:00:08
	// ----------------------------------------------------
	// Method: SIA_FieldPtr
	// Description
	//  ` return a pointer to an SIA field from a table - to match the name of a field in the main table
	// 
	// Parameters
	// $0 : $Fld_ptr
	// $1  : $Table_L : table for which to return the field
	// $2 : $SIAFld_ptr : pointer to a field in another table. used to get the name of a field in table $1
	// ----------------------------------------------------
	
	Mods_2011_09
End if 

C_LONGINT:C283($Table_L; $1)
C_POINTER:C301($0; $Fld_ptr)
C_POINTER:C301($2; $SIAFld_ptr)
$Table_L:=$1
$SIAFld_ptr:=$2
C_TEXT:C284($Tbl_txt; $Field_txt)
$Tbl_txt:=Table name:C256($Table_L)
$Field_txt:=Field name:C257($SIAFld_ptr)
EXECUTE FORMULA:C63("$Fld_ptr:=->["+$Tbl_txt+"]"+$Field_txt)

$0:=$Fld_ptr