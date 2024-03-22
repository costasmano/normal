//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 17:49:21
	// ----------------------------------------------------
	// Method: ut_LoadBlobArrDoc
	// Description
	// Load a Blob document that contains arrays.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis (4/22/09)
	Mods_2009_04
	//  `Use the new Get 4D folder(3) in v 2004 to get the set the 4DX folder in Client mode
	Mods_2010_12  //r002 CJ Miller`12/30/10, 11:17:58      `Change placement of initialize files to Extras folder from either Win4DX or Mac4DX
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 
C_BOOLEAN:C305($0; $UseFile_b)
C_TEXT:C284($1; $FileName)
$FileName:=$1
C_BLOB:C604(vBLobDocArrays)
SET BLOB SIZE:C606(vBLobDocArrays; 0)
$UseFile_b:=False:C215

C_TEXT:C284($Path_txt)
Case of 
	: (Application type:C494#4D Remote mode:K5:5)
		
		$Path_txt:=GetPath(Structure file:C489)+"Extras"+<>PL_DirectorySep_s+$Filename
		
	: (Application type:C494=4D Remote mode:K5:5)
		
		$Path_txt:=Get 4D folder:C485(4D Client database folder:K5:13)+"Extras"+<>PL_DirectorySep_s+$Filename
End case 
If (Test path name:C476($Path_txt)=Is a document:K24:1)
	$UseFile_b:=True:C214
End if 
If ($UseFile_b=True:C214)
	
	DOCUMENT TO BLOB:C525($Path_txt; vBlobDocArrays)
	If (OK=0)  //we have an error
		$UseFile_b:=False:C215
	Else 
		C_LONGINT:C283($viBlobCompr)
		BLOB PROPERTIES:C536(vBlobDocArrays; $viBlobCompr)
		If ($viBlobCompr#Is not compressed:K22:11)
			EXPAND BLOB:C535(vBlobDocArrays)
		End if 
		If (OK=0)  //we have an error
			$UseFile_b:=False:C215
		End if 
	End if 
End if 

$0:=$UseFile_b