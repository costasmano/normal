//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_CreateGenericDictionaryDoc
// User name (OS): charlesmiller
// Date and time: 12/30/10, 16:35:05
// ----------------------------------------------------
// Description
// This method will load parameter for MHD shared dictionary.
//It will create a blob with array of each word
//It will write document to extras folder on the server

//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2010_12  //r002 CJ Miller`12/30/10, 16:35:07      `
	Mods_2011_06  // CJ Miller`06/20/11, 10:30:47      ` Type all local variables for v11
End if 

C_BOOLEAN:C305($Process_b; $Not4DServer_b)
$Process_b:=True:C214
$Not4DServer_b:=False:C215
C_TEXT:C284($Path_txt)
If (Application type:C494#4D Server:K5:6)
	CONFIRM:C162("Are You sure you want to run this locally")
	$Not4DServer_b:=True:C214
	If (OK=0)
		$Process_b:=False:C215
	End if 
Else 
	$Path_txt:=Get 4D folder:C485(_o_Extras folder:K5:12)+"MHD_Dictionary.txt"
End if 
If ($Process_b)
	QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="MHD Dictionary")
	C_BLOB:C604($Blob_blb)
	
	SET BLOB SIZE:C606($Blob_blb; 0)
	
	$Blob_blb:=ut_ParseTextToArrayDelim([Parameters:107]Description:2; Char:C90(13))
	
	If (BLOB size:C605($Blob_blb)>0)
		If ($Not4DServer_b)
			C_TIME:C306($Doc)
			$Doc:=Create document:C266("")
			$Path_txt:=Document
			CLOSE DOCUMENT:C267($Doc)
			
			BLOB TO DOCUMENT:C526($Path_txt; $Blob_blb)
		Else 
			
			BLOB TO DOCUMENT:C526($Path_txt; $Blob_blb)
		End if 
	End if 
End if 

//End ut_CreateGenericDictionaryDoc