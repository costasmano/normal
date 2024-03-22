//find which is selected from uselb
C_COLLECTION:C1488(UseCselected)
If (UseCselected.length>0)
	//Form.OmitC.push(Form.UseC[usecpos-1])
	//combine the selected collection with the Omit collection
	Form:C1466.OmitC.combine(UseCselected)
	//sort the Omit collection
	Form:C1466.OmitC:=Form:C1466.OmitC.orderBy(Form:C1466.orderbycriteria)
	
	//remove the selected collection from the Use collection
	C_BOOLEAN:C305($selected_b)
	C_LONGINT:C283($c_L; $cLength_L)
	C_OBJECT:C1216($s_o)
	$cLength_L:=Form:C1466.UseC.length
	For ($c_L; $cLength_L-1; 0; -1)
		$selected_b:=False:C215
		
		For each ($s_o; UseCselected)
			If ($s_o[Form:C1466.equalattr]=Form:C1466.UseC[$c_L][Form:C1466.equalattr])
				$selected_b:=True:C214
			End if 
		End for each 
		
		If ($selected_b)
			Form:C1466.UseC.remove($c_L; 1)  // remove the element
		End if 
		
	End for 
	
	//clear the selection on the listbox
	LISTBOX SELECT ROW:C912(*; "UseLB"; 0; lk remove from selection:K53:3)
End if 

