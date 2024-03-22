//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/15/11, 14:11:52
	// ----------------------------------------------------
	// Method: Method: ut_DeleteExtrasDoc
	// Description
	//  ` Delete a document from the list of folders specified from the 2nd param and on
	// 
	// Parameters
	// $0 : Success_B
	// $1 : $Filename_txt
	// $(2) : $Folder_txt - list of folders under the structure file to search into
	// ----------------------------------------------------
	
	Mods_2011_02
End if 

C_BOOLEAN:C305($0; $UseFile_b)
C_TEXT:C284($1; $FileName; ${2}; $Folder_txt)
$FileName:=$1
Startup_PL
C_LONGINT:C283($Loop_L)
//TRACE
For ($Loop_L; 2; Count parameters:C259)
	$Folder_txt:=${$Loop_L}
	If ($Folder_txt#"")
		$UseFile_b:=False:C215
		C_BOOLEAN:C305($ServerMac4DX_b; $ServerWin4DX_b)
		$ServerMac4DX_b:=False:C215
		$ServerWin4DX_b:=False:C215
		//
		Case of 
			: (Application type:C494=4D Server:K5:6)
				C_TEXT:C284($StructureName_txt)
				$StructureName_txt:=Structure file:C489
				C_TEXT:C284($Path_txt; $Path_2_txt)
				$StructureName_txt:=GetPath($StructureName_txt)
				$Path_txt:=$StructureName_txt+$Folder_txt+<>PL_DirectorySep_s+$Filename
				$ServerMac4DX_b:=(Test path name:C476($Path_txt)=Is a document:K24:1)
				$UseFile_b:=$ServerMac4DX_b
				
			: (Application type:C494#4D Remote mode:K5:5)
				C_TEXT:C284($StructureName_txt)
				$StructureName_txt:=Structure file:C489
				C_TEXT:C284($Path_txt)
				$Path_txt:=GetPath($StructureName_txt)
				$Path_txt:=$Path_txt+$Folder_txt+<>PL_DirectorySep_s+$Filename
				$UseFile_b:=(Test path name:C476($Path_txt)=Is a document:K24:1)
				
			: (Application type:C494=4D Remote mode:K5:5)
				C_TEXT:C284($Path_txt)
				$Path_txt:=Get 4D folder:C485(4D Client database folder:K5:13)
				$Path_txt:=$Path_txt+$Folder_txt+<>PL_DirectorySep_s+$Filename
				$UseFile_b:=(Test path name:C476($Path_txt)=Is a document:K24:1)
				
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
					
					$UseFile_b:=$ServerWin4DX_b & $ServerMac4DX_b
					
				Else 
					DELETE DOCUMENT:C159($Path_txt)
					If (OK=0)  //we have an error
						$UseFile_b:=False:C215
					Else 
						
					End if 
					
			End case 
			
		End if 
		
	End if 
	
End for 

$0:=$UseFile_b