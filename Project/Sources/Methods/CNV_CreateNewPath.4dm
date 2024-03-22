//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/07/16, 16:45:18
//----------------------------------------------------
//Method: CNV_CreateNewPath
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/7/16 16:49:10)
	
End if 

Compiler_CNV

C_TEXT:C284($0; $1; $2; $PL_DirectorySep_txt; $StartFolder_txt; $InspectionPart_txt; $InspectionID_txt; $Path_txt)
$InspectionID_txt:=$1
$StartFolder_txt:=$2
C_LONGINT:C283($InspectionNumber_L)
$InspectionNumber_L:=Num:C11($InspectionID_txt)
$InspectionPart_txt:=Substring:C12(String:C10(Num:C11($InspectionID_txt); "000000"); 4)


If (Test path name:C476($StartFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($StartFolder_txt)
End if 

$Path_txt:=$StartFolder_txt+$InspectionPart_txt
If (Test path name:C476($Path_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($Path_txt)
End if 
$Path_txt:=$StartFolder_txt+$InspectionPart_txt+Folder separator:K24:12+$InspectionID_txt
If (Test path name:C476($Path_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($Path_txt)
	
End if 

$0:=$Path_txt+Folder separator:K24:12
//End CNV_CreatePath

