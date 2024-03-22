//%attributes = {"invisible":true}
//Method: RES_OpenResourceFile
//Description
// copy a resource file to a temp doc and open it.
// Parameters
// $1 : $OpenSpecs_o : object with attributes
//  // o.FileName : filespec in resources folder in POSIX format
//  // o.Description : description of file
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/20, 09:49:02
	// ----------------------------------------------------
	//Created : 
	Mods_2020_05
	
	C_OBJECT:C1216(RES_OpenResourceFile; $1)
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return correct type
End if 
//

C_OBJECT:C1216($1)

C_TEXT:C284($pdfgile_txt; $FileSpec; $Description)
$FileSpec:=OB Get:C1224($1; "FileName"; Is text:K8:3)
$Description:=OB Get:C1224($1; "Description"; Is text:K8:3)
$FileSpec:=Replace string:C233($FileSpec; "/"; Folder separator:K24:12)
$pdfgile_txt:=Get 4D folder:C485(Current resources folder:K5:16)+$FileSpec
If (Test path name:C476($pdfgile_txt)=Is a document:K24:1)
	If (Get document size:C479($pdfgile_txt)>0)
		C_TEXT:C284($tempName_txt)
		$tempName_txt:=Substring:C12(String:C10(Current date:C33(*); ISO date:K1:8); 1; 10)+" "+String:C10(Current time:C178(*); HH MM SS:K7:1)
		$tempName_txt:=Replace string:C233($tempName_txt; ":"; "")
		$tempName_txt:=Replace string:C233($tempName_txt; "-"; "")
		$tempName_txt:=String:C10(Current process:C322; "00000")+"-"+$tempName_txt
		$tempName_txt:=Temporary folder:C486+$tempName_txt+".pdf"
		COPY DOCUMENT:C541($pdfgile_txt; $tempName_txt; *)
		If (OK=1)
			ut_OpenDocument($tempName_txt)
		Else 
			ALERT:C41("Error Opening "+$Description+"!")
		End if 
	End if 
Else 
	ALERT:C41("Cannot Find "+$Description+"!")
End if 
//End RES_OpenResourceFile