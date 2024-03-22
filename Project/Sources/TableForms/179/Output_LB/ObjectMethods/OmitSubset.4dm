If (Records in set:C195("$ListboxSet0")>0)
	CREATE SET:C116([PON_ELEM_INSP:179]; "currSet")
	DIFFERENCE:C122("currSet"; "$ListboxSet0"; "currSet")
	USE SET:C118("currSet")
	CLEAR SET:C117("CurrSet")
	//CLEAR SET("$ListboxSet0")
	WINDOW_TITLE(Current form table:C627)
	
End if 
