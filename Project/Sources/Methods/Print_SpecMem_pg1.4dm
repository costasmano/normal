//%attributes = {"invisible":true}
If (False:C215)
	//Print_SpecMem_pg1
	//Created to Print  Page 1 for Spec Memb and FCR inspections
	Mods_2004_CM11  //twice
	Mods_2005_CM01
	Mods_2005_CM12
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(4/9/2007 09:44:41)
	Mods_2007_CM07
	If (False:C215)
		DIALOG:C40([Inspections:27]; "FC Pr (Pg 1)")
		DIALOG:C40([Inspections:27]; "FCPrPg1_v2")
		DIALOG:C40([Inspections:27]; "Damage Pg1")
		DIALOG:C40([Inspections:27]; "DamagePg1_v2")
	End if 
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 14:54:17)
	Mods_2013_01
	//  `Use new method Insp_SortElmtSfty
	//  `Added cases for the Rail inspection types
	Mods_2013_05  //r003 ` Add New tunnel inspection types and print form
	//([Inspections]Insp Type="TSP")
	//Modified by: Charles Miller (5/7/13 16:06:45)
	Mods_2013_05  //r003 ` Change number of items on page for  ([Inspections]Insp Type="TSP") to 6
	//Modified by: Charles Miller (5/21/13 15:39:26)
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 11:50:27)
	Mods_2014_04
	//  `use method INSP_SetSpMbPrintForm to get form names and element counts
End if 

G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)

C_LONGINT:C283($recnum; $i; $numGrps; $j; $k; $viElmtsPerPage; $viElmtsPerPage2)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($vsInspFormName; $vsInspFormName2)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283(vPageno)  //Command Replaced was o_C_INTEGER
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Rating:2#"N")
$recnum:=Records in selection:C76([ElementsSafety:29])
//Sort by element no.

Insp_SortElmtSfty

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
	End if   //if preview error
	
End for 