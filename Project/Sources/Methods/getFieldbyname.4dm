//%attributes = {"invisible":true}
// Method: getFieldbyname
// Description
// return a pointer to a field by table name and field name
// 
// Parameters
// $0 : $fld_ptr
// $1 : $tablename_txt (without the [ ] )
// $2 : $fieldname_txt
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 12/28/14, 10:47:50
	// ----------------------------------------------------
	// First Release
	Mods_2015_02
End if 

C_TEXT:C284($1; $2)
C_POINTER:C301($0)
C_POINTER:C301(makeBielief_p; $local_ptr)
makeBielief_p:=$local_ptr

ON ERR CALL:C155("Error Handler")
EXECUTE FORMULA:C63("makeBielief_p:=->["+$1+"]"+$2)
ON ERR CALL:C155("")
$0:=makeBielief_p