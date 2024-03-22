QUERY:C277(Current form table:C627->)
If (OK=1)
	
	If (Records in selection:C76(Current form table:C627->)=Records in table:C83(Current form table:C627->))
		SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
			String:C10(Records in table:C83(Current form table:C627->))+\
			"]")
		
	Else 
		SET WINDOW TITLE:C213(Substring:C12(Get window title:C450; 1; Position:C15(" ["; Get window title:C450))+"["+\
			String:C10(Records in selection:C76(Current form table:C627->))+\
			" of "+String:C10(Records in table:C83(Current form table:C627->))+\
			"]")
		
	End if 
	
End if 