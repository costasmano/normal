//%attributes = {"invisible":true}
//Method: NTI_ModifiedRecord
//Description
//
// Parameters
// $0 : $Modified_b
// $1 : $Table_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/18/16, 16:49:58
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_BOOLEAN:C305(NTI_ModifiedRecord; $0)
	C_POINTER:C301(NTI_ModifiedRecord; $1)
	// Modified by: Costas Manousakis-(Designer)-(6/24/21 10:03:13)
	Mods_2021_WP
	//  `
	
End if 
//
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_BOOLEAN:C305($Modified_b)

$Modified_b:=Modified record:C314($1->)

//  //C_LONGINT($viAreaMod)  //Command Replaced was o_C_INTEGER
//  //C_TEXT($vsStrValue)  // Command Replaced was o_C_STRING length was 2
//  //WR GET AREA PROPERTY (AreaElmComments;wr modified;$viAreaMod;$vsStrValue)

//$Modified_b:=$Modified_b | ($viAreaMod=1)

$0:=$Modified_b
//End NTI_ModifiedRecord