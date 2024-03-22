//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/05/10, 09:11:42
	// ----------------------------------------------------
	// Method: ARCHIVE_LoadDBF
	// Description
	//  ` Import an exported DBF file into tha [BridgeMHDNBISArchive] table
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_11
End if 

C_TIME:C306($importProj_t; $ImportFile_t)
C_BLOB:C604($importproj_x)
C_TEXT:C284($importProjFile_txt; $importFile_txt; $importFileName_txt)
ALERT:C41("Select Import PRoj Settings file")
$importProj_t:=Open document:C264("")
If (Ok=1)
	$importProjFile_txt:=Document
	CLOSE DOCUMENT:C267($importProj_t)
	DOCUMENT TO BLOB:C525($importProjFile_txt; $importproj_x)
	ALERT:C41("Select Import Data file")
	$ImportFile_t:=Open document:C264("")
	If (OK=1)
		$importFile_txt:=Document
		CLOSE DOCUMENT:C267($ImportFile_t)
		$importFileName_txt:=Replace string:C233($importFile_txt; GetPath($importFile_txt); "")
		
		C_DATE:C307(MHDARCHIVEDATE_D)
		C_TEXT:C284($YYYY; $MM; $DD)
		$YYYY:=Substring:C12($importFileName_txt; 1; Position:C15("_"; $importFileName_txt)-1)
		$importFileName_txt:=Substring:C12($importFileName_txt; (Length:C16($YYYY)+2))
		$MM:=Substring:C12($importFileName_txt; 1; Position:C15("_"; $importFileName_txt)-1)
		$importFileName_txt:=Substring:C12($importFileName_txt; (Length:C16($MM)+2))
		$DD:=Substring:C12($importFileName_txt; 1; Position:C15("."; $importFileName_txt)-1)
		$MHDARCHIVEDATE_txt:=$MM+"/"+$DD+"/"+$YYYY
		C_TEXT:C284(MHDARCHIVEREASON_TXT; $MHDARCHIVEDATE_txt)
		MHDARCHIVEREASON_TXT:=Request:C163("ARCHIVE REASON?"; "MONTHLYARCHIVE")
		If (OK=1)
			$MHDARCHIVEDATE_txt:=Request:C163("ARCHIVE DATE"; $MHDARCHIVEDATE_txt)
			If (Ok=1)
				MHDARCHIVEDATE_D:=Date:C102($MHDARCHIVEDATE_txt)
				If (MHDARCHIVEDATE_D#!00-00-00!)
					C_LONGINT:C283($ArchiveLoaded_L)
					SET QUERY DESTINATION:C396(Into variable:K19:4; $ArchiveLoaded_L)
					QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=MHDARCHIVEDATE_D; *)
					QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=MHDARCHIVEREASON_TXT)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($ArchiveLoaded_L>0)
						ALERT:C41("THERE ARE "+String:C10($ArchiveLoaded_L)+" EXISTING RECORDS IN TABLE [BridgeMHDNBISArchive] WITH THE SAME REASON AND DATE!!"+"!")
					Else 
						ALERT:C41("About to Launch Import Dialog. Need to verify the data on the import preview area"+"!")
						IMPORT DATA:C665($importFile_txt; $importproj_x; *)
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	End if 
	
End if 