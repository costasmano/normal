//%attributes = {"invisible":true}
If (False:C215)
	//G_Insp_ElmtArray_setup 
	//Set up arrays for the Element Safety Pulldown in 
	//Element safety input forms to allow direct navigation to
	//other elements on the list.
	
	Mods_2004_CM12
	// Modified by: costasmanousakis-(Designer)-(10/25/2007 12:22:17)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(8/5/08 10:55:15)
	Mods_2008_CM_5404
	//  `Use method INSP_ElmtSfty_ItemNo instead of a selection to array lookup
	// Modified by: costasmanousakis (4/29/09)
	Mods_2009_04
	//Keep track of the current record number to avoid loosing the spot when exiting the input form
	// or when clicking on the included list.
	Mods_2011_06  // CJ Miller`06/14/11, 10:43:10      ` Type all local variables for v11
End if 

//set up arrays for ElementsSafety navigation...
C_LONGINT:C283($currRecNum)
$currRecNum:=Selected record number:C246([ElementsSafety:29])

ARRAY LONGINT:C221(alElmtSftyPulldwnID; 0)
ARRAY TEXT:C222(asElmtSftyPulldwnName; 0)  //Command Replaced was o_ARRAY string length was 80
ARRAY BOOLEAN:C223($spFlag_ab; 0)
ARRAY TEXT:C222($elmtDictCat_as; 0)  //Command Replaced was o_ARRAY string length was 3
ARRAY INTEGER:C220($elmtNo_ai; 0)
SELECTION TO ARRAY:C260([ElementsSafety:29]ElmSafetyID:7; alElmtSftyPulldwnID; [ElementsSafety:29]Description:22; asElmtSftyPulldwnName; [ElementsSafety:29]SpecMemb Flag:8; $spFlag_ab; [ElementsSafety:29]ElementNo:1; $elmtNo_ai)
C_LONGINT:C283($vlNumElems; $i)
$vlNumElems:=Size of array:C274(alElmtSftyPulldwnID)
If ($currRecNum>0)
	GOTO SELECTED RECORD:C245([ElementsSafety:29]; $currRecNum)
End if 
C_TEXT:C284($Cat_txt)
For ($i; 1; $vlNumElems)
	$Cat_txt:=INSP_ElmtSfty_ItemNo($elmtNo_ai{$i})
	
	//Display description
	asElmtSftyPulldwnName{$i}:=$Cat_txt+" "+GetElmtNumber($elmtNo_ai{$i})+" "+asElmtSftyPulldwnName{$i}
	If ($spFlag_ab{$i})
		asElmtSftyPulldwnName{$i}:=asElmtSftyPulldwnName{$i}+" - (SpM)"
	End if 
	
End for 