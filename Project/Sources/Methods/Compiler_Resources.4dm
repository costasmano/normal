//%attributes = {"invisible":true}
//Method: Compiler_Resources
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/24/20, 13:54:24
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01
End if 
//
If (False:C215)
	
	C_BLOB:C604(RES_Load_to_Blob; $0)
	C_TEXT:C284(RES_Load_to_Blob; $1)
	C_TEXT:C284(RES_Load_to_Blob; $2)
	
	C_TEXT:C284(RES_Find_Parameter; $0)
	C_TEXT:C284(RES_Find_Parameter; $1)
	C_TEXT:C284(RES_Find_Parameter; $2)
	
	C_OBJECT:C1216(RES_OpenResourceFile; $1)
	
End if 

//End Compiler_Resources