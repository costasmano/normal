If (ListNames_atxt>1)
	
	CREATE SET:C116([TableOfLists:125]; "tableofLists")
	READ WRITE:C146([TableOfLists:125])
	Repeat 
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		ADD RECORD:C56(Current form table:C627->)
		ADD TO SET:C119([TableOfLists:125]; "tableofLists")
		
	Until (OK=0)
	
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	USE SET:C118("tableofLists")
	CLEAR SET:C117("tableofLists")
	ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListName_s:1; >; [TableOfLists:125]ListSequence_l:3; >; [TableOfLists:125]ListValue_s:2; >)
Else 
	ALERT:C41("You mut select a list name before adding records.")
End if 