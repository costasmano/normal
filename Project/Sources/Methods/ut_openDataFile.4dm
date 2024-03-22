//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/11, 15:47:19
	// ----------------------------------------------------
	// Method: ut_openDataFile
	// Description
	//  ` Open another data file
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
If (User in group:C338(Current user:C182; "Design Access Group"))
	C_TIME:C306($dataFile_t)
	$dataFile_t:=Open document:C264(""; "4DD"; Read mode:K24:5)
	If (OK=1)
		C_TEXT:C284($dataFile_txt)
		$dataFile_txt:=Document
		CLOSE DOCUMENT:C267($dataFile_t)
		OPEN DATA FILE:C312($dataFile_txt)
	End if 
End if 