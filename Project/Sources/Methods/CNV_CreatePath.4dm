//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 06/07/16, 16:45:18
//----------------------------------------------------
//Method: CNV_CreatePath
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (6/7/16 16:49:10)
	
End if 

C_TEXT:C284($0; $1; $2; $PL_DirectorySep_txt; $StartFolder_txt; $InspectionYear_txt; $InspectionMonth_txt; $InpsectionID_txt; $Path_txt)
$PL_DirectorySep_txt:=$1
$StartFolder_txt:=$2
$InspectionYear_txt:=String:C10(Year of:C25([Inspections:27]Insp Date:78); "0000")
$StartFolder_txt:=Replace string:C233($StartFolder_txt; $InspectionYear_txt+":"; "")

$InspectionMonth_txt:=String:C10(Month of:C24([Inspections:27]Insp Date:78); "00")
$InpsectionID_txt:=String:C10([Inspections:27]InspID:2)
If (Test path name:C476($StartFolder_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($StartFolder_txt)
	
End if 

$Path_txt:=$StartFolder_txt+$InspectionYear_txt
If (Test path name:C476($Path_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($Path_txt)
	
End if 
$Path_txt:=$StartFolder_txt+$InspectionYear_txt+$PL_DirectorySep_txt+$InspectionMonth_txt
If (Test path name:C476($Path_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($Path_txt)
	
End if 
$Path_txt:=$StartFolder_txt+$InspectionYear_txt+$PL_DirectorySep_txt+$InspectionMonth_txt+$PL_DirectorySep_txt+$InpsectionID_txt
If (Test path name:C476($Path_txt)=Is a folder:K24:2)
Else 
	CREATE FOLDER:C475($Path_txt)
	
End if 
$0:=$Path_txt+$PL_DirectorySep_txt
//End CNV_CreatePath

