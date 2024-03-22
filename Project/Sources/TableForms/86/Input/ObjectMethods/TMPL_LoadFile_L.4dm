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
$File_t:=Open document:C264(""; ""; Read mode:K24:5)
If (Ok=1)
	$FullPath_txt:=Document
	CLOSE DOCUMENT:C267($File_t)
	DOCUMENT TO BLOB:C525($FullPath_txt; $DocBlob_x)
	If (Ok=1)
		$FileName_txt:=Replace string:C233($FullPath_txt; GetPath($FullPath_txt); "")
		TMPL_FileName_txt:=$FileName_txt
		VARIABLE TO BLOB:C532(TMPL_FileName_txt; $FullBlob_x)
		VARIABLE TO BLOB:C532($DocBlob_x; $FullBlob_x; *)
		[Templates:86]Template_:3:=$FullBlob_x
		PushChange(1; ->[Templates:86]Template_:3)
		
		Template_Size_L:=BLOB size:C605($FullBlob_x)
	End if 
	
End if 
SET BLOB SIZE:C606($DocBlob_x; 0)
SET BLOB SIZE:C606($FullBlob_x; 0)