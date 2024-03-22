//%attributes = {"invisible":true}

// ----------------------------------------------------
// User name (OS): Lori Peterson
// Date and time: 04/21/15, 14:12:39
// ----------------------------------------------------
// Method: LSS_SelectPictureFile
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
//C_BOOLEAN($Proceed_b)
ARRAY TEXT:C222($Files_atxt; 0)
C_TEXT:C284($Path_txt)
$Path_txt:=Select document:C905(""; ""; "Select picture or sketch to import"; Multiple files:K24:7; $Files_atxt)
//C_BOOLEAN($Proceed_b)
//$Proceed_b:=False
$0:=""
Case of 
	: (Size of array:C274($Files_atxt)=0)
	: (Size of array:C274($Files_atxt)>1)
	Else 
		$0:=$Files_atxt{1}
		//$Proceed_b:=True
End case 


//End method  ` Method: LSS_SelectPictureFile
