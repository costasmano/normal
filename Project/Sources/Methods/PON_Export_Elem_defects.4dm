//%attributes = {"invisible":true}
//Method: PON_Export_Elem_defects
//Description
// create export of element and related defects
// Parameters
// $1 : $Defect_elem_tree : DOM with the Element and related defects
// $2 : $Defect_Lang_tree : DOM with the CS language for defects
// ----------------------------------------------------
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/02/18, 16:15:45
	// ----------------------------------------------------
	//Created : 
	Mods_2018_05
	
	C_TEXT:C284(PON_Export_Elem_defects; $1)
	C_TEXT:C284(PON_Export_Elem_defects; $2)
	
	// Modified by: Costas Manousakis-(Designer)-(3/22/19 11:11:49)
	Mods_2019_03
	//  `use ut_DOM_LoadXML to switch from Resource files to Parameters table.
	
End if 
//
C_TEXT:C284($PON_DEFECT_ELEM_TREE; $PON_DEFECT_LANG_TREE)
If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$PON_DEFECT_ELEM_TREE:=$1
End if 
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$PON_DEFECT_LANG_TREE:=$2
End if 
C_BOOLEAN:C305($UseDB_b)

$UseDB_b:=True:C214

If (User in group:C338(Current user:C182; "Design Access Group"))
	CONFIRM:C162("Use Element Names from XML attributes or DB?"; "XML"; "DB")
	$UseDB_b:=(OK=0)
End if 

//Load Defect and Language trees if needed
C_BOOLEAN:C305($TempDefectElem_b; $TempDefectLang_b)
$TempDefectElem_b:=False:C215
$TempDefectLang_b:=False:C215
If ($PON_DEFECT_ELEM_TREE="")
	$PON_DEFECT_ELEM_TREE:=ut_DOM_LoadXML("NBE"; "Element_DefectTree.xml")
	$TempDefectElem_b:=True:C214
End if 
If ($PON_DEFECT_LANG_TREE="")
	$PON_DEFECT_LANG_TREE:=ut_DOM_LoadXML("NBE"; "Defect_Language.xml")
	$TempDefectLang_b:=True:C214
End if 

READ ONLY:C145([PON_ELEM_DEFS:178])
ARRAY TEXT:C222($ReportData_atxt; 0)
//parse the language first
ARRAY LONGINT:C221($DefectNos_aL; 0)
ARRAY TEXT:C222($DefectNames_atxt; 0)
ARRAY TEXT:C222($DefectCS1_atxt; 0)
ARRAY TEXT:C222($DefectCS2_atxt; 0)
ARRAY TEXT:C222($DefectCS3_atxt; 0)
ARRAY TEXT:C222($DefectCS4_atxt; 0)

C_TEXT:C284($defectRef_txt; $stateRef_txt)
ARRAY TEXT:C222($DefectRefs_atxt; 0)
$defectRef_txt:=DOM Find XML element:C864($PON_DEFECT_LANG_TREE; "Root/Defect"; $DefectRefs_atxt)
C_LONGINT:C283($loop_L; $defectVal_L)
C_TEXT:C284($lastOnErr_txt)
$lastOnErr_txt:=Method called on error:C704
ON ERR CALL:C155("XMLErrorHandler")
For ($loop_L; 1; Size of array:C274($DefectRefs_atxt))
	DOM GET XML ELEMENT VALUE:C731($DefectRefs_atxt{$loop_L}; $defectVal_L)
	If (Find in array:C230($DefectNos_aL; $defectVal_L)>0)
		//compare CSs
		ARRAY TEXT:C222($StateRefs_atxt; 0)
		C_TEXT:C284($CSTextStored_txt)
		$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
		ARRAY TEXT:C222($StateLang_atxt; Size of array:C274($StateRefs_atxt))
		C_LONGINT:C283($loop2_L; $state_L)
		For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
			DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $StateLang_atxt{$loop2_L})
			Case of 
				: ($state_L=1)
					$CSTextStored_txt:=$DefectCS1_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
				: ($state_L=2)
					$CSTextStored_txt:=$DefectCS2_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
				: ($state_L=3)
					$CSTextStored_txt:=$DefectCS3_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
				: ($state_L=4)
					$CSTextStored_txt:=$DefectCS4_atxt{Find in array:C230($DefectNos_aL; $defectVal_L)}
			End case 
			If ($CSTextStored_txt#$CSTextStored_txt)
				ALERT:C41("Multiple Defect entry for Defect "+String:C10($defectVal_L)+" with mismatch CS"+String:C10($state_L))
			End if 
		End for 
		
	Else 
		
		APPEND TO ARRAY:C911($DefectNos_aL; $defectVal_L)
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=$defectVal_L)
		APPEND TO ARRAY:C911($DefectNames_atxt; [PON_ELEM_DEFS:178]ELEM_LONGNAME:11)
		APPEND TO ARRAY:C911($DefectCS1_atxt; "")
		APPEND TO ARRAY:C911($DefectCS2_atxt; "")
		APPEND TO ARRAY:C911($DefectCS3_atxt; "")
		APPEND TO ARRAY:C911($DefectCS4_atxt; "")
		ARRAY TEXT:C222($StateRefs_atxt; 0)
		$stateRef_txt:=DOM Find XML element:C864($DefectRefs_atxt{$loop_L}; "Defect/State"; $StateRefs_atxt)
		ARRAY TEXT:C222($StateLang_atxt; Size of array:C274($StateRefs_atxt))
		C_LONGINT:C283($loop2_L; $state_L)
		For ($loop2_L; 1; Size of array:C274($StateRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($StateRefs_atxt{$loop2_L}; $state_L)
			DOM GET XML ATTRIBUTE BY NAME:C728($StateRefs_atxt{$loop2_L}; "Language"; $StateLang_atxt{$loop2_L})
			Case of 
				: ($state_L=1)
					$DefectCS1_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
				: ($state_L=2)
					$DefectCS2_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
				: ($state_L=3)
					$DefectCS3_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
				: ($state_L=4)
					$DefectCS4_atxt{Size of array:C274($DefectCS1_atxt)}:=$StateLang_atxt{$loop2_L}
			End case 
		End for 
		
	End if 
	
End for 


C_TEXT:C284($Elem_txt; $ElemCategory_txt; $ElemName_txt; $DefectName_txt; $ElemUnits_txt)
ARRAY TEXT:C222($Elements_atxt; 0)
C_LONGINT:C283($ElemVal_L)
C_TEXT:C284($ReportData_txt)
$Elem_txt:=DOM Find XML element:C864($PON_DEFECT_ELEM_TREE; "Root/Element"; $Elements_atxt)
C_LONGINT:C283($loop_L)
$ReportData_txt:=""
For ($loop_L; 1; Size of array:C274($Elements_atxt))
	ARRAY TEXT:C222($ElemDefects_atxt; 0)
	DOM GET XML ELEMENT VALUE:C731($Elements_atxt{$loop_L}; $ElemVal_L)
	$ElemName_txt:=""
	DOM GET XML ATTRIBUTE BY NAME:C728($Elements_atxt{$loop_L}; "Category"; $ElemCategory_txt)
	DOM GET XML ATTRIBUTE BY NAME:C728($Elements_atxt{$loop_L}; "Name"; $ElemName_txt)
	If ((Ok=0) | $UseDB_b)
		QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=$ElemVal_L)
		$ElemName_txt:=[PON_ELEM_DEFS:178]ELEM_LONGNAME:11
		$ElemCategory_txt:=[PON_ELEM_DEFS:178]ELEM_CAT_KEY:5
	End if 
	QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=$ElemVal_L)
	$ElemUnits_txt:=[PON_ELEM_DEFS:178]ELEM_SCALEUNIT:13
	
	$ReportData_txt:=$ReportData_txt+String:C10($ElemVal_L)+Char:C90(Tab:K15:37)+$ElemName_txt+Char:C90(Tab:K15:37)+$ElemCategory_txt+Char:C90(Tab:K15:37)+$ElemUnits_txt+Char:C90(Carriage return:K15:38)
	$defectRef_txt:=DOM Find XML element:C864($Elements_atxt{$loop_L}; "Element/Defect"; $ElemDefects_atxt)
	
	C_LONGINT:C283($loop2_L; $DefectVal_L; $Indx_L)
	
	For ($loop2_L; 1; Size of array:C274($ElemDefects_atxt))
		DOM GET XML ELEMENT VALUE:C731($ElemDefects_atxt{$loop2_L}; $DefectVal_L)
		DOM GET XML ATTRIBUTE BY NAME:C728($ElemDefects_atxt{$loop2_L}; "Name"; $DefectName_txt)
		
		If ((Ok=0) | $UseDB_b)
			QUERY:C277([PON_ELEM_DEFS:178]; [PON_ELEM_DEFS:178]ELEM_KEY:1=$DefectVal_L)
			$DefectName_txt:=[PON_ELEM_DEFS:178]ELEM_LONGNAME:11
		End if 
		
		
		$Indx_L:=Find in array:C230($DefectNos_aL; $DefectVal_L)
		If ($Indx_L>0)
			$ReportData_txt:=$ReportData_txt+String:C10($ElemVal_L)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+Char:C90(Tab:K15:37)+$ElemUnits_txt+Char:C90(Tab:K15:37)+String:C10($DefectVal_L)+Char:C90(Tab:K15:37)+\
				$DefectName_txt+Char:C90(Tab:K15:37)+\
				$DefectCS1_atxt{$Indx_L}+Char:C90(Tab:K15:37)+\
				$DefectCS2_atxt{$Indx_L}+Char:C90(Tab:K15:37)+\
				$DefectCS3_atxt{$Indx_L}+Char:C90(Tab:K15:37)+\
				$DefectCS4_atxt{$Indx_L}
			
		Else 
			$ReportData_txt:=$ReportData_txt+String:C10($ElemVal_L)+Char:C90(Tab:K15:37)+String:C10($DefectVal_L)+Char:C90(Tab:K15:37)+\
				[PON_ELEM_DEFS:178]ELEM_LONGNAME:11+Char:C90(Tab:K15:37)+\
				"ERROR !!! CS data not found !!!"
			
		End if 
		$ReportData_txt:=$ReportData_txt+Char:C90(Carriage return:K15:38)
	End for 
	If (Length:C16($ReportData_txt)>20000)
		APPEND TO ARRAY:C911($ReportData_atxt; $ReportData_txt)
		$ReportData_txt:=""
	End if 
End for 

ON ERR CALL:C155($lastOnErr_txt)

APPEND TO ARRAY:C911($ReportData_atxt; $ReportData_txt)

C_TIME:C306($output_t)
C_TEXT:C284($OutputFile_txt)
$OutputFile_txt:=Select document:C905("NBE Definitions Export"; ".txt"; "Select Export document"; File name entry:K24:17)

If (OK=1)
	$output_t:=Create document:C266(Document)
	CLOSE DOCUMENT:C267($output_t)
	
	C_BLOB:C604($docData_x)
	C_LONGINT:C283($loop_L)
	//Add the header
	C_TEXT:C284($header_txt)
	$header_txt:="Element No\tName\tCategory Key\tUnits\tDefect num\tDefect Name\tCS1\tCS2\tCS3\tCS4\r"
	TEXT TO BLOB:C554($header_txt; $docData_x; UTF8 text without length:K22:17; *)
	For ($loop_L; 1; Size of array:C274($ReportData_atxt))
		TEXT TO BLOB:C554($ReportData_atxt{$loop_L}; $docData_x; UTF8 text without length:K22:17; *)
	End for 
	
	//TEXT TO BLOB($ReportData_txt;$docData_x)
	BLOB TO DOCUMENT:C526(Document; $docData_x)
	
	SHOW ON DISK:C922(Document)
End if 

// close these only if temp

If ($TempDefectElem_b)
	DOM CLOSE XML:C722($PON_DEFECT_ELEM_TREE)
	
End if 

If ($TempDefectLang_b)
	
	DOM CLOSE XML:C722($PON_DEFECT_LANG_TREE)
	
End if 


//End PON_Export_Elem_defects