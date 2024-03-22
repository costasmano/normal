If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/24/11, 15:39:54
	// ----------------------------------------------------
	// Method: Object Method: TMPL_LoadFile_L
	// Description
	// Load a file in the template
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_06
End if 
C_TIME:C306($File_t)
C_TEXT:C284($FullPath_txt; $FileName_txt; TMPL_FileName_txt)
C_BLOB:C604($DocBlob_x; $FullBlob_x)
If (BLOB size:C605([Templates:86]Template_:3)>0)
	C_LONGINT:C283($offset_L)
	$offset_L:=0
	BLOB TO VARIABLE:C533([Templates:86]Template_:3; $FileName_txt; $offset_L)
	BLOB TO VARIABLE:C533([Templates:86]Template_:3; $DocBlob_x; $offset_L)
	C_TEXT:C284($PathToStore_txt)
	$PathToStore_txt:=Select folder:C670("Select Folder to store the created file")
	If (OK=1)
		C_BOOLEAN:C305($Create_b)
		$Create_b:=True:C214
		If (Test path name:C476($PathToStore_txt+TMPL_FileName_txt)=Is a document:K24:1)
			//file exists!!! 
			$Create_b:=False:C215
			
			CONFIRM:C162("File "+TMPL_FileName_txt+" already exists!  Replace?"; "Cancel"; "Replace")
			If (OK=0)
				$Create_b:=True:C214
			End if 
			
		End if 
		If ($Create_b)
			
			BLOB TO DOCUMENT:C526(($PathToStore_txt+TMPL_FileName_txt); $DocBlob_x)
			If (OK=1)
				ut_OpenDocument($PathToStore_txt+TMPL_FileName_txt)
			End if 
			
		End if 
		
	End if 
	
End if 

SET BLOB SIZE:C606($DocBlob_x; 0)
SET BLOB SIZE:C606($FullBlob_x; 0)