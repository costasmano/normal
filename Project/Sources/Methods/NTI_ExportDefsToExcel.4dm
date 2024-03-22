//%attributes = {"invisible":true}
//Method: NTI_ExportDefsToExcel
//Description
// Development tool : Export a set of NTI element definitions to excel,
// Request the two files needed "Defect_language.xml" and "Element_defectTree.xml
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/26/18, 13:48:48
	// ----------------------------------------------------
	//Created : 
	Mods_2018_03
End if 
//

C_TEXT:C284($LangFile_txt; $treeFile_txt)
ARRAY TEXT:C222($LangFiles_atxt; 0)
ARRAY TEXT:C222($TreeFiles_atxt; 0)

C_TEXT:C284($LangTree_txt; $ElemDefectTree_txt)
C_TEXT:C284($defectRef_txt; $stateRef_txt; $RootElement_txt; $RootElementName_txt)

C_BOOLEAN:C305($DefectLangOk_b; $Elem_defectsOK_b)

$DefectLangOk_b:=False:C215
$Elem_defectsOK_b:=False:C215

$LangFile_txt:=Select document:C905(""; ".xml"; "Select Defect Language XML file"; 0; $LangFiles_atxt)

If (OK=1)
	$LangTree_txt:=DOM Parse XML source:C719($LangFiles_atxt{1})
	//check that it is a DefectLang xml
	ARRAY TEXT:C222($DefectRefs_atxt; 0)
	$defectRef_txt:=DOM Find XML element:C864($LangTree_txt; "NTIDEFECTLANG/Defect"; $DefectRefs_atxt)
	If (Size of array:C274($DefectRefs_atxt)>0)
		$DefectLangOk_b:=True:C214
		
		$treeFile_txt:=Select document:C905(""; ".xml"; "Select Element Defect Tree XML file"; 0; $TreeFiles_atxt)
		If (OK=1)
			$ElemDefectTree_txt:=DOM Parse XML source:C719($TreeFiles_atxt{1})
			ARRAY TEXT:C222($DefectRefs_atxt; 0)
			$defectRef_txt:=DOM Find XML element:C864($ElemDefectTree_txt; "NTI_ELEMDEFECTS/Element"; $DefectRefs_atxt)
			
			If (Size of array:C274($DefectRefs_atxt)>0)
				$Elem_defectsOK_b:=True:C214
			Else 
				DOM GET XML ELEMENT NAME:C730(DOM Get root XML element:C1053($ElemDefectTree_txt); $RootElementName_txt)
				ALERT:C41("XML File "+$TreeFiles_atxt{1}+" does not contain Element Defects! Root Element is "+$RootElementName_txt)
			End if 
			
		End if 
	Else 
		//can we get the root? 
		DOM GET XML ELEMENT NAME:C730(DOM Get root XML element:C1053($LangTree_txt); $RootElementName_txt)
		ALERT:C41("XML File "+$LangFiles_atxt{1}+" does not contain Defect language! Root Element is "+$RootElementName_txt)
	End if 
End if 

If ($DefectLangOk_b & $Elem_defectsOK_b)
	4DError_b:=False:C215
	ON ERR CALL:C155("")
	If (Not:C34(4DError_b))
		NTI_Export_Elem_Defects($ElemDefectTree_txt; $LangTree_txt)
	Else 
		ALERT:C41("Error reading XML files")
	End if 
	
End if 
//End NTI_ExportDefsToExcel