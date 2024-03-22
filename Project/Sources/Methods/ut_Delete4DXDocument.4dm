//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/21/06, 17:49:21
	// ----------------------------------------------------
	// Method: ut_Delete4DXDocument
	// Description
	// Delete a document in a 4DX folder.
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis (4/22/09)
	Mods_2009_04
	//  `Use the new Get 4D folder(3) in v 2004 to get the set the 4DX folder in Client mode
	// Modified by: costasmanousakis-(Designer)-(8/31/10 15:50:37)
	Mods_2010_08
	//  `Added extra case for deleting documents on server so that both Mac4DX and Win4DX
	//  `documents are deleted
End if 
C_BOOLEAN:C305($0; $UseFile_b)
C_TEXT:C284($1; $FileName)
$FileName:=$1
$UseFile_b:=False:C215
C_BOOLEAN:C305($ServerMac4DX_b; $ServerWin4DX_b)
$ServerMac4DX_b:=False:C215
$ServerWin4DX_b:=False:C215
//TRACE
Startup_PL
Case of 
	: (Application type:C494=4D Server:K5:6)
		C_TEXT:C284($StructureName_txt)
		$StructureName_txt:=Structure file:C489
		C_TEXT:C284($Path_txt; $Path_2_txt)
		$StructureName_txt:=GetPath($StructureName_txt)
		$Path_txt:=$StructureName_txt+"Mac4DX"+<>PL_DirectorySep_s+$Filename
		If (Test path name:C476($Path_txt)=Is a document:K24:1)
			$ServerMac4DX_b:=True:C214
		End if 
		$Path_2_txt:=$StructureName_txt+"Win4DX"+<>PL_DirectorySep_s+$Filename
		If (Test path name:C476($Path_2_txt)=Is a document:K24:1)
			$ServerWin4DX_b:=True:C214
		End if 
		$UseFile_b:=$ServerMac4DX_b | $ServerWin4DX_b
		
	: (Application type:C494#4D Remote mode:K5:5)
		C_TEXT:C284($StructureName_txt)
		$StructureName_txt:=Structure file:C489
		C_TEXT:C284($Path_txt)
		$Path_txt:=GetPath($StructureName_txt)
		Case of 
			: (<>PL_LPlatfrm=2)  //mac
				$Path_txt:=$Path_txt+"Mac4DX"+<>PL_DirectorySep_s+$Filename
				If (Test path name:C476($Path_txt)=Is a document:K24:1)
					$UseFile_b:=True:C214
				End if 
			: (<>PL_LPlatfrm=3)  //windows
				$Path_txt:=$Path_txt+"Win4DX"+<>PL_DirectorySep_s+$Filename
				If (Test path name:C476($Path_txt)=Is a document:K24:1)
					$UseFile_b:=True:C214
				End if 
		End case 
		
	: (Application type:C494=4D Remote mode:K5:5)
		C_TEXT:C284($Path_txt)
		$Path_txt:=Get 4D folder:C485(4D Client database folder:K5:13)
		Case of 
			: (<>PL_LPlatfrm=2)  //mac
				$Path_txt:=$Path_txt+"Mac4DX"+<>PL_DirectorySep_s+$Filename
				If (Test path name:C476($Path_txt)=Is a document:K24:1)
					$UseFile_b:=True:C214
				End if 
			: (<>PL_LPlatfrm=3)  //windows
				$Path_txt:=$Path_txt+"Win4DX"+<>PL_DirectorySep_s+$Filename
				If (Test path name:C476($Path_txt)=Is a document:K24:1)
					$UseFile_b:=True:C214
				End if 
		End case 
End case 

If ($UseFile_b=True:C214)
	Case of 
		: (Application type:C494=4D Server:K5:6)
			If ($ServerMac4DX_b)
				DELETE DOCUMENT:C159($Path_txt)
				If (OK=0)  //we have an error
					$ServerMac4DX_b:=False:C215
				Else 
					
				End if 
			End if 
			If ($ServerWin4DX_b)
				DELETE DOCUMENT:C159($Path_2_txt)
				If (OK=0)  //we have an error
					$ServerWin4DX_b:=False:C215
				Else 
					
				End if 
			End if 
			
			$UseFile_b:=$ServerWin4DX_b & $ServerMac4DX_b
			
		Else 
			DELETE DOCUMENT:C159($Path_txt)
			If (OK=0)  //we have an error
				$UseFile_b:=False:C215
			Else 
				
			End if 
			
	End case 
	
End if 

$0:=$UseFile_b