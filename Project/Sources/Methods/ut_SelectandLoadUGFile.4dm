//%attributes = {"invisible":true}
//Method: ut_SelectandLoadUGFile
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 04/13/21, 14:59:30
	// ----------------------------------------------------
	//Created : 
	Mods_2021_04  //Added code to allow for selected of previously saved Users and Group File
	//Modified by: CJ (4/13/21 15:57:01) 
End if 
//
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
C_LONGINT:C283($win_L)
$win_L:=Open form window:C675("UserandGroupFiles"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("UserandGroupFiles")
CLOSE WINDOW:C154

//End ut_SelectandLoadUGFile