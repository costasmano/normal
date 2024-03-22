//%attributes = {"invisible":true}
//Method: NTI_CheckXMLvsDB
//Description
// check the XML in resources vs DEFS table data
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/02/18, 12:12:58
	// ----------------------------------------------------
	//Created : 
	Mods_2018_04
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
End if 
//
C_TEXT:C284($NTI_DEFECT_ELEM_TREE; $NTI_DEFECT_LANG_TREE)

CONFIRM:C162("Use Element defect tree in resources or choose a file?"; "Resources"; "File")
C_TEXT:C284($File_txt)
C_LONGINT:C283($DefFolder_L)
$DefFolder_L:=5
If (OK=1)
	//$NTI_DEFECT_ELEM_TREE:=DOM Parse XML source(Get 4D folder(Current resources folder)+"TIN"+<>PL_DirectorySep_s+"Element_DefectTree.xml")
	$NTI_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("TIN"; "Element_DefectTree.xml")
Else 
	$File_txt:=Select document:C905($DefFolder_L; ".xml"; "Select an Element_defect tree xml file"; 0)
	$NTI_DEFECT_ELEM_TREE:=DOM Parse XML source:C719(Document)
End if 
CONFIRM:C162("Use Defect Language tree in resources or choose a file?"; "Resources"; "File")

If (OK=1)
	//$NTI_DEFECT_LANG_TREE:=DOM Parse XML source(Get 4D folder(Current resources folder)+"TIN"+<>PL_DirectorySep_s+"Defect_Language.xml")
	$NTI_DEFECT_LANG_TREE:=ut_DOM_LoadXML("TIN"; "Defect_Language.xml")
Else 
	$File_txt:=Select document:C905($DefFolder_L; ".xml"; "Select a Defect language tree xml file"; 0)
	$NTI_DEFECT_LANG_TREE:=DOM Parse XML source:C719(Document)
End if 


READ ONLY:C145([NTI_ELEM_DEFS:182])
//parse the defect language first
ARRAY TEXT:C222($Errors_atxt; 0)

C_TEXT:C284($defectRef_txt; $stateRef_txt; $ElemRef_txt; $ElemCategory_txt; $ElemName_txt)
C_TEXT:C284($Errors_txt)
C_LONGINT:C283($loop_L; $defectVal_L; $ElemVal_L)
C_TEXT:C284($lastOnErr_txt; $ElemName_txt)

ARRAY TEXT:C222($DefectRefs_atxt; 0)
$defectRef_txt:=DOM Find XML element:C864($NTI_DEFECT_LANG_TREE; "NTIDEFECTLANG/Defect"; $DefectRefs_atxt)

$lastOnErr_txt:=Method called on error:C704
ON ERR CALL:C155("XMLErrorHandler")
For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
	DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
	DOM GET XML ATTRIBUTE BY NAME:C728($DefectRefs_atxt{$loop_L}; "Name"; $ElemName_txt)
	
	QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$defectVal_L)
	If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
		APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+" Not found in DB")
	Else 
		If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10#"Y")
			APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"has DefectFlag=["+[NTI_ELEM_DEFS:182]DEFECTFLAG:10+"]")
		End if 
		If (Position:C15([NTI_ELEM_DEFS:182]ELEM_LONGNAME:5; $ElemName_txt; 1; *)=1) & (Position:C15($ElemName_txt; [NTI_ELEM_DEFS:182]ELEM_LONGNAME:5; 1; *)=1)
		Else 
			APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Longname does not match"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5)
		End if 
		If (Position:C15([NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11; $ElemName_txt; 1; *)=1) & (Position:C15($ElemName_txt; [NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11; 1; *)=1)
		Else 
			APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Shortname does not match"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11)
		End if 
		If ([NTI_ELEM_DEFS:182]REPORTED:16="Y")
			APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"has [NTI_ELEM_DEFS]REPORTED=["+[NTI_ELEM_DEFS:182]REPORTED:16+"]")
		End if 
		If ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
			APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"has [NTI_ELEM_DEFS]ELEM_PROTECT_SYS=["+[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21+"]")
		End if 
		ARRAY TEXT:C222($StateRefs_atxt; 0)
		$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
		
		C_TEXT:C284($State_lang_txt; $DefectNotes_txt)
		C_LONGINT:C283($loop2_L; $state_L)
		ARRAY TEXT:C222($StateLang_atxt; 4)
		
		For ($loop2_L; 1; 4)
			$StateLang_atxt{$loop2_L}:=""
		End for 
		
		For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
			DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $State_lang_txt)
			$StateLang_atxt{$state_L}:=$State_lang_txt
		End for 
		
		$DefectNotes_txt:=""
		For ($loop2_L; 1; 4)
			$DefectNotes_txt:=$DefectNotes_txt+"<CS"+String:C10($loop2_L)+">"+$StateLang_atxt{$loop2_L}+"</CS"+String:C10($loop2_L)+">"
		End for 
		
		If (Position:C15([NTI_ELEM_DEFS:182]NOTES:17; $DefectNotes_txt; 1; *)=1) & (Position:C15($DefectNotes_txt; [NTI_ELEM_DEFS:182]NOTES:17; 1; *)=1)
		Else 
			APPEND TO ARRAY:C911($Errors_atxt; "XML Defect "+String:C10($defectVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Elem Notes do not match!"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]NOTES:17+Char:C90(Tab:K15:37)+$DefectNotes_txt)
		End if 
		
	End if 
	
End for 

ARRAY TEXT:C222($Elementrefs_atxt; 0)
$ElemRef_txt:=DOM Find XML element:C864($NTI_DEFECT_ELEM_TREE; "NTI_ELEMDEFECTS/Element"; $Elementrefs_atxt)
C_TEXT:C284($BinOnly_txt; $ProtSys_txt; $reported_txt; $Tinonly_txt; $unit_txt)
C_LONGINT:C283($subset_L)
For ($loop_L; 1; Size of array:C274($Elementrefs_atxt))
	ARRAY TEXT:C222($ElemDefects_atxt; 0)
	DOM GET XML ELEMENT VALUE:C731($Elementrefs_atxt{$loop_L}; $ElemVal_L)
	$ElemName_txt:=""
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Category"; $ElemCategory_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "BINOnly"; $BinOnly_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "ProtectiveSystem"; $ProtSys_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Reported"; $reported_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "SubsetKey"; $subset_L)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "TINOnly"; $Tinonly_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Name"; $ElemName_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elementrefs_atxt{$loop_L}; "Unit"; $unit_txt)
	
	QUERY:C277([NTI_ELEM_DEFS:182]; [NTI_ELEM_DEFS:182]ELEM_KEY:4=$ElemVal_L)
	
	If (Records in selection:C76([NTI_ELEM_DEFS:182])=0)
		APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Not Found in DB!")
	Else 
		
		If (Position:C15([NTI_ELEM_DEFS:182]ELEM_LONGNAME:5; $ElemName_txt; 1; *)=1) & (Position:C15($ElemName_txt; [NTI_ELEM_DEFS:182]ELEM_LONGNAME:5; 1; *)=1)
		Else 
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Longname does not match"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_LONGNAME:5)
		End if 
		If (Position:C15([NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11; $ElemName_txt; 1; *)=1) & (Position:C15($ElemName_txt; [NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11; 1; *)=1)
		Else 
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Shortname does not match"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_SHORTNAME:11)
		End if 
		If (Position:C15([NTI_ELEM_DEFS:182]ELEM_CATEGORY:1; $ElemCategory_txt; 1; *)=1) & (Position:C15($ElemCategory_txt; [NTI_ELEM_DEFS:182]ELEM_CATEGORY:1; 1; *)=1)
		Else 
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Category does not match"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_CATEGORY:1+Char:C90(Tab:K15:37)+$ElemCategory_txt)
		End if 
		If ([NTI_ELEM_DEFS:182]DEFECTFLAG:10="Y")
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has defect flag"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]DEFECTFLAG:10)
		End if 
		If ([NTI_ELEM_DEFS:182]ELEM_BINONLY:18#$BinOnly_txt)
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has BinOnly"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_BINONLY:18+Char:C90(Tab:K15:37)+$BinOnly_txt)
		End if 
		If ([NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19#$Tinonly_txt)
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has TINOnly"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_TIN_ONLY:19+Char:C90(Tab:K15:37)+$Tinonly_txt)
		End if 
		If ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21#$ProtSys_txt)
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has ELEM_PROTECT_SYS"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21+Char:C90(Tab:K15:37)+$ProtSys_txt)
		End if 
		If ([NTI_ELEM_DEFS:182]REPORTED:16#$reported_txt)
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has REPORTED"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]REPORTED:16+Char:C90(Tab:K15:37)+$reported_txt)
		End if 
		If ([NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12#$unit_txt)
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has ELEM_SCALEUNIT"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_SCALEUNIT:12+Char:C90(Tab:K15:37)+$unit_txt)
		End if 
		If ([NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13#$subset_L)
			APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has ELEM_SUBSET_KEY"+Char:C90(Tab:K15:37)+String:C10([NTI_ELEM_DEFS:182]ELEM_SUBSET_KEY:13)+Char:C90(Tab:K15:37)+String:C10($subset_L))
		End if 
		
		If ($ElemCategory_txt="@Protective system@")
			If ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21#"Y")
				APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"- Prot sys - Has Protective system"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21)
			End if 
		Else 
			If ([NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21="Y")
				APPEND TO ARRAY:C911($Errors_atxt; "XML Element "+String:C10($ElemVal_L)+" "+$ElemName_txt+Char:C90(Tab:K15:37)+"Has Protective system"+Char:C90(Tab:K15:37)+[NTI_ELEM_DEFS:182]ELEM_PROTECT_SYS:21)
			End if 
			
		End if 
		
	End if 
	
End for 

If (Size of array:C274($Errors_atxt)>0)
	
	C_TEXT:C284($errFile_txt)
	$errFile_txt:=Select document:C905("XMLvsDBErrors.txt"; ".txt"; "Choose File to save Errors"; File name entry:K24:17)
	If (OK=1)
		$errFile_txt:=Document
		C_TIME:C306($errFileDoc_t)
		$errFileDoc_t:=Create document:C266($errFile_txt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($Errors_atxt))
			SEND PACKET:C103($errFileDoc_t; $Errors_atxt{$loop_L}+Char:C90(Carriage return:K15:38))
		End for 
		CLOSE DOCUMENT:C267($errFileDoc_t)
		SHOW ON DISK:C922($errFile_txt)
		
	End if 
	
Else 
	ALERT:C41("No discrepancies were found between XML files and DB")
End if 

//End NTI_CheckXMLvsDB