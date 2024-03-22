//%attributes = {"invisible":true}
//Method: RES_Load_to_Blob
//Description
// Load a resource file or data from a [parameter] record to a blob
// Parameters
// $0 : $Blob_x
// $1 : $ResFolder_txt
// $2 : $ResFile_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/26/19, 09:57:23
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
	
	C_BLOB:C604(RES_Load_to_Blob; $0)
	C_TEXT:C284(RES_Load_to_Blob; $1)
	C_TEXT:C284(RES_Load_to_Blob; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(4/16/19 17:48:43)
	Mods_2019_04
	//  `account for case when the ResFolder="" ie : at root of resources folder
End if 
//

C_BLOB:C604($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($Dom_txt; $ResFolder_txt; $ResFile_txt; $ParamName_txt; $ParameterSource_txt; $resParamTree_txt)
C_BLOB:C604($DocBlob_X)
$ResFolder_txt:=$1
$ResFile_txt:=$2

$ParamName_txt:=RES_Find_Parameter($ResFolder_txt; $ResFile_txt)
$ParameterSource_txt:=ut_GetSysParameter($ParamName_txt)

If ($ParameterSource_txt#"")
	//TEXT TO BLOB($ParameterSource_txt;$DocBlob_X;UTF8 text without length)
	TEXT TO BLOB:C554($ParameterSource_txt; $DocBlob_X)
	
Else 
	C_TEXT:C284($FileSpec_txt)
	If ($ResFolder_txt="")
		//at root of resources
		$FileSpec_txt:=Get 4D folder:C485(Current resources folder:K5:16)+$ResFile_txt
		
	Else 
		$FileSpec_txt:=Get 4D folder:C485(Current resources folder:K5:16)+$ResFolder_txt+<>PL_DirectorySep_s+$ResFile_txt
	End if 
	
	If (Test path name:C476($filespec_txt)=Is a document:K24:1)
		DOCUMENT TO BLOB:C525($FileSpec_txt; $DocBlob_X)
	Else 
		SET BLOB SIZE:C606($DocBlob_X; 0)
	End if 
End if 

$0:=$DocBlob_X
//End RES_Load_to_Blob