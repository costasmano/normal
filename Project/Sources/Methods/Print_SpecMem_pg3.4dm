//%attributes = {"invisible":true}
If (False:C215)
	//Print_SpecMem_pg3
	//Created to print Page3s of combined inspections
	Mods_2004_CM11  //twice
	Mods_2005_CM01
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(4/13/2007 16:28:41)
	Mods_2007_CM07
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 11:57:26)
	Mods_2014_04
	//  `use method INSP_SetSpMbPrintForm to get form names and element counts
End if 

C_LONGINT:C283($recnum; $i; $numGrps; $j; $k; $viElmtsPerPage; $viElmtsPerPage2)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vsInspFormName; $vsInspFormName2)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283(vPageno)  //Command Replaced was o_C_INTEGER

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)

QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]SpecMemb Flag:8=True:C214; *)
QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N"; *)
QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#" "; *)
QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"")
$recnum:=Records in selection:C76([ElementsSafety:29])
If ($recnum>0)
	//Sort by element no.
	//ORDER BY([ElementsSafety];[ElementsSafety]ElementNo;>)
	If ([Inspections:27]Insp Type:6="RTA")
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabelArch:14; >)
	Else 
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
	End if 
	
	ARRAY LONGINT:C221($alAllElmts; 0)
	C_LONGINT:C283($lElmtRecIDNum)
	LONGINT ARRAY FROM SELECTION:C647([ElementsSafety:29]; $alAllElmts)
	
	INSP_SetSpMbPrintForm([Inspections:27]Insp Type:6; ->$vsInspFormName; ->$viElmtsPerPage; ->$vsInspFormName2; ->$viElmtsPerPage2)
	
	If ($recnum<=$viElmtsPerPage)
		$numGrps:=1
	Else 
		$numGrps:=-(Trunc:C95(-(($recnum-$viElmtsPerPage)/$viElmtsPerPage2); 0))
		$numGrps:=$numGrps+1
	End if 
	$k:=0
	C_LONGINT:C283(vSpecMemStartLetter)
	vSpecMemStartLetter:=$viElmtsPerPage
	
	For ($i; 1; $numGrps)
		If (viInspPreviewErr=0)
			If ($i>1)
				//For more than one page
				$viElmtsPerPage:=$viElmtsPerPage2
				$vsInspFormName:=$vsInspFormName2
				If ($i>2)
					vSpecMemStartLetter:=vSpecMemStartLetter+$viElmtsPerPage2
				End if 
			End if 
			
			ARRAY LONGINT:C221($alGroup5; 0)
			For ($j; 1; $viElmtsPerPage)
				$k:=$k+1
				If ($k<=$recnum)
					INSERT IN ARRAY:C227($alGroup5; (Size of array:C274($alGroup5)+1))
					$alGroup5{Size of array:C274($alGroup5)}:=$alAllElmts{$k}
				End if 
				
			End for 
			CREATE SELECTION FROM ARRAY:C640([ElementsSafety:29]; $alGroup5)
			vPageNo:=vPageNo+1
			Print form:C5([Inspections:27]; $vsInspFormName)
			If ($i<$numGrps)  //last page break handled by calling method.
				PAGE BREAK:C6(>)
			End if 
		End if   //If previewError     
	End for 
End if 