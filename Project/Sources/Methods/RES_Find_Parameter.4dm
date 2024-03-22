//%attributes = {"invisible":true}
//Method: RES_Find_Parameter
//Description
// Find the record in [parameters] that corresponds to a resources file.
// Parameters
// $0 : $Param_txt
// $1 : $Resource file Folder
// $2 : $Resourcefile

// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/26/19, 10:14:37
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
	
	C_TEXT:C284(RES_Find_Parameter; $0)
	C_TEXT:C284(RES_Find_Parameter; $1)
	C_TEXT:C284(RES_Find_Parameter; $2)
	
End if 
//

C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($Dom_txt; $ResFolder_txt; $ResFile_txt; $ParamName_txt; $ParameterSource_txt; $resParamTree_txt)

$ResFolder_txt:=$1
$ResFile_txt:=$2

READ ONLY:C145([Parameters:107])

$ParameterSource_txt:=ut_GetSysParameter("RES_PARAM_XREF")
ON ERR CALL:C155("XMLErrorHandler")
$resParamTree_txt:=DOM Parse XML variable:C720($ParameterSource_txt)
ARRAY TEXT:C222($FileRefs_atxt; 0)
C_TEXT:C284($FileRef_txt)
//this is just a test
$FileRef_txt:=DOM Find XML element:C864($resParamTree_txt; "Root/Folder/File/Parameter"; $FileRefs_atxt)
//DOM GET XML ELEMENT VALUE($FileRefs_atxt{1};$folderName_txt)
ON ERR CALL:C155("")
$ParameterSource_txt:=""
$ParamName_txt:=""
If (Size of array:C274($FileRefs_atxt)>0)
	//There are valid references in the xml - try to use them 
	ARRAY TEXT:C222($FileRefs_atxt; 0)
	ARRAY TEXT:C222($FolderRefs_atxt; 0)
	C_TEXT:C284($FolderRef_txt; $folderName_txt; $ParamName_txt; $FileName_txt; $ParamRef_txt)
	
	$FolderRef_txt:=DOM Find XML element:C864($resParamTree_txt; "Root/Folder"; $FolderRefs_atxt)
	C_LONGINT:C283($Folderloop_L; $FileLoop_L)
	For ($Folderloop_L; 1; Size of array:C274($FolderRefs_atxt))
		DOM GET XML ELEMENT VALUE:C731($FolderRefs_atxt{$Folderloop_L}; $folderName_txt)
		$folderName_txt:=f_TrimStr($folderName_txt; True:C214; True:C214)
		If ($folderName_txt=$ResFolder_txt)
			//get the files
			$FileRef_txt:=DOM Find XML element:C864($FolderRefs_atxt{$Folderloop_L}; "Folder/File"; $FileRefs_atxt)
			
			For ($FileLoop_L; 1; Size of array:C274($FileRefs_atxt))
				DOM GET XML ELEMENT VALUE:C731($FileRefs_atxt{$FileLoop_L}; $FileName_txt)
				$FileName_txt:=f_TrimStr($FileName_txt; True:C214; True:C214)
				If ($FileName_txt=$ResFile_txt)
					$ParamRef_txt:=DOM Find XML element:C864($FileRefs_atxt{$FileLoop_L}; "File/Parameter")
					DOM GET XML ELEMENT VALUE:C731($ParamRef_txt; $ParamName_txt)
					$ParamName_txt:=f_TrimStr($ParamName_txt; True:C214; True:C214)
					//exit file and folder loop
					$FileLoop_L:=Size of array:C274($FileRefs_atxt)+1
					$Folderloop_L:=Size of array:C274($FolderRefs_atxt)+1
				End if 
				
			End for 
			
			//exit folder loop.
			$Folderloop_L:=Size of array:C274($FolderRefs_atxt)+1
		End if 
	End for 
	
End if 

$0:=$ParamName_txt
//End RES_Find_Parameter