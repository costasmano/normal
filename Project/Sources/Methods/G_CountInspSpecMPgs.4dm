//%attributes = {"invisible":true}
//G_CountInspSpecMPgs

If (False:C215)
	Mods_2004_CM11  //twice
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 14:17:50)
	Mods_2014_04
	//  `Use method INSP_SetSpMbPrintForm to get count of  elements per page
End if 

C_LONGINT:C283($0; $vlNumSpPages; $vlNumSpMems)  //Command Replaced was o_C_INTEGER
SET QUERY DESTINATION:C396(Into variable:K19:4; $vlNumSpMems)
QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]SpecMemb Flag:8=True:C214; *)
QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"N"; *)
QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#" "; *)
QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Rating:2#"")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($vlNumSpMems>0)
	C_LONGINT:C283($viElmtsperPage; $viElmtsperPage2)  //Command Replaced was o_C_INTEGER
	C_TEXT:C284($du_txt; $du2_txt)
	INSP_SetSpMbPrintForm([Inspections:27]Insp Type:6; ->$du_txt; ->$viElmtsperPage; ->$du2_txt; ->$viElmtsperPage2)
	
	If ($vlNumSpMems<=$viElmtsperPage)
		$vlNumSpPages:=1
	Else 
		$vlNumSpMems:=$vlNumSpMems-$viElmtsperPage
		$vlNumSpPages:=-(Trunc:C95(-($vlNumSpMems/$viElmtsperPage2); 0))
		$vlNumSpPages:=$vlNumSpPages+1
	End if 
Else 
	$vlNumSpPages:=0
End if 
$0:=$vlNumSpPages
