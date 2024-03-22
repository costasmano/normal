//%attributes = {"invisible":true}
//Method: Compiler_MoveResources
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/20/18, 16:03:16
	// ----------------------------------------------------
	//Created : 
	Mods_2018_11
End if 
//
ARRAY BOOLEAN:C223(v_1_004_ab; 0)
ARRAY TEXT:C222(v_1_150_atxt; 0)
C_TEXT:C284(v_1_150_txt)
ARRAY TEXT:C222(LBGeneric_atxt; 0)
If (False:C215)
	C_BOOLEAN:C305(Resource_FolderStructure; $0)
	C_TEXT:C284(Resource_FolderStructure; $1)
	C_TEXT:C284(Resource_FolderStructure; $2)
	C_BOOLEAN:C305(Server_SaveDocToResourceFolder; $0)
	C_TEXT:C284(Server_SaveDocToResourceFolder; $1)
	C_TEXT:C284(Server_SaveDocToResourceFolder; $2)
	C_BLOB:C604(Server_SaveDocToResourceFolder; $3)
	
	C_BLOB:C604(Server_ReturnResourceStructure; $0)
	C_BLOB:C604(Server_ReturnResourceFile; $0)
	C_TEXT:C284(Server_ReturnResourceFile; $1)
	C_BLOB:C604(Resource_SaveFileOnServer; $1)
	C_TEXT:C284(Resource_SaveFileOnServer; $0)
End if 



//End Compiler_MoveResources