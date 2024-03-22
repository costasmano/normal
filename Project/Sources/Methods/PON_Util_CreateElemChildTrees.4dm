//%attributes = {"invisible":true}
//Method: PON_Util_CreateElemChildTrees
//Description
// create the XMLs from tab delimited file. 
// column one is parent element, column2 is child, col3 is protsys (Y/N), col4 is defect (Y/N)
// compares defects found with defect tree stored in DB.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/20/19, 16:36:35
	// ----------------------------------------------------
	//Created : 
	Mods_2019_03
End if 
//

C_TEXT:C284($Clip_txt)

$Clip_txt:=Get text from pasteboard:C524

ARRAY TEXT:C222($ClipLines_atxt; 0)

C_TEXT:C284($doc_txt)
ARRAY TEXT:C222($docs_atxt; 0)
$doc_txt:=Select document:C905(""; ".txt"; "Choose text file tab delimited"; 0; $docs_atxt)
//C_BLOB($docBlob_txt)
$Clip_txt:=Document to text:C1236($docs_atxt{1}; UTF8 text without length:K22:17)

ut_TextToArray($Clip_txt; ->$ClipLines_atxt; Char:C90(Carriage return:K15:38))
C_TEXT:C284($PROChildType_txt; $DEFChildType_txt; $XMLHeader_txt)
$XMLHeader_txt:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\n<Root>\n"
$PROChildType_txt:="ProtSys"
$DEFChildType_txt:="Defect"
C_TEXT:C284($Elem_line_txt; $prot_sys_txt; $currElem_txt; $protYN_txt; $DefYN_txt)
C_TEXT:C284($ProtSysXML_txt; $DefectXML_txt)
C_LONGINT:C283($Tab_L)
If (Size of array:C274($ClipLines_atxt)>0)
	$ProtSysXML_txt:=""
	$DefectXML_txt:=""
	ARRAY TEXT:C222($Lineparts_atxt; 0)
	ut_TextToArray($ClipLines_atxt{1}; ->$Lineparts_atxt; Char:C90(Tab:K15:37))
	If (Size of array:C274($Lineparts_atxt)>3)
		$Elem_line_txt:=$Lineparts_atxt{1}
		$prot_sys_txt:=$Lineparts_atxt{2}
		$protYN_txt:=$Lineparts_atxt{3}
		$DefYN_txt:=$Lineparts_atxt{4}
		
		If ($Elem_line_txt#"")
			$currElem_txt:=$Elem_line_txt
			
			$ProtSysXML_txt:="<Element>"+$currElem_txt+"\n"
			$DefectXML_txt:="<Element>"+$currElem_txt+"\n"
			Case of 
				: ($protYN_txt="Y")
					$ProtSysXML_txt:=$ProtSysXML_txt+"\t<"+$PROChildType_txt+">"+$prot_sys_txt+"</"+$PROChildType_txt+">\n"
				: ($DefYN_txt="Y")
					$DefectXML_txt:=$DefectXML_txt+"\t<"+$DEFChildType_txt+">"+$prot_sys_txt+"</"+$DEFChildType_txt+">\n"
			End case 
			
		End if 
		
	End if 
	C_LONGINT:C283($loop_L)
	For ($loop_L; 2; Size of array:C274($ClipLines_atxt))
		ARRAY TEXT:C222($Lineparts_atxt; 0)
		ut_TextToArray($ClipLines_atxt{$loop_L}; ->$Lineparts_atxt; Char:C90(Tab:K15:37))
		If (Size of array:C274($Lineparts_atxt)>3)
			$Elem_line_txt:=$Lineparts_atxt{1}
			$prot_sys_txt:=$Lineparts_atxt{2}
			$protYN_txt:=$Lineparts_atxt{3}
			$DefYN_txt:=$Lineparts_atxt{4}
			
			If ($Elem_line_txt#"")
				If ($Elem_line_txt#$currElem_txt)
					//new parent element
					$currElem_txt:=$Elem_line_txt
					$ProtSysXML_txt:=$ProtSysXML_txt+"</Element>\n<Element>"+$currElem_txt+"\n"
					$DefectXML_txt:=$DefectXML_txt+"</Element>\n<Element>"+$currElem_txt+"\n"
					
				End if 
				
				Case of 
					: ($protYN_txt="Y")
						$ProtSysXML_txt:=$ProtSysXML_txt+"\t<"+$PROChildType_txt+">"+$prot_sys_txt+"</"+$PROChildType_txt+">\n"
					: ($DefYN_txt="Y")
						$DefectXML_txt:=$DefectXML_txt+"\t<"+$DEFChildType_txt+">"+$prot_sys_txt+"</"+$DEFChildType_txt+">\n"
				End case 
				
			End if 
			
		End if 
		
	End for 
	$ProtSysXML_txt:=$XMLHeader_txt+"\n"+$ProtSysXML_txt+"</Element>"+"\n</Root>"
	$DefectXML_txt:=$XMLHeader_txt+"\n"+$DefectXML_txt+"</Element>"+"\n</Root>"
	
	SET TEXT TO PASTEBOARD:C523($ProtSysXML_txt+"\n"+$DefectXML_txt)
	
	C_TEXT:C284($ImportDefectTree_txt; $MADOTDefectTree_txt)
	$ImportDefectTree_txt:=DOM Parse XML variable:C720($DefectXML_txt)
	
	ARRAY TEXT:C222($importElems_atxt; 0)
	C_TEXT:C284($importElemRef_txt; $importDefRef_txt)
	$importElemRef_txt:=DOM Find XML element:C864($ImportDefectTree_txt; "Root/Element"; $importElems_atxt)
	
	C_LONGINT:C283($importelemloop_L; $defectLoop_L; $importDefVal_L)
	C_TEXT:C284($Errors_txt)
	$Errors_txt:=""
	C_LONGINT:C283($importElem_L)
	For ($importelemloop_L; 1; Size of array:C274($importElems_atxt))
		ARRAY LONGINT:C221($madotdefects_aL; 0)
		DOM GET XML ELEMENT VALUE:C731($importElems_atxt{$importelemloop_L}; $importElem_L)
		PON_FindAllowedDefects($importElem_L; ->$madotdefects_aL)
		
		ARRAY TEXT:C222($importDefRefs_atxt; 0)
		$importDefRef_txt:=DOM Find XML element:C864($importElems_atxt{$importelemloop_L}; "Element/Defect"; $importDefRefs_atxt)
		ARRAY LONGINT:C221($ImportDefs_aL; 0)
		For ($defectLoop_L; 1; Size of array:C274($importDefRefs_atxt))
			DOM GET XML ELEMENT VALUE:C731($importDefRefs_atxt{$defectLoop_L}; $importDefVal_L)
			APPEND TO ARRAY:C911($ImportDefs_aL; $importDefVal_L)
		End for 
		//check if import defects are in massdot
		C_LONGINT:C283($loop_L)
		For ($defectLoop_L; 1; Size of array:C274($ImportDefs_aL))
			If (Find in array:C230($madotdefects_aL; $ImportDefs_aL{$defectLoop_L})>0)
			Else 
				$Errors_txt:=$Errors_txt+\
					("For element "+String:C10($importElem_L)+" import defect "+String:C10($ImportDefs_aL{$defectLoop_L})+" not found in list of MADOT defects")+"\n"
			End if 
		End for 
		
		//check if MADOT defects are in import
		For ($defectLoop_L; 1; Size of array:C274($madotdefects_aL))
			If (Find in array:C230($ImportDefs_aL; $madotdefects_aL{$defectLoop_L})>0)
			Else 
				$Errors_txt:=$Errors_txt+\
					("For element "+String:C10($importElem_L)+" import defect "+String:C10($madotdefects_aL{$defectLoop_L})+" not found in list of import defects")+"\n"
			End if 
		End for 
		
		
	End for 
	
	If ($Errors_txt#"")
		ut_BigAlert($Errors_txt)
	Else 
		ALERT:C41("No discrepancies found!")
	End if 
	
End if 

//End PON_Util_CreateElemChildTrees