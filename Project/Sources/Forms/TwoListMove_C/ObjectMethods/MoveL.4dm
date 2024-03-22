C_COLLECTION:C1488(OmitCselected)

If (OmitCselected.length>0)
	Form:C1466.UseC.combine(OmitCselected)
	Form:C1466.UseC:=Form:C1466.UseC.orderBy(Form:C1466.orderbycriteria)
	
	//remove the selected collection from the Use collection
	C_BOOLEAN:C305($selected_b)
	C_LONGINT:C283($c_L; $cLength_L)
	C_OBJECT:C1216($s_o)
	$cLength_L:=Form:C1466.OmitC.length
	For ($c_L; $cLength_L-1; 0; -1)
		$selected_b:=False:C215
		
		For each ($s_o; OmitCselected)
			If ($s_o[Form:C1466.equalattr]=Form:C1466.OmitC[$c_L][Form:C1466.equalattr])
				$selected_b:=True:C214
			End if 
		End for each 
		
		If ($selected_b)
			Form:C1466.OmitC.remove($c_L; 1)  // remove the element
		End if 
		
	End for 
	
	//clear the selection on the listbox
	LISTBOX SELECT ROW:C912(*; "OmitLB"; 0; lk remove from selection:K53:3)
End if 
