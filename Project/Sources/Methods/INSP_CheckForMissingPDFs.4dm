//%attributes = {"invisible":true}
//Method: INSP_CheckForMissingPDFs
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 03/16/21, 13:20:51
	// ----------------------------------------------------
	//Created : 
	//Mods_2021_03
End if 
//

Compiler_SQL
Compiler_clone
CONFIRM:C162("Clone Inspections"; "Yes"; "No")
If (OK=1)
	clone_ControlClone
End if 
READ ONLY:C145(*)
C_TEXT:C284($ServerMask_txt; $baseSpec_txt; $MountVolume_txt; $MountLetter_txt)
$ServerMask_txt:=ut_GetSysParameter("SCRRPT_ServrMask"; "mhd-shared.massdot.trans.internal/shareddata/")

C_LONGINT:C283($PDFCount_L; $RecordsCount_L; $SetSize_L)

$baseSpec_txt:=ut_GetSysParameter("SCRRPT_InspAPProvedLoc_P"; "mhd-shared.massdot.trans.internal/shareddata/Boston/B-Inspection/ApprovedInspectionReportPDFs")
C_LONGINT:C283($StartLoop_L)

If (ut_isSharedFolderMounted($ServerMask_txt; $baseSpec_txt; ->$MountVolume_txt))
	
	C_BOOLEAN:C305($Proceed_B)
	C_TEXT:C284($Directory_txt)
	$Proceed_B:=True:C214
	ARRAY TEXT:C222($DirectoryParts_atxt; 0)
	ut_NewTextToArray($baseSpec_txt; ->$DirectoryParts_atxt; "/")
	If (Folder separator:K24:12=":")
		$StartLoop_L:=3
		$Directory_txt:=$DirectoryParts_atxt{2}
	Else 
		$Directory_txt:=""
		$StartLoop_L:=3
		$MountLetter_txt:=Substring:C12($MountVolume_txt; 1; 2)
	End if 
	For ($Loop_L; $StartLoop_L; Size of array:C274($DirectoryParts_atxt))
		$Directory_txt:=$Directory_txt+Folder separator:K24:12+$DirectoryParts_atxt{$Loop_L}
		If (Test path name:C476($Directory_txt)=Is a folder:K24:2)
		Else 
			$Proceed_B:=False:C215
		End if 
	End for 
	ALL RECORDS:C47([Inspection Type:31])
	ARRAY TEXT:C222($InspectionTypeCode_atxt; 0)
	ARRAY TEXT:C222($InspectionDescription_atxt; 0)
	C_LONGINT:C283($Loop_L)
	ARRAY LONGINT:C221($DuplicateRNs_al; 0)
	
	SELECTION TO ARRAY:C260([Inspection Type:31]Code:1; $InspectionTypeCode_atxt; [Inspection Type:31]Description:2; $InspectionDescription_atxt)
	For ($Loop_L; 1; Size of array:C274($InspectionDescription_atxt))
		$InspectionDescription_atxt{$Loop_L}:=Replace string:C233($InspectionDescription_atxt{$Loop_L}; "/"; "_")
		$InspectionDescription_atxt{$Loop_L}:=Replace string:C233($InspectionDescription_atxt{$Loop_L}; ":"; "_")
	End for 
	SET QUERY DESTINATION:C396(Into set:K19:2; "TotalSet")
	
	QUERY:C277([Inspections:27]; [Inspections:27]InspApproved:167=2; *)
	QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6#"PON")
	SET QUERY DESTINATION:C396(Into set:K19:2; "FRZSet")
	QUERY:C277([Inspections:27]; [Inspections:27]InspReviewed:12=2; *)
	QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Type:6="FRZ")
	UNION:C120("FRZSet"; "TotalSet"; "TotalSet")
	USE SET:C118("TotalSet")
	$SetSize_L:=Records in set:C195("TotalSet")
	$RecordsCount_L:=0
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	ARRAY LONGINT:C221($AllRecordNumbers_aL; 0)
	SELECTION TO ARRAY:C260([Inspections:27]; $AllRecordNumbers_aL)
	C_LONGINT:C283($Loc_L; $InnerLoop_L)
	C_TEXT:C284($Bin_txt; $InspType_txt)
	C_DATE:C307($query_d)
	ARRAY TEXT:C222($TownFolders_atxt; 0)
	FOLDER LIST:C473($Directory_txt; $TownFolders_atxt)
	C_TEXT:C284($Path_txt)
	C_OBJECT:C1216($progressTObj_o; $progressFObj_o)
	$progressTObj_o:=ProgressNew("Parsing Town Folders"; Size of array:C274($TownFolders_atxt); True:C214; ""; 3)
	SORT ARRAY:C229($TownFolders_atxt; >)
	$PDFCount_L:=0
	For ($Loop_L; 1; Size of array:C274($TownFolders_atxt))
		//Progress SET TITLE (OB Get($progressTObj_o;"progress");"Processing : "+$TownFolders_atxt{$Loop_L})
		
		UpdateProgressNew($progressTObj_o; $Loop_L)
		$Path_txt:=$Directory_txt+Folder separator:K24:12+$TownFolders_atxt{$Loop_L}
		ARRAY TEXT:C222($Files_atxt; 0)
		DOCUMENT LIST:C474($Path_txt; $Files_atxt; Recursive parsing:K24:13+Ignore invisible:K24:16)
		$progressFObj_o:=ProgressNew("Processing documents for "+$TownFolders_atxt{$Loop_L}; Size of array:C274($Files_atxt); True:C214; ""; 3)
		C_LONGINT:C283($TypeLoop_L; $Start_L)
		$PDFCount_L:=$PDFCount_L+Size of array:C274($Files_atxt)
		For ($InnerLoop_L; 1; Size of array:C274($Files_atxt))
			UpdateProgressNew($progressFObj_o; $InnerLoop_L)
			
			ARRAY TEXT:C222($Parts_atxt; 0)
			ut_NewTextToArray(Substring:C12($Files_atxt{$InnerLoop_L}; 2); ->$Parts_atxt; "-")
			$Bin_txt:=$Parts_atxt{2}
			$InspType_txt:=Replace string:C233($Parts_atxt{6}; ".pdf"; "")
			$query_d:=Date:C102($Parts_atxt{4}+"/"+$Parts_atxt{5}+"/"+$Parts_atxt{3})
			$Loc_L:=Find in array:C230($InspectionDescription_atxt; $InspType_txt)
			If ($InspectionTypeCode_atxt{$Loc_L}="FRZ")
				QUERY:C277([Inspections:27]; [Inspections:27]InspReviewed:12=2; *)
			Else 
				QUERY:C277([Inspections:27]; [Inspections:27]InspApproved:167=2; *)
			End if 
			QUERY:C277([Inspections:27];  & ; [Inspections:27]BIN:1=$Bin_txt; *)
			QUERY:C277([Inspections:27];  & ; [Inspections:27]Insp Date:78=$query_d)
			
			ARRAY TEXT:C222($types_atxt; 0)
			$Loc_L:=0
			Repeat 
				$Start_L:=$Loc_L+1
				$Loc_L:=Find in array:C230($InspectionDescription_atxt; $InspType_txt; $Start_L)
				If ($Loc_L>0)
					APPEND TO ARRAY:C911($types_atxt; $InspectionTypeCode_atxt{$Loc_L})
				End if 
			Until ($Loc_l<0)
			C_LONGINT:C283($delLoop_L)
			QUERY SELECTION WITH ARRAY:C1050([Inspections:27]Insp Type:6; $types_atxt)
			$RecordsCount_L:=$RecordsCount_L+Records in selection:C76([Inspections:27])
			If (Records in selection:C76([Inspections:27])>1)
				For ($delLoop_L; 1; Records in selection:C76([Inspections:27]))
					GOTO SELECTED RECORD:C245([Inspections:27]; $delLoop_L)
					APPEND TO ARRAY:C911($DuplicateRNs_al; Record number:C243([Inspections:27]))
					$Loc_L:=Find in array:C230($AllRecordNumbers_aL; Record number:C243([Inspections:27]))
					If ($Loc_L>0)
						DELETE FROM ARRAY:C228($AllRecordNumbers_aL; $Loc_L; 1)
					End if 
				End for 
			Else 
				$Loc_L:=Find in array:C230($AllRecordNumbers_aL; Record number:C243([Inspections:27]))
				If ($Loc_L>0)
					DELETE FROM ARRAY:C228($AllRecordNumbers_aL; $Loc_L; 1)
				End if 
				
			End if 
		End for 
		Progress QUIT(OB Get:C1224($progressFObj_o; "progress"))
	End for 
	Progress QUIT(OB Get:C1224($progressTObj_o; "progress"))
	
	ALERT:C41("There are "+String:C10(Size of array:C274($AllRecordNumbers_aL))+" missing reports")
	
	Compiler_FieldVariables(Table:C252(->[Inspections:27]))
	C_TEXT:C284($result_txt; $fileName_txt)
	$Path_txt:=System folder:C487(Documents folder:K41:18)+"CheckForDuplicates"
	If (Test path name:C476($Path_txt)=Is a folder:K24:2)
	Else 
		CREATE FOLDER:C475($Path_txt)
	End if 
	$Path_txt:=$Path_txt+Folder separator:K24:12
	
	CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $AllRecordNumbers_aL)
	ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Type:6; >; [Inspections:27]Insp Date:78; >)
	SELECTION TO ARRAY:C260([Inspections:27]BIN:1; v_27_001_atxt; \
		[Inspections:27]Insp Date:78; v_27_078_ad; \
		[Inspections:27]InspID:2; v_27_002_aL; \
		[Inspections:27]Insp Type:6; v_27_006_atxt; \
		[Inspections:27]Modified By:134; v_27_134_atxt; \
		[Inspections:27]DateCreated:135; v_27_135_ad; \
		[Inspections:27]TimeCreated:136; v_27_136_atm; \
		[Inspections:27]DateModified:137; v_27_137_ad; \
		[Inspections:27]TimeModified:138; v_27_138_atm)
	
	$result_txt:="BIN,Insp Date,Insp ID,Insp Type,Modified By,Created Date, Created time,Modified Date,Modified time\n"
	$result_txt:=$result_txt+ut_ArrayToText_CSV(","; ->v_27_001_atxt; \
		->v_27_078_ad; \
		->v_27_002_aL; \
		->v_27_006_atxt; \
		->v_27_134_atxt; \
		->v_27_135_ad; \
		->v_27_136_atm; \
		->v_27_137_ad; \
		->v_27_138_atm)
	$fileName_txt:="MissingPDFs_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".csv"
	TEXT TO DOCUMENT:C1237($Path_txt+$fileName_txt; $result_txt; UTF8 text without length:K22:17)
	
	//QR REPORT([Inspections];Char(1))
	
	ALERT:C41("There are "+String:C10(Size of array:C274($DuplicateRNs_al))+" Duplicates")
	
	CREATE SELECTION FROM ARRAY:C640([Inspections:27]; $DuplicateRNs_al)
	Compiler_FieldVariables(Table:C252(->[Inspections:27]))
	ORDER BY:C49([Inspections:27]; [Inspections:27]BIN:1; >; [Inspections:27]Insp Type:6; >; [Inspections:27]Insp Date:78; >)
	SELECTION TO ARRAY:C260([Inspections:27]BIN:1; v_27_001_atxt; \
		[Inspections:27]Insp Date:78; v_27_078_ad; \
		[Inspections:27]InspID:2; v_27_002_aL; \
		[Inspections:27]Insp Type:6; v_27_006_atxt; \
		[Inspections:27]Modified By:134; v_27_134_atxt; \
		[Inspections:27]DateCreated:135; v_27_135_ad; \
		[Inspections:27]TimeCreated:136; v_27_136_atm; \
		[Inspections:27]DateModified:137; v_27_137_ad; \
		[Inspections:27]TimeModified:138; v_27_138_atm)
	
	$result_txt:="BIN,Insp Date,Insp ID,Insp Type,Modified By,Created Date, Created time,Modified Date,Modified time\n"
	$result_txt:=$result_txt+ut_ArrayToText_CSV(","; ->v_27_001_atxt; \
		->v_27_078_ad; \
		->v_27_002_aL; \
		->v_27_006_atxt; \
		->v_27_134_atxt; \
		->v_27_135_ad; \
		->v_27_136_atm; \
		->v_27_137_ad; \
		->v_27_138_atm)
	
	$fileName_txt:="Duplicate_PDFS_"+Substring:C12(ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178); 1; 12)+".csv"
	TEXT TO DOCUMENT:C1237($Path_txt+$fileName_txt; $result_txt; UTF8 text without length:K22:17)
	
	
	ALERT:C41("$SetSize_L is "+String:C10($SetSize_L)+Char:C90(Carriage return:K15:38)+"$RecordsCount_L is "+String:C10($RecordsCount_L)+Char:C90(Carriage return:K15:38)+"$PDFCount_L is "+String:C10($PDFCount_L))
	
	//QR REPORT([Inspections];Char(1))
	
	
End if 
//End INSP_CheckForMissingPDFs