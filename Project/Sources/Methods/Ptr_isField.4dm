//%attributes = {"invisible":true}
//Method: Ptr_isField
//Description
//  find if a pointer is a field and if it is one of the field types 
// Parameters
// $0 : $isField_b
// $1 : $pointer
// ${2} : $possible field types to check (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Jan 11, 2023, 16:58:52
	Mods_2023_01_bug
	// ----------------------------------------------------
	C_BOOLEAN:C305(Ptr_isField; $0)
	C_POINTER:C301(Ptr_isField; $1)
	C_LONGINT:C283(Ptr_isField; ${2})
	
End if 
//
//Ptr_isField (unPointeur_p {;type_l {;type2_l {.. ;typeN_l) -> bool 

C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_LONGINT:C283(${2})

C_BOOLEAN:C305($isField_b)
C_TEXT:C284($varName_t)
C_LONGINT:C283($table_l)
C_LONGINT:C283($field_l)
C_LONGINT:C283($type_l)
C_LONGINT:C283($i_l)
C_LONGINT:C283($params_l)

$isField_b:=False:C215
$params_l:=Count parameters:C259
ASSERT:C1129($params_l>0; Current method name:C684+" $1 missing")
Case of 
	: (Is nil pointer:C315($1))
		//pas bon
	: (Is a variable:C294($1))
		//pas bon
	Else 
		RESOLVE POINTER:C394($1; $varName_t; $table_l; $field_l)
		$isField_b:=(Is field number valid:C1000($table_l; $field_l))
		If ($isField_b) & ($params_l>1)  //on doit aussi contrôler le type
			$type_l:=Type:C295($1->)
			$i_l:=2
			Repeat 
				$isField_b:=($type_l=${$i_l})
				$i_l:=$i_l+1
			Until ($i_l>$params_l) | ($isField_b)
		End if 
End case 
$0:=$isField_b
//End Ptr_isField   