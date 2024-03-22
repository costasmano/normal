//%attributes = {"invisible":true}
//Method: NTI_ElmtRemarksArea
//Description
//
// Parameters
//$1 : NoteField Ptr
//$2: 4DWrArea
//$3 : FormEvent (optional)
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/18/16, 16:02:24
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_POINTER:C301(NTI_ElmtRemarksArea; $1)
	C_LONGINT:C283(NTI_ElmtRemarksArea; $2)
	C_LONGINT:C283(NTI_ElmtRemarksArea; $3)
	Mods_2021_Delete
	
End if 
//  //
//C_POINTER($1)

//C_LONGINT($2;$MyArea)
//$MyArea:=$2
//C_LONGINT($FormEvent_L)
//If (Count parameters>2)
//C_LONGINT($3)
//$FormEvent_L:=$3
//Else 
//$FormEvent_L:=Form event
//End if 

//Case of 
//: ($FormEvent_L=On Load)

//WR EXECUTE COMMAND ($MyArea;wr cmd new)
//Set Doc Margins ($MyArea)
//If (BLOB size($1->)>0)
//WR INSERT STYLED TEXT ($MyArea;$1->)
//End if 
//WR SET AREA PROPERTY ($MyArea;wr modified;0;"")  //pretend area is not modified

//: ($FormEvent_L=On Losing Focus)
//C_LONGINT($mod_L)
//C_TEXT($vsStrValue)
//WR GET AREA PROPERTY ($MyArea;wr modified;$mod_L;$vsStrValue)
//If ($mod_L=1)
//INSP_4DWRITE_SaveToFld ($MyArea;$1;PON_ChangeStackLvl_L)

//End if 
//End case 
//  //End NTI_ElmtRemarksArea