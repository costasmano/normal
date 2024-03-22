//%attributes = {"invisible":true}
// Method: ut_CreateMSOfficeDoc
// Description
//  ` Create an MS office document
// 
// Parameters
// $0 : $FilePath_txt
// $1 : $Extension_txt
// $2 : $TranslExt_txt = should be a 4 char MAC file type
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/07/10, 08:04:19
	// ----------------------------------------------------
	
	Mods_2010_09
	// Modified by: costasmanousakis-(Designer)-(3/11/11 16:37:12)
	Mods_2011_03
	//  `Modified logic in the Mac OS enviroment; added ON ERR CALL("ut_MakeDocErrorHandler")
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(12/26/17 13:06:34)
	Mods_2017_12
	//  `instead of create document use select document with the File name entry option - eventually will allow for a default name to be specified
End if 
C_TEXT:C284($0; $FilePath_txt; $fileExtension)
C_TEXT:C284($1; $Extension_txt)
C_TEXT:C284($2; $TranslExt_txt)

$Extension_txt:=$1
$TranslExt_txt:=$2
C_TIME:C306($doc_t)
C_TEXT:C284($Creator_txt; $FileType_txt; $TestFilePath_txt; $OrigFile_txt)
$Creator_txt:="????"
$FileType_txt:="    "
Case of 
	: ($Extension_txt=".XLS")
		$Creator_txt:="MSXL"
		$FileType_txt:="xls"
		//_O_MAP FILE TYPES($TranslExt_txt; "XLS"; "Excel Document")  //??
		
	: ($Extension_txt=".DOC")
		$Creator_txt:="MSWD"
		$FileType_txt:="doc"
		//_O_MAP FILE TYPES($TranslExt_txt; "DOC"; "Word Document")  //??
		//MAP FILE TYPES("RTF ";"DOC";"Word Document")
		//MAP FILE TYPES($TranslExt_txt;"DOC";"Word Document")
		
End case 
C_BOOLEAN:C305($Done_B)
Repeat 
	$FilePath_txt:=""
	$Done_B:=False:C215
	C_LONGINT:C283(SYS_WriteDocError)
	SYS_WriteDocError:=0
	ON ERR CALL:C155("ut_MakeDocErrorHandler")
	
	$FilePath_txt:=Select document:C905(""; ".doc"; "Select file to save"; File name entry:K24:17)
	
	//$doc_t:=create document("";$TranslExt_txt;)
	If (OK=1)
		$doc_t:=Create document:C266(Document)
		CLOSE DOCUMENT:C267($doc_t)
		$FilePath_txt:=Document
		$OrigFile_txt:=$FilePath_txt
		If (<>PL_LPlatfrm>2)
			//Windows platform
			If (Test path name:C476(Replace string:C233($FilePath_txt; $Extension_txt; $TranslExt_txt))=Is a document:K24:1)
				MOVE DOCUMENT:C540(Replace string:C233($FilePath_txt; $Extension_txt; $TranslExt_txt); $FilePath_txt)
			End if 
			$Done_B:=True:C214
		Else 
			//in MacOS
			//_ O _SET DOCUMENT CREATOR($FilePath_txt;$Creator_txt)
			$fileExtension:=GetFileExtension($FilePath_txt)
			If ($fileExtension#$Extension_txt)
				If ($fileExtension#"")
					$TestFilePath_txt:=Replace string:C233($FilePath_txt; $fileExtension; "")
				Else 
					$TestFilePath_txt:=$FilePath_txt
				End if 
				
				If (Test path name:C476($TestFilePath_txt+$Extension_txt)=Is a document:K24:1)
					//same name with .doc exists already - delete it first
					CONFIRM:C162("File "+$TestFilePath_txt+$Extension_txt+" Exists Already! Replace or Try Again?"; "Replace"; "Try Again")
					If (OK=1)
						DELETE DOCUMENT:C159($TestFilePath_txt+$Extension_txt)
						If ((OK=1) & (SYS_WriteDocError=0))
							MOVE DOCUMENT:C540($FilePath_txt; ($TestFilePath_txt+$Extension_txt))  //add the extension- don't replace it
							$FilePath_txt:=$TestFilePath_txt+$Extension_txt
							$Done_B:=True:C214
						Else 
							//Could not delete
							CONFIRM:C162("File "+$TestFilePath_txt+$Extension_txt+" Could not be Replaced!"+" File is possible locked or open by anoither application. "+" Try Again?"; "Try Again"; "Cancel")
							If (Ok=1)
							Else 
								$Done_B:=True:C214
								$FilePath_txt:=""
							End if 
							
						End if 
					Else 
						
					End if 
				Else 
					MOVE DOCUMENT:C540($FilePath_txt; ($TestFilePath_txt+$Extension_txt))  //add the extension- don't replace it
					$FilePath_txt:=$TestFilePath_txt+$Extension_txt
					$Done_B:=True:C214
				End if 
				If (Test path name:C476($OrigFile_txt)=Is a document:K24:1)
					//if the file we created still exists for some reason - delete it
					DELETE DOCUMENT:C159($OrigFile_txt)
				End if 
				
			Else 
				//try to delete it anyway and recreate it
				DELETE DOCUMENT:C159($FilePath_txt)
				If ((OK=1) & (SYS_WriteDocError=0))
					$doc_t:=Create document:C266($FilePath_txt)
					CLOSE DOCUMENT:C267($doc_t)
					$Done_B:=True:C214
				Else 
					CONFIRM:C162("File "+$FilePath_txt+" Could not be Replaced!"+" File is possible locked or open by anoither application. "+" Try Again?"; "Try Again"; "Cancel")
					If (Ok=1)
					Else 
						$Done_B:=True:C214
						$FilePath_txt:=""
					End if 
					
				End if 
				
			End if 
			
		End if 
	Else 
		$Done_B:=True:C214
		
	End if 
	ON ERR CALL:C155("")
	
Until ($Done_B)

$0:=$FilePath_txt