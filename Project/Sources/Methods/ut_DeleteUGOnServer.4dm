//%attributes = {"invisible":true}
//Method: ut_DeleteUGOnServer
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/29/21, 15:57:10
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04
	
End if 
//
C_TEXT:C284($1)
UG_deleteSelectedFile($1)

C_BLOB:C604($Blob_blb)
$Blob_blb:=ut_ReturnUGFilesFromServer
C_LONGINT:C283($Offset_L)
$Offset_L:=0
C_TEXT:C284(v_1_225_txt)
ARRAY TIME:C1223(v_1_193_atm; 0)
ARRAY DATE:C224(v_1_214_ad; 0)
ARRAY TEXT:C222(v_1_225_atxt; 0)
BLOB TO VARIABLE:C533($Blob_blb; v_1_225_txt; $Offset_L)  //folder
BLOB TO VARIABLE:C533($Blob_blb; v_1_225_atxt; $Offset_L)  //files
BLOB TO VARIABLE:C533($Blob_blb; v_1_214_ad; $Offset_L)  //created date
BLOB TO VARIABLE:C533($Blob_blb; v_1_193_atm; $Offset_L)  //created time

//End ut_DeleteUGOnServer